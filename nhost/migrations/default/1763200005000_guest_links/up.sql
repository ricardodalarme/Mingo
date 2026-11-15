-- A link that lets a partner without an account read one sent card. The app creates the token and sends only its
-- SHA-256, so the server never stores a usable link.
create table public.guest_links (
  id uuid primary key default gen_random_uuid(),
  card_id uuid not null references public.cards (id) on delete cascade,
  token_hash text not null unique check (token_hash ~ '^[0-9a-f]{64}$'),
  expires_at timestamptz not null default now() + interval '30 days',
  revoked_at timestamptz,
  opened_at timestamptz,
  created_at timestamptz not null default now()
);
create index guest_links_card_idx on public.guest_links (card_id);

create function private.guest_links_left(p_user_id uuid) returns integer
language sql stable as $$
  select greatest(0, 20 - (select count(*) from public.guest_links l join public.cards c on c.id = l.card_id
                           where c.author_id = p_user_id and l.created_at > now() - interval '1 day'))::integer;
$$;

create function private.before_guest_link_insert() returns trigger
language plpgsql as $$
begin
  if private.guest_links_left((select author_id from public.cards where id = new.card_id)) <= 0 then
    perform private.reject('RATE_LIMITED');
  end if;
  new.expires_at := now() + interval '30 days';
  new.created_at := now();
  new.revoked_at := null;
  new.opened_at := null;
  return new;
end $$;
create trigger guest_links_before_insert before insert on public.guest_links
  for each row execute function private.before_guest_link_insert();

-- A guest who pressed "stop receiving" for this sender. The sender is never told.
create table private.guest_stops (
  sender_id uuid primary key references public.profiles (id) on delete cascade,
  stopped_at timestamptz not null default now()
);

create table private.abuse_reports (
  id uuid primary key default gen_random_uuid(),
  reported_user_id uuid references public.profiles (id) on delete set null,
  card_id uuid references public.cards (id) on delete set null,
  source text not null check (source in ('guest', 'app')),
  reason text not null check (char_length(reason) between 1 and 60),
  details text check (char_length(details) <= 2000),
  card_snapshot jsonb,
  created_at timestamptz not null default now()
);
create index abuse_reports_reported_idx on private.abuse_reports (reported_user_id);
create index abuse_reports_card_idx on private.abuse_reports (card_id);

-- Result shapes of the guest functions. These tables never hold rows.
create table public.guest_cards (
  link_id uuid primary key,
  sender_name text,
  theme text,
  note text,
  sent_at timestamptz,
  opened boolean not null,
  items jsonb not null,
  reaction text,
  reply text
);
create table public.guest_results (
  done boolean primary key
);
create table public.invite_previews (
  inviter_name text,
  expires_at timestamptz primary key
);

create function private.hash_token(p_token text) returns text
language sql immutable as $$
  select encode(sha256(convert_to(coalesce(p_token, ''), 'UTF8')), 'hex');
$$;

-- Resolves a token to a live link, or nothing. Unknown, expired, revoked and stopped all look the same.
create function private.live_guest_link(p_token text) returns setof public.guest_links
language sql stable as $$
  select l.* from public.guest_links l join public.cards c on c.id = l.card_id
  where l.token_hash = private.hash_token(p_token) and l.revoked_at is null and l.expires_at > now()
    and c.status = 'sent'
    and not exists (select 1 from private.guest_stops s where s.sender_id = c.author_id);
$$;

create function private.guest_link_sender(p_token text) returns uuid
language sql stable as $$
  select c.author_id from public.guest_links l join public.cards c on c.id = l.card_id
  where l.token_hash = private.hash_token(p_token);
$$;

-- The minimum needed to render the page. Reading it never marks the card as opened (link-preview bots call it).
create function public.guest_card(token text) returns setof public.guest_cards
language sql stable security definer set search_path = '' as $$
  select l.id, p.display_name, (select s.theme from public.user_settings s where s.user_id = c.author_id), c.note, c.sent_at,
         l.opened_at is not null,
         coalesce((select jsonb_agg(jsonb_build_object('body', i.body, 'feeling', i.feeling) order by i.position)
                   from public.card_items i where i.card_id = c.id), '[]'::jsonb),
         r.reaction, r.reply
  from private.live_guest_link(token) l
  join public.cards c on c.id = l.card_id
  join public.profiles p on p.id = c.author_id
  left join public.card_reactions r on r.card_id = c.id;
$$;

-- A person tapped Open.
create function public.guest_open(token text) returns setof public.guest_results
language plpgsql volatile security definer set search_path = '' as $$
declare v_link public.guest_links;
begin
  select * into v_link from private.live_guest_link(token);
  if v_link.id is null then return next row(false)::public.guest_results; return; end if;
  update public.guest_links set opened_at = coalesce(opened_at, now()) where id = v_link.id;
  insert into public.card_opens (card_id) values (v_link.card_id) on conflict do nothing;
  return next row(true)::public.guest_results;
end $$;

create function public.guest_react(token text, reaction text default null, reply text default null) returns setof public.guest_results
language plpgsql volatile security definer set search_path = '' as $$
declare
  v_link public.guest_links;
  v_reaction text := nullif(left(btrim(reaction), 16), '');
  v_reply text := nullif(left(btrim(reply), 500), '');
begin
  select * into v_link from private.live_guest_link(token);
  if v_link.id is null or (v_reaction is null and v_reply is null) then
    return next row(false)::public.guest_results; return;
  end if;
  insert into public.card_reactions as r (card_id, reaction, reply, from_guest)
  values (v_link.card_id, v_reaction, v_reply, true)
  on conflict (card_id) do update set reaction = excluded.reaction, reply = excluded.reply, from_guest = true;
  return next row(true)::public.guest_results;
end $$;

-- Stop receiving from this sender: all their links die and future ones never resolve. Idempotent.
create function public.guest_stop(token text) returns setof public.guest_results
language plpgsql volatile security definer set search_path = '' as $$
declare v_sender uuid := private.guest_link_sender(token);
begin
  if v_sender is null then return next row(false)::public.guest_results; return; end if;
  insert into private.guest_stops (sender_id) values (v_sender) on conflict do nothing;
  update public.guest_links l set revoked_at = coalesce(l.revoked_at, now())
  from public.cards c where c.id = l.card_id and c.author_id = v_sender;
  return next row(true)::public.guest_results;
end $$;

-- Undoes "stop receiving" for the link in hand.
create function public.guest_resume(token text) returns setof public.guest_results
language plpgsql volatile security definer set search_path = '' as $$
declare v_sender uuid := private.guest_link_sender(token);
begin
  if v_sender is null then return next row(false)::public.guest_results; return; end if;
  delete from private.guest_stops where sender_id = v_sender;
  update public.guest_links l set revoked_at = null
  where l.token_hash = private.hash_token(token) and l.expires_at > now();
  return next row(true)::public.guest_results;
end $$;

-- Deletes what the guest left with this sender: reactions and opened state.
create function public.guest_forget(token text) returns setof public.guest_results
language plpgsql volatile security definer set search_path = '' as $$
declare v_sender uuid := private.guest_link_sender(token);
begin
  if v_sender is null then return next row(false)::public.guest_results; return; end if;
  delete from public.card_reactions r using public.cards c where c.id = r.card_id and c.author_id = v_sender and r.from_guest;
  delete from public.card_opens o using public.cards c
    where c.id = o.card_id and c.author_id = v_sender and c.recipient_id is null;
  update public.guest_links l set opened_at = null from public.cards c where c.id = l.card_id and c.author_id = v_sender;
  return next row(true)::public.guest_results;
end $$;

create function public.guest_report(token text, reason text, details text default null, "includeCard" boolean default false)
returns setof public.guest_results
language plpgsql volatile security definer set search_path = '' as $$
declare v_card public.cards;
begin
  select c.* into v_card from public.guest_links l join public.cards c on c.id = l.card_id
  where l.token_hash = private.hash_token(token);
  if v_card.id is null then return next row(false)::public.guest_results; return; end if;
  insert into private.abuse_reports (reported_user_id, card_id, source, reason, details, card_snapshot)
  values (v_card.author_id, v_card.id, 'guest', left(coalesce(nullif(btrim(reason), ''), 'unspecified'), 60), left(details, 2000),
          case when "includeCard" then
            (select jsonb_agg(jsonb_build_object('body', i.body) order by i.position) from public.card_items i where i.card_id = v_card.id)
          end);
  return next row(true)::public.guest_results;
end $$;

-- Invite landing page: who invited, only for a code that is still valid.
create function public.invite_preview(code text) returns setof public.invite_previews
language sql stable security definer set search_path = '' as $$
  select p.display_name, i.expires_at
  from public.invites i join public.profiles p on p.id = i.created_by
  where i.code = private.normalize_invite_code(invite_preview.code)
    and i.used_at is null and i.cancelled_at is null and i.expires_at > now();
$$;

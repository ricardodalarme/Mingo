-- A slip belongs to its author and is never shared as a row. The UI allows 140 characters; the database keeps headroom.
create table public.slips (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  kind text not null default 'quick' references public.slip_kind (value),
  polarity text not null default 'liked' references public.slip_polarity (value),
  body text not null check (char_length(btrim(body)) between 1 and 280),
  feeling text check (char_length(feeling) <= 200),
  plan_note text check (char_length(plan_note) <= 200),
  request text check (char_length(btrim(request)) <= 140),
  tags text[] not null default '{}' check (cardinality(tags) <= 10),
  category text references public.slip_category (value),
  work_area text references public.work_area (value),
  for_card boolean not null default true,
  in_jar boolean not null default false,
  photo_file_id uuid references storage.files (id) on delete set null,
  occurred_on date,
  archived_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint slips_invisible_never_for_card check (kind <> 'invisible' or not for_card),
  constraint slips_bothered_never_for_card check (polarity = 'liked' or not for_card),
  constraint slips_request_only_bothered check (request is null or polarity = 'bothered')
);
create index slips_author_created_idx on public.slips (author_id, created_at desc);
create index slips_photo_file_idx on public.slips (photo_file_id);
create trigger slips_set_updated_at before update on public.slips
  for each row execute function private.set_updated_at();

create function private.slips_this_month(p_user_id uuid) returns integer
language sql stable as $$
  select count(*)::integer from public.slips where author_id = p_user_id and created_at >= date_trunc('month', now());
$$;

-- Keeps the invariants a client could otherwise break: private kinds never reach a card, and an offline slip is never dated in the future.
create function private.before_slip_write() returns trigger
language plpgsql as $$
begin
  new.body := btrim(new.body);
  new.feeling := nullif(btrim(new.feeling), '');
  new.plan_note := nullif(btrim(new.plan_note), '');
  new.for_card := new.for_card and new.kind <> 'invisible' and new.polarity = 'liked';
  new.request := case when new.polarity = 'bothered' then nullif(btrim(new.request), '') end;
  if tg_op = 'INSERT' then
    new.created_at := least(coalesce(new.created_at, now()), now());
    -- The free limit applies to new slips only; nothing that exists is ever locked.
    if not private.has_plus(new.author_id)
       and private.slips_this_month(new.author_id) >= private.config_int('free_slips_per_month', 15) then
      perform private.reject('FREE_LIMIT_REACHED');
    end if;
  else
    new.created_at := old.created_at;
  end if;
  return new;
end $$;
create trigger slips_before_write before insert or update on public.slips
  for each row execute function private.before_slip_write();

create table public.cards (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  recipient_id uuid references public.profiles (id) on delete set null,
  couple_id uuid references public.couples (id) on delete set null,
  kind text not null default 'weekly' references public.card_kind (value),
  status text not null default 'draft' references public.card_status (value),
  week_start date not null,
  note text check (char_length(note) <= 500),
  sent_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint cards_sent_has_time check ((status = 'sent') = (sent_at is not null))
);
-- A single-slip card is sent on its own, so only weekly cards are limited to one per week.
create unique index cards_one_weekly_per_week on public.cards (author_id, week_start) where kind = 'weekly';
create index cards_author_idx on public.cards (author_id, sent_at desc);
create index cards_recipient_idx on public.cards (recipient_id, sent_at desc) where status = 'sent';
create index cards_couple_idx on public.cards (couple_id);
create trigger cards_set_updated_at before update on public.cards
  for each row execute function private.set_updated_at();

-- A frozen copy of the slip text: later edits to a slip never change a sent card.
create table public.card_items (
  id uuid primary key default gen_random_uuid(),
  card_id uuid not null references public.cards (id) on delete cascade,
  slip_id uuid references public.slips (id) on delete set null,
  body text not null,
  feeling text,
  position integer not null default 0,
  constraint card_items_slip_once unique (card_id, slip_id)
);
create index card_items_slip_idx on public.card_items (slip_id);

create function private.slip_is_card_eligible(s public.slips) returns boolean
language sql immutable as $$
  select s.for_card and s.kind <> 'invisible' and s.polarity = 'liked' and s.archived_at is null;
$$;

-- An item added by the author copies the slip text; the client sends only the slip id and the position.
create function private.before_card_item_insert() returns trigger
language plpgsql as $$
declare v_slip public.slips;
begin
  if new.slip_id is not null then
    select * into v_slip from public.slips where id = new.slip_id;
    new.body := v_slip.body;
    new.feeling := v_slip.feeling;
  end if;
  return new;
end $$;
create trigger card_items_before_insert before insert on public.card_items
  for each row execute function private.before_card_item_insert();

-- A deleted slip, or one that stops being eligible, leaves unsent cards; sent cards keep their frozen copy.
create function private.drop_slip_from_drafts() returns trigger
language plpgsql as $$
begin
  delete from public.card_items i using public.cards c
  where i.slip_id = old.id and c.id = i.card_id and c.status <> 'sent';
  return coalesce(new, old);
end $$;
create trigger slips_deleted_leave_drafts before delete on public.slips
  for each row execute function private.drop_slip_from_drafts();
create trigger slips_ineligible_leave_drafts after update on public.slips
  for each row when (private.slip_is_card_eligible(old) and not private.slip_is_card_eligible(new))
  execute function private.drop_slip_from_drafts();

create table public.card_reactions (
  card_id uuid primary key references public.cards (id) on delete cascade,
  reaction text check (char_length(reaction) between 1 and 16),
  reply text check (char_length(btrim(reply)) between 1 and 500),
  from_guest boolean not null default false,
  reacted_at timestamptz not null default now(),
  constraint card_reactions_not_empty check (reaction is not null or reply is not null)
);
create function private.before_card_reaction_write() returns trigger
language plpgsql as $$
begin
  new.reaction := nullif(btrim(new.reaction), '');
  new.reply := nullif(btrim(new.reply), '');
  new.reacted_at := now();
  return new;
end $$;
create trigger card_reactions_before_write before insert or update on public.card_reactions
  for each row execute function private.before_card_reaction_write();

-- Written only when a person taps Open. The author sees it only if the recipient shares read receipts.
create table public.card_opens (
  card_id uuid primary key references public.cards (id) on delete cascade,
  opened_at timestamptz not null default now()
);

create function private.cards_sent_this_month(p_user_id uuid) returns integer
language sql stable as $$
  select count(*)::integer from public.cards
  where author_id = p_user_id and status = 'sent' and sent_at >= date_trunc('month', now());
$$;

create function private.local_week_start(p_user_id uuid) returns date
language sql stable as $$
  select date_trunc('week', now() at time zone time_zone)::date from public.profiles where id = p_user_id;
$$;

-- Creates this week's draft from the eligible slips of the week. Never overwrites an existing card. Returns the card id, or null when the week has no eligible slip.
create function private.build_card_draft(p_user_id uuid) returns uuid
language plpgsql volatile as $$
declare
  v_week date := private.local_week_start(p_user_id);
  v_tz text := (select time_zone from public.profiles where id = p_user_id);
  v_card uuid;
begin
  select id into v_card from public.cards where author_id = p_user_id and week_start = v_week and kind = 'weekly';
  if v_card is not null then
    return v_card;
  end if;
  if not exists (select 1 from public.slips s
                 where s.author_id = p_user_id and private.slip_is_card_eligible(s)
                   and (s.created_at at time zone v_tz)::date >= v_week) then
    return null;
  end if;
  insert into public.cards (author_id, week_start) values (p_user_id, v_week)
  on conflict (author_id, week_start) where kind = 'weekly' do nothing returning id into v_card;
  if v_card is null then
    return (select id from public.cards where author_id = p_user_id and week_start = v_week and kind = 'weekly');
  end if;
  insert into public.card_items (card_id, slip_id, body, position)
  select v_card, s.id, s.body, row_number() over (order by s.created_at)
  from public.slips s
  where s.author_id = p_user_id and private.slip_is_card_eligible(s)
    and (s.created_at at time zone v_tz)::date >= v_week;
  return v_card;
end $$;

-- A card and its items in one row: the items a function creates are invisible to a relationship in the same call.
create table public.prepared_cards (
  card_id uuid primary key,
  kind text not null references public.card_kind (value),
  status text not null references public.card_status (value),
  week_start date not null,
  note text,
  items jsonb not null default '[]'
);

-- Builds this week's draft on demand, with the same rules as the weekly job. No row when the week has no eligible slip.
create function public.prepare_card(session json) returns setof public.prepared_cards
language plpgsql volatile as $$
declare v_card uuid := private.build_card_draft(private.uid(session));
begin
  return query
  select c.id, c.kind, c.status, c.week_start, c.note,
    coalesce((select jsonb_agg(jsonb_build_object(
                  'id', i.id, 'body', i.body, 'feeling', i.feeling, 'position', i.position,
                  'category', s.category, 'writtenAt', s.created_at) order by i.position)
              from public.card_items i left join public.slips s on s.id = i.slip_id
              where i.card_id = c.id), '[]'::jsonb)
  from public.cards c where c.id = v_card;
end $$;

-- Marks an unsent card of the author as sent to the current partner. Without a partner the card travels only by guest link.
create function private.deliver_card(p_card_id uuid, p_user_id uuid) returns setof public.cards
language plpgsql volatile as $$
declare v_card public.cards;
begin
  select * into v_card from public.cards where id = p_card_id and author_id = p_user_id for update;
  if not found or v_card.status = 'sent'
     or not exists (select 1 from public.card_items where card_id = v_card.id)
     or (not private.has_plus(p_user_id)
         and private.cards_sent_this_month(p_user_id) >= private.config_int('free_cards_per_month', 1)) then
    return;
  end if;
  update public.card_items i set body = s.body, feeling = s.feeling
  from public.slips s where i.card_id = v_card.id and s.id = i.slip_id;
  return query
  update public.cards c
  set status = 'sent', sent_at = now(), recipient_id = private.partner_of(p_user_id), couple_id = private.couple_of(p_user_id)
  where c.id = v_card.id returning c.*;
end $$;

-- Sends a draft or held card. No row when the card is not the caller's, already sent, empty, or over the free limit.
create function public.send_card("cardId" uuid, session json) returns setof public.cards
language sql volatile as $$
  select * from private.deliver_card("cardId", private.uid(session));
$$;

-- Sends one slip on its own, without touching the weekly card. No row when the slip is not eligible or the free limit is reached.
create function public.send_slip("slipId" uuid, session json, note text default null) returns setof public.cards
language plpgsql volatile as $$
declare v_uid uuid := private.uid(session); v_slip public.slips; v_card uuid;
begin
  select * into v_slip from public.slips s where s.id = "slipId" and s.author_id = v_uid;
  if not found or v_slip.kind = 'invisible' or v_slip.polarity <> 'liked' then
    return;
  end if;
  insert into public.cards (author_id, week_start, kind, note)
  values (v_uid, private.local_week_start(v_uid), 'single', nullif(btrim(note), '')) returning id into v_card;
  insert into public.card_items (card_id, slip_id, body, position) values (v_card, v_slip.id, v_slip.body, 1);
  return query select * from private.deliver_card(v_card, v_uid);
  if not found then
    delete from public.cards where id = v_card;
  end if;
end $$;

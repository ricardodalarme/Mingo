-- The content catalog: every piece of editorial content, one row per language.
create table public.content_items (
  id uuid primary key default gen_random_uuid(),
  kind text not null references public.content_kind (value),
  slug text not null check (char_length(slug) between 1 and 80),
  locale text not null check (locale in ('pt-BR', 'en')),
  title text not null check (char_length(title) <= 300),
  body text,
  parent_slug text,
  position integer not null default 0,
  tags text[] not null default '{}',
  month smallint check (month between 1 and 12),
  day smallint check (day between 1 and 31),
  country text check (char_length(country) = 2),
  plus_only boolean not null default false,
  sensitive boolean not null default false,
  published boolean not null default true,
  constraint content_items_unique unique (kind, slug, locale)
);
create index content_items_kind_idx on public.content_items (kind, locale, position);
create index content_items_parent_idx on public.content_items (parent_slug);

-- The same question, idea, mission or touch card for both partners on the same day: a deterministic pick from the
-- catalog. The rotation counts UTC days from 2026-01-01, so partners in different time zones share the pick; moving
-- that date changes every couple's pick.
create function public.daily_content(kind text, session json) returns setof public.content_items
language sql stable as $$
  with me as (
    select s.locale, (now() at time zone 'UTC')::date as today, coalesce(private.couple_of(s.user_id), s.user_id) as seed
    from public.user_settings s where s.user_id = private.uid(session)),
  pool as (
    select c.id, row_number() over (order by c.position, c.slug) - 1 as n, count(*) over () as total
    from public.content_items c, me
    where c.kind = daily_content.kind and daily_content.kind in ('question', 'daily_idea', 'mission', 'touch_card')
      and c.published and not c.plus_only and c.locale = me.locale)
  select c.* from pool p join public.content_items c on c.id = p.id, me
  where p.n = (((me.today - date '2026-01-01') + abs(hashtext(me.seed::text)) % 97) % p.total);
$$;

-- Versioned consent history; the newest row per kind is the current answer.
create table public.consents (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  kind text not null references public.consent_kind (value),
  granted boolean not null,
  version text not null check (char_length(version) between 1 and 20),
  created_at timestamptz not null default now()
);
create index consents_user_idx on public.consents (user_id, kind, created_at desc);

-- Account deletion: a row is the request, deleting the row cancels it, and 14 days later the account is erased.
create table public.deletion_requests (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  requested_at timestamptz not null default now(),
  purge_after timestamptz not null default now() + interval '14 days'
);
create index deletion_requests_purge_idx on public.deletion_requests (purge_after);

create table public.support_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles (id) on delete set null,
  topic text not null references public.support_topic (value),
  message text not null check (char_length(btrim(message)) between 1 and 2000),
  reply_email text check (char_length(reply_email) <= 254),
  app_version text check (char_length(app_version) <= 40),
  created_at timestamptz not null default now()
);
create index support_requests_user_idx on public.support_requests (user_id, created_at desc);

create function private.support_requests_left(p_user_id uuid) returns integer
language sql stable as $$
  select greatest(0, 5 - (select count(*) from public.support_requests
                          where user_id = p_user_id and created_at > now() - interval '1 day'))::integer;
$$;
create function private.before_support_request_insert() returns trigger
language plpgsql as $$
begin
  if private.support_requests_left(new.user_id) <= 0 then
    perform private.reject('RATE_LIMITED');
  end if;
  new.message := btrim(new.message);
  new.created_at := now();
  return new;
end $$;
create trigger support_requests_before_insert before insert on public.support_requests
  for each row execute function private.before_support_request_insert();

-- Files to remove from Storage after the row that owned them is gone. An event trigger drains it.
create table private.file_deletions (
  file_id uuid primary key,
  queued_at timestamptz not null default now()
);

-- Queues the file a row pointed to (`tg_argv[0]` is the column) when the row is deleted or points elsewhere.
create function private.queue_file_deletion() returns trigger
language plpgsql as $$
declare v_old uuid := (to_jsonb(old) ->> tg_argv[0])::uuid; v_new uuid;
begin
  if tg_op = 'UPDATE' then v_new := (to_jsonb(new) ->> tg_argv[0])::uuid; end if;
  if v_old is not null and v_old is distinct from v_new then
    insert into private.file_deletions (file_id) values (v_old) on conflict do nothing;
  end if;
  return null;
end $$;
create trigger profiles_file_cleanup after update of avatar_file_id or delete on public.profiles
  for each row execute function private.queue_file_deletion('avatar_file_id');
create trigger slips_file_cleanup after update of photo_file_id or delete on public.slips
  for each row execute function private.queue_file_deletion('photo_file_id');

-- The mascot conversation is never stored: a turn is a row without text that counts against the daily allowance.
create table public.chat_turns (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  created_at timestamptz not null default now()
);
create index chat_turns_user_idx on public.chat_turns (user_id, created_at desc);

create function private.chat_messages_left(p_user_id uuid) returns integer
language sql stable as $$
  select greatest(0,
    private.config_int(case when private.has_plus(p_user_id) then 'chat_messages_per_day_plus' else 'chat_messages_per_day_free' end, 0)
    - (select count(*) from public.chat_turns t where t.user_id = p_user_id and t.created_at >= date_trunc('day', now())))::integer;
$$;

-- Reserves one mascot message for the caller. No row when the chat is switched off or today's allowance is gone.
create function public.take_chat_turn(session json) returns setof public.chat_turns
language plpgsql volatile as $$
declare v_uid uuid := private.uid(session);
begin
  perform pg_advisory_xact_lock(hashtextextended(v_uid::text, 0));
  if not coalesce((select chat_enabled from public.user_settings where user_id = v_uid), false)
     or private.chat_messages_left(v_uid) <= 0 then
    return;
  end if;
  return query insert into public.chat_turns (user_id) values (v_uid) returning *;
end $$;

-- Things the mascot suggests remembering; nothing is kept until the person confirms it.
create table public.learned_items (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  target text not null references public.learned_item_target (value),
  text text not null check (char_length(text) between 1 and 500),
  excerpt text check (char_length(excerpt) <= 500),
  status text not null default 'pending' references public.learned_item_status (value),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index learned_items_author_idx on public.learned_items (author_id, status);
create trigger learned_items_set_updated_at before update on public.learned_items
  for each row execute function private.set_updated_at();

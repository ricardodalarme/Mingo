-- What a partner may see about a person. `city` is free text, never a location.
create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  display_name text check (char_length(btrim(display_name)) between 1 and 60),
  pronouns text check (char_length(pronouns) <= 30),
  city text check (char_length(city) <= 80),
  avatar_kind text not null default 'initials' references public.avatar_kind (value),
  avatar_file_id uuid references storage.files (id) on delete set null,
  time_zone text not null default 'America/Sao_Paulo' check (private.is_valid_time_zone(time_zone)),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index profiles_avatar_file_idx on public.profiles (avatar_file_id);
create trigger profiles_set_updated_at before update on public.profiles
  for each row execute function private.set_updated_at();

-- What only the person sees.
create table public.user_settings (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  theme text not null default 'neutro' references public.app_theme (value),
  locale text not null default 'pt-BR' check (locale in ('pt-BR', 'en')),
  goal text references public.relationship_goal (value),
  goals text[] not null default '{}'
    check (goals <@ array['reconnect', 'fight_less', 'keep_romance', 'remember_dates', 'organize_routine', 'just_record']),
  phase text references public.relationship_phase (value),
  relationship_status text not null default 'together' references public.relationship_status (value),
  partner_name text check (char_length(btrim(partner_name)) between 1 and 60),
  together_since date,
  onboarded_at timestamptz,
  share_read_receipts boolean not null default false,
  holiday_countries text[] not null default '{BR}' check (cardinality(holiday_countries) <= 10),
  card_channel text not null default 'link' references public.card_channel (value),
  card_theme text not null default 'paper' check (char_length(card_theme) <= 30),
  slips_default_for_card boolean not null default false,
  widget_allow_partner_notes boolean not null default false,
  widget_on_lock_screen boolean not null default false,
  widget_show_names boolean not null default false,
  spice_enabled boolean not null default false,
  low_stimulation boolean not null default false,
  chat_enabled boolean not null default false,
  chat_store_facts boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger user_settings_set_updated_at before update on public.user_settings
  for each row execute function private.set_updated_at();

create table public.couples (
  id uuid primary key default gen_random_uuid(),
  touch_topics_enabled boolean not null default true,
  created_at timestamptz not null default now(),
  ended_at timestamptz
);

-- A row exists only while the person is in the couple; the primary key allows one couple per person.
create table public.couple_members (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  couple_id uuid not null references public.couples (id) on delete cascade,
  role text not null references public.member_role (value),
  joined_at timestamptz not null default now()
);
create index couple_members_couple_idx on public.couple_members (couple_id);

create function private.enforce_couple_size() returns trigger
language plpgsql as $$
begin
  perform 1 from public.couples where id = new.couple_id for update;
  if (select count(*) from public.couple_members where couple_id = new.couple_id) >= 2 then
    perform private.reject('COUPLE_FULL');
  end if;
  return new;
end $$;
create trigger couple_members_max_two before insert on public.couple_members
  for each row execute function private.enforce_couple_size();

create function private.couple_of(p_user_id uuid) returns uuid
language sql stable as $$
  select couple_id from public.couple_members where user_id = p_user_id;
$$;

create function private.partner_of(p_user_id uuid) returns uuid
language sql stable as $$
  select other.user_id
  from public.couple_members me
  join public.couple_members other on other.couple_id = me.couple_id and other.user_id <> me.user_id
  where me.user_id = p_user_id;
$$;

create function private.local_date(p_user_id uuid) returns date
language sql stable as $$
  select (now() at time zone coalesce((select time_zone from public.profiles where id = p_user_id), 'America/Sao_Paulo'))::date;
$$;

-- Fills a daily row's date column (`tg_argv[0]`) with the author's local date when the client sends none.
create function private.set_local_date() returns trigger
language plpgsql as $$
begin
  if to_jsonb(new) ->> tg_argv[0] is null then
    new := jsonb_populate_record(new, jsonb_build_object(tg_argv[0], private.local_date(new.author_id)));
  end if;
  return new;
end $$;

create function private.new_invite_code() returns text
language sql volatile as $$
  select string_agg(substr('ABCDEFGHJKMNPQRSTUVWXYZ23456789', 1 + get_byte(b, i) % 31, 1), '')
  from (select uuid_send(gen_random_uuid()) as b) r, generate_series(0, 7) i;
$$;

create function private.normalize_invite_code(p_code text) returns text
language sql immutable as $$
  select upper(regexp_replace(coalesce(p_code, ''), '[^A-Za-z0-9]', '', 'g'));
$$;

-- Pairing codes. The creator can read the code again until it is used, cancelled or expired.
create table public.invites (
  id uuid primary key default gen_random_uuid(),
  created_by uuid not null references public.profiles (id) on delete cascade,
  code text not null unique default private.new_invite_code(),
  expires_at timestamptz not null default now() + interval '7 days',
  used_at timestamptz,
  used_by uuid references public.profiles (id) on delete set null,
  cancelled_at timestamptz,
  created_at timestamptz not null default now()
);
create index invites_created_by_idx on public.invites (created_by, created_at desc);
create index invites_used_by_idx on public.invites (used_by);

create function private.invites_left(p_user_id uuid) returns integer
language sql stable as $$
  select greatest(0, 10 - (select count(*) from public.invites
                           where created_by = p_user_id and created_at > now() - interval '1 day'))::integer;
$$;

-- A new invite replaces the creator's pending ones, so only one code is ever live.
create function private.before_invite_insert() returns trigger
language plpgsql as $$
begin
  if private.couple_of(new.created_by) is not null then
    perform private.reject('ALREADY_PAIRED');
  end if;
  if private.invites_left(new.created_by) <= 0 then
    perform private.reject('RATE_LIMITED');
  end if;
  new.code := private.new_invite_code();
  new.expires_at := now() + interval '7 days';
  new.created_at := now();
  update public.invites set cancelled_at = now()
  where created_by = new.created_by and used_at is null and cancelled_at is null;
  return new;
end $$;
create trigger invites_before_insert before insert on public.invites
  for each row execute function private.before_invite_insert();

-- Cancelling is the only change a creator makes; the time is the server's.
create function private.before_invite_update() returns trigger
language plpgsql as $$
begin
  if new.cancelled_at is not null and old.cancelled_at is null then
    new.cancelled_at := now();
  else
    new.cancelled_at := old.cancelled_at;
  end if;
  return new;
end $$;
create trigger invites_before_update before update of cancelled_at on public.invites
  for each row execute function private.before_invite_update();

-- Failed and successful attempts to accept a code, kept one day for the hourly limit.
create table private.invite_attempts (
  user_id uuid not null references public.profiles (id) on delete cascade,
  attempted_at timestamptz not null default now()
);
create index invite_attempts_user_idx on private.invite_attempts (user_id, attempted_at);

create function private.bootstrap_profile(p_user_id uuid, p_name text) returns void
language plpgsql as $$
begin
  insert into public.profiles (id, display_name)
  values (p_user_id, nullif(left(btrim(coalesce(p_name, '')), 60), ''))
  on conflict (id) do nothing;
  insert into public.user_settings (user_id) values (p_user_id) on conflict (user_id) do nothing;
end $$;

-- Auth writes `display_name` as the e-mail when the provider sends no name; that is not a name.
create function private.handle_new_user() returns trigger
language plpgsql security definer set search_path = '' as $$
begin
  perform private.bootstrap_profile(new.id, case when new.display_name is distinct from new.email::text then new.display_name end);
  return new;
end $$;
create trigger mingo_bootstrap_profile after insert on auth.users
  for each row execute function private.handle_new_user();

create table public.devices (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  token text not null unique check (char_length(token) between 10 and 4096),
  platform text not null references public.device_platform (value),
  label text check (char_length(label) <= 80),
  failure_count integer not null default 0,
  created_at timestamptz not null default now(),
  last_seen_at timestamptz not null default now()
);
create index devices_user_idx on public.devices (user_id);

-- Registering a token again refreshes it and clears its failures.
create function private.before_device_update() returns trigger
language plpgsql as $$
begin
  new.last_seen_at := now();
  new.failure_count := 0;
  return new;
end $$;
create trigger devices_before_update before update of token, platform, label on public.devices
  for each row execute function private.before_device_update();

create table public.notification_settings (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  enabled boolean not null default true,
  card_day smallint not null default 0 check (card_day between 0 and 6),
  card_hour smallint not null default 18 check (card_hour between 0 and 23),
  daily_max smallint not null default 2 check (daily_max between 0 and 2),
  updated_at timestamptz not null default now()
);
create trigger notification_settings_set_updated_at before update on public.notification_settings
  for each row execute function private.set_updated_at();

-- One row per notification type the person switched off.
create table public.notification_mutes (
  user_id uuid not null references public.profiles (id) on delete cascade,
  type text not null references public.notification_type (value),
  primary key (user_id, type)
);

create function private.create_notification_settings() returns trigger
language plpgsql as $$
begin
  insert into public.notification_settings (user_id) values (new.id) on conflict do nothing;
  return new;
end $$;
create trigger profiles_create_notification_settings after insert on public.profiles
  for each row execute function private.create_notification_settings();

-- Queue of pushes. A row is generic: a type and a reference id, never names or content. An event trigger delivers each row.
create table private.notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  type text not null references public.notification_type (value),
  ref_id uuid,
  dedupe_key text unique,
  outcome text check (outcome in ('sent', 'dropped', 'no_device')),
  created_at timestamptz not null default now(),
  settled_at timestamptz
);
create index notifications_user_sent_idx on private.notifications (user_id, settled_at) where outcome = 'sent';

create function private.notify(p_user_id uuid, p_type text, p_ref_id uuid default null, p_dedupe_key text default null) returns void
language sql volatile as $$
  insert into private.notifications (user_id, type, ref_id, dedupe_key)
  select p_user_id, p_type, p_ref_id, p_dedupe_key where p_user_id is not null
  on conflict (dedupe_key) do nothing;
$$;

-- Whether the partner started this notification. Those are never silenced by a quiet moment or counted in the daily cap.
create function private.is_partner_initiated(p_type text) returns boolean
language sql immutable as $$
  select p_type in ('card_received', 'card_reaction', 'partner_joined', 'unpaired', 'partner_message', 'game_invite', 'signal');
$$;

-- Decides one notification and returns the devices to push to; no row means nothing is sent. The person's settings,
-- muted types and daily cap apply, and reminders stay silent for 24 hours after a "fight" temperature.
create function private.claim_notification(notification_id uuid) returns setof public.devices
language plpgsql volatile as $$
declare
  n private.notifications;
  s public.notification_settings;
  v_drop boolean;
begin
  select * into n from private.notifications where id = notification_id and outcome is null for update;
  if not found then return; end if;
  select * into s from public.notification_settings where user_id = n.user_id;
  v_drop := s.user_id is null or not s.enabled
    or exists (select 1 from public.notification_mutes m where m.user_id = n.user_id and m.type = n.type);
  if not v_drop and not private.is_partner_initiated(n.type) then
    v_drop := private.is_quiet_moment(n.user_id)
      or (select count(*) from private.notifications o
          where o.user_id = n.user_id and o.outcome = 'sent' and o.settled_at > now() - interval '24 hours'
            and not private.is_partner_initiated(o.type)) >= s.daily_max;
  end if;
  if v_drop then
    update private.notifications set outcome = 'dropped', settled_at = now() where id = n.id;
    return;
  end if;
  if not exists (select 1 from public.devices d where d.user_id = n.user_id) then
    update private.notifications set outcome = 'no_device', settled_at = now() where id = n.id;
    return;
  end if;
  return query select d.* from public.devices d where d.user_id = n.user_id;
end $$;

-- Records a delivery. A token the push service rejected three times in a row is removed. The tokens arrive as JSON so
-- the argument is the same GraphQL type on both engines.
create function private.complete_notification(notification_id uuid, failed_tokens jsonb default '[]') returns setof public.devices
language plpgsql volatile as $$
declare v_failed text[] := coalesce(array(select jsonb_array_elements_text(failed_tokens)), '{}');
begin
  update private.notifications set outcome = 'sent', settled_at = now() where id = notification_id and outcome is null;
  update public.devices set failure_count = failure_count + 1 where token = any (v_failed);
  return query delete from public.devices where failure_count >= 3 returning *;
end $$;

create function private.on_card_sent() returns trigger
language plpgsql as $$
begin
  perform private.notify(new.recipient_id, 'card_received', new.id, 'card_received:' || new.id);
  return new;
end $$;
create trigger cards_after_sent after update of status on public.cards
  for each row when (new.status = 'sent' and old.status <> 'sent') execute function private.on_card_sent();

create function private.on_card_reaction() returns trigger
language plpgsql as $$
begin
  perform private.notify((select author_id from public.cards where id = new.card_id), 'card_reaction', new.card_id,
                         'card_reaction:' || new.card_id);
  return new;
end $$;
create trigger card_reactions_after_write after insert on public.card_reactions
  for each row execute function private.on_card_reaction();

create function private.on_member_joined() returns trigger
language plpgsql as $$
begin
  if new.role = 'inviter' then
    perform private.notify(new.user_id, 'partner_joined', new.couple_id, 'partner_joined:' || new.couple_id);
  end if;
  return new;
end $$;
create trigger couple_members_after_insert after insert on public.couple_members
  for each row execute function private.on_member_joined();

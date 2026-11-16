-- Tempero: an adult mode that exists only while both people switched it on. Answers stay private, only a match is shown,
-- and turning it off removes everything for both.

alter table public.user_settings
  add column spice_max_level smallint not null default 1 check (spice_max_level between 1 and 3),
  add column spice_notifications boolean not null default false;

alter table public.content_items add column level smallint check (level is null or level between 1 and 3);
insert into public.content_kind (value) values ('spice_desire'), ('spice_challenge') on conflict do nothing;
select private.create_enum('spice_answer', 'want', 'maybe', 'not_today');

create table public.spice_desire_answers (
  user_id uuid not null references public.profiles (id) on delete cascade,
  content_slug text not null check (char_length(content_slug) between 1 and 80),
  answer text not null references public.spice_answer (value),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, content_slug)
);
create trigger spice_desire_answers_set_updated_at before update on public.spice_desire_answers
  for each row execute function private.set_updated_at();

create table public.spice_card_plays (
  id uuid primary key default gen_random_uuid(),
  couple_id uuid not null references public.couples (id) on delete cascade,
  content_slug text not null,
  proposed_by uuid not null references public.profiles (id) on delete cascade,
  accepted_by uuid references public.profiles (id) on delete set null,
  declined_at timestamptz,
  created_at timestamptz not null default now()
);
create index spice_card_plays_couple_idx on public.spice_card_plays (couple_id, created_at desc);

create table public.spice_challenges (
  id uuid primary key default gen_random_uuid(),
  couple_id uuid not null references public.couples (id) on delete cascade,
  week_start date not null,
  content_slug text not null,
  swaps smallint not null default 0 check (swaps <= 3),
  accepted_by uuid[] not null default '{}',
  done_by uuid[] not null default '{}',
  seen_by uuid[] not null default '{}',
  created_at timestamptz not null default now(),
  unique (couple_id, week_start)
);

create table public.spice_states (
  state text not null,
  my_level smallint,
  couple_level smallint
);

-- Helpers ---------------------------------------------------------------------------------------------------------------
-- off: I am off. waiting_partner: I am on, the partner is not. partner_wants: I am off, the partner is on. on: both.
create function private.spice_state(p_user_id uuid) returns text
language sql stable as $$
  select case
    when mine and theirs then 'on'
    when mine then 'waiting_partner'
    when theirs then 'partner_wants'
    else 'off' end
  from (select coalesce((select spice_enabled from public.user_settings where user_id = p_user_id), false) as mine,
               coalesce((select spice_enabled from public.user_settings where user_id = private.partner_of(p_user_id)), false) as theirs) s;
$$;

-- The gentlest of the two limits, the only level either of them has agreed to.
create function private.spice_couple_level(p_user_id uuid) returns smallint
language sql stable as $$
  select least(
    coalesce((select spice_max_level from public.user_settings where user_id = p_user_id), 1),
    coalesce((select spice_max_level from public.user_settings where user_id = private.partner_of(p_user_id)), 1))::smallint;
$$;

create or replace function private.spice_cards_this_week(p_user_id uuid) returns integer
language sql stable as $$
  select count(*)::integer from public.spice_card_plays p
  where p.couple_id = private.couple_of(p_user_id)
    and p.created_at >= (private.local_week_start(p_user_id)::timestamp at time zone (select time_zone from public.profiles where id = p_user_id));
$$;

-- Everything Tempero keeps about a couple.
create function private.wipe_spice_couple(p_couple_id uuid) returns void
language plpgsql volatile as $$
begin
  delete from public.spice_card_plays where couple_id = p_couple_id;
  delete from public.spice_challenges where couple_id = p_couple_id;
end $$;

-- Rules on the switch ---------------------------------------------------------------------------------------------------
-- Turning it on tells the partner who is still off, with no content. Turning it off removes the person's answers and the
-- couple's cards and challenges, and tells a partner who was on. A flag lets the unpair stay silent.
create function private.after_spice_switch() returns trigger
language plpgsql as $$
declare v_partner uuid := private.partner_of(new.user_id); v_couple uuid := private.couple_of(new.user_id);
  v_silent boolean := coalesce(current_setting('mingo.spice_silent', true), '') = '1';
begin
  if new.spice_enabled and not old.spice_enabled then
    if v_partner is not null and not v_silent
       and not coalesce((select spice_enabled from public.user_settings where user_id = v_partner), false) then
      perform private.notify(v_partner, 'spice_invite', v_couple, 'spice_invite:' || v_couple || ':' || new.user_id || ':' || now()::date);
    end if;
  elsif old.spice_enabled and not new.spice_enabled then
    delete from public.spice_desire_answers where user_id = new.user_id;
    if v_couple is not null then
      perform private.wipe_spice_couple(v_couple);
      if v_partner is not null and not v_silent
         and coalesce((select spice_enabled from public.user_settings where user_id = v_partner), false) then
        perform private.notify(v_partner, 'spice_off', v_couple, 'spice_off:' || v_couple || ':' || now()::date);
      end if;
    end if;
  end if;
  return null;
end $$;
create trigger user_settings_spice_switch after update of spice_enabled on public.user_settings
  for each row when (old.spice_enabled is distinct from new.spice_enabled) execute function private.after_spice_switch();

-- Desires are a Plus feature and exist only while the person has the mode on.
create function private.before_spice_answer_insert() returns trigger
language plpgsql as $$
begin
  if not private.has_plus(new.user_id) then perform private.reject('PLUS_REQUIRED'); end if;
  if not coalesce((select spice_enabled from public.user_settings where user_id = new.user_id), false) then
    perform private.reject('SPICE_NOT_ON');
  end if;
  return new;
end $$;
create trigger spice_desire_answers_before_insert before insert on public.spice_desire_answers
  for each row execute function private.before_spice_answer_insert();

-- Functions -------------------------------------------------------------------------------------------------------------
create function public.spice_state(session json) returns setof public.spice_states
language sql stable security definer set search_path = '' as $$
  select private.spice_state(private.uid(session)),
         (select s.spice_max_level from public.user_settings s where s.user_id = private.uid(session)),
         case when private.spice_state(private.uid(session)) = 'on' then private.spice_couple_level(private.uid(session)) end;
$$;

-- One evening card at a time. The open card is returned again instead of a new one.
create function public.spice_next_card(session json) returns setof public.spice_card_plays
language plpgsql volatile security definer set search_path = '' as $$
declare v_uid uuid := private.uid(session); v_couple uuid := private.couple_of(v_uid); v_slug text; v_play public.spice_card_plays;
begin
  if private.spice_state(v_uid) <> 'on' then perform private.reject('SPICE_NOT_ON'); end if;
  select * into v_play from public.spice_card_plays p
  where p.couple_id = v_couple and p.accepted_by is null and p.declined_at is null order by p.created_at desc limit 1;
  if found then return next v_play; return; end if;
  if not private.has_plus(v_uid)
     and private.spice_cards_this_week(v_uid) >= private.config_int('free_spice_cards_per_week', 3) then
    perform private.reject('FREE_LIMIT_REACHED');
  end if;
  select c.slug into v_slug from public.content_items c
  where c.kind = 'spice_card' and c.published and c.level <= private.spice_couple_level(v_uid)
    and c.locale = (select locale from public.user_settings where user_id = v_uid)
    and not exists (select 1 from public.spice_card_plays p where p.couple_id = v_couple and p.content_slug = c.slug)
  order by c.position, c.slug limit 1;
  if v_slug is null then return; end if;
  insert into public.spice_card_plays (couple_id, content_slug, proposed_by) values (v_couple, v_slug, v_uid) returning * into v_play;
  return next v_play;
end $$;

-- The other person says yes or "not today". A "no" is never explained and never announced.
create function public.spice_respond_card("playId" uuid, accept boolean, session json) returns setof public.spice_card_plays
language plpgsql volatile security definer set search_path = '' as $$
declare v_uid uuid := private.uid(session);
begin
  if private.spice_state(v_uid) <> 'on' then return; end if;
  return query
  update public.spice_card_plays p
  set accepted_by = case when accept then v_uid end, declined_at = case when accept then null else now() end
  where p.id = "playId" and p.couple_id = private.couple_of(v_uid) and p.proposed_by <> v_uid
    and p.accepted_by is null and p.declined_at is null
  returning p.*;
end $$;

-- Desires both people want, and nothing else. Maybe and "not today" are never exposed.
create function public.spice_matches(session json) returns setof public.catalog_items
language plpgsql stable security definer set search_path = '' as $$
declare v_uid uuid := private.uid(session); v_partner uuid;
begin
  if private.spice_state(v_uid) <> 'on' then return; end if;
  if not private.has_plus(v_uid) then perform private.reject('PLUS_REQUIRED'); end if;
  v_partner := private.partner_of(v_uid);
  return query
  select c.id, c.kind, c.slug, c.locale, c.title, c.body, c.parent_slug, c.position, c.tags, c.month, c.day, c.country,
         c.plus_only, c.sensitive, false
  from public.content_items c
  join public.spice_desire_answers mine on mine.user_id = v_uid and mine.content_slug = c.slug and mine.answer = 'want'
  join public.spice_desire_answers theirs on theirs.user_id = v_partner and theirs.content_slug = c.slug and theirs.answer = 'want'
  where c.kind = 'spice_desire' and c.published and c.level <= private.spice_couple_level(v_uid)
    and c.locale = (select locale from public.user_settings where user_id = v_uid)
  order by c.level, c.position, c.slug;
end $$;

create function private.pick_spice_challenge(p_user_id uuid) returns text
language sql stable as $$
  select c.slug from public.content_items c
  where c.kind = 'spice_challenge' and c.published and c.level <= private.spice_couple_level(p_user_id)
    and c.locale = (select locale from public.user_settings where user_id = p_user_id)
    and not exists (select 1 from public.spice_challenges x where x.couple_id = private.couple_of(p_user_id) and x.content_slug = c.slug)
  order by c.position, c.slug limit 1;
$$;

-- This week's challenge for the couple, created on first ask. No points and no deadline.
create function public.spice_challenge(session json) returns setof public.spice_challenges
language plpgsql volatile security definer set search_path = '' as $$
declare v_uid uuid := private.uid(session); v_couple uuid := private.couple_of(v_uid);
  v_week date := private.local_week_start(v_uid); v_slug text;
begin
  if private.spice_state(v_uid) <> 'on' then perform private.reject('SPICE_NOT_ON'); end if;
  if not exists (select 1 from public.spice_challenges c where c.couple_id = v_couple and c.week_start = v_week) then
    v_slug := private.pick_spice_challenge(v_uid);
    if v_slug is null then return; end if;
    insert into public.spice_challenges (couple_id, week_start, content_slug) values (v_couple, v_week, v_slug)
    on conflict (couple_id, week_start) do nothing;
  end if;
  return query select c.* from public.spice_challenges c where c.couple_id = v_couple and c.week_start = v_week;
end $$;

create function public.spice_challenge_act(action text, session json) returns setof public.spice_challenges
language plpgsql volatile security definer set search_path = '' as $$
declare v_uid uuid := private.uid(session); v_couple uuid := private.couple_of(v_uid);
  v_week date := private.local_week_start(v_uid); v_row public.spice_challenges; v_slug text;
begin
  if private.spice_state(v_uid) <> 'on' then perform private.reject('SPICE_NOT_ON'); end if;
  select * into v_row from public.spice_challenges c where c.couple_id = v_couple and c.week_start = v_week for update;
  if not found then return; end if;
  if action = 'seen' then
    return query update public.spice_challenges c set seen_by = case when v_uid = any (c.seen_by) then c.seen_by else c.seen_by || v_uid end
      where c.id = v_row.id returning c.*;
  elsif action = 'accept' then
    return query update public.spice_challenges c set accepted_by = case when v_uid = any (c.accepted_by) then c.accepted_by else c.accepted_by || v_uid end
      where c.id = v_row.id returning c.*;
  elsif action = 'done' then
    return query update public.spice_challenges c set done_by = case when v_uid = any (c.done_by) then c.done_by else c.done_by || v_uid end
      where c.id = v_row.id returning c.*;
  elsif action = 'swap' then
    if v_row.swaps >= 3 then perform private.reject('SWAP_LIMIT'); end if;
    v_slug := private.pick_spice_challenge(v_uid);
    if v_slug is null then return; end if;
    return query update public.spice_challenges c
      set content_slug = v_slug, swaps = c.swaps + 1, accepted_by = '{}', done_by = '{}', seen_by = '{}'
      where c.id = v_row.id returning c.*;
  else
    perform private.reject('INVALID_ACTION');
  end if;
end $$;

-- Switches the mode off for both people and removes what it kept. A second call, or a call while off, does nothing.
create function public.spice_off(session json) returns setof public.user_settings
language plpgsql volatile security definer set search_path = '' as $$
declare v_uid uuid := private.uid(session); v_partner uuid := private.partner_of(v_uid);
begin
  if not coalesce((select spice_enabled from public.user_settings where user_id = v_uid), false) then return; end if;
  update public.user_settings set spice_enabled = false where user_id = v_uid;
  if v_partner is not null then
    update public.user_settings set spice_enabled = false where user_id = v_partner;
    delete from public.spice_desire_answers where user_id in (v_uid, v_partner);
  end if;
  return query select s.* from public.user_settings s where s.user_id = v_uid;
end $$;

-- A push about Tempero needs the person's explicit yes; the inbox row is always there.
create or replace function private.claim_notification(notification_id uuid) returns setof public.devices
language plpgsql volatile as $$
declare
  n private.notifications;
  s public.notification_settings;
  v_drop boolean;
begin
  select * into n from private.notifications where id = notification_id and outcome is null for update;
  if not found then return; end if;
  select * into s from public.notification_settings where user_id = n.user_id;
  v_drop := s.user_id is null or not s.enabled or private.is_inbox_only(n.type)
    or exists (select 1 from public.notification_mutes m where m.user_id = n.user_id and m.type = n.type)
    or (n.type like 'spice\_%'
        and not coalesce((select u.spice_notifications from public.user_settings u where u.user_id = n.user_id), false));
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

-- Tempero kinds are returned by the catalog only while both people have the mode on.
create or replace function public.content_catalog(session json, kind text default null, locale text default null)
returns setof public.catalog_items language sql stable as $$
  select c.id, c.kind, c.slug, c.locale, c.title,
         case when c.plus_only and not private.has_plus(private.uid(session)) then null else c.body end,
         c.parent_slug, c.position, c.tags, c.month, c.day, c.country, c.plus_only, c.sensitive,
         c.plus_only and not private.has_plus(private.uid(session))
  from public.content_items c
  where c.published
    and (content_catalog.kind is null or c.kind = content_catalog.kind)
    and (content_catalog.locale is null or c.locale = content_catalog.locale)
    and (c.kind not in ('spice_card', 'spice_desire', 'spice_challenge') or private.spice_on(private.uid(session)))
  order by c.kind, c.position, c.slug;
$$;

-- Unpairing removes the mode for both, silently, with everything it kept.
create or replace function private.end_couple(p_couple_id uuid, p_actor uuid) returns void
language plpgsql volatile as $$
begin
  perform set_config('mingo.spice_silent', '1', true);
  update public.user_settings set spice_enabled = false
  where user_id in (select user_id from public.couple_members where couple_id = p_couple_id) and spice_enabled;
  delete from public.spice_desire_answers where user_id in (select user_id from public.couple_members where couple_id = p_couple_id);
  perform private.wipe_spice_couple(p_couple_id);
  perform private.notify(m.user_id, 'unpaired', p_couple_id, 'unpaired:' || p_couple_id || ':' || m.user_id)
  from public.couple_members m where m.couple_id = p_couple_id and m.user_id <> p_actor;
  delete from public.couple_photos where couple_id = p_couple_id;
  delete from public.gentle_requests r
  where r.sender_id in (select user_id from public.couple_members where couple_id = p_couple_id)
    and r.recipient_id in (select user_id from public.couple_members where couple_id = p_couple_id);
  update public.game_sessions set status = 'cancelled' where couple_id = p_couple_id and status in ('invited', 'active');
  delete from public.couple_members where couple_id = p_couple_id;
  update public.couples set ended_at = now() where id = p_couple_id;
end $$;

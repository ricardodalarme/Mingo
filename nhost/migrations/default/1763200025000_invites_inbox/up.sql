-- Invite states for the join screens, and the inbox with the notification types the new features create.

-- WP-07 ---------------------------------------------------------------------------------------------------------------
create table public.invite_statuses (
  state text not null,
  inviter_name text,
  expires_at timestamptz
);

-- What a code is, without revealing who used it. The name is shown only while the code is valid.
create function public.invite_status(code text) returns setof public.invite_statuses
language sql stable security definer set search_path = '' as $$
  select case when i.cancelled_at is not null then 'cancelled'
              when i.used_at is not null then 'used'
              when i.expires_at <= now() then 'expired'
              else 'valid' end,
         case when i.cancelled_at is null and i.used_at is null and i.expires_at > now()
              then split_part(btrim(p.display_name), ' ', 1) end,
         case when i.cancelled_at is null and i.used_at is null and i.expires_at > now() then i.expires_at end
  from public.invites i join public.profiles p on p.id = i.created_by
  where i.code = private.normalize_invite_code(invite_status.code)
  union all
  select 'unknown', null, null
  where not exists (select 1 from public.invites i where i.code = private.normalize_invite_code(invite_status.code));
$$;

create table public.invite_accept_results (
  state text not null
);

-- Accepts the code and says why it did not work. One attempt log for both entry points.
create function private.accept_invite_state(p_uid uuid, p_code text) returns text
language plpgsql volatile as $$
declare v_invite public.invites; v_couple uuid;
begin
  insert into private.invite_attempts (user_id) values (p_uid);
  if (select count(*) from private.invite_attempts
      where user_id = p_uid and attempted_at > now() - interval '1 hour') > 10 then
    return 'rate_limited';
  end if;
  select * into v_invite from public.invites i where i.code = private.normalize_invite_code(p_code) for update;
  if not found then return 'unknown'; end if;
  if v_invite.created_by = p_uid then return 'own_code'; end if;
  if v_invite.cancelled_at is not null then return 'cancelled'; end if;
  if private.partner_of(p_uid) = v_invite.created_by then return 'already_connected'; end if;
  if v_invite.used_at is not null then return 'used'; end if;
  if v_invite.expires_at <= now() then return 'expired'; end if;
  if private.couple_of(p_uid) is not null then return 'you_are_paired'; end if;
  if private.couple_of(v_invite.created_by) is not null then return 'they_are_paired'; end if;
  insert into public.couples default values returning id into v_couple;
  insert into public.couple_members (couple_id, user_id, role)
  values (v_couple, v_invite.created_by, 'inviter'), (v_couple, p_uid, 'invitee');
  update public.question_answers set couple_id = v_couple
  where author_id in (v_invite.created_by, p_uid) and couple_id is null;
  update public.invites set used_at = now(), used_by = p_uid where id = v_invite.id;
  update public.invites set cancelled_at = now()
  where created_by = p_uid and used_at is null and cancelled_at is null;
  return 'accepted';
end $$;

create function public.try_accept_invite(code text, session json) returns setof public.invite_accept_results
language sql volatile as $$
  select private.accept_invite_state(private.uid(session), try_accept_invite.code);
$$;

-- Kept for older app versions: the profile on success or when already connected, nothing otherwise.
create or replace function public.accept_invite(code text, session json) returns setof public.profiles
language plpgsql volatile as $$
declare v_uid uuid := private.uid(session);
begin
  if private.accept_invite_state(v_uid, accept_invite.code) in ('accepted', 'already_connected') then
    return query select p.* from public.profiles p where p.id = v_uid;
  end if;
end $$;

-- WP-08 ---------------------------------------------------------------------------------------------------------------
insert into public.notification_type (value) values
  ('gentle_request'), ('gentle_request_answered'), ('quiz_shared'), ('spice_invite'), ('spice_off'),
  ('memory_proposed'), ('memory_accepted'), ('memory_declined'), ('annoyance_check'), ('plus_billing_issue'),
  ('plus_coverage_ended')
on conflict do nothing;

alter table public.inbox_items add column dedupe_key text unique;

-- Types that live only in the inbox: they are never pushed.
create function private.is_inbox_only(p_type text) returns boolean
language sql immutable as $$
  select p_type in ('annoyance_check', 'plus_billing_issue', 'plus_coverage_ended');
$$;

create function private.notify_inbox(p_user_id uuid, p_type text, p_ref_id uuid default null, p_dedupe_key text default null) returns void
language plpgsql volatile as $$
begin
  if p_user_id is null
     or exists (select 1 from public.notification_mutes m where m.user_id = p_user_id and m.type = p_type) then
    return;
  end if;
  insert into public.inbox_items (user_id, type, ref_id, dedupe_key) values (p_user_id, p_type, p_ref_id, p_dedupe_key)
  on conflict (dedupe_key) do nothing;
end $$;

-- Lists the notification in the inbox, whether or not it is pushed, and queues the push when the type allows one.
create or replace function private.notify(p_user_id uuid, p_type text, p_ref_id uuid default null, p_dedupe_key text default null) returns void
language plpgsql volatile as $$
begin
  if p_user_id is null then return; end if;
  perform private.notify_inbox(p_user_id, p_type, p_ref_id, p_dedupe_key);
  if private.is_inbox_only(p_type) then return; end if;
  insert into private.notifications (user_id, type, ref_id, dedupe_key)
  values (p_user_id, p_type, p_ref_id, p_dedupe_key)
  on conflict (dedupe_key) do nothing;
end $$;

create or replace function private.is_partner_initiated(p_type text) returns boolean
language sql immutable as $$
  select p_type in ('card_received', 'card_reaction', 'partner_joined', 'unpaired', 'partner_message', 'game_invite', 'signal',
    'gentle_request', 'gentle_request_answered', 'quiz_shared', 'spice_invite', 'spice_off', 'memory_proposed',
    'memory_accepted', 'memory_declined');
$$;

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

-- The owner learns about a payment problem; the partner covered by that plan is not told.
create function private.after_entitlement_change() returns trigger
language plpgsql as $$
declare v_partner uuid := private.partner_of(new.user_id);
begin
  if new.status = 'billing_issue' and old.status is distinct from 'billing_issue' then
    perform private.notify_inbox(new.user_id, 'plus_billing_issue', null, 'plus_billing_issue:' || new.user_id || ':' || new.updated_at);
  end if;
  if v_partner is not null and private.entitlement_is_live(old) and not private.entitlement_is_live(new)
     and not exists (select 1 from public.entitlements e where e.user_id = v_partner and private.entitlement_is_live(e)) then
    perform private.notify_inbox(v_partner, 'plus_coverage_ended', null, 'plus_coverage_ended:' || new.user_id || ':' || new.updated_at);
  end if;
  return null;
end $$;
create trigger entitlements_after_change after update on public.entitlements
  for each row execute function private.after_entitlement_change();

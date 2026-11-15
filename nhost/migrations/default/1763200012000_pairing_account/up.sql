-- Ends the shared space for both. Private data of each person is untouched; shared rows become unreachable for the
-- partner at once. The person who did not start it gets a neutral notice.
create function private.end_couple(p_couple_id uuid, p_actor uuid) returns void
language plpgsql volatile as $$
begin
  perform private.notify(m.user_id, 'unpaired', p_couple_id, 'unpaired:' || p_couple_id || ':' || m.user_id)
  from public.couple_members m where m.couple_id = p_couple_id and m.user_id <> p_actor;
  delete from public.couple_photos where couple_id = p_couple_id;
  update public.game_sessions set status = 'cancelled' where couple_id = p_couple_id and status in ('invited', 'active');
  delete from public.couple_members where couple_id = p_couple_id;
  update public.couples set ended_at = now() where id = p_couple_id;
end $$;

-- Pairs the caller with the creator of a code. No row for any code that cannot be used (unknown, expired, used,
-- cancelled, the caller's own, either side already paired) or after ten attempts in an hour: one generic answer, so
-- codes cannot be enumerated. Returns the caller's profile on success, also when a successful call is repeated.
-- The new couple is not readable inside this call: read it with the next query.
create function public.accept_invite(code text, session json) returns setof public.profiles
language plpgsql volatile as $$
declare
  v_uid uuid := private.uid(session);
  v_invite public.invites;
  v_couple uuid;
begin
  insert into private.invite_attempts (user_id) values (v_uid);
  if (select count(*) from private.invite_attempts
      where user_id = v_uid and attempted_at > now() - interval '1 hour') > 10 then
    return;
  end if;
  select * into v_invite from public.invites i where i.code = private.normalize_invite_code(accept_invite.code) for update;
  if not found or v_invite.cancelled_at is not null or v_invite.created_by = v_uid then
    return;
  end if;
  if v_invite.used_at is not null then
    if v_invite.used_by = v_uid and private.partner_of(v_uid) = v_invite.created_by then
      return query select p.* from public.profiles p where p.id = v_uid;
    end if;
    return;
  end if;
  if v_invite.expires_at <= now() or private.couple_of(v_uid) is not null
     or private.couple_of(v_invite.created_by) is not null then
    return;
  end if;
  insert into public.couples default values returning id into v_couple;
  insert into public.couple_members (couple_id, user_id, role)
  values (v_couple, v_invite.created_by, 'inviter'), (v_couple, v_uid, 'invitee');
  update public.question_answers set couple_id = v_couple
  where author_id in (v_invite.created_by, v_uid) and couple_id is null;
  update public.invites set used_at = now(), used_by = v_uid where id = v_invite.id;
  update public.invites set cancelled_at = now()
  where created_by = v_uid and used_at is null and cancelled_at is null;
  return query select p.* from public.profiles p where p.id = v_uid;
end $$;

-- Ends the caller's couple and returns the caller's profile. No row when the caller has no partner.
create function public.unpair(session json) returns setof public.profiles
language plpgsql volatile as $$
declare v_uid uuid := private.uid(session); v_couple uuid := private.couple_of(v_uid);
begin
  if v_couple is null then return; end if;
  perform private.end_couple(v_couple, v_uid);
  return query select p.* from public.profiles p where p.id = v_uid;
end $$;

-- After the couple ended: keeps what the caller created in the shared space as private rows, or deletes it.
-- No row while the caller still has a partner.
create function public.resolve_shared_items(keep boolean, session json) returns setof public.profiles
language plpgsql volatile as $$
declare v_uid uuid := private.uid(session); t text;
begin
  if private.couple_of(v_uid) is not null then return; end if;
  foreach t in array private.shared_tables() loop
    if keep then
      execute format('update public.%I set couple_id = null where author_id = $1 and couple_id is not null', t) using v_uid;
    else
      execute format('delete from public.%I where author_id = $1 and couple_id is not null', t) using v_uid;
    end if;
  end loop;
  return query select p.* from public.profiles p where p.id = v_uid;
end $$;

-- Asking to delete the account ends the pairing right away; the partner sees a neutral "unpaired" state.
create function private.before_deletion_request_insert() returns trigger
language plpgsql as $$
declare v_couple uuid := private.couple_of(new.user_id);
begin
  new.requested_at := now();
  new.purge_after := now() + interval '14 days';
  if v_couple is not null then
    perform private.end_couple(v_couple, new.user_id);
  end if;
  return new;
end $$;
create trigger deletion_requests_before_insert before insert on public.deletion_requests
  for each row execute function private.before_deletion_request_insert();

-- Erases one person: queues every file they uploaded, then removes the auth user; every table cascades from it.
create function private.erase_account(p_user_id uuid) returns void
language plpgsql volatile security definer set search_path = '' as $$
begin
  insert into private.file_deletions (file_id)
  select f.id from storage.files f where f.uploaded_by_user_id = p_user_id
  on conflict do nothing;
  delete from auth.users where id = p_user_id;
end $$;

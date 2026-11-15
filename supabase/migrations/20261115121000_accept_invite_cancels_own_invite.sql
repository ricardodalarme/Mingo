-- A person who accepts an invite is paired, so the invite they had created can never be used.
-- Cancelling it in the same transaction leaves no dead code for the other side and keeps two couples from forming.

SET local check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.accept_invite (
  code text
)
  RETURNS public.couples
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
declare
  v_uid uuid := private.require_user();
  v_invite public.invites;
  v_couple public.couples;
begin
  if not private.hit_rate_limit('accept_invite:' || v_uid, 10, interval '1 hour') then
    raise exception 'RATE_LIMITED' using errcode = 'P0001';
  end if;
  select * into v_invite from public.invites where code_hash = private.hash_invite_code(code) for update;
  if not found or v_invite.cancelled_at is not null or v_invite.created_by = v_uid then
    return null;
  end if;
  if v_invite.used_at is not null then
    -- Retry after a dropped response: same person, still paired with the inviter.
    if v_invite.used_by = v_uid then
      select c.* into v_couple from public.couples c
      where c.id = private.current_couple_id()
        and exists (select 1 from public.couple_members m
                    where m.couple_id = c.id and m.profile_id = v_invite.created_by and m.left_at is null);
      return v_couple;
    end if;
    return null;
  end if;
  if v_invite.expires_at <= now()
     or private.current_couple_id() is not null
     or exists (select 1 from public.couple_members where profile_id = v_invite.created_by and left_at is null) then
    return null;
  end if;
  insert into public.couples default values returning * into v_couple;
  insert into public.couple_members (couple_id, profile_id, role)
  values (v_couple.id, v_invite.created_by, 'inviter'), (v_couple.id, v_uid, 'invitee');
  update public.question_answers set couple_id = v_couple.id
  where author_id in (v_invite.created_by, v_uid) and couple_id is null;
  update public.invites set used_at = now(), used_by = v_uid where id = v_invite.id;
  update public.invites set cancelled_at = now()
  where created_by = v_uid and used_at is null and cancelled_at is null;
  return v_couple;
end $function$;

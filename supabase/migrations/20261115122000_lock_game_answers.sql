-- Once both partners answered the same item, its answers are frozen: the app maps ANSWER_LOCKED to its own message.
-- The session row is locked so two answers arriving together still see each other.

SET local check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.answer_game (
  session_id uuid,
  idx        integer,
  answer     text
)
  RETURNS boolean
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
declare v_uid uuid := private.require_user(); v_row public.game_sessions;
begin
  select * into v_row from public.game_sessions g
  where g.id = session_id and g.couple_id = private.current_couple_id() and g.status = 'active'
  for update;
  if not found then raise exception 'NOT_FOUND' using errcode = 'P0001'; end if;
  if answer_game.idx < 0 or answer_game.idx >= coalesce(array_length(v_row.item_slugs, 1), 0) then
    raise exception 'INVALID_GAME_INDEX' using errcode = 'P0001';
  end if;
  if (select count(*) from public.game_answers a
      join public.couple_members m on m.profile_id = a.author_id and m.couple_id = v_row.couple_id and m.left_at is null
      where a.session_id = v_row.id and a.idx = answer_game.idx) >= 2 then
    raise exception 'ANSWER_LOCKED' using errcode = 'P0001';
  end if;
  insert into public.game_answers as a (session_id, author_id, idx, answer)
  values (answer_game.session_id, v_uid, answer_game.idx, answer_game.answer)
  on conflict on constraint game_answers_once do update set answer = excluded.answer;
  return true;
end $function$;

COMMENT ON FUNCTION "public"."answer_game"(uuid, integer, text) IS '@graphql({"description": "Saves the caller''s answer to one item of an active game. Once both partners answered an item, it is locked and the call fails with ANSWER_LOCKED."})';

-- The mascot chat is always available: the person no longer switches it on, so the setting and its check go away.
create or replace function public.take_chat_turn(session json) returns setof public.chat_turns
language plpgsql volatile as $$
declare v_uid uuid := private.uid(session);
begin
  perform pg_advisory_xact_lock(hashtextextended(v_uid::text, 0));
  if private.chat_messages_left(v_uid) <= 0 then
    return;
  end if;
  return query insert into public.chat_turns (user_id) values (v_uid) returning *;
end $$;

comment on function public.take_chat_turn(json) is 'Reserves one mascot message for the caller. No row when today''s allowance is gone.';

alter table public.user_settings drop column chat_enabled;

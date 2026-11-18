-- Home widgets have no settings: the sender decides which note goes to the widget, and what a widget shows already
-- follows what the server lets each person read.

-- A note reaches the recipient's widget when the sender marks it, with no switch on the recipient's side.
create or replace function private.before_partner_message_insert() returns trigger
language plpgsql as $$
begin
  new.recipient_id := private.partner_of(new.sender_id);
  if new.recipient_id is null then perform private.reject('NOT_PAIRED'); end if;
  if private.partner_messages_left(new.sender_id) <= 0 then perform private.reject('RATE_LIMITED'); end if;
  new.body := nullif(btrim(new.body), '');
  new.created_at := now();
  new.seen_at := null; new.hearted_at := null;
  return new;
end $$;

alter table public.user_settings
  drop column widget_allow_partner_notes,
  drop column widget_on_lock_screen,
  drop column widget_show_names;

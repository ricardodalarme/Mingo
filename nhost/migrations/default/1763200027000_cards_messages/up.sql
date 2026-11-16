-- The held-card rule, clearing a reaction, and voice and drawing messages that are checked on arrival.

-- WP-10: a short, reviewable starting list of wordings that usually hurt. Product edits it with a migration.
create table private.hold_rules (
  id serial primary key,
  locale text not null check (locale in ('pt-BR', 'en')),
  pattern text not null,
  reason text not null check (reason in ('absolute', 'insult', 'blame', 'contempt'))
);

insert into private.hold_rules (locale, pattern, reason) values
  ('pt-BR', '\mvoc[eê] (sempre|nunca)\M', 'absolute'),
  ('pt-BR', '\mvoc[eê]\M.{0,40}\m(sempre|nunca) (faz|fez|foi|é)\M', 'absolute'),
  ('pt-BR', '\m(sempre|nunca) (faz|fez|foi|é)\M.{0,40}\mvoc[eê]\M', 'absolute'),
  ('pt-BR', '\mculpa sua\M', 'blame'),
  ('pt-BR', '\mnão aguento\M', 'contempt'),
  ('pt-BR', '\mid[ií]ota\M', 'insult'),
  ('pt-BR', '\mimbecil\M', 'insult'),
  ('pt-BR', '\mburr[oa]\M', 'insult'),
  ('pt-BR', '\modeio\M', 'contempt'),
  ('en', '\myou (always|never)\M', 'absolute'),
  ('en', '\myour fault\M', 'blame'),
  ('en', '\mi hate\M', 'contempt'),
  ('en', '\midiot\M', 'insult'),
  ('en', '\mstupid\M', 'insult');

alter table public.cards add column held_reason text check (held_reason in ('absolute', 'insult', 'blame', 'contempt'));

-- The reason of the first rule the note or an item matches, or null. Both languages are checked, so a mixed card is covered.
create function private.card_hold_reason(p_card_id uuid) returns text
language sql stable as $$
  with body as (
    select lower(concat_ws(E'\n', c.note,
             (select string_agg(concat_ws(' ', i.body, i.feeling), E'\n' order by i.position) from public.card_items i where i.card_id = c.id))) as text
    from public.cards c where c.id = p_card_id)
  select r.reason from private.hold_rules r, body where body.text ~* r.pattern order by r.id limit 1;
$$;

-- Without `p_anyway` a card whose wording matches a rule is held with its reason and nothing is sent.
drop function public.send_card(uuid, json);
drop function public.send_slip(uuid, json, text);
drop function private.deliver_card(uuid, uuid);

create function private.deliver_card(p_card_id uuid, p_user_id uuid, p_anyway boolean default false) returns setof public.cards
language plpgsql volatile as $$
declare v_card public.cards; v_reason text;
begin
  select * into v_card from public.cards where id = p_card_id and author_id = p_user_id for update;
  if not found or v_card.status = 'sent'
     or not exists (select 1 from public.card_items where card_id = v_card.id) then
    return;
  end if;
  update public.card_items i set body = s.body, feeling = s.feeling
  from public.slips s where i.card_id = v_card.id and s.id = i.slip_id;
  if not p_anyway then
    v_reason := private.card_hold_reason(v_card.id);
    if v_reason is not null then
      return query update public.cards c set status = 'held', held_reason = v_reason where c.id = v_card.id returning c.*;
      return;
    end if;
  end if;
  return query
  update public.cards c
  set status = 'sent', held_reason = null, sent_at = now(),
      recipient_id = private.partner_of(p_user_id), couple_id = private.couple_of(p_user_id)
  where c.id = v_card.id returning c.*;
end $$;

-- Sends a draft or held card. A card held for its wording comes back with status `held` until the person sends it anyway.
create function public.send_card("cardId" uuid, session json, anyway boolean default false) returns setof public.cards
language sql volatile as $$
  select * from private.deliver_card("cardId", private.uid(session), coalesce(anyway, false));
$$;

-- Sends one slip on its own, without touching the weekly card. A card held for its wording stays as a held card.
create function public.send_slip("slipId" uuid, session json, note text default null, anyway boolean default false)
returns setof public.cards language plpgsql volatile as $$
declare v_uid uuid := private.uid(session); v_slip public.slips; v_card uuid;
begin
  select * into v_slip from public.slips s where s.id = "slipId" and s.author_id = v_uid;
  if not found or v_slip.kind = 'invisible' or v_slip.polarity <> 'liked' then
    return;
  end if;
  insert into public.cards (author_id, week_start, kind, note)
  values (v_uid, private.local_week_start(v_uid), 'single', nullif(btrim(note), '')) returning id into v_card;
  insert into public.card_items (card_id, slip_id, body, position) values (v_card, v_slip.id, v_slip.body, 1);
  return query select * from private.deliver_card(v_card, v_uid, coalesce(anyway, false));
  if not found then
    delete from public.cards where id = v_card;
  end if;
end $$;

-- WP-11: a voice note lasts at most 30 seconds.
alter table public.partner_messages add column duration_ms integer check (duration_ms is null or duration_ms between 1 and 30000);

-- The shape of each kind and its file are checked when the message is written. The file may be removed later, so this is
-- not a table constraint.
create function private.validate_partner_message() returns trigger
language plpgsql as $$
declare v_file storage.files;
begin
  if new.kind = 'note' and new.body is null then perform private.reject('INVALID_MEDIA'); end if;
  if new.kind in ('voice', 'drawing') then
    select * into v_file from storage.files f
    where f.id = new.media_file_id and f.bucket_id = 'messages' and f.uploaded_by_user_id = new.sender_id;
    if not found then perform private.reject('INVALID_MEDIA'); end if;
    if new.kind = 'voice' and (new.duration_ms is null
         or v_file.mime_type not in ('audio/mp4', 'audio/m4a', 'audio/x-m4a', 'audio/aac', 'audio/mpeg')
         or v_file.size > 2000000) then
      perform private.reject('INVALID_MEDIA');
    end if;
    if new.kind = 'drawing' and v_file.mime_type not in ('image/png', 'image/jpeg', 'image/webp') then
      perform private.reject('INVALID_MEDIA');
    end if;
  end if;
  return new;
end $$;
-- Fires after `partner_messages_before_insert` has set the sender's partner.
create trigger partner_messages_validate before insert on public.partner_messages
  for each row execute function private.validate_partner_message();

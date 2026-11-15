-- Invariant: a slip is private to its author, and a `bothered` slip is never shared in any form. It cannot be read,
-- counted or aggregated by anyone else (the restrictive select policy keeps it author-only), it is never for the card
-- (the check constraint), and the card builders skip it so it never reaches a sent card, the jar or a shared aggregate.
SET local check_function_bodies = off;

DROP FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp WITH time zone);

CREATE TYPE "public"."slip_polarity" AS ENUM (
  'liked',
  'bothered'
);

ALTER TABLE "public"."slips"
  ADD COLUMN "polarity" public.slip_polarity NOT NULL DEFAULT 'liked'::public.slip_polarity;

CREATE OR REPLACE FUNCTION private.build_card_draft (
  p_profile_id uuid
)
  RETURNS uuid
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
declare
  v_week date := private.local_week_start(p_profile_id);
  v_tz text;
  v_card uuid;
begin
  select id into v_card from public.cards where author_id = p_profile_id and week_start = v_week and kind = 'weekly';
  if v_card is not null then
    return v_card;
  end if;
  select time_zone into v_tz from public.profile_settings where profile_id = p_profile_id;
  if not exists (
    select 1 from public.slips s
    where s.author_id = p_profile_id and s.for_card and s.kind <> 'invisible' and s.polarity = 'liked'
      and s.deleted_at is null and s.archived_at is null
      and (s.created_at at time zone v_tz)::date >= v_week) then
    return null;
  end if;
  insert into public.cards (author_id, week_start) values (p_profile_id, v_week)
  on conflict (author_id, week_start) where kind = 'weekly' do nothing returning id into v_card;
  if v_card is null then
    select id into v_card from public.cards where author_id = p_profile_id and week_start = v_week and kind = 'weekly';
    return v_card;
  end if;
  insert into public.card_items (card_id, slip_id, body, feeling, position)
  select v_card, s.id, s.body, s.feeling, row_number() over (order by s.created_at)
  from public.slips s
  where s.author_id = p_profile_id and s.for_card and s.kind <> 'invisible' and s.polarity = 'liked'
    and s.deleted_at is null and s.archived_at is null
    and (s.created_at at time zone v_tz)::date >= v_week;
  return v_card;
end $function$;

CREATE OR REPLACE FUNCTION public.draw_from_jar()
  RETURNS public.slips
  LANGUAGE sql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
  select s.* from public.slips s
  where s.author_id = auth.uid() and s.in_jar and s.polarity = 'liked' and s.deleted_at is null
  order by random() limit 1;
$function$;

CREATE OR REPLACE FUNCTION public.save_slip (
  id          uuid,
  body        text,
  kind        text                     DEFAULT 'quick'::text,
  feeling     text                     DEFAULT NULL::text,
  plan_note   text                     DEFAULT NULL::text,
  tags        text[]                   DEFAULT '{}'::text[],
  for_card    boolean                  DEFAULT true,
  occurred_on date                     DEFAULT NULL::date,
  photo_path  text                     DEFAULT NULL::text,
  created_at  timestamp with time zone DEFAULT NULL::timestamp WITH time zone,
  polarity    text                     DEFAULT 'liked'::text
)
  RETURNS public.slips
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
declare
  v_uid uuid := private.require_user();
  v_kind public.slip_kind;
  v_polarity public.slip_polarity;
  v_row public.slips;
begin
  begin
    v_kind := kind::public.slip_kind;
  exception when invalid_text_representation then
    raise exception 'INVALID_SLIP_KIND' using errcode = 'P0001';
  end;
  begin
    v_polarity := coalesce(polarity, 'liked')::public.slip_polarity;
  exception when invalid_text_representation then
    raise exception 'INVALID_SLIP_POLARITY' using errcode = 'P0001';
  end;
  insert into public.slips as s (id, author_id, kind, body, feeling, plan_note, tags, for_card, occurred_on, photo_path, created_at, polarity)
  values (save_slip.id, v_uid, v_kind, btrim(save_slip.body), nullif(btrim(save_slip.feeling), ''),
          nullif(btrim(save_slip.plan_note), ''), coalesce(save_slip.tags, '{}'),
          coalesce(save_slip.for_card, true) and v_kind <> 'invisible' and v_polarity = 'liked',
          save_slip.occurred_on, save_slip.photo_path,
          least(coalesce(save_slip.created_at, now()), now()), v_polarity)
  on conflict on constraint slips_pkey do update
    set kind = excluded.kind, body = excluded.body, feeling = excluded.feeling, plan_note = excluded.plan_note,
        tags = excluded.tags, for_card = excluded.for_card, occurred_on = excluded.occurred_on,
        photo_path = excluded.photo_path, polarity = excluded.polarity
    where s.author_id = v_uid and s.deleted_at is null
  returning s.* into v_row;
  if v_row.id is null then
    raise exception 'SLIP_NOT_FOUND' using errcode = 'P0001';
  end if;
  return v_row;
end $function$;

REVOKE ALL ON FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp WITH time zone, text) FROM PUBLIC, "anon";

CREATE OR REPLACE FUNCTION public.send_slip_now (
  slip_id uuid,
  note    text DEFAULT NULL::text
)
  RETURNS public.cards
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
declare v_uid uuid := private.require_user(); v_slip public.slips; v_card public.cards;
begin
  select * into v_slip from public.slips s
  where s.id = slip_id and s.author_id = v_uid and s.deleted_at is null and s.kind <> 'invisible'
    and s.polarity = 'liked';
  if not found then raise exception 'SLIP_NOT_ELIGIBLE' using errcode = 'P0001'; end if;
  insert into public.cards (author_id, week_start, kind, note)
  values (v_uid, private.local_week_start(v_uid), 'single', nullif(btrim(send_slip_now.note), '')) returning * into v_card;
  insert into public.card_items (card_id, slip_id, body, feeling, position) values (v_card.id, v_slip.id, v_slip.body, v_slip.feeling, 1);
  return public.send_card(v_card.id);
end $function$;

CREATE OR REPLACE FUNCTION public.update_card_draft (
  card_id  uuid,
  slip_ids uuid[],
  note     text   DEFAULT NULL::text
)
  RETURNS public.cards
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
declare v_card public.cards := private.own_editable_card(card_id);
begin
  if exists (
    select 1 from unnest(slip_ids) as wanted (id)
    where not exists (select 1 from public.slips s
                      where s.id = wanted.id and s.author_id = v_card.author_id and s.kind <> 'invisible'
                        and s.for_card and s.polarity = 'liked' and s.deleted_at is null)) then
    raise exception 'SLIP_NOT_ELIGIBLE' using errcode = 'P0001';
  end if;
  delete from public.card_items i where i.card_id = v_card.id;
  insert into public.card_items (card_id, slip_id, body, feeling, position)
  select v_card.id, s.id, s.body, s.feeling, w.ord
  from unnest(slip_ids) with ordinality as w (id, ord) join public.slips s on s.id = w.id;
  update public.cards c set note = nullif(btrim(update_card_draft.note), '')
  where c.id = v_card.id returning c.* into v_card;
  return v_card;
end $function$;

ALTER TABLE "public"."slips"
  ADD CONSTRAINT "slips_bothered_never_for_card" CHECK (((polarity = 'liked'::public.slip_polarity) OR (NOT for_card)));

CREATE POLICY "slips_bothered_author_only" ON "public"."slips"
  AS RESTRICTIVE
  FOR SELECT
  TO "authenticated"
  USING (((polarity = 'liked'::public.slip_polarity) OR (author_id = ( SELECT auth.uid() AS uid))));

COMMENT ON FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp with time zone, text) IS '@graphql({"description": "Creates or edits a slip. Editing an existing slip keeps working at the free-plan limit."})';

COMMENT ON TABLE "public"."slips" IS '@graphql({"description": "Private to the author. A bothered slip never reaches a card; a liked slip reaches the partner only as a frozen copy inside a sent card."})';

GRANT EXECUTE ON FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp WITH time zone, text) TO "authenticated";

REVOKE ALL ON FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp WITH time zone, text) FROM "postgres";

GRANT EXECUTE ON FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp WITH time zone, text) TO "postgres";

GRANT EXECUTE ON FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp WITH time zone, text) TO "service_role";

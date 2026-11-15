-- Invariant: the gentle request is the author's own note on a bothered slip. It lives in the same private row, is
-- never shared or delivered to the partner, exists only on a bothered slip, and is capped at 140 characters.
SET local check_function_bodies = off;

DROP FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp WITH time zone, text);

ALTER TABLE "public"."slips"
  ADD COLUMN "request" text;

CREATE OR REPLACE FUNCTION public.delete_slip (
  id uuid
)
  RETURNS boolean
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
declare v_uid uuid := private.require_user();
begin
  update public.slips s set deleted_at = coalesce(s.deleted_at, now()), body = '[deleted]', feeling = null,
    plan_note = null, tags = '{}', photo_path = null, request = null
  where s.id = delete_slip.id and s.author_id = v_uid;
  return found;
end $function$;

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
  polarity    text                     DEFAULT 'liked'::text,
  request     text                     DEFAULT NULL::text
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
  insert into public.slips as s (id, author_id, kind, body, feeling, plan_note, tags, for_card, occurred_on, photo_path, created_at, polarity, request)
  values (save_slip.id, v_uid, v_kind, btrim(save_slip.body), nullif(btrim(save_slip.feeling), ''),
          nullif(btrim(save_slip.plan_note), ''), coalesce(save_slip.tags, '{}'),
          coalesce(save_slip.for_card, true) and v_kind <> 'invisible' and v_polarity = 'liked',
          save_slip.occurred_on, save_slip.photo_path,
          least(coalesce(save_slip.created_at, now()), now()), v_polarity,
          case when v_polarity = 'bothered' then nullif(btrim(save_slip.request), '') end)
  on conflict on constraint slips_pkey do update
    set kind = excluded.kind, body = excluded.body, feeling = excluded.feeling, plan_note = excluded.plan_note,
        tags = excluded.tags, for_card = excluded.for_card, occurred_on = excluded.occurred_on,
        photo_path = excluded.photo_path, polarity = excluded.polarity, request = excluded.request
    where s.author_id = v_uid and s.deleted_at is null
  returning s.* into v_row;
  if v_row.id is null then
    raise exception 'SLIP_NOT_FOUND' using errcode = 'P0001';
  end if;
  return v_row;
end $function$;

REVOKE ALL ON FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp WITH time zone, text, text) FROM PUBLIC, "anon";

ALTER TABLE "public"."slips"
  ADD CONSTRAINT "slips_request_check" CHECK ((char_length(btrim(request)) <= 140));

ALTER TABLE "public"."slips"
  ADD CONSTRAINT "slips_request_only_bothered" CHECK (((request IS NULL) OR (polarity = 'bothered'::public.slip_polarity)));

COMMENT ON FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp with time zone, text, text) IS '@graphql({"description": "Creates or edits a slip. Editing an existing slip keeps working at the free-plan limit."})';

GRANT EXECUTE ON FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp WITH time zone, text, text) TO "authenticated";

REVOKE ALL ON FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp WITH time zone, text, text) FROM "postgres";

GRANT EXECUTE ON FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp WITH time zone, text, text) TO "postgres";

GRANT EXECUTE ON FUNCTION "public"."save_slip"(uuid, text, text, text, text, text[], boolean, date, text, timestamp WITH time zone, text, text) TO "service_role";

SET local check_function_bodies = off;

DROP FUNCTION "private"."claim_notifications"(integer);

DROP VIEW "private"."push_job";

DROP FUNCTION "public"."widget"();

DROP VIEW "public"."widget_state";

ALTER TABLE "public"."notification_settings"
  DROP COLUMN "discreet";

ALTER TABLE "public"."profile_settings"
  DROP COLUMN "widget_in_discreet";

CREATE VIEW "private"."push_job" WITH (security_invoker=true) AS  SELECT id AS outbox_id,
    profile_id,
    type,
    ref_id,
    NULL::text[] AS tokens
   FROM private.notification_outbox o
  WHERE false;

CREATE OR REPLACE FUNCTION private.claim_notifications (
  p_limit integer DEFAULT 50
)
  RETURNS SETOF private.push_job
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
declare r private.notification_outbox; v_decision text; v_job private.push_job;
begin
  for r in
    select * from private.notification_outbox
    where sent_at is null and send_after <= now() and attempts < 5
    order by send_after limit p_limit for update skip locked
  loop
    v_decision := private.should_send(r.profile_id, r.type, now());
    if v_decision = 'drop' then
      update private.notification_outbox set sent_at = now(), outcome = 'dropped' where id = r.id;
    else
      update private.notification_outbox set attempts = attempts + 1, send_after = now() + interval '5 minutes' where id = r.id;
      select r.id, r.profile_id, r.type, r.ref_id,
             (select array_agg(d.token) from public.devices d where d.profile_id = r.profile_id)
      into v_job;
      if v_job.tokens is null then
        update private.notification_outbox set sent_at = now(), outcome = 'no_device' where id = r.id;
      else
        return next v_job;
      end if;
    end if;
  end loop;
end $function$;

CREATE VIEW "public"."widget_state" WITH (security_invoker=true) AS  SELECT id AS profile_id,
    false AS is_paired,
    NULL::date AS together_since,
    NULL::text AS partner_name,
    NULL::text AS next_date_title,
    NULL::date AS next_date_on,
    0 AS unopened_cards,
    NULL::text AS partner_note,
    NULL::text AS partner_note_media,
    NULL::timestamp with time zone AS partner_note_at,
    NULL::text AS partner_mood
   FROM public.profiles p
  WHERE false;

CREATE OR REPLACE FUNCTION public.widget()
  RETURNS public.widget_state
  LANGUAGE plpgsql
  STABLE
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
declare v_uid uuid := private.require_user(); t public.today_state := public.today(); r public.widget_state; s public.profile_settings;
begin
  select * into s from public.profile_settings where profile_id = v_uid;
  r.profile_id := v_uid;
  r.is_paired := t.is_paired;
  r.together_since := t.together_since;
  r.unopened_cards := t.unopened_cards;
  r.next_date_on := t.next_date_on;
  r.next_date_title := t.next_date_title;
  r.partner_name := case when s.widget_show_names then t.partner_name end;
  if s.widget_allow_partner_notes then
    select m.body, m.media_path, m.created_at into r.partner_note, r.partner_note_media, r.partner_note_at
    from public.partner_messages m
    where m.recipient_id = v_uid and m.for_widget and m.kind = 'note'
    order by m.created_at desc limit 1;
  end if;
  r.partner_mood := (select mood from public.partner_mood_today());
  return r;
end $function$;

COMMENT ON FUNCTION "public"."widget"() IS '@graphql({"description": "Everything the home-screen widget shows."})';

COMMENT ON VIEW "public"."widget_state" IS '@graphql({"primary_key_columns": ["profile_id"], "description": "Everything the home-screen widget shows."})';

GRANT EXECUTE ON FUNCTION "private"."claim_notifications"(integer) TO "service_role";

GRANT EXECUTE ON FUNCTION "public"."widget"() TO "authenticated";

GRANT SELECT ON TABLE "private"."push_job" TO "service_role";

GRANT SELECT ON TABLE "public"."widget_state" TO "authenticated";


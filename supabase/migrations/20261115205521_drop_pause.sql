SET local check_function_bodies = off;

SELECT cron.unschedule('expire-pauses');

ALTER TABLE "public"."pauses"
  DROP CONSTRAINT "pauses_couple_id_fkey";

ALTER TABLE "public"."pauses"
  DROP CONSTRAINT "pauses_started_by_fkey";

DROP FUNCTION "private"."expire_pauses"();

DROP FUNCTION "public"."active_pause"();

DROP FUNCTION "public"."end_pause"();

DROP FUNCTION "public"."start_pause"(timestamp WITH time zone, text);

DROP FUNCTION "public"."today"();

DROP VIEW "public"."today_state";

DROP FUNCTION "public"."widget"();

DROP VIEW "public"."widget_state";

DROP TABLE "public"."pauses";

CREATE OR REPLACE FUNCTION private.is_partner_initiated (
  p_type text
)
  RETURNS boolean
  LANGUAGE sql
  IMMUTABLE
  SET search_path TO ''
  AS $function$
  select p_type in ('card_received', 'card_reaction', 'partner_joined', 'unpaired', 'partner_message', 'game_invite')
         or p_type like 'signal_%';
$function$;

CREATE OR REPLACE FUNCTION private.is_quiet_moment (
  p_profile_id uuid
)
  RETURNS boolean
  LANGUAGE sql
  STABLE
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
  select exists (select 1 from public.temperature_checks t where t.author_id = p_profile_id and t.level = 'fight' and t.created_at > now() - interval '24 hours')
      or exists (select 1 from public.profile_settings s where s.profile_id = p_profile_id
                 and (s.relationship_status <> 'together' or s.app_paused_until > now()));
$function$;

CREATE OR REPLACE FUNCTION private.should_send (
  p_profile_id uuid,
  p_type       text,
  p_at         timestamp with time zone
)
  RETURNS text
  LANGUAGE plpgsql
  STABLE
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
declare
  v_s public.notification_settings;
  v_from_partner boolean := private.is_partner_initiated(p_type);
begin
  select * into v_s from public.notification_settings where profile_id = p_profile_id;
  if not found or not v_s.enabled or p_type = any (v_s.muted_types) then
    return 'drop';
  end if;
  if not v_from_partner then
    if private.is_quiet_moment(p_profile_id) then
      return 'drop';
    end if;
    if (select count(*) from private.notification_outbox o
        where o.profile_id = p_profile_id and o.outcome = 'sent' and o.sent_at > p_at - interval '24 hours'
          and not private.is_partner_initiated(o.type)) >= v_s.daily_max then
      return 'drop';
    end if;
  end if;
  return 'send';
end $function$;

CREATE VIEW "public"."today_state" WITH (security_invoker=true) AS  SELECT id AS profile_id,
    false AS is_paired,
    NULL::text AS partner_name,
    NULL::date AS local_date,
    NULL::uuid AS card_id,
    NULL::text AS card_status,
    0 AS unopened_cards,
    0 AS slips_this_week,
    0 AS slips_total,
    false AS has_pending_invite,
    NULL::text AS suggestion_key,
    NULL::date AS together_since,
    NULL::text AS temperature,
    NULL::uuid AS next_date_id,
    NULL::text AS next_date_title,
    NULL::date AS next_date_on,
    0 AS unseen_signals,
    false AS has_plus,
    false AS deletion_pending,
    NULL::text AS relationship_status,
    NULL::date[] AS slip_days
   FROM public.profiles p
  WHERE false;

CREATE OR REPLACE FUNCTION public.today()
  RETURNS public.today_state
  LANGUAGE plpgsql
  STABLE
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
declare
  v_uid uuid := private.require_user();
  v_s public.profile_settings; v_week date; v_partner uuid; r public.today_state;
begin
  select * into v_s from public.profile_settings where profile_id = v_uid;
  v_s.time_zone := coalesce(v_s.time_zone, 'America/Sao_Paulo');
  v_week := date_trunc('week', now() at time zone v_s.time_zone)::date;
  v_partner := private.partner_id();
  r.profile_id := v_uid;
  r.local_date := (now() at time zone v_s.time_zone)::date;
  r.is_paired := v_partner is not null;
  r.partner_name := coalesce((select display_name from public.profiles where id = v_partner), v_s.partner_name);
  r.together_since := v_s.together_since;
  r.relationship_status := v_s.relationship_status::text;
  select c.id, c.status::text into r.card_id, r.card_status
  from public.cards c where c.author_id = v_uid and c.week_start = v_week and c.kind = 'weekly' and c.deleted_at is null;
  r.unopened_cards := (select count(*) from public.cards c
                       where c.recipient_id = v_uid and c.status = 'sent' and c.deleted_at is null
                         and not exists (select 1 from public.card_opens o where o.card_id = c.id));
  select count(*) filter (where (s.created_at at time zone v_s.time_zone)::date >= v_week), count(*)
  into r.slips_this_week, r.slips_total
  from public.slips s where s.author_id = v_uid and s.deleted_at is null;
  r.slip_days := (select array_agg(distinct (s.created_at at time zone v_s.time_zone)::date)
                  from public.slips s
                  where s.author_id = v_uid and s.deleted_at is null
                    and (s.created_at at time zone v_s.time_zone)::date >= v_week);
  r.has_pending_invite := exists (select 1 from public.invites i
    where i.created_by = v_uid and i.used_at is null and i.cancelled_at is null and i.expires_at > now());
  r.temperature := (select level from public.current_temperature());
  select d.id, d.title, private.next_occurrence(d.month, d.day, r.local_date)
  into r.next_date_id, r.next_date_title, r.next_date_on
  from public.important_dates d
  where not d.hidden and (d.author_id = v_uid or d.couple_id = private.current_couple_id())
  order by private.next_occurrence(d.month, d.day, r.local_date) limit 1;
  r.unseen_signals := (select count(*) from public.signals g where g.recipient_id = v_uid and g.seen_at is null);
  r.has_plus := private.has_plus(v_uid);
  r.deletion_pending := exists (select 1 from public.deletion_requests where profile_id = v_uid);
  r.suggestion_key := case
    when r.slips_total = 0 then 'first_slip'
    when r.unopened_cards > 0 then 'open_card'
    when r.temperature = 'fight' then 'repair'
    when r.card_status = 'draft' then 'review_card'
    when not r.is_paired and not r.has_pending_invite then 'invite_partner'
    else 'write_slip' end;
  return r;
end $function$;

CREATE VIEW "public"."widget_state" WITH (security_invoker=true) AS  SELECT id AS profile_id,
    false AS discreet,
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
  r.discreet := coalesce((select discreet from public.notification_settings where profile_id = v_uid), false) and not s.widget_in_discreet;
  r.is_paired := t.is_paired;
  r.together_since := t.together_since;
  r.unopened_cards := t.unopened_cards;
  r.next_date_on := t.next_date_on;
  if not r.discreet then
    r.next_date_title := t.next_date_title;
    r.partner_name := case when s.widget_show_names then t.partner_name end;
    if s.widget_allow_partner_notes then
      select m.body, m.media_path, m.created_at into r.partner_note, r.partner_note_media, r.partner_note_at
      from public.partner_messages m
      where m.recipient_id = v_uid and m.for_widget and m.kind = 'note'
      order by m.created_at desc limit 1;
    end if;
    r.partner_mood := (select mood from public.partner_mood_today());
  end if;
  return r;
end $function$;

COMMENT ON FUNCTION "public"."today"() IS '@graphql({"description": "Everything the Today screen needs in one call."})';

COMMENT ON FUNCTION "public"."widget"() IS '@graphql({"description": "Everything the home-screen widget shows."})';

COMMENT ON VIEW "public"."today_state" IS '@graphql({"primary_key_columns": ["profile_id"], "description": "Everything Hoje needs in one call. suggestion_key: first_slip, open_card, repair, review_card, invite_partner, write_slip."})';

COMMENT ON VIEW "public"."widget_state" IS '@graphql({"primary_key_columns": ["profile_id"], "description": "Everything the home-screen widget shows."})';

GRANT EXECUTE ON FUNCTION "public"."today"() TO "authenticated";


GRANT EXECUTE ON FUNCTION "public"."widget"() TO "authenticated";

GRANT SELECT ON TABLE "public"."today_state" TO "authenticated";

GRANT SELECT ON TABLE "public"."widget_state" TO "authenticated";


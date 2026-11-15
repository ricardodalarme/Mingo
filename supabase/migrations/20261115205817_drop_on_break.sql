SET local check_function_bodies = off;

ALTER TABLE "public"."profile_settings"
  ALTER COLUMN "relationship_status" DROP DEFAULT;

update public.profile_settings set relationship_status = 'together' where relationship_status = 'on_break';

ALTER TYPE "public"."relationship_status" RENAME TO "relationship_status__pgdelta_replaced";

CREATE TYPE "public"."relationship_status" AS ENUM (
  'together',
  'ended',
  'bereaved'
);

ALTER TABLE "public"."profile_settings"
  ALTER COLUMN "relationship_status" TYPE "public"."relationship_status" USING "relationship_status"::text::"public"."relationship_status";

DROP TYPE "public"."relationship_status__pgdelta_replaced";

ALTER TABLE "public"."profile_settings"
  ALTER COLUMN "relationship_status" SET DEFAULT 'together'::public.relationship_status;

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
      or exists (select 1 from public.profile_settings s where s.profile_id = p_profile_id and s.app_paused_until > now());
$function$;

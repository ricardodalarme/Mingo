update public.consents set kind = 'sensitive_data' where kind = 'sensitive_tracks';

ALTER TYPE "public"."consent_kind" RENAME TO "consent_kind__pgdelta_replaced";

CREATE TYPE "public"."consent_kind" AS ENUM (
  'sensitive_data',
  'analytics',
  'marketing',
  'ai',
  'terms'
);

ALTER TABLE "public"."consents"
  ALTER COLUMN "kind" TYPE "public"."consent_kind" USING "kind"::text::"public"."consent_kind";

DROP TYPE "public"."consent_kind__pgdelta_replaced";

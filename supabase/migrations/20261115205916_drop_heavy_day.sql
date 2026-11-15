ALTER TABLE "public"."profile_settings"
  DROP COLUMN "heavy_day_sharing";

DROP TYPE "public"."heavy_day_sharing";

delete from public.signals where kind = 'heavy_day';

ALTER TYPE "public"."signal_kind" RENAME TO "signal_kind__pgdelta_replaced";

CREATE TYPE "public"."signal_kind" AS ENUM (
  'need',
  'miss_us',
  'hug',
  'distance',
  'repair',
  'good_news'
);

ALTER TABLE "public"."signals"
  ALTER COLUMN "kind" TYPE "public"."signal_kind" USING "kind"::text::"public"."signal_kind";

DROP TYPE "public"."signal_kind__pgdelta_replaced";

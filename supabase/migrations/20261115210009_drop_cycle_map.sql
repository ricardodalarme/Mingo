ALTER TABLE "public"."cycle_days"
  DROP CONSTRAINT "cycle_days_author_id_fkey";

DROP TABLE "public"."cycle_days";

DROP TYPE "public"."cycle_day_kind";

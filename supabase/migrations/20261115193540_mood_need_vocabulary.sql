-- A person can ask for concrete things, not only for a way to be heard.
ALTER TYPE "public"."mood_need" ADD VALUE 'chocolate' AFTER 'space';

ALTER TYPE "public"."mood_need" ADD VALUE 'cute_message' AFTER 'chocolate';

ALTER TYPE "public"."mood_need" ADD VALUE 'forehead_kiss' AFTER 'cute_message';

ALTER TYPE "public"."mood_need" ADD VALUE 'company' AFTER 'forehead_kiss';

ALTER TYPE "public"."mood_need" ADD VALUE 'rest' AFTER 'company';

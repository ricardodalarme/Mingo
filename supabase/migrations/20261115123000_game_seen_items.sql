-- A game that can be replayed needs to know what the couple was already served, so the server can hand out
-- new items and only start over once the catalog of that game runs out.

SET local check_function_bodies = off;

CREATE TABLE "public"."game_seen_items" (
  "couple_id" uuid                     NOT NULL,
  "game"      public.game_kind         NOT NULL,
  "item_slug" text                     NOT NULL,
  "seen_at"   timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT "game_seen_items_item_slug_check" CHECK (((char_length(item_slug) >= 1) AND (char_length(item_slug) <= 80))),
  CONSTRAINT "game_seen_items_pkey" PRIMARY KEY (couple_id, game, item_slug)
);

ALTER TABLE "public"."game_seen_items"
  ENABLE ROW LEVEL SECURITY;

REVOKE ALL ON TABLE "public"."game_seen_items" FROM "anon";

CREATE OR REPLACE FUNCTION public.next_game_items (
  game   text,
  locale text    DEFAULT NULL::text,
  count  integer DEFAULT 5
)
  RETURNS SETOF public.content_items
  LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path TO ''
  AS $function$
declare
  v_uid uuid := private.require_user();
  v_couple uuid := private.current_couple_id();
  v_kind public.game_kind;
  v_locale text := coalesce(nullif(next_game_items.locale, ''),
                            (select s.locale from public.profile_settings s where s.profile_id = v_uid));
  v_count integer := least(greatest(coalesce(next_game_items.count, 5), 1), 50);
  v_slugs text[];
begin
  begin
    v_kind := next_game_items.game::public.game_kind;
  exception when invalid_text_representation then
    raise exception 'INVALID_GAME_KIND' using errcode = 'P0001';
  end;
  select array_agg(p.slug) into v_slugs
  from (select c.slug
        from public.content_items c
        left join public.game_seen_items s
          on s.couple_id = v_couple and s.game = v_kind and s.item_slug = c.slug
        where c.kind::text = v_kind::text and c.locale = v_locale and c.published and not c.plus_only
        order by s.seen_at nulls first, c.position, c.slug
        limit v_count) p;
  if v_slugs is null then return; end if;
  if v_couple is not null then
    insert into public.game_seen_items as g (couple_id, game, item_slug)
    select v_couple, v_kind, u.slug from unnest(v_slugs) as u (slug)
    on conflict on constraint game_seen_items_pkey do update set seen_at = now();
  end if;
  return query
  select c.* from public.content_items c
  join unnest(v_slugs) with ordinality as u (slug, ord) on u.slug = c.slug
  where c.kind::text = v_kind::text and c.locale = v_locale
  order by u.ord;
end $function$;

REVOKE ALL ON FUNCTION "public"."next_game_items"(text, text, integer) FROM PUBLIC, "anon";

ALTER TABLE "public"."game_seen_items"
  ADD CONSTRAINT "game_seen_items_couple_id_fkey" FOREIGN KEY (couple_id) REFERENCES public.couples(id) ON DELETE CASCADE;

CREATE POLICY "game_seen_items_select_couple" ON "public"."game_seen_items"
  FOR SELECT
  TO "authenticated"
  USING ((couple_id = ( SELECT private.current_couple_id() AS current_couple_id)));

COMMENT ON FUNCTION "public"."next_game_items"(text, text, integer) IS '@graphql({"description": "The next items of a game for the couple: ones it has not seen yet, then the least recently seen, so a replay starts over instead of running out. The returned items are recorded as seen."})';

COMMENT ON TABLE "public"."game_seen_items" IS '@graphql({"description": "Which game items a couple has already been served, so a replay starts with new ones."})';

GRANT EXECUTE ON FUNCTION "public"."next_game_items"(text, text, integer) TO "authenticated";

REVOKE ALL ON FUNCTION "public"."next_game_items"(text, text, integer) FROM "postgres";

GRANT EXECUTE ON FUNCTION "public"."next_game_items"(text, text, integer) TO "postgres";

GRANT EXECUTE ON FUNCTION "public"."next_game_items"(text, text, integer) TO "service_role";

REVOKE ALL ON TABLE "public"."game_seen_items" FROM "authenticated";

GRANT SELECT ON TABLE "public"."game_seen_items" TO "authenticated";

REVOKE ALL ON TABLE "public"."game_seen_items" FROM "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."game_seen_items" TO "postgres";

GRANT DELETE, INSERT, MAINTAIN, REFERENCES, SELECT, TRIGGER, TRUNCATE, UPDATE ON TABLE "public"."game_seen_items" TO "service_role";

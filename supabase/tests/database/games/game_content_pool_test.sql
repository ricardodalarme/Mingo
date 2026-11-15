begin;
set local search_path = tap, public, extensions;
select plan(17);

-- A replay only feels new while the pool lasts: each playable game keeps at least 36 published items per locale.
select ok(
  (select count(*) from public.content_items
   where kind = 'me_or_you' and locale = 'pt-BR' and published and not plus_only) >= 36,
  'me_or_you has at least 36 published items in pt-BR'
);
select ok(
  (select count(*) from public.content_items
   where kind = 'me_or_you' and locale = 'en' and published and not plus_only) >= 36,
  'me_or_you has at least 36 published items in en'
);
select ok(
  (select count(*) from public.content_items
   where kind = 'how_well' and locale = 'pt-BR' and published and not plus_only) >= 36,
  'how_well has at least 36 published items in pt-BR'
);
select ok(
  (select count(*) from public.content_items
   where kind = 'how_well' and locale = 'en' and published and not plus_only) >= 36,
  'how_well has at least 36 published items in en'
);
select ok(
  (select count(*) from public.content_items
   where kind = 'never_have_we' and locale = 'pt-BR' and published and not plus_only) >= 36,
  'never_have_we has at least 36 published items in pt-BR'
);
select ok(
  (select count(*) from public.content_items
   where kind = 'never_have_we' and locale = 'en' and published and not plus_only) >= 36,
  'never_have_we has at least 36 published items in en'
);
select ok(
  (select count(*) from public.content_items
   where kind = 'mission' and locale = 'pt-BR' and published and not plus_only) >= 36,
  'mission has at least 36 published items in pt-BR'
);
select ok(
  (select count(*) from public.content_items
   where kind = 'mission' and locale = 'en' and published and not plus_only) >= 36,
  'mission has at least 36 published items in en'
);

-- Only these four game kinds have a content kind of the same name, so only they can read a pool.
-- twenty_questions and compliments have no content_kind and are out of the catalog on purpose for now.

-- A slug is the key the app resolves an item by, so it identifies one prompt across the whole game catalog.
select ok(
  not exists (
    select 1 from public.content_items
    where kind in ('me_or_you', 'how_well', 'never_have_we', 'mission')
    group by slug
    having count(distinct kind) > 1
  ),
  'no slug is used by more than one game'
);

-- The two partners of a session read the same slugs, each in their own locale.
select ok(
  not exists (
    select 1 from public.content_items
    where kind in ('me_or_you', 'how_well', 'never_have_we', 'mission')
    group by kind, slug
    having count(distinct locale) <> 2
  ),
  'every game item exists in both locales'
);

-- next_game_items never serves plus-only rows, so a premium game item would be unreachable.
select ok(
  not exists (
    select 1 from public.content_items
    where kind in ('me_or_you', 'how_well', 'never_have_we', 'mission')
      and plus_only
  ),
  'no game item is plus only'
);

select ok(
  not exists (
    select 1 from public.content_items
    where kind in ('me_or_you', 'how_well', 'never_have_we', 'mission')
    group by kind, locale, title
    having count(*) > 1
  ),
  'no two items of a game repeat the same prompt'
);

-- The catalog and the games agree: each playable game hands out a full hand from the pool.
select tests.create_user('pool_ana', 'Ana');
select tests.create_user('pool_bia', 'Bia');
select tests.pair('pool_ana', 'pool_bia');
select tests.as('pool_ana');
select is((select count(*)::int from public.next_game_items('me_or_you', 'pt-BR', 5)), 5,
  'me_or_you serves five items');
select is((select count(*)::int from public.next_game_items('how_well', 'pt-BR', 10)), 10,
  'how_well serves ten items');
select is((select count(*)::int from public.next_game_items('never_have_we', 'pt-BR', 10)), 10,
  'never_have_we serves ten items');
select is((select count(*)::int from public.next_game_items('mission', 'pt-BR', 5)), 5,
  'mission serves five items');
select is((select count(*)::int from public.next_game_items('how_well', 'en', 10)), 10,
  'the english pool serves a full hand too');

select * from finish();
rollback;

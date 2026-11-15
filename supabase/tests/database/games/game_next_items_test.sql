begin;
set local search_path = tap, public, extensions;
select plan(15);
select tests.create_user('next_ana', 'Ana');
select tests.create_user('next_bia', 'Bia');
select tests.create_user('next_caio', 'Caio');
select tests.create_user('next_dani', 'Dani');
create temp table ids (k text primary key, id uuid) on commit drop;
create temp table served (slug text primary key) on commit drop;
grant all on ids, served to authenticated;

select tests.pair('next_ana', 'next_bia');
select tests.pair('next_caio', 'next_dani');
insert into ids select 'couple', couple_id from public.couple_members
  where profile_id = tests.uid('next_ana') and left_at is null;

insert into public.content_items (kind, slug, locale, title, position) values
  ('me_or_you', 'next-a', 'pt-BR', 'Quem chega primeiro?', 91),
  ('me_or_you', 'next-b', 'pt-BR', 'Quem escolhe o filme?', 92),
  ('me_or_you', 'next-c', 'pt-BR', 'Quem fala mais alto?', 93),
  ('me_or_you', 'next-d', 'pt-BR', 'Quem dorme primeiro?', 94),
  ('me_or_you', 'next-e', 'pt-BR', 'Quem cozinha melhor?', 95),
  ('me_or_you', 'next-f', 'pt-BR', 'Quem paga a conta?', 96),
  ('how_well', 'next-hw-a', 'pt-BR', 'Qual é o café dele?', 91),
  ('how_well', 'next-hw-b', 'pt-BR', 'Qual é a sobremesa dele?', 92);

select tests.as('next_ana');
insert into served select slug from public.next_game_items('me_or_you', 'pt-BR', 3);

select is((select count(*)::int from served), 3, 'a call returns the number of items asked for');
select is((select count(*)::int from public.game_seen_items
           where couple_id = (select id from ids where k = 'couple')), 3,
  'the served items are recorded for the couple');
select is((select count(*)::int from served s
           join public.content_items c on c.slug = s.slug and c.kind = 'me_or_you' and c.locale = 'pt-BR'), 3,
  'the items come from the game catalog for the locale');

select tests.as('next_bia');
select is((select count(*)::int from public.game_seen_items), 3,
  'the partner reads the same seen rows');

select tests.as('next_ana');
select is((select count(*)::int from public.next_game_items('me_or_you', 'pt-BR', 3) n
           join served s on s.slug = n.slug), 0,
  'the next call prefers items the couple has not seen yet');

select is((select count(*)::int from public.next_game_items('me_or_you', 'pt-BR', 50)),
  (select count(*)::int from public.content_items
   where kind = 'me_or_you' and locale = 'pt-BR' and published and not plus_only),
  'a large call drains the whole catalog of the game');
select is((select count(*)::int from public.next_game_items('me_or_you', 'pt-BR', 3)), 3,
  'an exhausted catalog still returns items');
select is((select count(*)::int from public.next_game_items('me_or_you', 'pt-BR', 3) n
           where n.slug in (select item_slug from public.game_seen_items
                            where couple_id = (select id from ids where k = 'couple'))), 3,
  'the repeats come from the items the couple already saw');
select is((select count(*)::int from public.next_game_items('how_well', 'pt-BR', 2)), 2,
  'another game keeps its own seen set');

create temp table seen_total (n int) on commit drop;
select tests.as_admin();
insert into seen_total select count(*) from public.game_seen_items;
select tests.create_user('next_solo', 'Solo');

select tests.as('next_solo');
select is((select count(*)::int from public.next_game_items('me_or_you', 'pt-BR', 2)), 2,
  'a person without a couple still gets items');

select tests.as_admin();
select is((select count(*)::int from public.game_seen_items), (select n from seen_total),
  'nothing is recorded when there is no couple to record it for');

select tests.as('next_caio');
select is((select count(*)::int from public.game_seen_items), 0,
  'another couple cannot read these seen rows');
select throws_ok(
  format($$insert into public.game_seen_items (couple_id, game, item_slug) values (%L, 'me_or_you', 'next-a')$$,
         (select id from ids where k = 'couple')),
  '42501', null,
  'clients cannot write seen rows directly'
);

select tests.as('next_ana');
select throws_ok($$select * from public.next_game_items('nope', 'pt-BR', 1)$$, 'P0001', 'INVALID_GAME_KIND',
  'an unknown game is rejected');
select is((select count(*)::int from public.next_game_items('twenty_questions', 'pt-BR', 5)), 0,
  'a game with no content kind returns no items');

select * from finish();
rollback;

begin;
set local search_path = tap, public, extensions;
select plan(17);

select tests.create_user('ana'); select tests.create_user('bia'); select tests.create_user('caio');
select tests.pair('ana', 'bia');

-- A bothered slip is private to its author and never shared, in any form.
select tests.as('ana');
select is(
  (select polarity::text from public.save_slip('00000000-0000-4000-8000-0000000000b1', 'Fez o café')),
  'liked',
  'a slip is liked by default'
);
select is(
  (select polarity::text from public.save_slip(
    '00000000-0000-4000-8000-0000000000b2', 'Chegou tarde sem avisar', 'quick', null, null, '{}', true, null, null, null, 'bothered'
  )),
  'bothered',
  'the author saves a bothered slip'
);
select is(
  (select for_card from public.slips where id = '00000000-0000-4000-8000-0000000000b2'),
  false,
  'a bothered slip is never for the card'
);
select throws_ok(
  $$select public.save_slip('00000000-0000-4000-8000-0000000000b3', 'x', 'quick', null, null, '{}', true, null, null, null, 'nope')$$,
  'P0001',
  'INVALID_SLIP_POLARITY',
  'unknown polarity is rejected with a stable code'
);
select is(
  (select count(*)::int from public.slips where polarity = 'bothered'),
  1,
  'the author reads the bothered slip'
);

-- The weekly card and the jar never take a bothered slip.
select isnt((select id from public.prepare_card()), null, 'prepare_card builds the draft');
select is((select count(*)::int from public.card_items), 1, 'the draft holds only the liked slip');
select throws_ok(
  format(
    $$select public.update_card_draft(%L, array['00000000-0000-4000-8000-0000000000b2']::uuid[])$$,
    (select id from public.cards where author_id = tests.uid('ana') and kind = 'weekly')
  ),
  'P0001',
  'SLIP_NOT_ELIGIBLE',
  'a bothered slip can never be added to a card'
);
select throws_ok(
  $$select public.send_slip_now('00000000-0000-4000-8000-0000000000b2')$$,
  'P0001',
  'SLIP_NOT_ELIGIBLE',
  'a bothered slip cannot be sent on its own'
);
select public.save_slip('00000000-0000-4000-8000-0000000000b1', 'Fez o café', 'quick', null, null, '{}', true, null, null, null, 'bothered');
select is((select count(*)::int from public.card_items), 0, 'a slip turned bothered leaves the unsent draft');
select public.set_slip_details('00000000-0000-4000-8000-0000000000b2', 'did', null, true);
select ok((select public.draw_from_jar()) is null, 'the jar never draws a bothered slip');

-- Partner and stranger see nothing of it, not even a count.
select tests.as('bia');
select is((select count(*)::int from public.slips), 0, 'the partner cannot read a bothered slip');
select is((select count(*)::int from public.slips where polarity = 'bothered'), 0, 'the partner cannot count bothered slips');
select is((select count(*)::int from public.timeline_items where kind = 'slip'), 0, 'a bothered slip never reaches the partner timeline');
select is((select count(*)::int from public.cards), 0, 'the draft card stays private to the author');
select tests.as('caio');
select is((select count(*)::int from public.slips), 0, 'a stranger cannot read bothered slips');
select tests.as('ana');
select is(
  (select body from public.slips where id = '00000000-0000-4000-8000-0000000000b2'),
  'Chegou tarde sem avisar',
  'the author still reads their own bothered slip'
);

select * from finish();
rollback;

begin;
set local search_path = tap, public, extensions;
select plan(13);

select tests.create_user('ana'); select tests.create_user('bia');
select tests.pair('ana', 'bia');

-- One short, optional request on a bothered slip, private by the same rule as the slip.
select tests.as('ana');
select is(
  (select request from public.save_slip(
    '00000000-0000-4000-8000-0000000000c1', 'Chegou tarde sem avisar', 'quick', null, null, '{}', true, null, null, null, 'bothered',
    '  Poderia me avisar antes?  '
  )),
  'Poderia me avisar antes?',
  'the request is stored trimmed with the bothered slip'
);
select is(
  (select request from public.slips where id = '00000000-0000-4000-8000-0000000000c1'),
  'Poderia me avisar antes?',
  'the author reads their own request'
);
select is(
  (select request from public.save_slip(
    '00000000-0000-4000-8000-0000000000c2', 'Hoje eu precisava de ajuda com a louça', 'quick', null, null, '{}', true, null, null, null, 'bothered', '   '
  )),
  null,
  'an empty request is stored as null'
);
select is(
  (select request from public.save_slip('00000000-0000-4000-8000-0000000000c3', 'Fez o café')),
  null,
  'a request is optional'
);
select throws_ok(
  format(
    $$select public.save_slip('00000000-0000-4000-8000-0000000000c4', 'Chegou tarde', 'quick', null, null, '{}', true, null, null, null, 'bothered', %L)$$,
    repeat('a', 141)
  ),
  '23514',
  null,
  'a request over 140 characters is rejected'
);
select is(
  (select request from public.save_slip(
    '00000000-0000-4000-8000-0000000000c5', 'Fez o café', 'quick', null, null, '{}', true, null, null, null, 'liked', 'Poderia me avisar antes?'
  )),
  null,
  'a request is kept only on a bothered slip'
);
select tests.as_admin();
select throws_ok(
  format(
    $$insert into public.slips (author_id, body, polarity, request) values (%L, 'Fez o café', 'liked', 'Poderia me avisar antes?')$$,
    tests.uid('ana')
  ),
  '23514',
  null,
  'the database rejects a request on a liked slip'
);

-- The request never leaves the private row, not even inside a card.
select tests.as('ana');
select public.save_slip('00000000-0000-4000-8000-0000000000c6', 'Fez o café');
select isnt((select id from public.prepare_card()), null, 'prepare_card builds the draft');
select is((select count(*)::int from public.card_items), 3, 'the draft holds only the liked slips');
select is(
  (select count(*)::int from public.card_items i join public.slips s on s.id = i.slip_id where s.polarity = 'bothered'),
  0,
  'the bothered slip with its request never enters the weekly card'
);
select tests.as('bia');
select is((select count(*)::int from public.slips where request is not null), 0, 'the partner cannot read the request');
select is((select count(*)::int from public.slips), 0, 'the partner cannot read the bothered slip');
select tests.as('ana');
select public.delete_slip('00000000-0000-4000-8000-0000000000c1');
select is(
  (select request from public.slips where id = '00000000-0000-4000-8000-0000000000c1'),
  null,
  'deleting the slip clears the request'
);

select * from finish();
rollback;

begin;
set local search_path = tap, public, extensions;
select plan(11);
select tests.create_user('lock_ana', 'Ana');
select tests.create_user('lock_bia', 'Bia');
create temp table ids (k text primary key, id uuid) on commit drop;
grant all on ids to authenticated;

select tests.pair('lock_ana', 'lock_bia');

select tests.as('lock_ana');
with x as (select id from public.invite_to_game('me_or_you', array['organized', 'romantic']))
insert into ids select 'session', id from x;

select tests.as('lock_bia');
select is(
  (select status from public.update_game((select id from ids where k = 'session'), 'join')),
  'active',
  'the partner joins the session'
);

-- one answer each is what unlocks the reveal, so the first edit is still open
select tests.as('lock_ana');
select lives_ok(
  format($$select public.answer_game(%L, 0, 'ana first')$$, (select id from ids where k = 'session')),
  'the first partner answers an item'
);
select tests.as('lock_bia');
select lives_ok(
  format($$select public.answer_game(%L, 0, 'bia first')$$, (select id from ids where k = 'session')),
  'the second partner answers the same item'
);

-- both answered: neither side can rewrite it any more
select tests.as('lock_ana');
select throws_ok(
  format($$select public.answer_game(%L, 0, 'ana edited')$$, (select id from ids where k = 'session')),
  'P0001', 'ANSWER_LOCKED',
  'editing my own answer is refused once both answered'
);
select tests.as('lock_bia');
select throws_ok(
  format($$select public.answer_game(%L, 0, 'bia edited')$$, (select id from ids where k = 'session')),
  'P0001', 'ANSWER_LOCKED',
  'the partner cannot rewrite their answer either'
);
select tests.as_admin();
select is(
  (select answer from public.game_answers
   where session_id = (select id from ids where k = 'session') and author_id = tests.uid('lock_ana') and idx = 0),
  'ana first',
  'the refused edit left the stored answer untouched'
);

-- a one-sided item stays editable
select tests.as('lock_ana');
select lives_ok(
  format($$select public.answer_game(%L, 1, 'ana first')$$, (select id from ids where k = 'session')),
  'the first partner answers the second item'
);
select lives_ok(
  format($$select public.answer_game(%L, 1, 'ana edited')$$, (select id from ids where k = 'session')),
  'editing it again while the partner has not answered is allowed'
);
select is(
  (select answer from public.game_answers
   where session_id = (select id from ids where k = 'session') and author_id = tests.uid('lock_ana') and idx = 1),
  'ana edited',
  'the edit is stored while the item is one-sided'
);

select tests.as('lock_bia');
select lives_ok(
  format($$select public.answer_game(%L, 1, 'bia first')$$, (select id from ids where k = 'session')),
  'the partner answers the second item too'
);
select throws_ok(
  format($$select public.answer_game(%L, 1, 'bia edited')$$, (select id from ids where k = 'session')),
  'P0001', 'ANSWER_LOCKED',
  'the second item locks as soon as both answered it'
);

select * from finish();
rollback;

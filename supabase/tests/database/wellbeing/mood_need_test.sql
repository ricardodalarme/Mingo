begin;
set local search_path = tap, public, extensions;
select plan(4);

select tests.create_user('ana'); select tests.create_user('bia');
select tests.pair('ana', 'bia');

-- Every concrete thing a person can ask for is a valid need on today's row.
select tests.as('ana');
select is(
  (select count(*)::int from (
    select unnest(enum_range(null::public.mood_need))::text as value
  ) needs where value in ('chocolate', 'cute_message', 'forehead_kiss', 'company', 'rest')),
  5,
  'the need vocabulary carries the concrete requests'
);
insert into public.moods (mood, need, share) values ('tired', 'chocolate', 'mood_need');
select is((select need::text from public.moods), 'chocolate', 'a concrete need is stored as it was asked');

-- The partner reads a concrete need only when the mood is shared with it.
select tests.as('bia');
select is((select need::text from public.partner_mood_today()), 'chocolate', 'the partner reads the shared need');

select tests.as('ana');
update public.moods set share = 'mood';
select tests.as('bia');
select is((select need::text from public.partner_mood_today()), null, 'the need stays private when only the mood is shared');

select * from finish();
rollback;

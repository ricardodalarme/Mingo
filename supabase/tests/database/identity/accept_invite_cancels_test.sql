begin;
set local search_path = tap, public, extensions;
select plan(10);
select tests.create_user('cancel_ana', 'Ana');
select tests.create_user('cancel_bia', 'Bia');
select tests.create_user('cancel_caio', 'Caio');
select tests.create_user('cancel_dani', 'Dani');
create temp table codes (who text primary key, code text) on commit drop;
create temp table ids (k text primary key, id uuid) on commit drop;
grant all on codes, ids to authenticated;

-- both sides invited each other: whoever accepts first must not leave the other code alive
select tests.as('cancel_ana');
insert into codes select 'ana', code from public.create_invite();
select tests.as('cancel_bia');
insert into codes select 'bia', code from public.create_invite();
insert into ids select 'bia_own', id from public.invites where created_by = tests.uid('cancel_bia');

select isnt((select id from public.accept_invite((select code from codes where who = 'ana'))), null,
  'bia accepts ana''s invite and gets the couple');

select tests.as_admin();
select isnt((select cancelled_at from public.invites where id = (select id from ids where k = 'bia_own')), null,
  'accepting cancels the invite the accepter had created');
select is((select used_at is null from public.invites where id = (select id from ids where k = 'bia_own')), true,
  'the cancelled invite is never marked as used');
select is((select count(*)::int from public.invites where used_by = tests.uid('cancel_bia') and used_at is not null), 1,
  'the accepted invite stays used');

-- an invite the accepter created earlier and that was already accepted is history, not pending work
select tests.as('cancel_caio');
insert into codes select 'caio', code from public.create_invite();
select tests.as('cancel_dani');
select isnt((select id from public.accept_invite((select code from codes where who = 'caio'))), null,
  'dani pairs with caio');
select tests.as_admin();
insert into ids select 'caio_used', id from public.invites where created_by = tests.uid('cancel_caio') and used_at is not null;

select tests.as('cancel_caio');
select is(public.unpair(), true, 'caio leaves the shared space');
select tests.as('cancel_dani');
select is(public.unpair(), false, 'the partner has nothing left to unpair');
select tests.as('cancel_ana');
select is(public.unpair(), true, 'ana leaves the shared space');

select tests.as('cancel_ana');
insert into codes select 'ana_again', code from public.create_invite();
select tests.as('cancel_caio');
select isnt((select id from public.accept_invite((select code from codes where who = 'ana_again'))), null,
  'caio accepts a new invite after unpairing');

select tests.as_admin();
select is((select cancelled_at is null from public.invites where id = (select id from ids where k = 'caio_used')), true,
  'an already accepted invite is not cancelled by a later accept');

select * from finish();
rollback;

begin;
set local search_path = tap, public, extensions;
select plan(26);
select tests.create_user('ana', 'Ana'); select tests.create_user('bia', 'Bia'); select tests.create_user('caio');
create temp table ids (k text primary key, id uuid) on commit drop; grant all on ids to authenticated;

-- alone: partner features say NOT_PAIRED
select tests.as('ana');
select throws_ok($$select public.send_signal('miss_us')$$, 'P0001', 'NOT_PAIRED', 'signals need a partner');
select tests.pair('ana', 'bia');

-- signals and messages
select tests.as('ana');
with x as (select id from public.send_signal('need', 'hug')) insert into ids select 'signal', id from x;
with x as (select id from public.send_partner_message('note', 'Boa sorte na reunião!', null, true)) insert into ids select 'msg', id from x;
select is((select for_widget from public.partner_messages), false, 'note stays off the widget until the receiver allows it');
select throws_ok(format($$select public.respond_to_signal(%L, 'here')$$, (select id from ids where k = 'signal')), 'P0001', 'NOT_FOUND', 'sender cannot answer their own signal');
select tests.as('bia');
select is((select unseen_signals from public.today()), 1, 'Hoje counts the unseen signal');
select is((select response from public.respond_to_signal((select id from ids where k = 'signal'), 'here')), 'here', 'recipient answers with one tap');
select isnt((select hearted_at from public.mark_partner_message((select id from ids where k = 'msg'), true)), null, 'recipient hearts the note');
update public.profile_settings set widget_allow_partner_notes = true where profile_id = tests.uid('bia');
select tests.as('ana');
select public.send_partner_message('note', 'Te amo', null, true);
select tests.as('bia');
select is((select partner_note from public.widget()), 'Te amo', 'widget shows the note once the receiver allowed it');
select tests.as('ana');
select public.send_partner_message('drawing', null, 'ana/drawing.png', true);
select tests.as('bia');
select is((select partner_note from public.widget()), 'Te amo', 'a newer drawing does not blank the text note');
select is((select partner_note_media from public.widget()), null, 'the widget keeps showing text only');
select tests.as('caio');
select is((select count(*)::int from public.signals) + (select count(*)::int from public.partner_messages), 0, 'stranger sees no signals or messages');

-- couple question: hidden until both answer
select tests.as('ana');
insert into public.question_answers (question_slug, body, couple_id) values ('first-meeting', 'Foi na festa da Ana.', private.current_couple_id());
select tests.as('bia');
select is((select count(*)::int from public.question_answers), 0, 'partner cannot read my answer before answering');
select is(public.partner_answered('first-meeting'), true, 'but knows that I answered');
insert into public.question_answers (question_slug, body, couple_id) values ('first-meeting', 'Achei você sério demais.', private.current_couple_id());
select is((select count(*)::int from public.question_answers), 2, 'both answers are revealed once both answered');

-- answers are scoped to the couple that was current when they were written
select tests.create_user('davi', 'Davi'); select tests.create_user('eve', 'Eve'); select tests.create_user('fabi', 'Fabi');
select tests.as('davi');
insert into public.question_answers (question_slug, body) values ('second-question', 'Antes de qualquer par.');
select tests.pair('davi', 'eve');
select tests.as('davi');
select is((select couple_id from public.question_answers where question_slug = 'second-question'),
          private.current_couple_id(), 'a solo answer joins the couple when they pair');
select tests.as('eve');
insert into public.question_answers (question_slug, body, couple_id) values ('second-question', 'Agora respondo.', private.current_couple_id());
select tests.as('davi');
select is((select count(*)::int from public.question_answers where question_slug = 'second-question'), 2, 'both answers reveal for the new couple');

insert into public.question_answers (question_slug, body, couple_id) values ('third-question', 'Da primeira vez.', private.current_couple_id());
select public.unpair();
select tests.as_admin();
select tests.pair('davi', 'fabi');
select tests.as('fabi');
insert into public.question_answers (question_slug, body, couple_id) values ('third-question', 'Da segunda vez.', private.current_couple_id());
select tests.as('davi');
select is((select count(*)::int from public.question_answers where question_slug = 'third-question' and author_id = tests.uid('fabi')), 0, 'an answer from a previous couple does not reveal the new partner answer');
insert into public.question_answers (question_slug, body, couple_id) values ('third-question', 'Respondo de novo.', private.current_couple_id());
select is((select count(*)::int from public.question_answers where question_slug = 'third-question'), 3, 'a person can answer the same question in a new couple');
select tests.as('fabi');
select is((select count(*)::int from public.question_answers where question_slug = 'third-question' and author_id = tests.uid('davi')), 1, 'the new couple reveals once both answered');

-- weekly check-in: revealed when both finished all four
select tests.as('ana');
insert into public.checkin_answers (couple_id, week_start, question, body) select private.current_couple_id(), '2026-11-09', q, 'resposta ' || q from generate_series(1, 4) q;
select tests.as('bia');
insert into public.checkin_answers (couple_id, week_start, question, body) select private.current_couple_id(), '2026-11-09', q, 'resposta ' || q from generate_series(1, 3) q;
select is((select count(*)::int from public.checkin_answers), 3, 'check-in answers stay hidden until I finish too');
insert into public.checkin_answers (couple_id, week_start, question, body) values (private.current_couple_id(), '2026-11-09', 4, 'resposta 4');
select is((select count(*)::int from public.checkin_answers), 8, 'both finished: all answers visible');

-- games
select tests.as('ana');
with x as (select id from public.invite_to_game('me_or_you', array['organized', 'romantic'])) insert into ids select 'game', id from x;
select throws_ok(format($$select public.update_game(%L, 'join')$$, (select id from ids where k = 'game')), 'P0001', 'INVALID_GAME_ACTION', 'the inviter cannot join their own invite');
select tests.as('bia');
select is((select status from public.update_game((select id from ids where k = 'game'), 'join')), 'active', 'partner joins');
select public.answer_game((select id from ids where k = 'game'), 0, 'me'); select public.answer_game((select id from ids where k = 'game'), 1, 'you');
select throws_ok(format($$select public.update_game(%L, 'finish')$$, (select id from ids where k = 'game')), 'P0001', 'GAME_NOT_COMPLETE', 'cannot finish before both answered');
select tests.as('ana');
select is((select count(*)::int from public.game_answers), 0, 'answers are private while the game is running');
select public.answer_game((select id from ids where k = 'game'), 0, 'you'); select public.answer_game((select id from ids where k = 'game'), 1, 'you');
select is((select status from public.update_game((select id from ids where k = 'game'), 'finish')), 'finished', 'game finishes');
select is((select count(*)::int from public.game_answers), 4, 'answers are revealed together at the end');

select * from finish();
rollback;

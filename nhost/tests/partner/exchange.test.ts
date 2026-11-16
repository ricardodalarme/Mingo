import { test } from 'node:test';
import { assert, couple, denied, ok, person, sql } from '../lib.ts';

test('a signal goes to the current partner only, and only the recipient answers it', async () => {
  const { a, b } = await couple();
  const stranger = await person();
  await denied(a, `mutation ($r: uuid!) { insertSignalsOne(object: {kind: hug, recipientId: $r}) { id } }`, { r: stranger.id });
  const signal = (await ok(a, `mutation { insertSignalsOne(object: {kind: hug, body: " oi "}) { id senderId recipientId body } }`)).insertSignalsOne;
  assert.deepEqual([signal.senderId, signal.recipientId, signal.body], [a.id, b.id, 'oi']);
  assert.deepEqual((await ok(stranger, `{ signals { id } }`)).signals, []);
  assert.equal((await ok(b, `{ today { unseenSignals } }`)).today[0].unseenSignals, 1);
  assert.equal((await ok(a, `mutation ($id: uuid!) { updateSignalsByPk(pk_columns: {id: $id}, _set: {response: here}) { id } }`, { id: signal.id })).updateSignalsByPk, null);
  const answered = (await ok(b, `mutation ($id: uuid!) { updateSignalsByPk(pk_columns: {id: $id}, _set: {response: here}) { response respondedAt seenAt } }`, { id: signal.id })).updateSignalsByPk;
  assert.equal(answered.response, 'here');
  assert.ok(answered.respondedAt && answered.seenAt);
  assert.deepEqual(await sql(`select type from private.notifications where ref_id = '${signal.id}'`), [['signal']]);
});

test('signals and messages need a partner and stop at 30 a day', async () => {
  const solo = await person();
  await denied(solo, `mutation { insertSignalsOne(object: {kind: hug}) { id } }`);
  await denied(solo, `mutation { insertPartnerMessagesOne(object: {kind: note, body: "oi"}) { id } }`);
  const { a, b } = await couple();
  await sql(`insert into public.signals (sender_id, recipient_id, kind) select '${a.id}', '${b.id}', 'hug' from generate_series(1, 29)`);
  assert.equal((await ok(a, `{ plusStates { signalsLeftToday } }`)).plusStates[0].signalsLeftToday, 1);
  await ok(a, `mutation { insertSignalsOne(object: {kind: hug}) { id } }`);
  await denied(a, `mutation { insertSignalsOne(object: {kind: hug}) { id } }`);
});

test('a partner message reaches the widget only if the recipient allowed it, and the sender can take it back', async () => {
  const { a, b } = await couple();
  const first = (await ok(a, `mutation { insertPartnerMessagesOne(object: {kind: note, body: "pensei em você", forWidget: true}) { id forWidget recipientId } }`)).insertPartnerMessagesOne;
  assert.deepEqual([first.forWidget, first.recipientId], [false, b.id]);
  await ok(b, `mutation ($id: uuid!) { updateUserSettingsByPk(pk_columns: {userId: $id}, _set: {widgetAllowPartnerNotes: true}) { userId } }`, { id: b.id });
  const second = (await ok(a, `mutation { insertPartnerMessagesOne(object: {kind: note, body: "oi", forWidget: true}) { id forWidget } }`)).insertPartnerMessagesOne;
  assert.equal(second.forWidget, true);
  const hearted = await ok(b, `mutation ($id: uuid!) { updatePartnerMessagesByPk(pk_columns: {id: $id}, _set: {heartedAt: "now()", seenAt: "now()"}) { heartedAt } }`, { id: second.id });
  assert.ok(hearted.updatePartnerMessagesByPk.heartedAt);
  assert.equal((await ok(b, `mutation ($id: uuid!) { deletePartnerMessagesByPk(id: $id) { id } }`, { id: second.id })).deletePartnerMessagesByPk, null);
  await ok(a, `mutation ($id: uuid!) { deletePartnerMessagesByPk(id: $id) { id } }`, { id: second.id });
  assert.deepEqual((await ok(b, `{ partnerMessages { id } }`)).partnerMessages, [{ id: first.id }]);
  const stranger = await person();
  assert.deepEqual((await ok(stranger, `{ partnerMessages { id } }`)).partnerMessages, []);
});

test('a question answer stays hidden from the partner until both answered', async () => {
  const { a, b, coupleId } = await couple();
  const mine = (await ok(a, `mutation { insertQuestionAnswersOne(object: {questionSlug: "first-meeting", body: "na praia"}) { id coupleId } }`)).insertQuestionAnswersOne;
  assert.equal(mine.coupleId, coupleId);
  assert.deepEqual((await ok(b, `{ questionAnswers { id } }`)).questionAnswers, []);
  await denied(b, `{ questionAnswersAggregate { aggregate { count } } }`);
  await ok(b, `mutation { insertQuestionAnswersOne(object: {questionSlug: "other", body: "x"}) { id } }`);
  assert.equal((await ok(b, `{ questionAnswers { id } }`)).questionAnswers.length, 1, 'answering another question reveals nothing');
  await ok(b, `mutation { insertQuestionAnswersOne(object: {questionSlug: "first-meeting", body: "no cinema"}) { id } }`);
  const revealed = (await ok(b, `{ questionAnswers(where: {questionSlug: {_eq: "first-meeting"}}, order_by: {createdAt: asc}) { body } }`)).questionAnswers;
  assert.deepEqual(revealed, [{ body: 'na praia' }, { body: 'no cinema' }]);
  await ok(a, `mutation { unpair { id } }`);
  assert.equal((await ok(b, `{ questionAnswers(where: {questionSlug: {_eq: "first-meeting"}}) { body } }`)).questionAnswers.length, 1, 'an ex-partner sees only their own');
});

test('a solo answer joins the couple when the person pairs', async () => {
  const a = await person();
  const b = await person();
  await ok(a, `mutation { insertQuestionAnswersOne(object: {questionSlug: "q", body: "solo"}) { id } }`);
  const { pair } = await import('../lib.ts');
  const coupleId = await pair(a, b);
  assert.deepEqual((await ok(a, `{ questionAnswers { coupleId } }`)).questionAnswers, [{ coupleId }]);
});

test('a weekly check-in is revealed only when both finished all four answers', async () => {
  const { a, b } = await couple();
  const full = `answer1: "a", answer2: "b", answer3: "c", answer4: "d"`;
  await ok(a, `mutation { insertCheckinsOne(object: {${full}}) { id completed weekStart } }`);
  const partial = (await ok(b, `mutation { insertCheckinsOne(object: {answer1: "x"}) { id completed } }`)).insertCheckinsOne;
  assert.equal(partial.completed, false);
  assert.equal((await ok(b, `{ checkins { id } }`)).checkins.length, 1);
  assert.equal((await ok(a, `{ checkins { id } }`)).checkins.length, 1);
  await ok(b, `mutation ($id: uuid!) { updateCheckinsByPk(pk_columns: {id: $id}, _set: {answer2: "y", answer3: "z", answer4: "w"}) { completed } }`, { id: partial.id });
  assert.equal((await ok(a, `{ checkins { id } }`)).checkins.length, 2);
  assert.equal((await ok(b, `{ checkins { id } }`)).checkins.length, 2);
  const solo = await person();
  await denied(solo, `mutation { insertCheckinsOne(object: {answer1: "x"}) { id } }`);
});

test('a game is joined by the other partner, answers stay private until it is finished, and nothing is scored', async () => {
  const { a, b } = await couple();
  const stranger = await person();
  const game = (await ok(a, `mutation { insertGameSessionsOne(object: {game: me_or_you, itemSlugs: ["one", "two"]}) { id status invitedBy } }`)).insertGameSessionsOne;
  assert.deepEqual([game.status, game.invitedBy], ['invited', a.id]);
  await denied(a, `mutation { insertGameSessionsOne(object: {game: me_or_you}) { id } }`);
  const act = (who: any, action: string, extra = '') =>
    ok(who, `mutation ($id: uuid!) { updateGame(args: {sessionId: $id, action: "${action}"${extra}}) { status outcome } }`, { id: game.id }).then((d) => d.updateGame);
  assert.deepEqual(await act(a, 'join'), [], 'the inviter cannot join their own game');
  assert.deepEqual(await act(stranger, 'join'), []);
  await denied(b, `mutation ($id: uuid!) { insertGameAnswersOne(object: {sessionId: $id, idx: 0, answer: "me"}) { id } }`, { id: game.id });
  assert.deepEqual(await act(b, 'join'), [{ status: 'active', outcome: null }]);
  const answer = (who: any, idx: number, text: string) =>
    ok(who, `mutation ($id: uuid!) { insertGameAnswersOne(object: {sessionId: $id, idx: ${idx}, answer: "${text}"},
      on_conflict: {constraint: game_answers_once, update_columns: [answer]}) { id } }`, { id: game.id });
  await answer(a, 0, 'me');
  await answer(a, 0, 'you');
  await denied(stranger, `mutation ($id: uuid!) { insertGameAnswersOne(object: {sessionId: $id, idx: 0, answer: "x"}) { id } }`, { id: game.id });
  await denied(a, `mutation ($id: uuid!) { insertGameAnswersOne(object: {sessionId: $id, idx: 5, answer: "x"}) { id } }`, { id: game.id });
  assert.deepEqual((await ok(b, `{ gameAnswers { id } }`)).gameAnswers, [], 'the partner cannot peek');
  assert.deepEqual(await act(a, 'finish'), [], 'not finished before both answered everything');
  await answer(b, 0, 'you');
  await denied(a, `mutation ($id: uuid!) { insertGameAnswersOne(object: {sessionId: $id, idx: 0, answer: "changed"},
    on_conflict: {constraint: game_answers_once, update_columns: [answer]}) { id } }`, { id: game.id });
  await answer(a, 1, 'me');
  await answer(b, 1, 'me');
  assert.deepEqual(await act(b, 'finish', ', outcome: "great"'), [{ status: 'finished', outcome: 'great' }]);
  assert.equal((await ok(b, `{ gameAnswers { id } }`)).gameAnswers.length, 4);
  assert.deepEqual((await ok(stranger, `{ gameSessions { id } gameAnswers { id } }`)), { gameSessions: [], gameAnswers: [] });
  const fields = (await ok(a, `{ __type(name: "gameSessions") { fields { name } } }`)).__type.fields.map((f: any) => f.name);
  assert.equal(fields.some((f: string) => /score|winner|points/i.test(f)), false);
});

test('game items are served unseen first and recorded for the couple', async () => {
  const { a, b } = await couple();
  await sql(`insert into public.content_items (kind, slug, locale, title, position)
             select 'never_have_we', 'nhw-' || g, 'pt-BR', 'item ' || g, g from generate_series(1, 4) g on conflict do nothing`);
  const next = (who: any) => ok(who, `mutation { nextGameItems(args: {game: "never_have_we", count: 2}) { slug } }`).then((d) => d.nextGameItems.map((i: any) => i.slug));
  const first = await next(a);
  const second = await next(b);
  assert.equal(first.length, 2);
  assert.equal(second.some((s: string) => first.includes(s)), false, 'the partner continues where the couple stopped');
  await denied(a, `{ gameSeenItems { itemSlug } }`);
});

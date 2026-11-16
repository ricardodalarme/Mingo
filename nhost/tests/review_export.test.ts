import { test } from 'node:test';
import { assert, couple, denied, ok, person, signUp, sql, upload, urls } from './lib.ts';

const review = (who: any, week: string | null = null) =>
  ok(who, `query { weeklyReview(args: {${week ? `weekStart: "${week}"` : ''}}) { weekStart slips activeDays streakDays moodsLogged ritualsDone cardsSent cardsReceived checkinDone partnerCardsSent coupleRitualsDone bothCheckinDone lowData missing } }`)
    .then((d) => d.weeklyReview[0]);

// Dates are relative to the person's own week so the tests do not depend on the weekday they run.
async function week(who: { id: string }): Promise<{ start: string; day: (n: number) => string }> {
  const start = (await sql(`select private.local_week_start('${who.id}')`))[0][0];
  return { start, day: (n) => `${start}`.replace(/.*/, () => new Date(Date.parse(start) + n * 86_400_000).toISOString().slice(0, 10)) };
}

test('an empty week says what is missing and never scores', async () => {
  const a = await person();
  const r = await review(a);
  assert.deepEqual([r.slips, r.activeDays, r.streakDays, r.moodsLogged, r.ritualsDone, r.cardsSent, r.cardsReceived], [0, 0, 0, 0, 0, 0, 0]);
  assert.deepEqual([r.lowData, r.missing, r.checkinDone], [true, ['slips', 'mood', 'ritual'], false]);
  assert.deepEqual([r.partnerCardsSent, r.coupleRitualsDone, r.bothCheckinDone], [null, null, null], 'nothing about a partner without a couple');
});

test('the week counts own slips, moods and rituals, and a streak of consecutive days', async () => {
  const a = await person();
  const w = await week(a);
  const past = '2025-03-10';
  await sql(`insert into public.slips (author_id, body, created_at) values
    ('${a.id}', 'um', '${past}T12:00:00Z'), ('${a.id}', 'dois', '${past}T13:00:00Z'), ('${a.id}', 'três', '2025-03-11T12:00:00Z')`);
  await sql(`insert into public.moods (author_id, day, mood) values ('${a.id}', '2025-03-12', 'happy')`);
  const r = await review(a, '2025-03-12');
  assert.equal(r.weekStart, '2025-03-10');
  assert.deepEqual([r.slips, r.activeDays, r.streakDays, r.moodsLogged], [3, 3, 3, 1]);
  assert.deepEqual(r.missing, ['ritual']);
  assert.equal(r.lowData, false);
  const next = await review(a, '2025-03-17');
  assert.deepEqual([next.slips, next.streakDays, next.lowData], [0, 0, true]);
  assert.equal(w.start.length, 10);
});

test('the streak ends at the last active day of a past week and reaches into the week before', async () => {
  const a = await person();
  await sql(`insert into public.slips (author_id, body, created_at) values
    ('${a.id}', 'a', '2025-03-08T12:00:00Z'), ('${a.id}', 'b', '2025-03-09T12:00:00Z'), ('${a.id}', 'c', '2025-03-10T12:00:00Z')`);
  const r = await review(a, '2025-03-10');
  assert.deepEqual([r.activeDays, r.streakDays], [1, 3]);
});

test('this week a streak that is older than yesterday no longer counts', async () => {
  const a = await person();
  const w = await week(a);
  const today = (await sql(`select private.local_date('${a.id}')`))[0][0];
  await sql(`insert into public.slips (author_id, body, created_at) values ('${a.id}', 'hoje', now())`);
  assert.deepEqual((await review(a)).streakDays, 1);
  await sql(`delete from public.slips where author_id = '${a.id}'`);
  const ritual = (await ok(a, `mutation { insertRitualsOne(object: {title: "r"}) { id } }`)).insertRitualsOne;
  await sql(`insert into public.ritual_logs (ritual_id, author_id, done_on) values ('${ritual.id}', '${a.id}', '${today}'::date - 3)`);
  assert.deepEqual((await review(a)).streakDays, 0);
  assert.ok(w.start);
});

test('together shows only counts: the partner cards, shared rituals and a check-in both finished', async () => {
  const { a, b, coupleId } = await couple();
  const ritual = (await ok(a, `mutation ($c: uuid!) { insertRitualsOne(object: {title: "café", coupleId: $c}) { id } }`, { c: coupleId })).insertRitualsOne;
  const second = (await ok(a, `mutation ($c: uuid!) { insertRitualsOne(object: {title: "chá", coupleId: $c}) { id } }`, { c: coupleId })).insertRitualsOne;
  const solo = (await ok(a, `mutation { insertRitualsOne(object: {title: "meu"}) { id } }`)).insertRitualsOne;
  const w = (await sql(`select private.local_week_start('${a.id}')`))[0][0];
  await sql(`insert into public.ritual_logs (ritual_id, author_id, done_on) values ('${ritual.id}', '${a.id}', '${w}'), ('${second.id}', '${b.id}', '${w}'), ('${solo.id}', '${a.id}', '${w}')`);
  await sql(`insert into public.slips (author_id, body) values ('${b.id}', 'segredo')`);
  assert.deepEqual((await review(a)).bothCheckinDone, false);
  for (const who of [a, b]) {
    await ok(who, `mutation { insertCheckinsOne(object: {answer1: "a", answer2: "b", answer3: "c", answer4: "d"}) { id } }`);
  }
  const r = await review(a);
  assert.deepEqual([r.coupleRitualsDone, r.ritualsDone, r.bothCheckinDone, r.checkinDone], [2, 2, true, true]);
  assert.deepEqual([r.slips, r.partnerCardsSent], [0, 0], 'the partner slips are not visible, not even as a count');
  assert.equal((await review(b)).coupleRitualsDone, 2);
  assert.equal((await review(b)).ritualsDone, 1);
});

test('the review does not read annoyances, notes or Tempero', async () => {
  const a = await person();
  await ok(a, `mutation { insertAnnoyancesOne(object: {body: "segredo"}) { id } }`);
  const text = JSON.stringify(await review(a));
  assert.doesNotMatch(text, /segredo/);
  assert.equal((await review(a)).activeDays, 0, 'an annoyance is not an active day');
});

// Export -----------------------------------------------------------------------------------------------------------------
const exportFor = async (userId: string) => {
  const { exportUserData } = await ok('admin', `mutation ($u: uuid!) { exportUserData(args: {userId: $u}) { data } }`, { u: userId });
  return exportUserData[0]?.data;
};

test('the export holds the person data only, never the partner rows, replies or answers', async () => {
  const { a, b, coupleId } = await couple();
  await ok(a, `mutation { insertSlipsOne(object: {body: "minha-nota-a"}) { id } insertAnnoyancesOne(object: {body: "incomodo-a"}) { id } }`);
  await ok(b, `mutation { insertSlipsOne(object: {body: "nota-do-parceiro-b"}) { id } insertAnnoyancesOne(object: {body: "incomodo-b"}) { id } }`);
  await ok(a, `mutation ($c: uuid!) { insertMemoriesOne(object: {title: "viagem-a", happenedOn: "2024-01-01", coupleId: $c}) { id } }`, { c: coupleId });
  await ok(b, `mutation ($c: uuid!) { insertMemoriesOne(object: {title: "viagem-b", happenedOn: "2024-01-02", coupleId: $c}) { id } }`, { c: coupleId });
  await ok(a, `mutation { insertSignalsOne(object: {kind: thinking, value: "x", body: "sinal-de-a"}) { id } }`).catch(() => null);
  await ok(a, `mutation { insertPartnerMessagesOne(object: {kind: note, body: "bilhete-de-a"}) { id } }`);
  await ok(b, `mutation { insertPartnerMessagesOne(object: {kind: note, body: "bilhete-de-b"}) { id } }`);
  const { sendGentleRequest } = await ok(a, `mutation { sendGentleRequest(args: {whenText: "quando-a", feelText: "sinto-a", wishText: "quero-a"}) { id } }`);
  await ok(b, `mutation ($id: uuid!) { updateGentleRequestsByPk(pk_columns: {id: $id}, _set: {response: will_do}) { id } }`, { id: sendGentleRequest[0].id });

  const data = await exportFor(a.id);
  const text = JSON.stringify(data);
  for (const mine of ['minha-nota-a', 'incomodo-a', 'viagem-a', 'bilhete-de-a', 'quando-a']) assert.ok(text.includes(mine), mine);
  for (const theirs of ['nota-do-parceiro-b', 'incomodo-b', 'viagem-b', 'bilhete-de-b', 'will_do']) assert.ok(!text.includes(theirs), `the export leaks ${theirs}`);
  assert.equal(data.profile.id, a.id);
  for (const section of ['profile', 'settings', 'consents', 'notification_settings', 'slips', 'annoyances', 'gentle_requests_sent', 'cards_authored', 'card_items',
    'card_reactions_made', 'moods', 'temperature_checks', 'repair_sessions', 'repair_learnings', 'journal_entries', 'conversation_preps', 'partner_facts',
    'manual_entries', 'learned_items', 'quiz_results', 'memories_authored', 'story_events_authored', 'important_dates_authored', 'rituals_authored',
    'ritual_logs', 'logistic_items_authored', 'saved_date_ideas', 'lists_authored', 'list_items', 'gift_ideas_authored', 'capsules_authored',
    'question_answers', 'checkins', 'game_answers', 'signals_sent', 'partner_messages_sent', 'spice_desire_answers', 'agreements_authored', 'files']) {
    assert.ok(Array.isArray(data[section]) || typeof data[section] === 'object', `missing section ${section}`);
  }
  assert.equal(data.slips.length, 1);
  assert.equal(data.partner_messages_sent.length, 1);
});

test('an export is limited to one a day and the data function is for Functions only', async () => {
  const a = await person();
  await exportFor(a.id);
  const refused = await ok('admin', `mutation ($u: uuid!) { exportUserData(args: {userId: $u}) { data } }`, { u: a.id });
  assert.deepEqual(refused.exportUserData, [], 'a second export within a day returns nothing');
  await sql(`update private.export_requests set created_at = now() - interval '25 hours' where user_id = '${a.id}'`);
  assert.ok(await exportFor(a.id), 'allowed again after a day');
  await denied(a, `mutation ($u: uuid!) { exportUserData(args: {userId: $u}) { data } }`, { u: a.id });
  const file = await upload((await signUp()).token, 'exports').catch((e) => e);
  assert.ok(file instanceof Error, 'a person cannot upload into the exports bucket');
});

// Sessions ---------------------------------------------------------------------------------------------------------------
test('a person lists and ends their own sessions, with the device linked to each', async () => {
  const s = await signUp('Ana');
  const other = await signUp('Bruno');
  const tokenId = (await sql(`select id from auth.refresh_tokens where user_id = '${s.id}'`))[0][0];
  await ok(s, `mutation ($t: String!, $r: uuid!) { insertDevicesOne(object: {token: $t, platform: ios, label: "iPhone", refreshTokenId: $r}) { id } }`, { t: `t${Date.now()}`, r: tokenId });
  const list = (await ok(s, `{ mySessions { id deviceLabel platform } }`)).mySessions;
  assert.deepEqual(list, [{ id: tokenId, deviceLabel: 'iPhone', platform: 'ios' }]);
  assert.deepEqual((await ok(other, `{ mySessions { id } }`)).mySessions.map((r: any) => r.id).includes(tokenId), false);
  assert.deepEqual((await ok(other, `mutation ($id: uuid!) { revokeSession(args: {sessionId: $id}) { id } }`, { id: tokenId })).revokeSession, []);
  assert.equal((await ok(s, `mutation ($id: uuid!) { revokeSession(args: {sessionId: $id}) { id } }`, { id: tokenId })).revokeSession.length, 1);
  assert.deepEqual((await ok(s, `{ mySessions { id } }`)).mySessions, []);
  assert.deepEqual((await ok(s, `{ devices { id } }`)).devices, [], 'the push device goes with the session');
});

test('POST /export stores the document for the caller, hands back a link, and allows one a day', async () => {
  const session = await signUp('Ana');
  await ok(session, `mutation { insertSlipsOne(object: {body: "exportada"}) { id } }`);
  const call = (token: string | null) =>
    fetch(`${urls.functions}/export`, { method: 'POST', headers: token ? { authorization: `Bearer ${token}` } : {} });
  assert.equal((await call(null)).status, 401);
  assert.equal((await call('not-a-token')).status, 401);
  const first = await call(session.token);
  assert.equal(first.status, 200);
  const { url, expiresAt } = (await first.json()) as { url: string; expiresAt: string };
  assert.ok(url.startsWith('http') && Date.parse(expiresAt) > Date.now());
  const rows = await sql(`select id, uploaded_by_user_id, mime_type from storage.files where bucket_id = 'exports' and uploaded_by_user_id = '${session.id}'`);
  assert.equal(rows.length, 1);
  const document = await (await fetch(`${urls.storage}/files/${rows[0][0]}`, { headers: { authorization: `Bearer ${session.token}` } })).json();
  assert.equal(document.profile.id, session.id);
  assert.equal(document.slips[0].body, 'exportada');
  const stranger = await signUp('Bruno');
  assert.equal((await fetch(`${urls.storage}/files/${rows[0][0]}`, { headers: { authorization: `Bearer ${stranger.token}` } })).status, 404);
  assert.equal((await call(session.token)).status, 429);
});

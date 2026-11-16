import { test } from 'node:test';
import { assert, couple, denied, ok, person, signUp, sql, upload, urls } from '../lib.ts';

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

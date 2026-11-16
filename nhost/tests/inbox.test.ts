import { test } from 'node:test';
import { assert, couple, denied, ok, person, plus, randomUUID, sql } from './lib.ts';

const notify = (userId: string, type: string, key: string | null = randomUUID()) =>
  sql(`select private.notify('${userId}', '${type}', null, ${key === null ? 'null' : `'${key}'`})`);

test('a notification is listed in the inbox of its person only', async () => {
  const a = await person();
  const b = await person();
  await notify(a.id, 'card_received');

  const mine = await ok(a, `{ inboxItems { type readAt } }`);
  assert.deepEqual(mine.inboxItems, [{ type: 'card_received', readAt: null }]);
  assert.deepEqual((await ok(b, `{ inboxItems { type } }`)).inboxItems, []);
});

test('the same notification is listed once', async () => {
  const p = await person();
  const key = randomUUID();
  await notify(p.id, 'card_ready', key);
  await notify(p.id, 'card_ready', key);

  assert.equal((await ok(p, `{ inboxItemsAggregate { aggregate { count } } }`)).inboxItemsAggregate.aggregate.count, 1);
});

test('a type the person switched off is not listed', async () => {
  const p = await person();
  await ok(p, `mutation { insertNotificationMutesOne(object: {type: daily_idea}) { type } }`);
  await notify(p.id, 'daily_idea');
  await notify(p.id, 'card_ready');

  const { inboxItems } = await ok(p, `{ inboxItems { type } }`);
  assert.deepEqual(inboxItems.map((i: any) => i.type), ['card_ready']);
});

test('a person marks their own items read and changes nothing else', async () => {
  const a = await person();
  const b = await person();
  await notify(a.id, 'card_received');
  await notify(b.id, 'card_received');

  const done = await ok(a, `mutation { updateInboxItems(where: {readAt: {_is_null: true}}, _set: {readAt: "2026-01-01T00:00:00Z"}) { affected_rows } }`);
  assert.equal(done.updateInboxItems.affected_rows, 1);
  assert.equal((await ok(b, `{ inboxItemsAggregate(where: {readAt: {_is_null: true}}) { aggregate { count } } }`)).inboxItemsAggregate.aggregate.count, 1);
  await denied(a, `mutation { updateInboxItems(where: {}, _set: {type: signal}) { affected_rows } }`);
  await denied(a, `mutation { insertInboxItemsOne(object: {type: signal}) { id } }`);
  assert.equal((await ok(a, `mutation { deleteInboxItems(where: {}) { affected_rows } }`)).deleteInboxItems.affected_rows, 1);
  assert.equal((await ok(b, `{ inboxItemsAggregate { aggregate { count } } }`)).inboxItemsAggregate.aggregate.count, 1, 'only the own rows can be deleted');
});

test('an inbox row exists even when the push is dropped, and inbox-only types are never pushed', async () => {
  const p = await person();
  await sql(`update public.notification_settings set enabled = false where user_id = '${p.id}'`);
  await notify(p.id, 'card_received');
  await sql(`select private.notify_inbox('${p.id}', 'annoyance_check', null, 'ac:${p.id}')`);
  await sql(`select private.notify('${p.id}', 'plus_billing_issue', null, 'pb:${p.id}')`);
  const { inboxItems } = await ok(p, `{ inboxItems(order_by: {type: asc}) { type } }`);
  assert.deepEqual(inboxItems.map((i: any) => i.type), ['annoyance_check', 'card_received', 'plus_billing_issue']);
  const pushes = await sql(`select type, outcome from private.notifications where user_id = '${p.id}' order by type`);
  assert.deepEqual(pushes, [['card_received', 'NULL']], 'inbox-only types have no push row');
  const claimed = await sql(`select count(*) from private.claim_notification((select id from private.notifications where user_id = '${p.id}'))`);
  assert.equal(claimed[0][0], '0');
  assert.deepEqual(await sql(`select outcome from private.notifications where user_id = '${p.id}'`), [['dropped']]);
});

test('a muted type creates no inbox row, also for inbox-only types', async () => {
  const p = await person();
  await ok(p, `mutation { insertNotificationMutesOne(object: {type: annoyance_check}) { type } }`);
  await sql(`select private.notify_inbox('${p.id}', 'annoyance_check', null, null)`);
  assert.deepEqual((await ok(p, `{ inboxItems { id } }`)).inboxItems, []);
});

test('partner-initiated types bypass the daily cap, and the new types exist', async () => {
  const kinds = ['gentle_request', 'gentle_request_answered', 'quiz_shared', 'spice_invite', 'spice_off', 'memory_proposed', 'memory_accepted', 'memory_declined'];
  for (const kind of kinds) assert.equal((await sql(`select private.is_partner_initiated('${kind}')`))[0][0], 't', kind);
  for (const kind of ['annoyance_check', 'plus_billing_issue', 'plus_coverage_ended']) {
    assert.equal((await sql(`select private.is_partner_initiated('${kind}')`))[0][0], 'f', kind);
  }
});

test('a payment problem is told to the owner only, and the end of coverage to the covered partner', async () => {
  const { a, b } = await couple();
  await plus(a);
  await sql(`update public.entitlements set status = 'billing_issue' where user_id = '${a.id}'`);
  const types = async (who: any) => (await ok(who, `{ inboxItems(where: {type: {_in: [plus_billing_issue, plus_coverage_ended]}}) { type } }`)).inboxItems.map((i: any) => i.type);
  assert.deepEqual(await types(a), ['plus_billing_issue']);
  assert.deepEqual(await types(b), []);
  await sql(`update public.entitlements set status = 'expired' where user_id = '${a.id}'`);
  assert.deepEqual(await types(b), ['plus_coverage_ended']);
});

import { test } from 'node:test';
import { assert, denied, ok, person, randomUUID, sql } from './lib.ts';

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
  await denied(a, `mutation { deleteInboxItems(where: {}) { affected_rows } }`);
});

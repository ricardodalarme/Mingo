import { test } from 'node:test';
import { assert, ok, person, randomUUID, sql } from './lib.ts';

const device = () => randomUUID().replace(/-/g, '');

/** A notification awaiting delivery, as the database triggers queue them. */
async function queue(userId: string, type: string, key = randomUUID()): Promise<string> {
  const rows = await sql(`insert into private.notifications (user_id, type, dedupe_key)
    values ('${userId}', '${type}', '${key}') returning id`);
  return rows[0][0];
}

async function claim(notificationId: string): Promise<string[]> {
  const { claimNotification } = await ok('admin', `mutation ($id: uuid!) { claimNotification(args: {notification_id: $id}) { token } }`, { id: notificationId });
  return claimNotification.map((d: any) => d.token);
}

async function complete(notificationId: string, failed: string[] = []): Promise<string[]> {
  const { completeNotification } = await ok('admin', `mutation ($id: uuid!, $t: jsonb!) { completeNotification(args: {notification_id: $id, failed_tokens: $t}) { token } }`, { id: notificationId, t: failed });
  return completeNotification.map((d: any) => d.token);
}

async function outcome(notificationId: string): Promise<string | null> {
  const rows = await sql(`select coalesce(outcome, 'pending') from private.notifications where id = '${notificationId}'`);
  return rows[0]?.[0] ?? null;
}

async function settings(userId: string, set: string) {
  await sql(`update public.notification_settings set ${set} where user_id = '${userId}'`);
}

test('a notification goes to every device of its person once, until it is settled', async () => {
  const p = await person();
  const first = device();
  const second = device();
  await ok(p, `mutation ($a: String!, $b: String!) {
    insertDevices(objects: [{token: $a, platform: ios}, {token: $b, platform: android}]) { returning { id } } }`, { a: first, b: second });
  const id = await queue(p.id, 'card_ready');
  assert.deepEqual((await claim(id)).sort(), [first, second].sort());
  await complete(id);
  assert.equal(await outcome(id), 'sent');
  assert.deepEqual(await claim(id), [], 'a settled notification is never delivered again');
});

test('the daily cap and the person switch silence a notification', async () => {
  const p = await person();
  await ok(p, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: ios}) { id } }`, { t: device() });
  await settings(p.id, `daily_max = 1`);
  const first = await queue(p.id, 'daily_idea');
  await claim(first);
  await complete(first);
  const second = await queue(p.id, 'daily_idea');
  assert.deepEqual(await claim(second), []);
  assert.equal(await outcome(second), 'dropped');

  const q = await person();
  await ok(q, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: ios}) { id } }`, { t: device() });
  await settings(q.id, `enabled = false`);
  const silenced = await queue(q.id, 'card_ready');
  assert.deepEqual(await claim(silenced), []);
  assert.equal(await outcome(silenced), 'dropped');
});

test('a muted type is not delivered, and muting one leaves the others alone', async () => {
  const p = await person();
  await ok(p, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: ios}) { id } }`, { t: device() });
  await ok(p, `mutation { insertNotificationMutesOne(object: {type: ritual}) { type } }`);
  const muted = await queue(p.id, 'ritual');
  assert.deepEqual(await claim(muted), []);
  assert.equal(await outcome(muted), 'dropped');
  assert.equal((await claim(await queue(p.id, 'card_ready'))).length, 1);
});

test('a quiet moment after a fight holds reminders but never a partner', async () => {
  const p = await person();
  await ok(p, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: ios}) { id } }`, { t: device() });
  await ok(p, `mutation { insertTemperatureChecksOne(object: {level: fight}) { id } }`);
  assert.deepEqual(await claim(await queue(p.id, 'daily_idea')), [], 'a reminder waits');
  assert.equal((await claim(await queue(p.id, 'partner_message'))).length, 1, 'the partner still reaches them');
  await sql(`update public.temperature_checks set created_at = now() - interval '25 hours' where author_id = '${p.id}'`);
  assert.equal((await claim(await queue(p.id, 'daily_idea'))).length, 1, 'the quiet moment is over');
});

test('a partner-initiated notification is not counted against the daily cap', async () => {
  const p = await person();
  await ok(p, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: ios}) { id } }`, { t: device() });
  await settings(p.id, `daily_max = 1`);
  const reminder = await queue(p.id, 'daily_idea');
  await claim(reminder);
  await complete(reminder);
  const fromPartner = await queue(p.id, 'card_received');
  assert.equal((await claim(fromPartner)).length, 1);
  await complete(fromPartner);
  assert.deepEqual(await claim(await queue(p.id, 'ritual')), [], 'the cap still counts reminders only');
});

test('a person with no device is settled without sending anything', async () => {
  const p = await person();
  const id = await queue(p.id, 'card_ready');
  assert.deepEqual(await claim(id), []);
  assert.equal(await outcome(id), 'no_device');
});

test('a token the push service keeps rejecting is removed after three failures', async () => {
  const p = await person();
  const bad = device();
  await ok(p, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: ios}) { id } }`, { t: bad });
  for (let i = 0; i < 2; i++) {
    const id = await queue(p.id, 'card_received');
    assert.deepEqual(await claim(id), [bad]);
    await complete(id, [bad]);
  }
  assert.deepEqual(await sql(`select failure_count from public.devices where token = '${bad}'`), [['2']]);
  const last = await queue(p.id, 'card_received');
  assert.deepEqual(await claim(last), [bad]);
  assert.deepEqual(await complete(last, [bad]), [bad], 'the third failure removes the device');
  assert.deepEqual(await sql(`select count(*) from public.devices where token = '${bad}'`), [['0']]);
});

test('a person cannot claim or complete a notification, and cannot read the queue', async () => {
  const p = await person();
  const id = await queue(p.id, 'card_ready');
  const deniedQuery = `mutation ($id: uuid!) { claimNotification(args: {notification_id: $id}) { token } }`;
  const { gql } = await import('./lib.ts');
  assert.ok((await gql(p, deniedQuery, { id })).errors?.length);
  const read = await gql(p, `{ pushNotifications { id } }`);
  assert.ok(read.errors?.length);
  const settle = await gql(p, `mutation ($id: uuid!) { completeNotification(args: {notification_id: $id}) { token } }`, { id });
  assert.ok(settle.errors?.length);
});

import { test } from 'node:test';
import { assert, couple, denied, ok, person, randomUUID, sql } from './lib.ts';

const token = () => randomUUID().replace(/-/g, '');

test('a device belongs to the person who registered it', async () => {
  const a = await person();
  const device = (await ok(a, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: ios, label: "iPhone"}) { id userId platform label } }`, { t: token() })).insertDevicesOne;
  assert.equal(device.userId, a.id);
  assert.deepEqual([device.platform, device.label], ['ios', 'iPhone']);
  assert.deepEqual((await ok(a, `{ devices { id } }`)).devices, [{ id: device.id }]);
  const stranger = await person();
  assert.deepEqual((await ok(stranger, `{ devices { id } }`)).devices, []);
});

test('a token cannot be taken over by another person', async () => {
  const a = await person();
  const b = await person();
  const shared = token();
  await ok(a, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: ios}) { id } }`, { t: shared });
  await denied(b, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: android}) { id } }`, { t: shared });
  const rows = await sql(`select user_id from public.devices where token = '${shared}'`);
  assert.deepEqual(rows, [[a.id]]);
});

test('only the owner updates or removes a device', async () => {
  const a = await person();
  const b = await person();
  const device = (await ok(a, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: ios}) { id } }`, { t: token() })).insertDevicesOne;
  assert.equal((await ok(b, `mutation ($id: uuid!) { updateDevicesByPk(pk_columns: {id: $id}, _set: {label: "x"}) { id } }`, { id: device.id })).updateDevicesByPk, null);
  assert.equal((await ok(b, `mutation ($id: uuid!) { deleteDevicesByPk(id: $id) { id } }`, { id: device.id })).deleteDevicesByPk, null);
  await denied(a, `mutation ($id: uuid!) { updateDevicesByPk(pk_columns: {id: $id}, _set: {userId: "00000000-0000-0000-0000-000000000000"}) { id } }`, { id: device.id });
  const updated = (await ok(a, `mutation ($id: uuid!) { updateDevicesByPk(pk_columns: {id: $id}, _set: {label: "iPad"}) { label } }`, { id: device.id })).updateDevicesByPk;
  assert.equal(updated.label, 'iPad');
  await ok(a, `mutation ($id: uuid!) { deleteDevicesByPk(id: $id) { id } }`, { id: device.id });
  assert.deepEqual((await ok(a, `{ devices { id } }`)).devices, []);
});

test('registering the same device again refreshes it and clears its failures', async () => {
  const a = await person();
  const value = token();
  const device = (await ok(a, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: ios}) { id lastSeenAt } }`, { t: value })).insertDevicesOne;
  await sql(`update public.devices set failure_count = 2, last_seen_at = now() - interval '2 days' where id = '${device.id}'`);
  const again = (await ok(a, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: ios},
    on_conflict: {constraint: devices_token_key, update_columns: [platform]}) { id } }`, { t: value })).insertDevicesOne;
  assert.equal(again.id, device.id);
  const rows = await sql(`select failure_count, last_seen_at > now() - interval '1 minute' from public.devices where id = '${device.id}'`);
  assert.deepEqual(rows, [['0', 't']]);
});

test('a device token must be plausible and the platform is a closed set', async () => {
  const a = await person();
  await denied(a, `mutation { insertDevicesOne(object: {token: "short", platform: ios}) { id } }`);
  await denied(a, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: desktop}) { id } }`, { t: token() });
});

test('a partner never sees the other person devices', async () => {
  const { a, b } = await couple();
  await ok(a, `mutation ($t: String!) { insertDevicesOne(object: {token: $t, platform: ios}) { id } }`, { t: token() });
  assert.deepEqual((await ok(b, `{ devices { id token } }`)).devices, []);
});

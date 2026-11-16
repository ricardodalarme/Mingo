import { test } from 'node:test';
import { assert, ok, signUp, sql } from '../lib.ts';

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

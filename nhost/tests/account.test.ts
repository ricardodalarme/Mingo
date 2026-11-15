import { test } from 'node:test';
import { assert, couple, denied, ok, person, randomUUID, signUp, sql, upload, waitFor } from './lib.ts';

test('asking to delete the account ends the pairing at once and schedules the purge in 14 days', async () => {
  const { a, b } = await couple();
  await ok(a, `mutation { insertSlipsOne(object: {body: "um bom dia"}) { id } }`);
  const request = (await ok(a, `mutation { insertDeletionRequestsOne(object: {}) { userId requestedAt purgeAfter } }`)).insertDeletionRequestsOne;
  assert.equal(request.userId, a.id);
  const days = await sql(`select round(extract(epoch from (purge_after - requested_at)) / 86400) from public.deletion_requests where user_id = '${a.id}'`);
  assert.deepEqual(days, [['14']]);
  assert.deepEqual((await ok(b, `{ coupleMembers { userId } couples { id } }`)), { coupleMembers: [], couples: [] });
  assert.equal((await ok(a, `{ coupleMembers { userId } }`)).coupleMembers.length, 0);
  assert.equal((await ok(a, `{ slips { id } }`)).slips.length, 1, 'private data is untouched until the purge');
  assert.deepEqual(await sql(`select type, ref_id is not null from private.notifications where user_id = '${b.id}' and type = 'unpaired'`), [['unpaired', 't']]);
  assert.deepEqual((await ok(a, `{ today { deletionPending } }`)).today[0].deletionPending, true);
});

test('nobody else reads or removes a deletion request', async () => {
  const { a, b } = await couple();
  await ok(a, `mutation { insertDeletionRequestsOne(object: {}) { userId } }`);
  assert.deepEqual((await ok(b, `{ deletionRequests { userId } }`)).deletionRequests, []);
  assert.equal((await ok(b, `mutation { deleteDeletionRequestsByPk(userId: "${a.id}") { userId } }`)).deleteDeletionRequestsByPk, null);
  const own = (await ok(b, `mutation { insertDeletionRequestsOne(object: {}) { userId } }`)).insertDeletionRequestsOne;
  assert.equal(own.userId, b.id, 'a request is always for the caller');
  assert.deepEqual((await sql(`select user_id from public.deletion_requests where user_id in ('${a.id}', '${b.id}') order by user_id`)).map((r) => r[0]), [a.id, b.id].sort());
});

test('the person reads the support requests they sent, and nobody else does', async () => {
  const { a, b } = await couple();
  const stranger = await person();
  const message = `ajuda ${randomUUID()}`;
  await ok(a, `mutation ($m: String!) { insertSupportRequests(objects: [{topic: bug, message: $m}]) { affected_rows } }`, { m: message });
  const mine = await ok(a, `{ supportRequests { topic message } }`);
  assert.deepEqual(mine.supportRequests, [{ topic: 'bug', message }]);
  assert.deepEqual((await ok(b, `{ supportRequests { id } }`)).supportRequests, []);
  assert.deepEqual((await ok(stranger, `{ supportRequests { id } }`)).supportRequests, []);
  const own = `ajuda ${randomUUID()}`;
  await ok(b, `mutation ($m: String!) { insertSupportRequests(objects: [{topic: other, message: $m}]) { affected_rows } }`, { m: own });
  assert.deepEqual((await ok(b, `{ supportRequests { topic message } }`)).supportRequests, [{ topic: 'other', message: own }]);
  assert.deepEqual((await ok(a, `{ supportRequests { message } }`)).supportRequests, [{ message }]);
});

test('cancelling keeps the account and can be undone by asking again', async () => {
  const p = await person();
  await ok(p, `mutation { insertDeletionRequestsOne(object: {}) { userId } }`);
  await ok(p, `mutation { deleteDeletionRequestsByPk(userId: "${p.id}") { userId } }`);
  assert.deepEqual((await ok(p, `{ today { deletionPending } }`)).today[0].deletionPending, false);
  await ok(p, `mutation { insertDeletionRequestsOne(object: {}) { userId } }`);
  assert.deepEqual((await ok(p, `{ today { deletionPending } }`)).today[0].deletionPending, true);
});

test('the purge erases the person and everything that hangs from the account', async () => {
  const session = await signUp('Apagar');
  const { a: partner } = await couple();
  const file = await upload(session.token, 'avatars', [7, 7, 7]);
  await ok(session, `mutation ($id: uuid!) { updateProfilesByPk(pk_columns: {id: "${session.id}"}, _set: {avatarFileId: $id}) { id } }`, { id: file.id });
  await ok(session, `mutation { insertConsentsOne(object: {kind: terms, granted: true, version: "1"}) { id } }`);
  const message = `preciso de ajuda ${randomUUID()}`;
  const sent = await ok(session, `mutation ($message: String!) { insertSupportRequests(objects: [{topic: other, message: $message}]) { affected_rows } }`, { message });
  assert.equal(sent.insertSupportRequests.affected_rows, 1);
  await ok(session, `mutation { insertDeletionRequestsOne(object: {}) { userId } }`);
  await sql(`update public.deletion_requests set purge_after = now() - interval '1 minute' where user_id = '${session.id}'`);
  await ok('admin', `mutation { runJob(args: {job: "purge_accounts"}) { affected } }`);
  for (const table of ['profiles', 'user_settings', 'notification_settings', 'consents', 'deletion_requests']) {
    assert.deepEqual(await sql(`select count(*) from public.${table} where ${table === 'profiles' ? 'id' : 'user_id'} = '${session.id}'`), [['0']], table);
  }
  assert.deepEqual(await sql(`select count(*) from auth.users where id = '${session.id}'`), [['0']]);
  assert.deepEqual(await sql(`select count(*) from public.support_requests where message = '${message}' and user_id is null`), [['1']],
    'support keeps the message without the person');
  await waitFor(async () => (await sql(`select count(*) from storage.files where uploaded_by_user_id = '${session.id}'`))[0][0] === '0');
  void partner;
});

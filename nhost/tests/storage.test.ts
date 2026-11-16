import { test } from 'node:test';
import { assert, couple, denied, download, gql, ok, okToken, randomUUID, signUp, sql, upload, waitFor } from './lib.ts';

test('the owner reads a file through Storage, a stranger gets the same answer as a missing file', async () => {
  const owner = await signUp();
  const file = await upload(owner.token, 'avatars');
  assert.equal(await download(owner.token, file.id), 200);
  const stranger = await signUp();
  assert.equal(await download(stranger.token, file.id), 404);
  assert.equal(await download(stranger.token, '00000000-0000-0000-0000-000000000000'), 404);
});

test('a file a profile points to is readable by the partner and lost by an ex-partner', async () => {
  const session = await signUp('Ana');
  const partner = await signUp('Bruno');
  const stranger = await signUp('Carla');
  const file = await upload(session.token, 'avatars');
  await ok(session, `mutation ($id: uuid!) { updateProfilesByPk(pk_columns: {id: "${session.id}"}, _set: {avatarKind: photo, avatarFileId: $id}) { id } }`, { id: file.id });
  assert.equal(await download(partner.token, file.id), 404, 'not a partner yet');
  const { insertInvitesOne } = await ok(session, `mutation { insertInvitesOne(object: {}) { code } }`);
  await ok(partner, `mutation ($c: String!) { acceptInvite(args: {code: $c}) { id } }`, { c: insertInvitesOne.code });
  assert.equal(await download(partner.token, file.id), 200);
  assert.equal(await download(stranger.token, file.id), 404);
  await ok(session, `mutation { unpair { id } }`);
  assert.equal(await download(partner.token, file.id), 404, 'the ex-partner loses the file at once');
});

test('a partner reads the media in a message and a stranger does not', async () => {
  const session = await signUp('Ana');
  const partner = await signUp('Bruno');
  const stranger = await signUp('Carla');
  const { insertInvitesOne } = await ok(session, `mutation { insertInvitesOne(object: {}) { code } }`);
  await ok(partner, `mutation ($c: String!) { acceptInvite(args: {code: $c}) { id } }`, { c: insertInvitesOne.code });
  const file = await upload(session.token, 'messages', [8, 8, 8]);
  await ok(session, `mutation ($id: uuid!) { insertPartnerMessagesOne(object: {kind: voice, mediaFileId: $id}) { id } }`, { id: file.id });
  assert.equal(await download(session.token, file.id), 200);
  assert.equal(await download(partner.token, file.id), 200);
  assert.equal(await download(stranger.token, file.id), 404);
});

test('a file column cannot point to a file someone else uploaded', async () => {
  const { a } = await couple();
  const ownerFile = await upload((await signUp()).token, 'avatars');
  await denied(a, `mutation ($id: uuid!) { updateProfilesByPk(pk_columns: {id: "${a.id}"}, _set: {avatarKind: photo, avatarFileId: $id}) { id } }`, { id: ownerFile.id });
  await denied(a, `mutation ($id: uuid!) { insertMemoriesOne(object: {title: "x", happenedOn: "2026-01-01", photoFileId: $id}) { id } }`, { id: ownerFile.id });
});

test('a person can only insert files into the app buckets, always as themselves', async () => {
  const session = await signUp();
  const inserted = await okToken(session.token, `mutation ($id: uuid!) { insertFile(object: {id: $id, bucketId: "avatars", name: "a", size: 1, mimeType: "image/png"}) { id uploadedByUserId } }`, {
    id: randomUUID(),
  });
  assert.equal(inserted.insertFile.uploadedByUserId, session.id);
  await denied(session, `mutation { insertFile(object: {bucketId: "other", name: "a", size: 1}) { id } }`);
});

test('deleting a row that owns a file removes the file from Storage', async () => {
  const session = await signUp();
  const file = await upload(session.token, 'memories', [4, 5, 6, 7]);
  const memory = (await okToken(session.token, `mutation ($id: uuid!) { insertMemoriesOne(object: {title: "Praia", happenedOn: "2026-01-01", photoFileId: $id}) { id photoFileId } }`, { id: file.id })).insertMemoriesOne;
  assert.equal(memory.photoFileId, file.id);
  assert.equal(await download(session.token, file.id), 200);
  await okToken(session.token, `mutation ($id: uuid!) { deleteMemoriesByPk(id: $id) { id } }`, { id: memory.id });
  await waitFor(async () => (await download(session.token, file.id)) === 404);
  const queued = await sql(`select count(*) from private.file_deletions where file_id = '${file.id}'`);
  assert.deepEqual(queued, [['0']], 'the queue row is removed once Storage confirms');
});

test('the app reads only the files it is allowed to see', async () => {
  const { b } = await couple();
  const session = await signUp();
  const file = await upload(session.token, 'slips');
  assert.deepEqual((await ok(session, `{ files { id } }`)).files, [{ id: file.id }]);
  assert.deepEqual((await ok(b, `{ files { id } }`)).files, []);
  assert.ok((await gql('public', `{ files { id } }`)).errors?.length, 'the anonymous role reads no files');
});

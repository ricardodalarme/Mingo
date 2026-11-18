import assert from 'node:assert/strict';
import { afterEach, beforeEach, mock, test } from 'node:test';
import { BACKEND_ENV, gql, json, request, response, restoreEnv, setEnv, stubFetch } from '../../_lib/_testing.ts';
import deleteFile from '../delete-file.ts';

const FILE = '7c2d0b6f-8a0e-4a2e-9a0f-5f6b7c8d9e0f';
const trigger = { 'nhost-webhook-secret': BACKEND_ENV.NHOST_WEBHOOK_SECRET };
const queued = { event: { data: { new: { file_id: FILE } } } };

beforeEach(() => setEnv(BACKEND_ENV));
afterEach(() => {
  restoreEnv();
  mock.restoreAll();
});

test('a body without a file id is an invalid event', async () => {
  const res = response();
  await deleteFile(request({ headers: trigger, body: { event: { data: { new: {} } } } }), res);
  assert.equal(res.statusCode, 400);
  assert.deepEqual(res.payload, { error: 'INVALID_EVENT' });
});

test('the file is removed from Storage and from the queue', async () => {
  const calls = stubFetch((call) => (call.url.includes('storage') ? json({}) : gql({ deleteFileDeletionsByPk: {} })));
  const res = response();
  await deleteFile(request({ headers: trigger, body: queued }), res);
  assert.equal(res.statusCode, 200);
  assert.deepEqual(res.payload, { removed: true });
  assert.equal(calls[0]?.url, `http://storage.test/v1/files/${FILE}`);
  assert.equal(calls[0]?.init.method, 'DELETE');
  assert.equal(calls.length, 2);
});

test('a file that is already gone counts as removed', async () => {
  stubFetch((call) => (call.url.includes('storage') ? json({}, 404) : gql({})));
  const res = response();
  await deleteFile(request({ headers: trigger, body: queued }), res);
  assert.equal(res.statusCode, 200);
});

test('a Storage failure answers 500 so the trigger retries and keeps the file queued', async () => {
  const calls = stubFetch(() => json({}, 503));
  const res = response();
  await deleteFile(request({ headers: trigger, body: queued }), res);
  assert.equal(res.statusCode, 500);
  assert.deepEqual(res.payload, { error: 'STORAGE_UNAVAILABLE' });
  assert.equal(calls.length, 1, 'the queue row stays');
});

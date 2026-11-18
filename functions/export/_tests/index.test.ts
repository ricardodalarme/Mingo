import assert from 'node:assert/strict';
import { afterEach, beforeEach, mock, test } from 'node:test';
import {
  BACKEND_ENV,
  type FetchCall,
  gql,
  json,
  queryOf,
  request,
  response,
  restoreEnv,
  setEnv,
  stubFetch,
  variablesOf,
} from '../../_lib/_testing.ts';
import exportData from '../index.ts';

const USER = '0b7b1f1e-6f0a-4f4e-8a34-2f6a1c9d3b21';
const FILE = 'f1e2d3c4-0000-4000-8000-000000000009';
const signedIn = { authorization: 'Bearer token' };

beforeEach(() => setEnv(BACKEND_ENV));
afterEach(() => {
  restoreEnv();
  mock.restoreAll();
});

type Routes = { settings?: () => Response; exported?: unknown[]; upload?: () => Response; presign?: () => Response };

/** A stand-in for the database and Storage. */
function backend({
  settings = () => gql({ userSettings: [{ userId: USER }] }),
  exported = [{ data: { slips: [] } }],
  upload = () => json({ processedFiles: [{ id: FILE }] }),
  presign = () => json({ url: 'https://files.test/signed', expiration: 300 }),
}: Routes = {}) {
  return stubFetch((call: FetchCall) => {
    if (call.url.includes('presignedurl')) return presign();
    if (call.url.endsWith('/files')) return upload();
    const query = queryOf(call);
    if (query.includes('userSettings')) return settings();
    if (query.includes('exportUserData')) return gql({ exportUserData: exported });
    return gql({});
  });
}

const run = async () => {
  const res = response();
  await exportData(request({ headers: signedIn }), res);
  return res;
};

const sent = (calls: FetchCall[], text: string) =>
  calls.filter((call) => call.url.includes('graphql') && queryOf(call).includes(text));

test('a request without a token is refused', async () => {
  const res = response();
  await exportData(request(), res);
  assert.equal(res.statusCode, 401);
});

test('a token the engine does not accept is refused', async () => {
  backend({ settings: () => json({ errors: [{ message: 'invalid token' }] }) });
  assert.equal((await run()).statusCode, 401);
});

test('a person with no settings row is refused', async () => {
  backend({ settings: () => gql({ userSettings: [] }) });
  assert.equal((await run()).statusCode, 401);
});

test('the second export of the day is refused', async () => {
  backend({ exported: [] });
  const res = await run();
  assert.equal(res.statusCode, 429);
  assert.deepEqual(res.payload, { error: 'EXPORT_LIMIT' });
});

test('the document is stored for the person and handed back as a short link', async () => {
  const calls = backend();
  const before = Date.now();
  const res = await run();
  const { url, expiresAt } = res.payload as { url: string; expiresAt: string };
  assert.equal(res.statusCode, 200);
  assert.equal(url, 'https://files.test/signed');
  assert.ok(Date.parse(expiresAt) - before >= 299_000 && Date.parse(expiresAt) - before < 302_000);
  assert.deepEqual(variablesOf(sent(calls, 'updateFile')[0]), { id: FILE, user: USER });
  const presign = calls.find((call) => call.url.includes('presignedurl'));
  assert.equal(new Headers(presign?.init.headers).get('authorization'), 'Bearer token');
});

test('the export is built from the caller id the engine returned, never from the request', async () => {
  const calls = backend();
  await exportData(request({ headers: signedIn, body: { userId: 'someone-else' } }), response());
  assert.deepEqual(variablesOf(sent(calls, 'exportUserData')[0]), { user: USER });
});

test('a failed upload gives back the days export and answers 500', async () => {
  mock.method(console, 'error', () => undefined);
  const calls = backend({ upload: () => json({}, 500) });
  const res = await run();
  assert.equal(res.statusCode, 500);
  assert.deepEqual(res.payload, { error: 'EXPORT_FAILED' });
  assert.equal(sent(calls, 'deleteExportRequests').length, 1);
});

test('a failure after the upload also removes the stored file', async () => {
  mock.method(console, 'error', () => undefined);
  const calls = backend({ presign: () => json({}, 500) });
  const res = await run();
  assert.equal(res.statusCode, 500);
  assert.deepEqual(variablesOf(sent(calls, 'deleteFile(')[0]), { id: FILE });
});

import assert from 'node:assert/strict';
import { generateKeyPairSync } from 'node:crypto';
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
import { tokenCache } from '../_fcm.ts';
import push from '../push.ts';

const { privateKey } = generateKeyPairSync('rsa', {
  modulusLength: 2048,
  publicKeyEncoding: { type: 'spki', format: 'pem' },
  privateKeyEncoding: { type: 'pkcs8', format: 'pem' },
});
const SERVICE_ACCOUNT = JSON.stringify({ client_email: 'a@b.test', private_key: privateKey, project_id: 'mingo' });

const NOTIFICATION = 'e1b2c3d4-0000-4000-8000-000000000001';
const event = { event: { data: { new: { id: NOTIFICATION, type: 'card_received', ref_id: null } } } };
const trigger = { 'nhost-webhook-secret': BACKEND_ENV.NHOST_WEBHOOK_SECRET };

beforeEach(() => {
  setEnv({ ...BACKEND_ENV, FCM_SERVICE_ACCOUNT: SERVICE_ACCOUNT });
  tokenCache.clear();
});
afterEach(() => {
  restoreEnv();
  mock.restoreAll();
});

type Routes = { devices?: string[]; fcm?: (token: string) => Response; complete?: () => Response };

/** A stand-in for the database, Google's token endpoint and FCM. */
function backend({ devices = ['t1'], fcm = () => json({}), complete = () => gql({}) }: Routes = {}) {
  return stubFetch((call: FetchCall) => {
    if (call.url.includes('oauth2')) return json({ access_token: 'ya29', expires_in: 3600 });
    if (call.url.includes('fcm.googleapis')) return fcm(JSON.parse(String(call.init.body)).message.token);
    return queryOf(call).includes('claimNotification')
      ? gql({ claimNotification: devices.map((token) => ({ token })) })
      : complete();
  });
}

const run = async () => {
  const res = response();
  await push(request({ headers: trigger, body: event }), res);
  return res;
};

const completions = (calls: FetchCall[]) =>
  calls.filter((call) => call.url.includes('graphql') && queryOf(call).includes('completeNotification'));

test('a body without a notification is an invalid event', async () => {
  const res = response();
  await push(request({ headers: trigger, body: {} }), res);
  assert.equal(res.statusCode, 400);
});

test('without a service account nothing is sent and the trigger is satisfied', async () => {
  restoreEnv();
  setEnv(BACKEND_ENV);
  const calls = backend();
  const res = await run();
  assert.equal(res.statusCode, 200);
  assert.equal(calls.length, 0);
});

test('a service account that cannot be read answers 500 and is logged', async () => {
  setEnv({ FCM_SERVICE_ACCOUNT: '{"client_email":"x"}' });
  const logged = mock.method(console, 'error', () => undefined);
  const res = await run();
  assert.equal(res.statusCode, 500);
  assert.deepEqual(res.payload, { error: 'FCM_SERVICE_ACCOUNT_INVALID' });
  assert.equal(logged.mock.callCount(), 1);
});

test('a notification with no device to reach is settled by the database and sends nothing', async () => {
  const calls = backend({ devices: [] });
  const res = await run();
  assert.deepEqual(res.payload, { sent: 0 });
  assert.equal(calls.filter((call) => call.url.includes('fcm.googleapis')).length, 0);
});

test('every device gets the push and the delivery is recorded', async () => {
  const calls = backend({ devices: ['t1', 't2', 't3'] });
  const res = await run();
  assert.deepEqual(res.payload, { sent: 3 });
  assert.deepEqual(variablesOf(completions(calls)[0]), { id: NOTIFICATION, dead: [] });
});

test('a token that FCM rejects is reported dead and the others still count', async () => {
  const calls = backend({ devices: ['t1', 'gone', 't3'], fcm: (token) => json({}, token === 'gone' ? 404 : 200) });
  const res = await run();
  assert.deepEqual(res.payload, { sent: 2 });
  assert.deepEqual(variablesOf(completions(calls)[0]), { id: NOTIFICATION, dead: ['gone'] });
});

test('when FCM is down for every device the trigger is asked to retry and nothing is recorded', async () => {
  mock.method(console, 'warn', () => undefined);
  const calls = backend({ devices: ['t1', 't2'], fcm: () => json({}, 503) });
  const res = await run();
  assert.equal(res.statusCode, 500);
  assert.deepEqual(res.payload, { error: 'FCM_UNAVAILABLE' });
  assert.equal(completions(calls).length, 0);
});

test('a failed Google sign-in answers 500 so the trigger retries', async () => {
  mock.method(console, 'error', () => undefined);
  stubFetch((call) => {
    if (call.url.includes('oauth2')) return json({}, 401);
    return gql({ claimNotification: [{ token: 't1' }] });
  });
  const res = await run();
  assert.deepEqual(res.payload, { error: 'FCM_AUTH_FAILED' });
});

test('a completion that fails once is retried before the trigger would send the push again', async () => {
  let attempts = 0;
  const calls = backend({ complete: () => (++attempts < 2 ? json({ errors: [{ message: 'busy' }] }) : gql({})) });
  const res = await run();
  assert.equal(res.statusCode, 200);
  assert.equal(completions(calls).length, 2);
});

test('the access token is reused across notifications', async () => {
  const calls = backend();
  await run();
  await run();
  assert.equal(calls.filter((call) => call.url.includes('oauth2')).length, 1);
});

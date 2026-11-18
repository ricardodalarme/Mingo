import assert from 'node:assert/strict';
import { generateKeyPairSync, verify } from 'node:crypto';
import { test } from 'node:test';
import { json } from '../../_lib/_testing.ts';
import { type Account, accessToken, assertion, loadAccount, type Push, send, type TokenCache } from '../_fcm.ts';

const { privateKey } = generateKeyPairSync('rsa', {
  modulusLength: 2048,
  publicKeyEncoding: { type: 'spki', format: 'pem' },
  privateKeyEncoding: { type: 'pkcs8', format: 'pem' },
});
const account: Account = {
  client_email: 'sender@mingo.iam.gserviceaccount.com',
  private_key: privateKey,
  project_id: 'mingo',
};
const push: Push = {
  id: '7c2d0b6f-8a0e-4a2e-9a0f-5f6b7c8d9e0f',
  type: 'card_received',
  refId: '2a1b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d',
};

const respondWith =
  (body: unknown, status = 200): typeof fetch =>
  async () =>
    json(body, status);

const decoded = (part: string | undefined) => JSON.parse(Buffer.from(part ?? '', 'base64url').toString());

test('loadAccount reads a complete service account', () => {
  assert.deepEqual(loadAccount(JSON.stringify(account)), { state: 'ready', account });
});

test('loadAccount is unset when missing and invalid when unusable', () => {
  assert.deepEqual(loadAccount(undefined), { state: 'unset' });
  assert.deepEqual(loadAccount(''), { state: 'unset' });
  assert.deepEqual(loadAccount('not json'), { state: 'invalid' });
  assert.deepEqual(loadAccount(JSON.stringify({ client_email: 'x' })), { state: 'invalid' });
});

test('the assertion is a signed RS256 JWT for the messaging scope', () => {
  const [head, claims, signature] = assertion(account, 1794784036).split('.') as [string, string, string];
  assert.deepEqual(decoded(head), { alg: 'RS256', typ: 'JWT' });
  assert.deepEqual(decoded(claims), {
    iss: account.client_email,
    scope: 'https://www.googleapis.com/auth/firebase.messaging',
    aud: 'https://oauth2.googleapis.com/token',
    iat: 1794784036,
    exp: 1794787636,
  });
  const ok = verify(
    'RSA-SHA256',
    Buffer.from(`${head}.${claims}`),
    account.private_key,
    Buffer.from(signature, 'base64url'),
  );
  assert.equal(ok, true);
});

test('the assertion carries no project id outside the signed claims', () => {
  const [, claims] = assertion(account).split('.');
  assert.equal(decoded(claims).project_id, undefined);
});

test('accessToken trades the assertion for a bearer token', async () => {
  let form: URLSearchParams | undefined;
  const fetcher: typeof fetch = async (_url, init) => {
    form = new URLSearchParams(String(init?.body));
    return json({ access_token: 'ya29.token' });
  };
  assert.equal(await accessToken(account, fetcher, new Map()), 'ya29.token');
  assert.equal(form?.get('grant_type'), 'urn:ietf:params:oauth:grant-type:jwt-bearer');
});

test('accessToken fails when the token endpoint refuses or returns nothing', async () => {
  await assert.rejects(accessToken(account, respondWith({}, 403), new Map()));
  await assert.rejects(accessToken(account, respondWith({}), new Map()));
});

test('a token that is still valid is reused instead of requested again', async () => {
  const cache: TokenCache = new Map();
  let requests = 0;
  const fetcher: typeof fetch = async () => {
    requests++;
    return json({ access_token: `token-${requests}`, expires_in: 3600 });
  };
  let now = 1_000_000;
  const clock = () => now;
  assert.equal(await accessToken(account, fetcher, cache, clock), 'token-1');
  now += 30 * 60 * 1000;
  assert.equal(await accessToken(account, fetcher, cache, clock), 'token-1');
  assert.equal(requests, 1);
});

test('a token close to its expiry is replaced', async () => {
  const cache: TokenCache = new Map();
  let requests = 0;
  const fetcher: typeof fetch = async () => json({ access_token: `token-${++requests}`, expires_in: 3600 });
  let now = 1_000_000;
  const clock = () => now;
  await accessToken(account, fetcher, cache, clock);
  now += 56 * 60 * 1000;
  assert.equal(await accessToken(account, fetcher, cache, clock), 'token-2');
});

test('a data-only message is sent to the device', async () => {
  let sent: { url: string; body: { message: Record<string, unknown> }; auth: string | null } | undefined;
  const fetcher: typeof fetch = async (url, init) => {
    sent = {
      url: String(url),
      body: JSON.parse(String(init?.body)),
      auth: new Headers(init?.headers).get('authorization'),
    };
    return json({ name: 'projects/mingo/messages/1' });
  };
  assert.equal(await send(account, 'ya29.token', 'device-token', push, fetcher), 'sent');
  assert.equal(sent?.url, 'https://fcm.googleapis.com/v1/projects/mingo/messages:send');
  assert.equal(sent?.auth, 'Bearer ya29.token');
  assert.equal(sent?.body.message.token, 'device-token');
  assert.deepEqual(sent?.body.message.data, { type: 'card_received', ref: push.refId, id: push.id });
  assert.equal(sent?.body.message.notification, undefined, 'the app renders the text, so no visible payload is sent');
});

test('a rejected token is dead, a server or network failure is transient', async () => {
  const status = (code: number) => respondWith({}, code);
  assert.equal(await send(account, 't', 'd', push, status(400)), 'dead');
  assert.equal(await send(account, 't', 'd', push, status(404)), 'dead');
  assert.equal(await send(account, 't', 'd', push, status(500)), 'transient');
  assert.equal(await send(account, 't', 'd', push, status(429)), 'transient');
  const offline: typeof fetch = async () => {
    throw new Error('offline');
  };
  assert.equal(await send(account, 't', 'd', push, offline), 'transient');
});

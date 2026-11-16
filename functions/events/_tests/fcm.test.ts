import { test } from 'node:test';
import assert from 'node:assert/strict';
import { generateKeyPairSync, verify } from 'node:crypto';
import { accessToken, assertion, loadAccount, send, type Account, type Push } from '../_fcm.ts';

const { privateKey } = generateKeyPairSync('rsa', {
  modulusLength: 2048,
  publicKeyEncoding: { type: 'spki', format: 'pem' },
  privateKeyEncoding: { type: 'pkcs8', format: 'pem' },
});
const account: Account = { client_email: 'sender@mingo.iam.gserviceaccount.com', private_key: privateKey, project_id: 'mingo' };
const push: Push = { id: '7c2d0b6f-8a0e-4a2e-9a0f-5f6b7c8d9e0f', type: 'card_received', refId: '2a1b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d' };

const json = (body: unknown, status = 200) =>
  new Response(JSON.stringify(body), { status, headers: { 'content-type': 'application/json' } });

test('loadAccount reads a complete service account', () => {
  assert.deepEqual(loadAccount(JSON.stringify(account)), account);
});

test('loadAccount is null when unset and invalid when unusable', () => {
  assert.equal(loadAccount(undefined), null);
  assert.equal(loadAccount('not json'), 'invalid');
  assert.equal(loadAccount(JSON.stringify({ client_email: 'x' })), 'invalid');
});

test('the assertion is a signed RS256 JWT for the messaging scope', () => {
  const [head, claims, signature] = assertion(account, 1794784036).split('.');
  const decoded = (part: string) => JSON.parse(Buffer.from(part, 'base64url').toString());
  assert.deepEqual(decoded(head), { alg: 'RS256', typ: 'JWT' });
  assert.deepEqual(decoded(claims), {
    iss: account.client_email,
    scope: 'https://www.googleapis.com/auth/firebase.messaging',
    aud: 'https://oauth2.googleapis.com/token',
    iat: 1794784036,
    exp: 1794787636,
  });
  const ok = verify('RSA-SHA256', Buffer.from(`${head}.${claims}`), account.private_key, Buffer.from(signature, 'base64url'));
  assert.equal(ok, true);
});

test('the assertion carries no project id outside the signed claims', () => {
  const [, claims] = assertion(account).split('.');
  assert.equal(JSON.parse(Buffer.from(claims, 'base64url').toString()).project_id, undefined);
});

test('accessToken trades the assertion for a bearer token', async () => {
  let form: URLSearchParams | undefined;
  const fetcher = (async (_url: any, init: any) => {
    form = new URLSearchParams(init.body);
    return json({ access_token: 'ya29.token' });
  }) as typeof fetch;
  assert.equal(await accessToken(account, fetcher), 'ya29.token');
  assert.equal(form?.get('grant_type'), 'urn:ietf:params:oauth:grant-type:jwt-bearer');
});

test('accessToken fails when the token endpoint refuses or returns nothing', async () => {
  await assert.rejects(accessToken(account, (async () => json({}, 403)) as typeof fetch));
  await assert.rejects(accessToken(account, (async () => json({})) as typeof fetch));
});

test('a data-only message is sent to the device', async () => {
  let sent: any;
  const fetcher = (async (url: any, init: any) => {
    sent = { url, body: JSON.parse(init.body), auth: init.headers.authorization };
    return json({ name: 'projects/mingo/messages/1' });
  }) as typeof fetch;
  assert.equal(await send(account, 'ya29.token', 'device-token', push, fetcher), 'sent');
  assert.equal(sent.url, 'https://fcm.googleapis.com/v1/projects/mingo/messages:send');
  assert.equal(sent.auth, 'Bearer ya29.token');
  assert.equal(sent.body.message.token, 'device-token');
  assert.deepEqual(sent.body.message.data, { type: 'card_received', ref: push.refId, id: push.id });
  assert.equal(sent.body.message.notification, undefined, 'the app renders the text, so no visible payload is sent');
});

test('a rejected token is dead, a server or network failure is transient', async () => {
  const status = (code: number) => (async () => json({}, code)) as typeof fetch;
  assert.equal(await send(account, 't', 'd', push, status(400)), 'dead');
  assert.equal(await send(account, 't', 'd', push, status(404)), 'dead');
  assert.equal(await send(account, 't', 'd', push, status(500)), 'transient');
  assert.equal(await send(account, 't', 'd', push, status(429)), 'transient');
  assert.equal(await send(account, 't', 'd', push, (async () => { throw new Error('offline'); }) as typeof fetch), 'transient');
});

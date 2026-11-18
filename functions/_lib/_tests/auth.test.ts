import assert from 'node:assert/strict';
import { afterEach, test } from 'node:test';
import { request, restoreEnv, setEnv } from '../_testing.ts';
import { hasBearer, isTrigger, matchesSecret, safeEqual } from '../auth.ts';

afterEach(restoreEnv);

test('safeEqual compares equal and unequal strings', () => {
  assert.equal(safeEqual('abc', 'abc'), true);
  assert.equal(safeEqual('abc', 'abd'), false);
  assert.equal(safeEqual('abc', 'abc '), false);
  assert.equal(safeEqual('', ''), true);
});

test('safeEqual accepts values of different lengths without throwing', () => {
  assert.equal(safeEqual('a', 'a much longer value'), false);
});

test('a request with the trigger secret is a trigger', () => {
  setEnv({ NHOST_WEBHOOK_SECRET: 's3cret' });
  assert.equal(isTrigger(request({ headers: { 'nhost-webhook-secret': 's3cret' } })), true);
});

test('a request with a wrong or no secret is not a trigger', () => {
  setEnv({ NHOST_WEBHOOK_SECRET: 's3cret' });
  assert.equal(isTrigger(request({ headers: { 'nhost-webhook-secret': 'other' } })), false);
  assert.equal(isTrigger(request()), false);
});

test('nothing is a trigger while the secret is unset', () => {
  assert.equal(isTrigger(request({ headers: { 'nhost-webhook-secret': '' } })), false);
});

test('a shared secret matches only the header that carries it', () => {
  setEnv({ REVENUECAT_WEBHOOK_AUTH: 'rc-secret' });
  const matches = (headers: Record<string, string>) =>
    matchesSecret(request({ headers }), 'authorization', 'REVENUECAT_WEBHOOK_AUTH');
  assert.equal(matches({ authorization: 'rc-secret' }), true);
  assert.equal(matches({ authorization: 'wrong' }), false);
  assert.equal(matches({}), false);
});

test('a bearer token is a scheme followed by a value', () => {
  assert.equal(hasBearer(request({ headers: { authorization: 'Bearer abc.def' } })), true);
  assert.equal(hasBearer(request({ headers: { authorization: 'bearer abc' } })), true);
  assert.equal(hasBearer(request({ headers: { authorization: 'Bearer ' } })), false);
  assert.equal(hasBearer(request({ headers: { authorization: 'Basic abc' } })), false);
  assert.equal(hasBearer(request()), false);
});

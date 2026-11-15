import { afterEach, test } from 'node:test';
import assert from 'node:assert/strict';
import { isTrigger, safeEqual, type Req } from '../_lib/backend.ts';

const request = (headers: Record<string, string>): Req =>
  ({ method: 'POST', headers, body: {}, on: () => {} }) as unknown as Req;

afterEach(() => {
  delete process.env.NHOST_WEBHOOK_SECRET;
});

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
  process.env.NHOST_WEBHOOK_SECRET = 's3cret';
  assert.equal(isTrigger(request({ 'nhost-webhook-secret': 's3cret' })), true);
});

test('a request with a wrong or no secret is not a trigger', () => {
  process.env.NHOST_WEBHOOK_SECRET = 's3cret';
  assert.equal(isTrigger(request({ 'nhost-webhook-secret': 'other' })), false);
  assert.equal(isTrigger(request({})), false);
});

test('nothing is a trigger while the secret is unset', () => {
  assert.equal(isTrigger(request({ 'nhost-webhook-secret': '' })), false);
});

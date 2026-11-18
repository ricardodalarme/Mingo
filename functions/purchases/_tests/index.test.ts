import assert from 'node:assert/strict';
import { afterEach, beforeEach, mock, test } from 'node:test';
import {
  BACKEND_ENV,
  gql,
  json,
  request,
  response,
  restoreEnv,
  setEnv,
  stubFetch,
  variablesOf,
} from '../../_lib/_testing.ts';
import webhook from '../index.ts';

const USER = '0b7b1f1e-6f0a-4f4e-8a34-2f6a1c9d3b21';
const secret = { authorization: 'rc-secret' };

const purchase = (overrides: Record<string, unknown> = {}) => ({
  event: {
    id: 'evt-1',
    app_user_id: USER,
    type: 'INITIAL_PURCHASE',
    event_timestamp_ms: 1794784036000,
    product_id: 'mingo_plus_monthly',
    period_type: 'NORMAL',
    store: 'PLAY_STORE',
    ...overrides,
  },
});

beforeEach(() => setEnv({ ...BACKEND_ENV, REVENUECAT_WEBHOOK_AUTH: 'rc-secret' }));
afterEach(() => {
  restoreEnv();
  mock.restoreAll();
});

test('a request without the shared secret is refused', async () => {
  const res = response();
  await webhook(request({ body: purchase(), headers: { authorization: 'wrong' } }), res);
  assert.equal(res.statusCode, 401);
});

test('an event that changes nothing is acknowledged without touching the database', async () => {
  const calls = stubFetch(() => gql({}));
  const res = response();
  await webhook(request({ body: purchase({ type: 'TEST' }), headers: secret }), res);
  assert.equal(res.statusCode, 200);
  assert.deepEqual(res.payload, { ok: true, ignored: true });
  assert.equal(calls.length, 0);
});

test('a purchase is applied as the entitlement it leaves behind', async () => {
  const calls = stubFetch(() => gql({ applyPurchaseEvent: [{ userId: USER }] }));
  const res = response();
  await webhook(request({ body: purchase(), headers: secret }), res);
  assert.deepEqual(res.payload, { ok: true, applied: true });
  assert.deepEqual(variablesOf(calls[0]), {
    id: 'evt-1',
    user: USER,
    type: 'INITIAL_PURCHASE',
    at: new Date(1794784036000).toISOString(),
    plan: 'plus_monthly',
    status: 'active',
    expires: null,
    renew: true,
    store: 'play_store',
  });
});

test('an event the database already knows is reported as not applied', async () => {
  stubFetch(() => gql({ applyPurchaseEvent: [] }));
  const res = response();
  await webhook(request({ body: purchase(), headers: secret }), res);
  assert.deepEqual(res.payload, { ok: true, applied: false });
});

test('a database failure answers 500 so RevenueCat retries', async () => {
  mock.method(console, 'error', () => undefined);
  stubFetch(() => json({ errors: [{ message: 'down' }] }));
  const res = response();
  await webhook(request({ body: purchase(), headers: secret }), res);
  assert.equal(res.statusCode, 500);
});

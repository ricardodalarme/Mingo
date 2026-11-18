import assert from 'node:assert/strict';
import { afterEach, mock, test } from 'node:test';
import { request, response, restoreEnv, setEnv } from '../_testing.ts';
import { handler } from '../handler.ts';

afterEach(() => {
  restoreEnv();
  mock.restoreAll();
});

const trigger = (run: Parameters<typeof handler>[1]) => handler({ method: 'POST', guard: { kind: 'trigger' } }, run);
const asTrigger = { 'nhost-webhook-secret': 'hook' };

test('a method other than POST is refused with 405 before anything else runs', async () => {
  const run = mock.fn(async () => undefined);
  const res = response();
  await trigger(run)(request({ method: 'GET' }), res);
  assert.equal(res.statusCode, 405);
  assert.deepEqual(res.payload, { error: 'METHOD_NOT_ALLOWED' });
  assert.equal(run.mock.callCount(), 0);
});

test('a caller the guard refuses gets 401 and the function does not run', async () => {
  setEnv({ NHOST_WEBHOOK_SECRET: 'hook' });
  const run = mock.fn(async () => undefined);
  const res = response();
  await trigger(run)(request({ headers: { 'nhost-webhook-secret': 'nope' } }), res);
  assert.equal(res.statusCode, 401);
  assert.deepEqual(res.payload, { error: 'UNAUTHORIZED' });
  assert.equal(run.mock.callCount(), 0);
});

test('each guard lets its own caller through', async () => {
  setEnv({ NHOST_WEBHOOK_SECRET: 'hook', REVENUECAT_WEBHOOK_AUTH: 'rc' });
  const reached = async (guard: Parameters<typeof handler>[0]['guard'], headers: Record<string, string>) => {
    const run = mock.fn(async () => undefined);
    await handler({ method: 'POST', guard }, run)(request({ headers }), response());
    return run.mock.callCount() === 1;
  };
  assert.equal(await reached({ kind: 'trigger' }, asTrigger), true);
  assert.equal(await reached({ kind: 'bearer' }, { authorization: 'Bearer t' }), true);
  assert.equal(
    await reached({ kind: 'secret', header: 'authorization', env: 'REVENUECAT_WEBHOOK_AUTH' }, { authorization: 'rc' }),
    true,
  );
});

test('a throw is answered with 500 INTERNAL instead of reaching the platform', async () => {
  setEnv({ NHOST_WEBHOOK_SECRET: 'hook' });
  mock.method(console, 'error', () => undefined);
  const res = response();
  await trigger(async () => {
    throw new Error('database is down');
  })(request({ headers: asTrigger }), res);
  assert.equal(res.statusCode, 500);
  assert.deepEqual(res.payload, { error: 'INTERNAL' });
});

test('a throw after the response started only ends the response', async () => {
  setEnv({ NHOST_WEBHOOK_SECRET: 'hook' });
  mock.method(console, 'error', () => undefined);
  const res = response();
  await trigger(async (_req, out) => {
    out.write('data: first\n\n');
    throw new Error('broke mid stream');
  })(request({ headers: asTrigger }), res);
  assert.equal(res.payload, undefined, 'no JSON error is mixed into the stream');
  assert.equal(res.writableEnded, true);
});

test('the failure is logged as an error with a short reason', async () => {
  setEnv({ NHOST_WEBHOOK_SECRET: 'hook' });
  const logged = mock.method(console, 'error', () => undefined);
  await trigger(async () => {
    throw new Error('x'.repeat(500));
  })(request({ headers: asTrigger }), response());
  const line = JSON.parse(String(logged.mock.calls[0]?.arguments[0]));
  assert.equal(line.event, 'handler_failed');
  assert.equal(line.reason.length, 120);
});

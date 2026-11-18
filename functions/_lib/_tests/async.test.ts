import assert from 'node:assert/strict';
import { test } from 'node:test';
import { ignoreError, mapLimit, retry } from '../async.ts';

test('mapLimit keeps the order of the results', async () => {
  const delays = [30, 5, 15, 1];
  const results = await mapLimit(delays, 2, async (ms) => {
    await new Promise((done) => setTimeout(done, ms));
    return ms * 2;
  });
  assert.deepEqual(results, [60, 10, 30, 2]);
});

test('mapLimit never runs more than the limit at once', async () => {
  let running = 0;
  let peak = 0;
  await mapLimit([1, 2, 3, 4, 5, 6], 3, async () => {
    peak = Math.max(peak, ++running);
    await new Promise((done) => setTimeout(done, 5));
    running--;
  });
  assert.equal(peak, 3);
});

test('mapLimit of nothing is nothing', async () => {
  assert.deepEqual(await mapLimit([], 4, async (x) => x), []);
});

test('retry returns the first success and stops', async () => {
  let calls = 0;
  const result = await retry(3, async () => {
    if (++calls < 2) throw new Error('flaky');
    return 'ok';
  });
  assert.equal(result, 'ok');
  assert.equal(calls, 2);
});

test('retry rethrows the last failure after the last attempt', async () => {
  let calls = 0;
  await assert.rejects(
    retry(3, async () => {
      throw new Error(`failure ${++calls}`);
    }),
    /failure 3/,
  );
});

test('ignoreError settles a rejected promise', async () => {
  await Promise.reject(new Error('allowed')).catch(ignoreError);
});

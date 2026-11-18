import assert from 'node:assert/strict';
import { afterEach, beforeEach, mock, test } from 'node:test';
import {
  BACKEND_ENV,
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
import jobs from '../jobs.ts';

const trigger = { 'nhost-webhook-secret': BACKEND_ENV.NHOST_WEBHOOK_SECRET };
const cron = (job: unknown) => request({ headers: trigger, body: { payload: { job } } });

beforeEach(() => setEnv(BACKEND_ENV));
afterEach(() => {
  restoreEnv();
  mock.restoreAll();
});

test('a job that is not listed is refused', async () => {
  const calls = stubFetch(() => gql({}));
  for (const job of ['drop_everything', undefined, 7]) {
    const res = response();
    await jobs(cron(job), res);
    assert.equal(res.statusCode, 400);
    assert.deepEqual(res.payload, { error: 'UNKNOWN_JOB' });
  }
  assert.equal(calls.length, 0);
});

test('a database job runs in SQL and reports the rows it touched', async () => {
  const calls = stubFetch(() => gql({ runJob: [{ affected: 4 }] }));
  const res = response();
  await jobs(cron('weekly_cards'), res);
  assert.deepEqual(res.payload, { job: 'weekly_cards', affected: 4 });
  assert.deepEqual(variablesOf(calls[0]), { job: 'weekly_cards' });
});

test('a job that returns no row reports zero', async () => {
  stubFetch(() => gql({ runJob: [] }));
  const res = response();
  await jobs(cron('prune'), res);
  assert.deepEqual(res.payload, { job: 'prune', affected: 0 });
});

test('the sweep removes the queued files and counts the ones it removed', async () => {
  const files = ['a', 'b', 'c'].map((fileId) => ({ fileId }));
  stubFetch((call) => {
    if (call.url.includes('graphql')) {
      return queryOf(call).includes('fileDeletions(') ? gql({ fileDeletions: files }) : gql({});
    }
    return json({}, call.url.endsWith('/b') ? 503 : 200);
  });
  const res = response();
  await jobs(cron('sweep_files'), res);
  assert.deepEqual(res.payload, { job: 'sweep_files', affected: 2 });
});

test('the sweep only takes files that waited an hour in the queue, at most 200', async () => {
  const calls = stubFetch(() => gql({ fileDeletions: [] }));
  await jobs(cron('sweep_files'), response());
  const { before, limit } = variablesOf(calls[0]) as { before: string; limit: number };
  assert.equal(limit, 200);
  const waited = Date.now() - Date.parse(before);
  assert.ok(waited >= 3_600_000 && waited < 3_700_000);
});

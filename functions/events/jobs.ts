// Runs one scheduled job. Called by the cron triggers with `{ "job": "<name>" }` as payload.
// The database jobs run in `private.run_job`, which records each run; `sweep_files` retries the files the
// `delete_file` trigger could not remove.
import * as v from 'valibot';
import { mapLimit } from '../_lib/async.ts';
import { HOUR_MS } from '../_lib/config.ts';
import { asAdmin } from '../_lib/graphql.ts';
import { handler } from '../_lib/handler.ts';
import { fail, ok } from '../_lib/http.ts';
import { log } from '../_lib/log.ts';
import { cronPayload, parse } from '../_lib/payloads.ts';
import { removeFile } from './_files.ts';
import { queuedFileDeletions, runJob } from './_operations.ts';

const DATABASE_JOBS: readonly string[] = [
  'weekly_cards',
  'reminders',
  'open_capsules',
  'purge_accounts',
  'prune',
  'expire_annoyances',
];

/** A file must wait this long in the queue before the sweep takes it, so the `delete_file` trigger gets the first try. */
const SWEEP_GRACE_MS = HOUR_MS;
const SWEEP_BATCH = 200;
const SWEEP_PARALLEL = 10;
/** Stops starting removals after this long, because Starter projects stop a function after 10 seconds. */
const SWEEP_BUDGET_MS = 8000;

const Job = cronPayload(v.object({ job: v.string() }));

async function sweepFiles(): Promise<number> {
  const before = new Date(Date.now() - SWEEP_GRACE_MS).toISOString();
  const { fileDeletions } = await asAdmin(queuedFileDeletions, { before, limit: SWEEP_BATCH });
  const deadline = Date.now() + SWEEP_BUDGET_MS;
  const results = await mapLimit(
    fileDeletions,
    SWEEP_PARALLEL,
    async ({ fileId }) => Date.now() < deadline && (await removeFile(fileId)),
  );
  return results.filter(Boolean).length;
}

async function runDatabaseJob(job: string): Promise<number> {
  const { runJob: rows } = await asAdmin(runJob, { job });
  return rows[0]?.affected ?? 0;
}

export default handler({ method: 'POST', guard: { kind: 'trigger' } }, async (req, res) => {
  const job = parse(Job, req.body)?.payload.job;
  if (!job || (job !== 'sweep_files' && !DATABASE_JOBS.includes(job))) return fail(res, 'UNKNOWN_JOB');
  const affected = job === 'sweep_files' ? await sweepFiles() : await runDatabaseJob(job);
  log.info('job', { job, affected });
  ok(res, { job, affected });
});

// Runs one scheduled job. Called by the cron triggers with `{ "job": "<name>" }` as payload.
// The database jobs run in `private.run_job`, which records each run; `sweep_files` retries the files the
// `delete_file` trigger could not remove.
import { asAdmin, isTrigger, log, type Req, type Res } from '../_lib/backend';
import { removeFile } from './_files';

const DATABASE_JOBS = ['weekly_cards', 'reminders', 'open_capsules', 'purge_accounts', 'prune', 'expire_annoyances'];

export default async (req: Req, res: Res) => {
  if (!isTrigger(req)) return res.status(401).json({ error: 'UNAUTHORIZED' });
  const job: unknown = req.body?.payload?.job;
  if (job === 'sweep_files') {
    const { fileDeletions } = await asAdmin<{
      fileDeletions: { fileId: string }[];
    }>(
      `query ($before: timestamptz!) { fileDeletions(where: { queuedAt: { _lt: $before } }, limit: 200) { fileId } }`,
      { before: new Date(Date.now() - 3600_000).toISOString() },
    );
    let removed = 0;
    for (const { fileId } of fileDeletions) if (await removeFile(fileId)) removed++;
    log('job', { job, affected: removed });
    return res.status(200).json({ job, affected: removed });
  }
  if (typeof job !== 'string' || !DATABASE_JOBS.includes(job)) return res.status(400).json({ error: 'UNKNOWN_JOB' });
  const { runJob } = await asAdmin<{ runJob: { affected: number }[] }>(
    `mutation ($job: String!) { runJob(args: { job: $job }) { affected } }`,
    { job },
  );
  const affected = runJob[0]?.affected ?? 0;
  log('job', { job, affected });
  return res.status(200).json({ job, affected });
};

// Removes the file of a deleted row from Storage. Called by the `delete_file` event trigger for every queued file.
// Idempotent: a file that is already gone is a success. 500 makes the trigger retry; what still fails stays queued
// for the daily `sweep_files` job.
import { isTrigger, log, type Req, type Res } from '../_lib/backend';
import { removeFile } from './_files';

export default async (req: Req, res: Res) => {
  if (!isTrigger(req)) return res.status(401).json({ error: 'UNAUTHORIZED' });
  const fileId: string | undefined = req.body?.event?.data?.new?.file_id;
  if (!fileId) return res.status(400).json({ error: 'INVALID_EVENT' });
  const removed = await removeFile(fileId);
  log('file_deleted', { removed });
  return removed ? res.status(200).json({ removed: true }) : res.status(500).json({ error: 'STORAGE_UNAVAILABLE' });
};

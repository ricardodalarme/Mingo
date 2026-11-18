// Removes the file of a deleted row from Storage. Called by the `delete_file` event trigger for every queued file.
// Idempotent: a file that is already gone is a success. 500 makes the trigger retry; what still fails stays queued
// for the daily `sweep_files` job.
import * as v from 'valibot';
import { handler } from '../_lib/handler.ts';
import { fail, ok } from '../_lib/http.ts';
import { log } from '../_lib/log.ts';
import { insertedRow, NonEmptyString, parse } from '../_lib/payloads.ts';
import { removeFile } from './_files.ts';

const QueuedFile = insertedRow(v.object({ file_id: NonEmptyString }));

export default handler({ method: 'POST', guard: { kind: 'trigger' } }, async (req, res) => {
  const fileId = parse(QueuedFile, req.body)?.event.data.new.file_id;
  if (!fileId) return fail(res, 'INVALID_EVENT');
  const removed = await removeFile(fileId);
  log.info('file_deleted', { removed });
  if (!removed) return fail(res, 'STORAGE_UNAVAILABLE');
  ok(res, { removed: true });
});

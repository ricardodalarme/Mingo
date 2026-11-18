// Export of the caller's own data (LGPD). Signed-in people only.
//   POST /export  -> 200 { url, expiresAt } | 401 UNAUTHORIZED | 429 EXPORT_LIMIT | 500 EXPORT_FAILED
// The document is built by the database from the caller's own rows only, stored in the private `exports` bucket and
// handed back as a presigned link that lasts five minutes. The file itself is removed by the daily prune after 24 hours.

import { ignoreError } from '../_lib/async.ts';
import { asAdmin, asCaller } from '../_lib/graphql.ts';
import { handler } from '../_lib/handler.ts';
import { fail, ok, type Req } from '../_lib/http.ts';
import { log, reasonOf } from '../_lib/log.ts';
import { presignFile, uploadJson } from '../_lib/storage.ts';
import { assignFileOwner, clearExportRequests, exportUserData, ownSettings, removeFileRow } from './_operations.ts';

const EXPORT_BUCKET = 'exports';
const MS_PER_SECOND = 1000;

const exportFileName = () => `mingo-export-${new Date().toISOString().slice(0, 10)}.json`;

/** The id of the signed-in person. The engine verifies the token, and the person's own settings row is the only one the caller can read. */
async function identify(req: Req): Promise<string | null> {
  try {
    const { userSettings } = await asCaller(req, ownSettings);
    return userSettings[0]?.userId ?? null;
  } catch {
    return null;
  }
}

/** Stores the document as a file the person owns, so the person's own read permission lets them download it. */
async function storeDocument(userId: string, document: unknown): Promise<string> {
  const fileId = await uploadJson(EXPORT_BUCKET, exportFileName(), document);
  await asAdmin(assignFileOwner, { id: fileId, user: userId });
  return fileId;
}

/** Undoes a failed run so it does not use up the day's export. */
async function rollback(userId: string, fileId: string | undefined): Promise<void> {
  await asAdmin(clearExportRequests, { user: userId }).catch(ignoreError);
  if (fileId) await asAdmin(removeFileRow, { id: fileId }).catch(ignoreError);
}

export default handler({ method: 'POST', guard: { kind: 'bearer' } }, async (req, res) => {
  const userId = await identify(req);
  if (!userId) return fail(res, 'UNAUTHORIZED');

  let fileId: string | undefined;
  try {
    const { exportUserData: rows } = await asAdmin(exportUserData, { user: userId });
    // No row means the person already exported today.
    if (!rows[0]) return fail(res, 'EXPORT_LIMIT');
    fileId = await storeDocument(userId, rows[0].data);
    const { url, expiration } = await presignFile(req, fileId);
    log.info('export_done');
    ok(res, { url, expiresAt: new Date(Date.now() + expiration * MS_PER_SECOND).toISOString() });
  } catch (error) {
    await rollback(userId, fileId);
    log.error('export_failed', { reason: reasonOf(error) });
    fail(res, 'EXPORT_FAILED');
  }
});

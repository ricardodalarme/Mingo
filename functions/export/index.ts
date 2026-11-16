// Export of the caller's own data (LGPD). Signed-in people only.
//   POST /export  -> 200 { url, expiresAt } | 401 UNAUTHORIZED | 429 EXPORT_LIMIT | 500 EXPORT_FAILED
// The document is built by the database from the caller's own rows only, stored in the private `exports` bucket and
// handed back as a presigned link that lasts five minutes. The file itself is removed by the daily prune after 24 hours.
import { asAdmin, asCaller, header, log, type Req, type Res } from '../_lib/backend';

type Presigned = { url: string; expiration: number };

async function store(document: unknown, userId: string): Promise<string> {
  const form = new FormData();
  const name = `mingo-export-${new Date().toISOString().slice(0, 10)}.json`;
  form.append('bucket-id', 'exports');
  form.append('file[]', new Blob([JSON.stringify(document)], { type: 'application/json' }), name);
  const res = await fetch(`${process.env.NHOST_STORAGE_URL}/files`, {
    method: 'POST',
    headers: { 'x-hasura-admin-secret': process.env.NHOST_ADMIN_SECRET! },
    body: form,
    signal: AbortSignal.timeout(30_000),
  });
  const body = (await res.json()) as { processedFiles?: { id: string }[] };
  const id = body.processedFiles?.[0]?.id;
  if (!res.ok || !id) throw new Error(`upload failed: ${res.status}`);
  // The person owns the file, so the person's own read permission lets them download it.
  await asAdmin(`mutation ($id: uuid!, $user: uuid!) { updateFile(pk_columns: {id: $id}, _set: {uploadedByUserId: $user}) { id } }`, { id, user: userId });
  return id;
}

export default async (req: Req, res: Res) => {
  if (req.method !== 'POST') return res.status(405).json({ error: 'METHOD_NOT_ALLOWED' });
  if (!/^Bearer\s+\S+/i.test(header(req, 'authorization'))) return res.status(401).json({ error: 'UNAUTHORIZED' });

  let userId: string | undefined;
  try {
    // The engine verifies the token; the person's own settings row is the only one the caller can read.
    userId = (await asCaller<{ userSettings: { userId: string }[] }>(req, `{ userSettings { userId } }`)).userSettings[0]?.userId;
  } catch {
    return res.status(401).json({ error: 'UNAUTHORIZED' });
  }
  if (!userId) return res.status(401).json({ error: 'UNAUTHORIZED' });

  let fileId: string | undefined;
  try {
    const data = await asAdmin<{ exportUserData: { data: unknown }[] }>(
      `mutation ($user: uuid!) { exportUserData(args: { userId: $user }) { data } }`, { user: userId });
    // No row means the person already exported today.
    if (!data.exportUserData[0]) return res.status(429).json({ error: 'EXPORT_LIMIT' });
    fileId = await store(data.exportUserData[0].data, userId);
    const link = await fetch(`${process.env.NHOST_STORAGE_URL}/files/${fileId}/presignedurl`, {
      headers: { authorization: header(req, 'authorization') },
      signal: AbortSignal.timeout(20_000),
    });
    if (!link.ok) throw new Error(`presign failed: ${link.status}`);
    const { url, expiration } = (await link.json()) as Presigned;
    log('export_done');
    return res.status(200).json({ url, expiresAt: new Date(Date.now() + expiration * 1000).toISOString() });
  } catch (error) {
    // A failed run does not use up the day's export.
    await asAdmin(`mutation ($user: uuid!) { deleteExportRequests(where: { userId: { _eq: $user } }) { affected_rows } }`, { user: userId }).catch(() => {});
    if (fileId) await asAdmin(`mutation ($id: uuid!) { deleteFile(id: $id) { id } }`, { id: fileId }).catch(() => {});
    log('export_failed', { reason: error instanceof Error ? error.message.slice(0, 120) : 'unknown' });
    return res.status(500).json({ error: 'EXPORT_FAILED' });
  }
};

import { asAdmin } from '../_lib/backend';

/** Removes a file from Storage and from the deletion queue. A file that is already gone counts as removed. */
export async function removeFile(fileId: string): Promise<boolean> {
  const res = await fetch(`${process.env.NHOST_STORAGE_URL}/files/${fileId}`, {
    method: 'DELETE',
    headers: { 'x-hasura-admin-secret': process.env.NHOST_ADMIN_SECRET! },
    signal: AbortSignal.timeout(20_000),
  });
  if (!res.ok && res.status !== 404) return false;
  await asAdmin(`mutation ($id: uuid!) { deleteFileDeletionsByPk(fileId: $id) { fileId } }`, { id: fileId });
  return true;
}

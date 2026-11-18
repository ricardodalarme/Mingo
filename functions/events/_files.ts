import { asAdmin } from '../_lib/graphql.ts';
import { deleteStoredFile } from '../_lib/storage.ts';
import { dequeueFileDeletion } from './_operations.ts';

/** Removes a file from Storage and from the deletion queue. A file that is already gone counts as removed. */
export async function removeFile(fileId: string): Promise<boolean> {
  if (!(await deleteStoredFile(fileId))) return false;
  await asAdmin(dequeueFileDeletion, { id: fileId });
  return true;
}

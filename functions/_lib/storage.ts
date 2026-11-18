import { TIMEOUT_MS } from './config.ts';
import { requireEnv } from './env.ts';
import { adminHeaders } from './graphql.ts';
import { header, type Req } from './http.ts';

const storageUrl = (path: string): string => `${requireEnv('NHOST_STORAGE_URL')}${path}`;

export type PresignedLink = { url: string; expiration: number };

/** Removes a file from Storage. A file that is already gone counts as removed. */
export async function deleteStoredFile(fileId: string): Promise<boolean> {
  const res = await fetch(storageUrl(`/files/${fileId}`), {
    method: 'DELETE',
    headers: adminHeaders(),
    signal: AbortSignal.timeout(TIMEOUT_MS.storage),
  });
  return res.ok || res.status === 404;
}

/** Stores a JSON document in [bucket] and returns the id of the new file. */
export async function uploadJson(bucket: string, name: string, document: unknown): Promise<string> {
  const form = new FormData();
  form.append('bucket-id', bucket);
  form.append('file[]', new Blob([JSON.stringify(document)], { type: 'application/json' }), name);
  const res = await fetch(storageUrl('/files'), {
    method: 'POST',
    headers: adminHeaders(),
    body: form,
    signal: AbortSignal.timeout(TIMEOUT_MS.upload),
  });
  const body = (await res.json()) as { processedFiles?: { id: string }[] };
  const id = body.processedFiles?.[0]?.id;
  if (!res.ok || !id) throw new Error(`upload failed: ${res.status}`);
  return id;
}

/** A temporary download link for a file, issued as the caller so the caller's read permission applies. */
export async function presignFile(req: Req, fileId: string): Promise<PresignedLink> {
  const res = await fetch(storageUrl(`/files/${fileId}/presignedurl`), {
    headers: { authorization: header(req, 'authorization') },
    signal: AbortSignal.timeout(TIMEOUT_MS.storage),
  });
  if (!res.ok) throw new Error(`presign failed: ${res.status}`);
  return (await res.json()) as PresignedLink;
}

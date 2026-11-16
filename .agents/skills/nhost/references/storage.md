# Nhost Storage

Docs: `.work/nhost-docs/docs/products/storage/` (`index.mdx`, `architecture.mdx`, `buckets.mdx`, `permissions.mdx`, `guides/*`, `image-transformation.mdx`,
`cdn.mdx`, `antivirus.mdx`) and `.work/nhost-docs/api/storage.openapi.yaml`.

## Model

Storage is a REST service in front of an S3-compatible backend. Each file has a row in `storage.files` (visible in GraphQL), grouped in `storage.buckets`.
Permissions are the same engine permissions as tables, set on `storage.files` per role: **insert** = upload, **select** = download, **update** = replace,
**delete**. Zero trust by default.

## Buckets

- Every project has a `default` bucket. The app's private buckets are `avatars`, `slips`, `memories`, `messages` and `couple-photos`, created by the storage
  migration with `presigned_urls_enabled = true` and `download_expiration = 300` (5 minutes). Sizes: 5 MB for avatars, 10 MB for the rest.
- The storage service owns `storage.files` and `storage.buckets` on cloud; migrations can insert buckets but cannot create indexes on those tables. Keep
  cleanup and heavy storage work in Functions.
- A per-bucket rule is just `bucket_id _eq '<bucket>'` in the file permission.

## Permissions

A private file is uploaded with check `bucket_id` in the app's buckets and the **uploader identity** preset (`uploaded_by_user_id = X-Hasura-User-Id`).
Download and delete filter `uploaded_by_user_id = X-Hasura-User-Id`. For files shared with the partner, add a relationship from `storage.files` to the app
table that owns the file and filter through it:
`avatarOf` (profiles), `memories`, `partnerMessages`, `couplePhotos`. Test every rule with a stranger, a partner and an ex-partner.

## Rows that own files

Store the file's `id` in the app table with a real foreign key to `storage.files(id)` and track the relationship in both directions. Then one GraphQL query
returns the row and the file metadata (`name`, `size`, `mimeType`, `bucketId`, `uploadedByUserId`, `metadata`, ...). Upload order: upload through REST, then
insert the row with the returned id; make the upload and the row creation safe to retry, and delete orphans with a job.

## URLs for the app

GraphQL returns file metadata, not a URL. Three ways to show a private image (`guides/display-images.mdx`):

1. **Authenticated request** to `https://<sub>.storage.<region>.nhost.run/v1/files/<id>` with `Authorization: Bearer`. CDN friendly, but the image loader
   needs the header.
2. **Presigned URL** (`GET /files/{id}/presignedurl` returns `{url, expiration}`): tokenless and temporary, but every URL bypasses the CDN cache. The app uses
   this through `StorageService.signedUrl`, caching per file and per active session for four minutes.
3. **Public bucket** for files that need no protection.

Local presigned URLs use `local.storage.local.nhost.run`, which the development network does not resolve: use the authenticated endpoint locally and presigned
URLs in cloud.

## Images

Transform on the fly with `w` and `h` (1 to 8000 px, aspect ratio kept), `q` quality, `f` format (`auto`, `same`, `jpeg`, `webp`, `png`, `avif`) and `b` blur
(`image-transformation.mdx`). Use it for thumbnails and avatars instead of storing derivatives. Antivirus is `[storage.antivirus] server = "tcp://run-clamav:3310"`,
which needs a ClamAV service on Nhost Run; decide whether user uploads need it.

## Cleanup

Deleting a row must not leave the file behind: a trigger queues the file id in `private.file_deletions`, the `delete_file` event trigger calls the Storage
delete API with the admin secret, and the daily `sweep_files` job retries what failed. Account deletion queues every file of the person (`references/auth.md`).

-- Buckets also ship in the storage migration; the local bootstrap applies migrations while the Storage service is still
-- initializing its own schema, so the seed re-creates them once every service is healthy.
insert into storage.buckets (id, min_upload_file_size, max_upload_file_size, cache_control, presigned_urls_enabled, download_expiration)
values
  ('avatars', 1, 5000000, 'private, max-age=3600', true, 300),
  ('slips', 1, 10000000, 'private, max-age=3600', true, 300),
  ('memories', 1, 10000000, 'private, max-age=3600', true, 300),
  ('messages', 1, 10000000, 'private, max-age=3600', true, 300),
  ('couple-photos', 1, 10000000, 'private, max-age=3600', true, 300),
  ('exports', 1, 10000000, 'private, max-age=0', true, 300)
on conflict (id) do update
  set max_upload_file_size = excluded.max_upload_file_size,
      cache_control = excluded.cache_control,
      presigned_urls_enabled = excluded.presigned_urls_enabled,
      download_expiration = excluded.download_expiration;

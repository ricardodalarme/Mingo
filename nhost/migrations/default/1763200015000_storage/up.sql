-- Private buckets. Files are read with the caller's token or a presigned URL that lasts five minutes.
insert into storage.buckets (id, min_upload_file_size, max_upload_file_size, cache_control, presigned_urls_enabled, download_expiration)
values
  ('avatars', 1, 5000000, 'private, max-age=3600', true, 300),
  ('slips', 1, 10000000, 'private, max-age=3600', true, 300),
  ('memories', 1, 10000000, 'private, max-age=3600', true, 300),
  ('messages', 1, 10000000, 'private, max-age=3600', true, 300),
  ('couple-photos', 1, 10000000, 'private, max-age=3600', true, 300)
on conflict (id) do nothing;

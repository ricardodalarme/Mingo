-- The daily prune also drops what the new features no longer need.
create or replace function private.prune_expired_rows() returns integer
language plpgsql volatile as $$
declare v_n integer := 0; v_rows integer;
begin
  delete from private.notifications where created_at < now() - interval '30 days';
  get diagnostics v_rows = row_count; v_n := v_n + v_rows;
  delete from private.job_runs where ran_at < now() - interval '30 days';
  get diagnostics v_rows = row_count; v_n := v_n + v_rows;
  delete from private.invite_attempts where attempted_at < now() - interval '1 day';
  get diagnostics v_rows = row_count; v_n := v_n + v_rows;
  delete from public.chat_turns where created_at < now() - interval '7 days';
  get diagnostics v_rows = row_count; v_n := v_n + v_rows;
  delete from public.inbox_items where created_at < now() - interval '30 days';
  get diagnostics v_rows = row_count; v_n := v_n + v_rows;
  -- A card nobody accepted or declined for 90 days is closed; an answered one stays until the mode is switched off.
  delete from public.spice_card_plays where created_at < now() - interval '90 days' and accepted_by is null;
  get diagnostics v_rows = row_count; v_n := v_n + v_rows;
  -- An export lives 24 hours: its file is queued for the same removal every other file gets.
  insert into private.file_deletions (file_id)
  select f.id from storage.files f where f.bucket_id = 'exports' and f.created_at < now() - interval '24 hours'
  on conflict do nothing;
  get diagnostics v_rows = row_count; v_n := v_n + v_rows;
  delete from private.export_requests where created_at < now() - interval '7 days';
  get diagnostics v_rows = row_count; v_n := v_n + v_rows;
  return v_n;
end $$;

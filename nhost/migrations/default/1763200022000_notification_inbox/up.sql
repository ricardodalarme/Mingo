-- The in-app list of notifications. Every notification the backend creates is listed here, also the ones the daily cap
-- kept from being pushed. A person reads their own rows and marks them read; nothing else is theirs to change.
create table public.inbox_items (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  type text not null references public.notification_type (value),
  ref_id uuid,
  created_at timestamptz not null default now(),
  read_at timestamptz
);
create index inbox_items_user_created_idx on public.inbox_items (user_id, created_at desc);
create index inbox_items_unread_idx on public.inbox_items (user_id) where read_at is null;

-- Queues the push as before and lists it in the inbox once. A type the person switched off is not listed.
create or replace function private.notify(p_user_id uuid, p_type text, p_ref_id uuid default null, p_dedupe_key text default null) returns void
language plpgsql volatile as $$
declare v_id uuid;
begin
  if p_user_id is null then return; end if;
  insert into private.notifications (user_id, type, ref_id, dedupe_key)
  values (p_user_id, p_type, p_ref_id, p_dedupe_key)
  on conflict (dedupe_key) do nothing
  returning id into v_id;
  if v_id is not null and not exists (
    select 1 from public.notification_mutes m where m.user_id = p_user_id and m.type = p_type
  ) then
    insert into public.inbox_items (user_id, type, ref_id) values (p_user_id, p_type, p_ref_id);
  end if;
end $$;

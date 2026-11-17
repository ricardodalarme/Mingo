-- Small key/value configuration the app reads before sign-in (limits, minimum app version). Never store a secret here.
create table public.app_config (
  key text primary key check (char_length(key) <= 60),
  value text not null
);

create table public.entitlements (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  plan text not null references public.entitlement_plan (value),
  status text not null references public.entitlement_status (value),
  expires_at timestamptz,
  will_renew boolean not null default true,
  store text references public.entitlement_store (value),
  updated_at timestamptz not null default now()
);

create table private.purchase_events (
  event_id text primary key,
  user_id uuid references public.profiles (id) on delete set null,
  type text not null,
  event_at timestamptz not null,
  received_at timestamptz not null default now()
);
create index purchase_events_user_idx on private.purchase_events (user_id);

create function private.entitlement_is_live(e public.entitlements) returns boolean
language sql stable as $$
  select e.status in ('trialing', 'active', 'grace', 'billing_issue')
     and (e.expires_at is null or e.expires_at > now() - interval '48 hours');
$$;

-- Plus is on when the person or their current partner has a live entitlement (48 h grace after expiry).
create function private.has_plus(p_user_id uuid) returns boolean
language sql stable as $$
  select exists (
    select 1 from public.entitlements e
    where private.entitlement_is_live(e)
      and e.user_id in (p_user_id, private.partner_of(p_user_id)));
$$;

-- A missing app_config row falls back to the launch value, so removing the row can never lift a limit.
create function private.config_int(p_key text, p_fallback integer) returns integer
language sql stable as $$
  select coalesce((select value::integer from public.app_config where key = p_key), p_fallback);
$$;

-- Idempotent by event id; an event older than the stored state is recorded and ignored. Timestamps arrive as ISO text
-- and are cast here, so the GraphQL argument type is the same.
create function private.apply_purchase_event(p_event_id text, p_user_id uuid, p_type text, p_event_at text,
  p_plan text, p_status text, p_will_renew boolean, p_store text, p_expires_at text default null)
returns setof public.entitlements language plpgsql volatile as $$
declare v_at timestamptz := p_event_at::timestamptz; v_expires timestamptz := nullif(p_expires_at, '')::timestamptz;
begin
  insert into private.purchase_events (event_id, user_id, type, event_at)
  values (p_event_id, (select id from public.profiles where id = p_user_id), p_type, v_at)
  on conflict (event_id) do nothing;
  if not found or not exists (select 1 from public.profiles where id = p_user_id) then
    return;
  end if;
  return query
  insert into public.entitlements as e (user_id, plan, status, expires_at, will_renew, store, updated_at)
  values (p_user_id, p_plan, p_status, v_expires, coalesce(p_will_renew, true), p_store, v_at)
  on conflict (user_id) do update
    set plan = excluded.plan, status = excluded.status, expires_at = excluded.expires_at,
        will_renew = excluded.will_renew, store = excluded.store, updated_at = excluded.updated_at
    where e.updated_at <= excluded.updated_at
  returning e.*;
end $$;

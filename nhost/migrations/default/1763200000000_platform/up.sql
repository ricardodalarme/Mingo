-- `public` is the GraphQL surface; `private` holds internals that no role reaches.
create schema private;

create function private.set_updated_at() returns trigger
language plpgsql as $$
begin
  new.updated_at := now();
  return new;
end $$;

create function private.is_valid_time_zone(tz text) returns boolean
language sql stable as $$
  select exists (select 1 from pg_catalog.pg_timezone_names where name = tz);
$$;

-- The signed-in user of a tracked function call; raises when the session carries none.
create function private.uid(session json) returns uuid
language plpgsql stable as $$
declare v_uid uuid := nullif(session ->> 'x-hasura-user-id', '')::uuid;
begin
  if v_uid is null then
    raise exception 'UNAUTHENTICATED' using errcode = '28000';
  end if;
  return v_uid;
end $$;

-- Rejects a write with a stable code. Clients never parse it: every rule it guards is readable state.
create function private.reject(code text) returns void
language plpgsql as $$
begin
  raise exception '%', code using errcode = '23514';
end $$;

-- Creates an enum table: one row per value, exposed as a GraphQL enum.
create function private.create_enum(name text, variadic vals text[]) returns void
language plpgsql as $$
begin
  execute format('create table public.%I (value text primary key)', name);
  execute format('insert into public.%I (value) select unnest($1)', name) using vals;
end $$;

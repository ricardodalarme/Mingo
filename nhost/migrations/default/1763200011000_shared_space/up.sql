-- Rows here belong to their author. A row with `couple_id` is also visible to the current partner; when the couple
-- ends, the partner loses access at once and the author decides what happens to the row.

create table public.rituals (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  couple_id uuid references public.couples (id) on delete set null,
  title text not null check (char_length(title) between 1 and 80),
  cadence text not null default 'weekly' references public.ritual_cadence (value),
  weekday smallint check (weekday between 0 and 6),
  at_time time,
  reminder boolean not null default false,
  archived_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.ritual_logs (
  id uuid primary key default gen_random_uuid(),
  ritual_id uuid not null references public.rituals (id) on delete cascade,
  author_id uuid not null references public.profiles (id) on delete cascade,
  done_on date not null,
  skipped boolean not null default false,
  created_at timestamptz not null default now(),
  constraint ritual_logs_once unique (ritual_id, done_on)
);
create index ritual_logs_author_idx on public.ritual_logs (author_id);
create trigger ritual_logs_local_date before insert on public.ritual_logs
  for each row execute function private.set_local_date('done_on');

create table public.logistic_items (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  couple_id uuid references public.couples (id) on delete set null,
  title text not null check (char_length(title) between 1 and 120),
  assignee_id uuid references public.profiles (id) on delete set null,
  due_on date,
  week_start date,
  invisible_work boolean not null default false,
  done_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index logistic_items_assignee_idx on public.logistic_items (assignee_id);

create table public.saved_date_ideas (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  couple_id uuid references public.couples (id) on delete set null,
  content_slug text check (char_length(content_slug) <= 80),
  title text not null check (char_length(title) between 1 and 120),
  notes text check (char_length(notes) <= 1000),
  status text not null default 'saved' references public.date_idea_status (value),
  planned_for date,
  place_name text check (char_length(place_name) <= 120),
  place_address text check (char_length(place_address) <= 240),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.important_dates (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  couple_id uuid references public.couples (id) on delete set null,
  title text not null check (char_length(title) between 1 and 120),
  kind text not null default 'custom' references public.important_date_kind (value),
  month smallint not null check (month between 1 and 12),
  day smallint not null check (day between 1 and 31),
  year smallint check (year between 1900 and 2200),
  yearly boolean not null default true,
  remind_days smallint[] not null default '{7,1}' check (cardinality(remind_days) <= 10),
  hidden boolean not null default false,
  origin text not null default 'manual' references public.important_date_origin (value),
  holiday_key text check (char_length(holiday_key) <= 80),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.memories (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  couple_id uuid references public.couples (id) on delete set null,
  title text not null check (char_length(title) between 1 and 160),
  body text check (char_length(body) <= 3000),
  happened_on date not null,
  date_precision text not null default 'day' references public.date_precision (value),
  place text check (char_length(place) <= 120),
  photo_file_id uuid references storage.files (id) on delete set null,
  origin text not null default 'manual' references public.memory_origin (value),
  source_id uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index memories_photo_file_idx on public.memories (photo_file_id);
create trigger memories_local_date before insert on public.memories
  for each row execute function private.set_local_date('happened_on');
create trigger memories_file_cleanup after update of photo_file_id or delete on public.memories
  for each row execute function private.queue_file_deletion('photo_file_id');

create table public.story_events (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  couple_id uuid references public.couples (id) on delete set null,
  kind text not null references public.story_event_kind (value),
  title text check (char_length(title) <= 120),
  happened_on date not null,
  date_precision text not null default 'day' references public.date_precision (value),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- A letter sealed until its open date. Nobody edits it after sealing, and the partner reads it only once it is opened.
create table public.capsules (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  couple_id uuid references public.couples (id) on delete set null,
  body text not null check (char_length(body) between 1 and 3000),
  opens_on date not null,
  opened_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create function private.before_capsule_insert() returns trigger
language plpgsql as $$
declare v_today date := private.local_date(new.author_id);
begin
  if new.opens_on < v_today + 7 then perform private.reject('CAPSULE_OPENS_TOO_SOON'); end if;
  if new.opens_on > (v_today + interval '50 years')::date then perform private.reject('CAPSULE_OPENS_TOO_FAR'); end if;
  new.opened_at := null;
  return new;
end $$;
create trigger capsules_before_insert before insert on public.capsules
  for each row execute function private.before_capsule_insert();

create table public.lists (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  couple_id uuid references public.couples (id) on delete set null,
  title text not null check (char_length(title) between 1 and 80),
  kind text not null default 'custom' references public.list_kind (value),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.list_items (
  id uuid primary key default gen_random_uuid(),
  list_id uuid not null references public.lists (id) on delete cascade,
  author_id uuid not null references public.profiles (id) on delete cascade,
  title text not null check (char_length(title) between 1 and 160),
  status text not null default 'dream' references public.list_item_status (value),
  position integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index list_items_list_idx on public.list_items (list_id, position);
create index list_items_author_idx on public.list_items (author_id);
create trigger list_items_set_updated_at before update on public.list_items
  for each row execute function private.set_updated_at();

-- Gift ideas and wishes: the author writes; the partner reads the ones shared with the couple.
create table public.gift_ideas (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  couple_id uuid references public.couples (id) on delete set null,
  kind text not null default 'idea' references public.gift_idea_kind (value),
  title text not null check (char_length(title) between 1 and 120),
  note text check (char_length(note) <= 1000),
  occasion_date_id uuid references public.important_dates (id) on delete set null,
  status text not null default 'idea' references public.gift_idea_status (value),
  budget text references public.gift_budget (value),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index gift_ideas_occasion_idx on public.gift_ideas (occasion_date_id);

do $$
declare t text;
begin
  foreach t in array array['rituals', 'logistic_items', 'saved_date_ideas', 'important_dates', 'memories', 'story_events',
    'capsules', 'lists', 'gift_ideas'] loop
    execute format('create index %I on public.%I (author_id, created_at desc)', t || '_author_idx', t);
    execute format('create index %I on public.%I (couple_id, created_at desc)', t || '_couple_idx', t);
    execute format('create trigger %I before update on public.%I for each row execute function private.set_updated_at()',
                   t || '_set_updated_at', t);
  end loop;
end $$;

-- The tables whose rows can be shared with the couple through `couple_id`.
create function private.shared_tables() returns text[]
language sql immutable as $$
  select array['rituals', 'logistic_items', 'saved_date_ideas', 'important_dates', 'memories', 'story_events',
    'capsules', 'lists', 'gift_ideas'];
$$;

-- Everything here is private to its author unless a table says otherwise.

create table public.temperature_checks (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  level text not null references public.temperature_level (value),
  note text check (char_length(note) <= 500),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- No reminders for 24 hours after a "fight" temperature. Partner-initiated notifications still arrive.
create function private.is_quiet_moment(p_user_id uuid) returns boolean
language sql stable as $$
  select exists (select 1 from public.temperature_checks t
                 where t.author_id = p_user_id and t.level = 'fight' and t.created_at > now() - interval '24 hours');
$$;

create table public.repair_sessions (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  intensity smallint check (intensity between 1 and 10),
  path text references public.repair_path (value),
  step smallint not null default 0,
  feeling_after text references public.repair_feeling (value),
  draft text check (char_length(draft) <= 1000),
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.repair_learnings (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  repair_session_id uuid references public.repair_sessions (id) on delete set null,
  kind text not null references public.repair_learning_kind (value),
  note text not null check (char_length(note) between 1 and 1000),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index repair_learnings_session_idx on public.repair_learnings (repair_session_id);

create table public.journal_entries (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  entry_date date not null,
  body text not null check (char_length(body) between 1 and 5000),
  mood text check (char_length(mood) <= 30),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger journal_entries_local_date before insert on public.journal_entries
  for each row execute function private.set_local_date('entry_date');

create table public.conversation_preps (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  guide text not null default 'free' references public.conversation_guide (value),
  topic text check (char_length(topic) <= 120),
  notes text check (char_length(notes) <= 5000),
  draft text check (char_length(draft) <= 2000),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- One mood per person per local day. The row itself is never visible to the partner.
create table public.moods (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  day date not null,
  mood text not null references public.mood (value),
  need text references public.mood_need (value),
  share text not null default 'none' references public.mood_share (value),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint moods_one_per_day unique (author_id, day)
);
create trigger moods_local_date before insert on public.moods
  for each row execute function private.set_local_date('day');

-- What the person chose to show the partner right now: one row per person, replaced on every share, so the partner
-- never gets a mood history.
create table public.shared_moods (
  user_id uuid primary key references public.profiles (id) on delete cascade,
  day date not null,
  mood text not null references public.mood (value),
  need text references public.mood_need (value),
  updated_at timestamptz not null default now()
);

create function private.sync_shared_mood() returns trigger
language plpgsql as $$
begin
  if tg_op <> 'INSERT' then
    delete from public.shared_moods where user_id = old.author_id and day = old.day;
  end if;
  if tg_op = 'DELETE' or new.share = 'none' or new.day < private.local_date(new.author_id) then
    return null;
  end if;
  insert into public.shared_moods as s (user_id, day, mood, need)
  values (new.author_id, new.day, new.mood, case when new.share = 'mood_need' then new.need end)
  on conflict (user_id) do update
    set day = excluded.day, mood = excluded.mood, need = excluded.need, updated_at = now();
  return null;
end $$;
create trigger moods_sync_shared after insert or update or delete on public.moods
  for each row execute function private.sync_shared_mood();

create table public.partner_facts (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  label text not null check (char_length(label) between 1 and 80),
  value text not null check (char_length(value) between 1 and 500),
  category text references public.partner_fact_category (value),
  source text not null default 'manual' references public.partner_fact_source (value),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- "My manual": the partner reads only the entries marked as shared.
create table public.manual_entries (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  key text not null check (char_length(key) between 1 and 60),
  value text not null check (char_length(value) between 1 and 1000),
  shared boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint manual_entries_once unique (author_id, key)
);

create table public.program_enrollments (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  program_slug text not null check (char_length(program_slug) between 1 and 80),
  current_day smallint not null default 1,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint program_enrollments_once unique (author_id, program_slug)
);

create table public.lesson_progress (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  program_slug text not null check (char_length(program_slug) between 1 and 80),
  lesson_day smallint not null,
  status text not null default 'done' references public.lesson_status (value),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint lesson_progress_once unique (author_id, program_slug, lesson_day)
);

create table public.quiz_results (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  quiz_key text not null references public.quiz_key (value),
  ranked text[] not null check (cardinality(ranked) <= 20),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint quiz_results_once unique (author_id, quiz_key)
);

do $$
declare t text;
begin
  foreach t in array array['temperature_checks', 'repair_sessions', 'repair_learnings', 'journal_entries', 'conversation_preps',
    'moods', 'partner_facts', 'manual_entries', 'program_enrollments', 'lesson_progress', 'quiz_results'] loop
    execute format('create index %I on public.%I (author_id, created_at desc)', t || '_author_idx', t);
    execute format('create trigger %I before update on public.%I for each row execute function private.set_updated_at()',
                   t || '_set_updated_at', t);
  end loop;
end $$;

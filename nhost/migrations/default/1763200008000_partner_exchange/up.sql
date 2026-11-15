-- One photo per couple, for the couple-photo widget.
create table public.couple_photos (
  couple_id uuid primary key references public.couples (id) on delete cascade,
  file_id uuid not null references storage.files (id) on delete cascade,
  uploaded_by uuid not null references public.profiles (id) on delete cascade,
  updated_at timestamptz not null default now()
);
create index couple_photos_file_idx on public.couple_photos (file_id);
create index couple_photos_uploaded_by_idx on public.couple_photos (uploaded_by);
create trigger couple_photos_set_updated_at before update on public.couple_photos
  for each row execute function private.set_updated_at();
create trigger couple_photos_file_cleanup after update of file_id or delete on public.couple_photos
  for each row execute function private.queue_file_deletion('file_id');

-- One-tap messages between partners. Responses are never counted or scored.
create table public.signals (
  id uuid primary key default gen_random_uuid(),
  sender_id uuid not null references public.profiles (id) on delete cascade,
  recipient_id uuid not null references public.profiles (id) on delete cascade,
  kind text not null references public.signal_kind (value),
  value text check (char_length(value) <= 40),
  body text check (char_length(body) <= 500),
  response text references public.signal_response (value),
  responded_at timestamptz,
  seen_at timestamptz,
  created_at timestamptz not null default now()
);
create index signals_recipient_idx on public.signals (recipient_id, created_at desc);
create index signals_sender_idx on public.signals (sender_id, created_at desc);
create index signals_recipient_unseen_idx on public.signals (recipient_id) where seen_at is null;

create function private.signals_left(p_user_id uuid) returns integer
language sql stable as $$
  select greatest(0, 30 - (select count(*) from public.signals
                           where sender_id = p_user_id and created_at > now() - interval '1 day'))::integer;
$$;

-- The recipient is always the sender's current partner; the client never chooses it.
create function private.before_signal_insert() returns trigger
language plpgsql as $$
begin
  new.recipient_id := private.partner_of(new.sender_id);
  if new.recipient_id is null then perform private.reject('NOT_PAIRED'); end if;
  if private.signals_left(new.sender_id) <= 0 then perform private.reject('RATE_LIMITED'); end if;
  new.body := nullif(btrim(new.body), '');
  new.created_at := now();
  new.response := null; new.responded_at := null; new.seen_at := null;
  return new;
end $$;
create trigger signals_before_insert before insert on public.signals
  for each row execute function private.before_signal_insert();

create function private.before_signal_update() returns trigger
language plpgsql as $$
begin
  if new.response is distinct from old.response then
    new.responded_at := now();
    new.seen_at := coalesce(new.seen_at, now());
  end if;
  return new;
end $$;
create trigger signals_before_update before update on public.signals
  for each row execute function private.before_signal_update();

create function private.after_signal_insert() returns trigger
language plpgsql as $$
begin
  perform private.notify(new.recipient_id, 'signal', new.id, 'signal:' || new.id);
  return new;
end $$;
create trigger signals_after_insert after insert on public.signals
  for each row execute function private.after_signal_insert();

-- Messages to the partner: a note, a drawing, a voice note or a "thinking of you" pack.
create table public.partner_messages (
  id uuid primary key default gen_random_uuid(),
  sender_id uuid not null references public.profiles (id) on delete cascade,
  recipient_id uuid not null references public.profiles (id) on delete cascade,
  kind text not null references public.partner_message_kind (value),
  body text check (char_length(body) <= 280),
  media_file_id uuid references storage.files (id) on delete set null,
  for_widget boolean not null default false,
  seen_at timestamptz,
  hearted_at timestamptz,
  created_at timestamptz not null default now(),
  constraint partner_messages_has_content check (body is not null or media_file_id is not null)
);
create index partner_messages_recipient_idx on public.partner_messages (recipient_id, created_at desc);
create index partner_messages_sender_idx on public.partner_messages (sender_id, created_at desc);
create index partner_messages_media_idx on public.partner_messages (media_file_id);
create trigger partner_messages_file_cleanup after update of media_file_id or delete on public.partner_messages
  for each row execute function private.queue_file_deletion('media_file_id');

create function private.partner_messages_left(p_user_id uuid) returns integer
language sql stable as $$
  select greatest(0, 30 - (select count(*) from public.partner_messages
                           where sender_id = p_user_id and created_at > now() - interval '1 day'))::integer;
$$;

-- A note reaches the recipient's widget only if the recipient allowed it; otherwise it is delivered in the app only.
create function private.before_partner_message_insert() returns trigger
language plpgsql as $$
begin
  new.recipient_id := private.partner_of(new.sender_id);
  if new.recipient_id is null then perform private.reject('NOT_PAIRED'); end if;
  if private.partner_messages_left(new.sender_id) <= 0 then perform private.reject('RATE_LIMITED'); end if;
  new.body := nullif(btrim(new.body), '');
  new.for_widget := new.for_widget
    and coalesce((select widget_allow_partner_notes from public.user_settings where user_id = new.recipient_id), false);
  new.created_at := now();
  new.seen_at := null; new.hearted_at := null;
  return new;
end $$;
create trigger partner_messages_before_insert before insert on public.partner_messages
  for each row execute function private.before_partner_message_insert();

create function private.after_partner_message_insert() returns trigger
language plpgsql as $$
begin
  perform private.notify(new.recipient_id, 'partner_message', new.id, 'partner_message:' || new.id);
  return new;
end $$;
create trigger partner_messages_after_insert after insert on public.partner_messages
  for each row execute function private.after_partner_message_insert();

-- Couple question: an answer stays hidden from the partner until both have answered.
create table public.question_answers (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  couple_id uuid references public.couples (id) on delete set null,
  question_slug text not null check (char_length(question_slug) between 1 and 80),
  body text not null check (char_length(btrim(body)) between 1 and 1000),
  -- One answer per question before pairing; null once shared, so unique treats each shared row as distinct.
  solo_key text generated always as (case when couple_id is null then question_slug end) stored,
  created_at timestamptz not null default now(),
  constraint question_answers_once unique (author_id, couple_id, question_slug),
  constraint question_answers_solo_once unique (author_id, solo_key)
);
create index question_answers_couple_idx on public.question_answers (couple_id, question_slug);

-- Weekly check-in: four private answers each, revealed to the partner when both finished.
create table public.checkins (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  couple_id uuid not null references public.couples (id) on delete cascade,
  week_start date not null,
  answer_1 text check (char_length(btrim(answer_1)) between 1 and 1000),
  answer_2 text check (char_length(btrim(answer_2)) between 1 and 1000),
  answer_3 text check (char_length(btrim(answer_3)) between 1 and 1000),
  answer_4 text check (char_length(btrim(answer_4)) between 1 and 1000),
  completed boolean generated always as
    (answer_1 is not null and answer_2 is not null and answer_3 is not null and answer_4 is not null) stored,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint checkins_once unique (author_id, couple_id, week_start)
);
create index checkins_couple_idx on public.checkins (couple_id, week_start);
create trigger checkins_set_updated_at before update on public.checkins
  for each row execute function private.set_updated_at();

-- Rows written inside the couple take the author's current couple; the client never sends it.
create function private.set_current_couple() returns trigger
language plpgsql as $$
begin
  new.couple_id := private.couple_of(new.author_id);
  if new.couple_id is null and tg_argv[0] = 'required' then
    perform private.reject('NOT_PAIRED');
  end if;
  return new;
end $$;
create trigger question_answers_set_couple before insert on public.question_answers
  for each row execute function private.set_current_couple('optional');
create trigger checkins_set_couple before insert on public.checkins
  for each row execute function private.set_current_couple('required');
create function private.set_checkin_week() returns trigger
language plpgsql as $$
begin
  new.week_start := private.local_week_start(new.author_id);
  return new;
end $$;
create trigger checkins_set_week before insert on public.checkins
  for each row execute function private.set_checkin_week();

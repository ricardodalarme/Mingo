-- The weekly review, the data export, and the list of sessions.

-- WP-16 ---------------------------------------------------------------------------------------------------------------
-- Counts only. The partner side is the partner's cards and the shared rituals and check-in; nothing else about them.
create table public.weekly_reviews (
  week_start date not null,
  slips integer not null,
  active_days integer not null,
  streak_days integer not null,
  moods_logged integer not null,
  rituals_done integer not null,
  cards_sent integer not null,
  cards_received integer not null,
  checkin_done boolean not null,
  partner_cards_sent integer,
  couple_rituals_done integer,
  both_checkin_done boolean,
  low_data boolean not null,
  missing text[] not null
);

-- The week of `weekStart` (a Monday, or any day of that week), the current week of the person when omitted. It reads the
-- caller's own counts and a few counts of the couple, and never any text, annoyance or Tempero table.
create function public.weekly_review(session json, "weekStart" date default null) returns setof public.weekly_reviews
language plpgsql stable security definer set search_path = '' as $$
declare
  v_uid uuid := private.uid(session);
  v_tz text := (select time_zone from public.profiles where id = v_uid);
  v_today date := private.local_date(v_uid);
  v_current date := private.local_week_start(v_uid);
  v_week date := date_trunc('week', coalesce("weekStart", private.local_week_start(v_uid))::timestamp)::date;
  v_end date := v_week + 6;
  v_couple uuid := private.couple_of(v_uid);
  v_partner uuid := private.partner_of(v_uid);
  v_days date[];
  v_last date; v_streak integer := 0;
  v_slips integer; v_moods integer; v_rituals integer; v_sent integer; v_received integer; v_active integer;
begin
  select array_agg(distinct d order by d) into v_days from (
    select (s.created_at at time zone v_tz)::date as d from public.slips s where s.author_id = v_uid
    union select m.day from public.moods m where m.author_id = v_uid
    union select l.done_on from public.ritual_logs l where l.author_id = v_uid and not l.skipped
    union select (c.sent_at at time zone v_tz)::date from public.cards c where c.author_id = v_uid and c.status = 'sent'
  ) x where d between v_week - 400 and least(v_end, v_today);
  v_days := coalesce(v_days, '{}');
  v_active := (select count(*) from unnest(v_days) d where d between v_week and v_end);

  -- The run ends at the last active day of the week; in the current week it must be today or yesterday to still count.
  v_last := (select max(d) from unnest(v_days) d where d between v_week and v_end);
  if v_last is not null and not (v_week = v_current and v_last < v_today - 1) then
    while v_streak < 400 and (v_last - v_streak) = any (v_days) loop v_streak := v_streak + 1; end loop;
  end if;

  v_slips := (select count(*) from public.slips s where s.author_id = v_uid and (s.created_at at time zone v_tz)::date between v_week and v_end);
  v_moods := (select count(*) from public.moods m where m.author_id = v_uid and m.day between v_week and v_end);
  v_rituals := (select count(*) from public.ritual_logs l where l.author_id = v_uid and not l.skipped and l.done_on between v_week and v_end);
  v_sent := (select count(*) from public.cards c where c.author_id = v_uid and c.status = 'sent' and (c.sent_at at time zone v_tz)::date between v_week and v_end);
  v_received := (select count(*) from public.cards c where c.recipient_id = v_uid and c.status = 'sent' and (c.sent_at at time zone v_tz)::date between v_week and v_end);

  return query select
    v_week, v_slips, v_active, v_streak, v_moods, v_rituals, v_sent, v_received,
    exists (select 1 from public.checkins c where c.author_id = v_uid and c.week_start = v_week and c.completed),
    case when v_couple is not null then (select count(*)::integer from public.cards c
      where c.author_id = v_partner and c.status = 'sent' and (c.sent_at at time zone v_tz)::date between v_week and v_end) end,
    case when v_couple is not null then (select count(*)::integer from public.ritual_logs l join public.rituals r on r.id = l.ritual_id
      where r.couple_id = v_couple and not l.skipped and l.done_on between v_week and v_end) end,
    case when v_couple is not null then (select count(distinct c.author_id) >= 2 from public.checkins c
      where c.couple_id = v_couple and c.week_start = v_week and c.completed) end,
    v_active < 2,
    array_remove(array[case when v_slips = 0 then 'slips' end, case when v_moods = 0 then 'mood' end,
                       case when v_rituals = 0 then 'ritual' end], null);
end $$;

-- WP-18 ---------------------------------------------------------------------------------------------------------------
-- One export per person per 24 hours.
create table private.export_requests (
  user_id uuid not null references public.profiles (id) on delete cascade,
  created_at timestamptz not null default now()
);
create index export_requests_user_idx on private.export_requests (user_id, created_at desc);

create table public.export_documents (
  data jsonb not null
);

-- The person's own data, as one document. Rows that are the partner's are never included, not even the shared ones, and
-- neither is what the partner wrote in reply (answers to requests and signals, replies to cards).
create function private.export_user_data(p_user_id uuid) returns jsonb
language plpgsql stable as $$
declare v_out jsonb; v jsonb; t record;
begin
  v_out := jsonb_build_object('exportedAt', now(), 'format', 1,
    'profile', (select to_jsonb(p) from public.profiles p where p.id = p_user_id));
  for t in select * from (values
      ('settings', 'user_settings', 'user_id'), ('consents', 'consents', 'user_id'),
      ('notification_settings', 'notification_settings', 'user_id'), ('notification_mutes', 'notification_mutes', 'user_id'),
      ('slips', 'slips', 'author_id'), ('annoyances', 'annoyances', 'author_id'),
      ('cards_authored', 'cards', 'author_id'), ('moods', 'moods', 'author_id'),
      ('temperature_checks', 'temperature_checks', 'author_id'), ('repair_sessions', 'repair_sessions', 'author_id'),
      ('repair_learnings', 'repair_learnings', 'author_id'), ('journal_entries', 'journal_entries', 'author_id'),
      ('conversation_preps', 'conversation_preps', 'author_id'), ('partner_facts', 'partner_facts', 'author_id'),
      ('manual_entries', 'manual_entries', 'author_id'), ('learned_items', 'learned_items', 'author_id'),
      ('quiz_results', 'quiz_results', 'author_id'), ('memories_authored', 'memories', 'author_id'),
      ('story_events_authored', 'story_events', 'author_id'), ('important_dates_authored', 'important_dates', 'author_id'),
      ('rituals_authored', 'rituals', 'author_id'), ('ritual_logs', 'ritual_logs', 'author_id'),
      ('logistic_items_authored', 'logistic_items', 'author_id'), ('saved_date_ideas', 'saved_date_ideas', 'author_id'),
      ('lists_authored', 'lists', 'author_id'), ('gift_ideas_authored', 'gift_ideas', 'author_id'),
      ('capsules_authored', 'capsules', 'author_id'), ('question_answers', 'question_answers', 'author_id'),
      ('checkins', 'checkins', 'author_id'), ('game_answers', 'game_answers', 'author_id'),
      ('spice_desire_answers', 'spice_desire_answers', 'user_id'), ('agreements_authored', 'agreements', 'author_id'),
      ('program_enrollments', 'program_enrollments', 'author_id'), ('lesson_progress', 'lesson_progress', 'author_id')
    ) as x (key, tbl, col)
  loop
    execute format('select coalesce(jsonb_agg(to_jsonb(r)), ''[]''::jsonb) from public.%I r where r.%I = $1', t.tbl, t.col) into v using p_user_id;
    v_out := v_out || jsonb_build_object(t.key, v);
  end loop;

  v_out := v_out || jsonb_build_object(
    'card_items', (select coalesce(jsonb_agg(to_jsonb(i)), '[]') from public.card_items i join public.cards c on c.id = i.card_id where c.author_id = p_user_id),
    'card_reactions_made', (select coalesce(jsonb_agg(jsonb_build_object('card_id', r.card_id, 'reaction', r.reaction, 'reply', r.reply, 'reacted_at', r.reacted_at)), '[]')
      from public.card_reactions r join public.cards c on c.id = r.card_id where c.recipient_id = p_user_id and not r.from_guest),
    'list_items', (select coalesce(jsonb_agg(to_jsonb(i)), '[]') from public.list_items i join public.lists l on l.id = i.list_id where l.author_id = p_user_id),
    'gentle_requests_sent', (select coalesce(jsonb_agg(jsonb_build_object('id', g.id, 'when_text', g.when_text, 'feel_text', g.feel_text,
      'wish_text', g.wish_text, 'created_at', g.created_at)), '[]') from public.gentle_requests g where g.sender_id = p_user_id),
    'signals_sent', (select coalesce(jsonb_agg(jsonb_build_object('id', s.id, 'kind', s.kind, 'value', s.value, 'body', s.body,
      'created_at', s.created_at)), '[]') from public.signals s where s.sender_id = p_user_id),
    'partner_messages_sent', (select coalesce(jsonb_agg(jsonb_build_object('id', m.id, 'kind', m.kind, 'body', m.body,
      'duration_ms', m.duration_ms, 'created_at', m.created_at)), '[]') from public.partner_messages m where m.sender_id = p_user_id),
    'files', (select coalesce(jsonb_agg(jsonb_build_object('id', f.id, 'name', f.name, 'bucket', f.bucket_id, 'size', f.size,
      'mime_type', f.mime_type, 'created_at', f.created_at)), '[]') from storage.files f
      where f.uploaded_by_user_id = p_user_id and f.bucket_id <> 'exports'));
  return v_out;
end $$;

-- For Functions only (no role is granted it). Records the request; no row comes back when one was already made today.
create function public.export_user_data("userId" uuid) returns setof public.export_documents
language plpgsql volatile as $$
begin
  perform pg_advisory_xact_lock(hashtext('export:' || "userId"));
  if exists (select 1 from private.export_requests r where r.user_id = "userId" and r.created_at > now() - interval '24 hours') then
    return;
  end if;
  insert into private.export_requests (user_id) values ("userId");
  return query select private.export_user_data("userId");
end $$;

-- A private bucket for the exports; Storage is written by Functions only and each file lives 24 hours.
insert into storage.buckets (id, min_upload_file_size, max_upload_file_size, cache_control, presigned_urls_enabled, download_expiration)
values ('exports', 1, 10000000, 'private, max-age=0', true, 300)
on conflict (id) do nothing;

-- WP-19 ---------------------------------------------------------------------------------------------------------------
-- Auth does not record the device of a session, so the app links its push device to the session id it received at sign-in.
alter table public.devices add column refresh_token_id uuid;

create table public.session_rows (
  id uuid not null,
  created_at timestamptz not null,
  expires_at timestamptz not null,
  device_id uuid,
  device_label text,
  platform text
);

-- The caller's live sessions, newest first, with the device the app linked to each one.
create function public.my_sessions(session json) returns setof public.session_rows
language sql stable security definer set search_path = '' as $$
  select t.id, t.created_at, t.expires_at, d.id, d.label, d.platform
  from auth.refresh_tokens t
  left join public.devices d on d.refresh_token_id = t.id and d.user_id = t.user_id
  where t.user_id = private.uid(session) and t.type = 'regular' and t.expires_at > now()
  order by t.created_at desc;
$$;

-- Ends one of the caller's sessions and stops the pushes to its device. An access token already issued stays valid until
-- it expires, 15 minutes at most.
create function public.revoke_session("sessionId" uuid, session json) returns setof public.session_rows
language plpgsql volatile security definer set search_path = '' as $$
declare v_uid uuid := private.uid(session); v_row public.session_rows;
begin
  select t.id, t.created_at, t.expires_at, d.id, d.label, d.platform into v_row
  from auth.refresh_tokens t left join public.devices d on d.refresh_token_id = t.id and d.user_id = t.user_id
  where t.id = "sessionId" and t.user_id = v_uid and t.type = 'regular';
  if not found then return; end if;
  delete from public.devices where refresh_token_id = "sessionId" and user_id = v_uid;
  delete from auth.refresh_tokens where id = "sessionId" and user_id = v_uid;
  return next v_row;
end $$;

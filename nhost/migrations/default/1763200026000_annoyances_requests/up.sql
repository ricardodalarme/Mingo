-- Things that bothered a person stay private and fade; a gentle request is the one way to bring one to the partner.

-- A note about something that bothered the author. Never shared, never counted, gone after 14 days.
create table public.annoyances (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  body text not null check (char_length(btrim(body)) between 1 and 280),
  created_at timestamptz not null default now(),
  expires_at timestamptz not null default now() + interval '14 days',
  check_sent_at timestamptz
);
create index annoyances_author_idx on public.annoyances (author_id, created_at desc);
create index annoyances_expiry_idx on public.annoyances (expires_at);

-- Clients cannot extend the life of a note: they can write the body only, and an insert always starts the 14 days.
create function private.before_annoyance_write() returns trigger
language plpgsql as $$
begin
  new.body := btrim(new.body);
  if tg_op = 'INSERT' then
    new.created_at := now();
    new.expires_at := now() + interval '14 days';
    new.check_sent_at := null;
  end if;
  return new;
end $$;
create trigger annoyances_before_write before insert or update on public.annoyances
  for each row execute function private.before_annoyance_write();

-- A request has three parts and goes only to the current partner. It is never part of a card.
create table public.gentle_requests (
  id uuid primary key default gen_random_uuid(),
  sender_id uuid not null references public.profiles (id) on delete cascade,
  recipient_id uuid not null references public.profiles (id) on delete cascade,
  when_text text not null check (char_length(btrim(when_text)) between 1 and 140),
  feel_text text not null check (char_length(btrim(feel_text)) between 1 and 140),
  wish_text text not null check (char_length(btrim(wish_text)) between 1 and 140),
  response text check (response in ('will_do', 'later', 'not_now', 'talk', 'more_time')),
  seen_at timestamptz,
  responded_at timestamptz,
  thanked_at timestamptz,
  created_at timestamptz not null default now(),
  purge_after timestamptz not null default now() + interval '30 days',
  constraint gentle_requests_not_to_self check (sender_id <> recipient_id)
);
create index gentle_requests_sender_idx on public.gentle_requests (sender_id, created_at desc);
create index gentle_requests_recipient_idx on public.gentle_requests (recipient_id, created_at desc);
create index gentle_requests_purge_idx on public.gentle_requests (purge_after);

-- The first answer starts the 7 days the request stays. The recipient can write the answer and the seen time only.
create function private.before_gentle_request_update() returns trigger
language plpgsql as $$
begin
  if old.response is null and new.response is not null then
    new.responded_at := now();
    new.purge_after := now() + interval '7 days';
  end if;
  return new;
end $$;
create trigger gentle_requests_before_update before update on public.gentle_requests
  for each row execute function private.before_gentle_request_update();

-- The text of the answer never travels in the notification.
create function private.after_gentle_request_answer() returns trigger
language plpgsql as $$
begin
  if old.response is null and new.response is not null then
    perform private.notify(new.sender_id, 'gentle_request_answered', new.id, 'gentle_request_answered:' || new.id);
  end if;
  return null;
end $$;
create trigger gentle_requests_after_answer after update of response on public.gentle_requests
  for each row execute function private.after_gentle_request_answer();

-- Sends the request after the person confirmed it. The complaint it came from leaves the table.
create function public.send_gentle_request("whenText" text, "feelText" text, "wishText" text, session json, "annoyanceId" uuid default null)
returns setof public.gentle_requests language plpgsql volatile as $$
declare v_uid uuid := private.uid(session); v_partner uuid := private.partner_of(v_uid); v_row public.gentle_requests;
begin
  if v_partner is null then perform private.reject('NOT_PAIRED'); end if;
  insert into public.gentle_requests (sender_id, recipient_id, when_text, feel_text, wish_text)
  values (v_uid, v_partner, btrim("whenText"), btrim("feelText"), btrim("wishText"))
  returning * into v_row;
  delete from public.annoyances a where a.id = "annoyanceId" and a.author_id = v_uid;
  perform private.notify(v_partner, 'gentle_request', v_row.id, 'gentle_request:' || v_row.id);
  return next v_row;
end $$;

-- The sender thanks a partner who promised to do it; the thanks becomes a good slip of their own.
create function public.thank_gentle_request("requestId" uuid, body text, session json) returns setof public.slips
language plpgsql volatile as $$
declare v_uid uuid := private.uid(session); v_request public.gentle_requests;
begin
  select * into v_request from public.gentle_requests r
  where r.id = "requestId" and r.sender_id = v_uid and r.response = 'will_do' and r.thanked_at is null for update;
  if not found then return; end if;
  update public.gentle_requests set thanked_at = now() where id = v_request.id;
  return query
  insert into public.slips (author_id, kind, polarity, body, category)
  values (v_uid, 'quick', 'liked', thank_gentle_request.body, 'said') returning *;
end $$;

-- Expires the notes, asks on day 10 whether one still bothers, and purges the requests whose time is up.
create function private.expire_annoyances() returns integer
language plpgsql volatile as $$
declare v_n integer := 0; v_rows integer;
begin
  delete from public.annoyances where expires_at <= now();
  get diagnostics v_rows = row_count; v_n := v_n + v_rows;
  with due as (
    update public.annoyances set check_sent_at = now()
    where created_at <= now() - interval '10 days' and check_sent_at is null and expires_at > now()
    returning id, author_id)
  select count(*), count(private.notify_inbox(author_id, 'annoyance_check', id, 'annoyance_check:' || id)) into v_rows from due;
  v_n := v_n + v_rows;
  delete from public.gentle_requests where purge_after <= now();
  get diagnostics v_rows = row_count; v_n := v_n + v_rows;
  return v_n;
end $$;

create or replace function private.run_job(job text) returns setof private.job_runs
language plpgsql volatile as $$
declare v_affected integer;
begin
  v_affected := case job
    when 'weekly_cards' then private.generate_weekly_cards()
    when 'reminders' then private.enqueue_reminders()
    when 'open_capsules' then private.open_due_capsules()
    when 'purge_accounts' then private.purge_deleted_accounts()
    when 'prune' then private.prune_expired_rows()
    when 'expire_annoyances' then private.expire_annoyances()
  end;
  if v_affected is null then
    raise exception 'UNKNOWN_JOB %', job;
  end if;
  return query insert into private.job_runs (job, affected) values (run_job.job, v_affected) returning *;
end $$;

-- A request between two people ends with their couple.
create or replace function private.end_couple(p_couple_id uuid, p_actor uuid) returns void
language plpgsql volatile as $$
begin
  perform private.notify(m.user_id, 'unpaired', p_couple_id, 'unpaired:' || p_couple_id || ':' || m.user_id)
  from public.couple_members m where m.couple_id = p_couple_id and m.user_id <> p_actor;
  delete from public.couple_photos where couple_id = p_couple_id;
  delete from public.gentle_requests r
  where r.sender_id in (select user_id from public.couple_members where couple_id = p_couple_id)
    and r.recipient_id in (select user_id from public.couple_members where couple_id = p_couple_id);
  update public.game_sessions set status = 'cancelled' where couple_id = p_couple_id and status in ('invited', 'active');
  delete from public.couple_members where couple_id = p_couple_id;
  update public.couples set ended_at = now() where id = p_couple_id;
end $$;

-- Step A of retiring "bothered" slips: they become private annoyances and no new one can be written as a slip.
insert into public.annoyances (author_id, body, created_at, expires_at)
select s.author_id, s.body, s.created_at, s.created_at + interval '14 days'
from public.slips s where s.polarity = 'bothered' and s.created_at + interval '14 days' > now();
delete from public.slips where polarity = 'bothered';
alter table public.slips add constraint slips_only_liked check (polarity = 'liked');

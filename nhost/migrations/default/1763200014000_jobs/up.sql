-- One row per run of a scheduled job, kept for a month.
create table private.job_runs (
  id uuid primary key default gen_random_uuid(),
  job text not null,
  affected integer not null,
  ran_at timestamptz not null default now()
);

-- Creates the weekly draft for everyone whose chosen day and hour arrived, and announces it.
create function private.generate_weekly_cards() returns integer
language plpgsql volatile as $$
declare v_user uuid; v_card uuid; v_count integer := 0;
begin
  for v_user in
    select p.id
    from public.profiles p join public.notification_settings n on n.user_id = p.id
    where extract(dow from now() at time zone p.time_zone) = n.card_day
      and extract(hour from now() at time zone p.time_zone) >= n.card_hour
      and not exists (select 1 from public.cards c
                      where c.author_id = p.id and c.kind = 'weekly'
                        and c.week_start = date_trunc('week', now() at time zone p.time_zone)::date)
  loop
    v_card := private.build_card_draft(v_user);
    if v_card is not null then
      v_count := v_count + 1;
      perform private.notify(v_user, 'card_ready', v_card, 'card_ready:' || v_card);
    end if;
  end loop;
  return v_count;
end $$;

-- Hourly reminders, each evaluated in the person's local time. Preferences and the daily cap apply at delivery.
create function private.enqueue_reminders() returns integer
language plpgsql volatile as $$
declare v_n integer := 0; r record;
begin
  -- dates the person or the couple saved, N days before, at 10:00
  for r in
    select d.id, p.id as target, private.next_occurrence(d.month, d.day, (now() at time zone p.time_zone)::date) as occ,
           (now() at time zone p.time_zone)::date as today, d.remind_days
    from public.important_dates d
    join public.profiles p on p.id = d.author_id
      or p.id in (select m.user_id from public.couple_members m where m.couple_id = d.couple_id)
    where not d.hidden and d.kind <> 'holiday' and (d.yearly or d.year >= extract(year from now())::int)
      and extract(hour from now() at time zone p.time_zone) = 10
  loop
    if (r.occ - r.today) = any (r.remind_days) then
      perform private.notify(r.target, 'date_coming', r.id, 'date:' || r.id || ':' || r.target || ':' || r.occ || ':' || (r.occ - r.today));
      v_n := v_n + 1;
    end if;
  end loop;
  -- holidays of the countries the person follows, 7 and 1 days before, unless they hid that holiday
  for r in
    select p.id as target, h.slug, private.next_occurrence(h.month, h.day, (now() at time zone p.time_zone)::date) as occ,
           (now() at time zone p.time_zone)::date as today
    from public.profiles p
    join public.user_settings s on s.user_id = p.id
    join public.content_items h on h.kind = 'holiday' and h.published and h.locale = s.locale and h.country = any (s.holiday_countries)
    where extract(hour from now() at time zone p.time_zone) = 10 and h.month is not null and h.day is not null
      and not exists (select 1 from public.important_dates d where d.author_id = p.id and d.holiday_key = h.slug and d.hidden)
  loop
    if (r.occ - r.today) in (7, 1) then
      perform private.notify(r.target, 'date_coming', null, 'holiday:' || r.slug || ':' || r.target || ':' || r.occ || ':' || (r.occ - r.today));
      v_n := v_n + 1;
    end if;
  end loop;
  -- rituals with a reminder, at their hour (weekly ones on their weekday, monthly ones on their creation day)
  for r in
    select rt.id, p.id as target, (now() at time zone p.time_zone)::date as today
    from public.rituals rt
    join public.profiles p on p.id = rt.author_id
      or p.id in (select m.user_id from public.couple_members m where m.couple_id = rt.couple_id)
    where rt.reminder and rt.archived_at is null
      and extract(hour from now() at time zone p.time_zone) = extract(hour from coalesce(rt.at_time, time '19:00'))
      and (rt.cadence in ('daily', 'monthly') or rt.weekday is null or rt.weekday = extract(dow from now() at time zone p.time_zone))
      and (rt.cadence <> 'monthly' or extract(day from now() at time zone p.time_zone) = extract(day from rt.created_at at time zone p.time_zone))
  loop
    perform private.notify(r.target, 'ritual', r.id, 'ritual:' || r.id || ':' || r.target || ':' || r.today);
    v_n := v_n + 1;
  end loop;
  -- one small idea at noon, or a gentle return after a quiet week (at most once a week, never a guilt trip)
  for r in
    select p.id as target, (now() at time zone p.time_zone)::date as today,
           (select max(sl.created_at) from public.slips sl where sl.author_id = p.id) as last_slip
    from public.profiles p join public.user_settings s on s.user_id = p.id
    where extract(hour from now() at time zone p.time_zone) = 12 and s.onboarded_at is not null
  loop
    if r.last_slip is not null and r.last_slip < now() - interval '5 days' then
      perform private.notify(r.target, 'gentle_return', null, 'gentle_return:' || r.target || ':' || to_char(r.today, 'IYYY-IW'));
    else
      perform private.notify(r.target, 'daily_idea', null, 'daily_idea:' || r.target || ':' || r.today);
    end if;
    v_n := v_n + 1;
  end loop;
  return v_n;
end $$;

-- Opens the capsules whose date arrived in the author's time zone and tells the people who can now read them.
create function private.open_due_capsules() returns integer
language plpgsql volatile as $$
declare c public.capsules; v_n integer := 0;
begin
  for c in
    update public.capsules k set opened_at = now()
    where k.opened_at is null and k.opens_on <= private.local_date(k.author_id)
    returning k.*
  loop
    perform private.notify(c.author_id, 'capsule_opened', c.id, 'capsule:' || c.id || ':' || c.author_id);
    perform private.notify(m.user_id, 'capsule_opened', c.id, 'capsule:' || c.id || ':' || m.user_id)
    from public.couple_members m where m.couple_id = c.couple_id and m.user_id <> c.author_id;
    v_n := v_n + 1;
  end loop;
  return v_n;
end $$;

-- Erases the accounts whose 14 days are over.
create function private.purge_deleted_accounts() returns integer
language plpgsql volatile as $$
declare v_id uuid; v_n integer := 0;
begin
  for v_id in select user_id from public.deletion_requests where purge_after <= now() loop
    perform private.erase_account(v_id);
    v_n := v_n + 1;
  end loop;
  return v_n;
end $$;

-- Drops what has no further use: settled notifications and job history after 30 days, invite attempts after a day,
-- chat turns after a week.
create function private.prune_expired_rows() returns integer
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
  return v_n;
end $$;

-- Runs one scheduled job by name and records the run. Cron triggers call it through the `jobs` function.
create function private.run_job(job text) returns setof private.job_runs
language plpgsql volatile as $$
declare v_affected integer;
begin
  v_affected := case job
    when 'weekly_cards' then private.generate_weekly_cards()
    when 'reminders' then private.enqueue_reminders()
    when 'open_capsules' then private.open_due_capsules()
    when 'purge_accounts' then private.purge_deleted_accounts()
    when 'prune' then private.prune_expired_rows()
  end;
  if v_affected is null then
    raise exception 'UNKNOWN_JOB %', job;
  end if;
  return query insert into private.job_runs (job, affected) values (run_job.job, v_affected) returning *;
end $$;

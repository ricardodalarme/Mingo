create function private.next_occurrence(p_month smallint, p_day smallint, p_from date) returns date
language sql immutable as $$
  select min(d) from (
    select (make_date(y, p_month, 1)
            + (least(p_day, extract(day from (make_date(y, p_month, 1) + interval '1 month - 1 day'))::int) - 1))::date as d
    from generate_series(extract(year from p_from)::int, extract(year from p_from)::int + 1) y) c
  where d >= p_from;
$$;

-- Everything the Today screen needs about the person, one row per person. Counts only: nothing here compares partners.
create view public.today as
select p.id as user_id,
       l.local_date,
       l.week_start,
       m.couple_id,
       pm.user_id as partner_id,
       coalesce(pp.display_name, s.partner_name) as partner_name,
       s.together_since,
       (select c.id from public.cards c where c.author_id = p.id and c.week_start = l.week_start and c.kind = 'weekly') as card_id,
       (select count(*) from public.cards c
        where c.recipient_id = p.id and c.status = 'sent'
          and not exists (select 1 from public.card_opens o where o.card_id = c.id))::integer as unopened_cards,
       (select count(*) from public.slips sl
        where sl.author_id = p.id and (sl.created_at at time zone p.time_zone)::date >= l.week_start)::integer as slips_this_week,
       (select count(*) from public.slips sl where sl.author_id = p.id)::integer as slips_total,
       coalesce((select array_agg(distinct (sl.created_at at time zone p.time_zone)::date)
                 from public.slips sl
                 where sl.author_id = p.id and (sl.created_at at time zone p.time_zone)::date >= l.week_start), '{}') as slip_days,
       exists (select 1 from public.invites i
               where i.created_by = p.id and i.used_at is null and i.cancelled_at is null and i.expires_at > now()) as has_pending_invite,
       (select count(*) from public.signals g where g.recipient_id = p.id and g.seen_at is null)::integer as unseen_signals,
       nd.id as next_date_id,
       nd.next_on as next_date_on,
       exists (select 1 from public.deletion_requests d where d.user_id = p.id) as deletion_pending
from public.profiles p
join public.user_settings s on s.user_id = p.id
cross join lateral (select (now() at time zone p.time_zone)::date as local_date,
                           date_trunc('week', now() at time zone p.time_zone)::date as week_start) l
left join public.couple_members m on m.user_id = p.id
left join public.couple_members pm on pm.couple_id = m.couple_id and pm.user_id <> p.id
left join public.profiles pp on pp.id = pm.user_id
left join lateral (
  select d.id, private.next_occurrence(d.month, d.day, l.local_date) as next_on
  from public.important_dates d
  where not d.hidden and (d.author_id = p.id or d.couple_id = m.couple_id)
  order by 2 limit 1) nd on true;

-- The person's plan and what is left of each allowance. Every limit the server enforces is readable here, so the
-- app can explain a limit before a write is refused.
create view public.plus_states as
select p.id as user_id,
       private.has_plus(p.id) as has_plus,
       coalesce(not private.entitlement_is_live(e), true) and private.has_plus(p.id) as paid_by_partner,
       case when coalesce(private.entitlement_is_live(e), false) then p.id
            when private.has_plus(p.id) then private.partner_of(p.id)
            else e.user_id end as entitlement_user_id,
       greatest(0, private.config_int('free_slips_per_month', 15) - private.slips_this_month(p.id)) as slips_left_this_month,
       greatest(0, private.config_int('free_cards_per_month', 1) - private.cards_sent_this_month(p.id)) as cards_left_this_month,
       private.chat_messages_left(p.id) as chat_messages_left_today,
       private.invites_left(p.id) as invites_left_today,
       private.signals_left(p.id) as signals_left_today,
       private.partner_messages_left(p.id) as partner_messages_left_today,
       private.guest_links_left(p.id) as guest_links_left_today,
       private.support_requests_left(p.id) as support_requests_left_today
from public.profiles p
left join public.entitlements e on e.user_id = p.id;

-- Year in review: the person's own counts, never scores or comparisons.
create view public.year_recaps as
select p.id as user_id, y.year::integer as year,
  (select count(*) from public.slips where author_id = p.id and extract(year from created_at) = y.year)::integer as slips,
  (select count(*) from public.cards where author_id = p.id and status = 'sent' and extract(year from sent_at) = y.year)::integer as cards_sent,
  (select count(*) from public.cards where recipient_id = p.id and status = 'sent' and extract(year from sent_at) = y.year)::integer as cards_received,
  (select count(*) from public.memories where author_id = p.id and extract(year from happened_on) = y.year)::integer as memories,
  (select count(*) from public.memories where author_id = p.id and origin = 'first' and extract(year from happened_on) = y.year)::integer as firsts,
  (select count(*) from public.ritual_logs where author_id = p.id and not skipped and extract(year from done_on) = y.year)::integer as rituals_done
from public.profiles p
cross join lateral generate_series(extract(year from p.created_at)::integer, extract(year from now())::integer) as y (year);

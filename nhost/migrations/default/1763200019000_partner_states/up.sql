-- Read-only signals that do not expose the partner's content.
create table public.question_states (
  question_slug text primary key,
  partner_answered boolean not null
);

create table public.checkin_states (
  partner_completed boolean not null
);

create function public.partner_question_states("questionSlugs" jsonb, session json) returns setof public.question_states
language sql stable security definer set search_path = '' as $$
  with me as (select private.uid(session) as id, private.couple_of(private.uid(session)) as couple)
  select s.slug,
         exists (
           select 1 from public.question_answers a
           where a.couple_id = me.couple and a.question_slug = s.slug and a.author_id <> me.id
         )
  from me, jsonb_array_elements_text("questionSlugs") as s(slug)
  where me.couple is not null;
$$;

create function public.partner_checkin_state(session json) returns setof public.checkin_states
language sql stable security definer set search_path = '' as $$
  with me as (select private.uid(session) as id, private.couple_of(private.uid(session)) as couple)
  select exists (
    select 1 from public.checkins c
    where c.couple_id = me.couple
      and c.author_id <> me.id
      and c.completed
      and c.week_start = private.local_week_start(me.id)
  )
  from me
  where me.couple is not null;
$$;

-- Replaces the caller's muted types in one transaction, so two saves cannot interleave into a partial set.
create function public.set_notification_mutes(types jsonb, session json) returns setof public.notification_mutes
language plpgsql volatile security definer set search_path = '' as $$
declare v_uid uuid := private.uid(session);
begin
  delete from public.notification_mutes where user_id = v_uid;
  insert into public.notification_mutes (user_id, type)
  select v_uid, value from jsonb_array_elements_text(types) as value
  on conflict do nothing;
  return query select * from public.notification_mutes where user_id = v_uid;
end $$;

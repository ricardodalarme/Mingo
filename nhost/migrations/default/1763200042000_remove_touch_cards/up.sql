-- Touch cards and the couple switch that hid them are gone; the chat handles suggestions now.

delete from public.content_items where kind = 'touch_card';
delete from public.content_kind where value = 'touch_card';

create or replace function public.daily_content(kind text, session json) returns setof public.content_items
language sql stable as $$
  with me as (
    select s.locale, (now() at time zone 'UTC')::date as today, coalesce(private.couple_of(s.user_id), s.user_id) as seed
    from public.user_settings s where s.user_id = private.uid(session)),
  pool as (
    select c.id, row_number() over (order by c.position, c.slug) - 1 as n, count(*) over () as total
    from public.content_items c, me
    where c.kind = daily_content.kind and daily_content.kind in ('question', 'daily_idea', 'mission')
      and c.published and not c.plus_only and c.locale = me.locale)
  select c.* from pool p join public.content_items c on c.id = p.id, me
  where p.n = (((me.today - date '2026-01-01') + abs(hashtext(me.seed::text)) % 97) % p.total);
$$;

alter table public.couples drop column touch_topics_enabled;

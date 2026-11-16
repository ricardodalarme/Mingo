-- New limits model: slips and the weekly card are unlimited; Plus unlocks themes, more chat, more games, rituals and lists.

-- Slips are unlimited. The write trigger keeps its normalization only.
create or replace function private.before_slip_write() returns trigger
language plpgsql as $$
begin
  new.body := btrim(new.body);
  new.feeling := nullif(btrim(new.feeling), '');
  new.plan_note := nullif(btrim(new.plan_note), '');
  new.for_card := new.for_card and new.kind <> 'invisible' and new.polarity = 'liked';
  new.request := case when new.polarity = 'bothered' then nullif(btrim(new.request), '') end;
  if tg_op = 'INSERT' then
    new.created_at := least(coalesce(new.created_at, now()), now());
  else
    new.created_at := old.created_at;
  end if;
  return new;
end $$;

-- A card is sent whenever the author asks; only an empty or foreign card is refused.
create or replace function private.deliver_card(p_card_id uuid, p_user_id uuid) returns setof public.cards
language plpgsql volatile as $$
declare v_card public.cards;
begin
  select * into v_card from public.cards where id = p_card_id and author_id = p_user_id for update;
  if not found or v_card.status = 'sent'
     or not exists (select 1 from public.card_items where card_id = v_card.id) then
    return;
  end if;
  update public.card_items i set body = s.body, feeling = s.feeling
  from public.slips s where i.card_id = v_card.id and s.id = i.slip_id;
  return query
  update public.cards c
  set status = 'sent', sent_at = now(), recipient_id = private.partner_of(p_user_id), couple_id = private.couple_of(p_user_id)
  where c.id = v_card.id returning c.*;
end $$;

-- No tolerance after expiry. `grace` and `billing_issue` are decided by the store while it retries the payment, so they stay live.
create or replace function private.entitlement_is_live(e public.entitlements) returns boolean
language sql stable as $$
  select e.status in ('trialing', 'active', 'grace', 'billing_issue')
     and (e.expires_at is null or e.expires_at > now());
$$;

-- Launch configuration.
update public.app_config set value = '5' where key = 'chat_messages_per_day_free';
insert into public.app_config (key, value) values
  ('chat_messages_per_day_plus', '20'),
  ('free_games_per_week', '3'),
  ('free_rituals', '3'),
  ('free_lists', '3'),
  ('free_spice_cards_per_week', '3'),
  ('free_agreements', '3'),
  ('free_card_themes', 'paper'),
  ('min_app_version_ios', '1.0.0'),
  ('min_app_version_android', '1.0.0'),
  ('store_url_ios', ''),
  ('store_url_android', '')
on conflict (key) do nothing;
delete from public.app_config where key in ('free_slips_per_month', 'free_cards_per_month');

-- Plus allowances are counted per week of the person's own time zone.
create function private.games_this_week(p_user_id uuid) returns integer
language sql stable as $$
  select count(*)::integer from public.game_sessions g
  where g.couple_id = private.couple_of(p_user_id)
    and (g.created_at at time zone (select time_zone from public.profiles where id = p_user_id))::date >= private.local_week_start(p_user_id);
$$;

create function private.free_left(p_user_id uuid, p_limit_key text, p_fallback integer, p_used integer) returns integer
language sql stable as $$
  select case when private.has_plus(p_user_id) then null
              else greatest(0, private.config_int(p_limit_key, p_fallback) - p_used) end;
$$;

-- Active rituals and lists the person authored; archived rituals do not count.
create function private.rituals_used(p_user_id uuid) returns integer
language sql stable as $$
  select count(*)::integer from public.rituals where author_id = p_user_id and archived_at is null;
$$;
create function private.lists_used(p_user_id uuid) returns integer
language sql stable as $$
  select count(*)::integer from public.lists where author_id = p_user_id;
$$;

-- Replaced when the Tempero tables exist.
create function private.spice_cards_this_week(p_user_id uuid) returns integer
language sql stable as $$ select 0; $$;

drop view public.plus_states;
drop function private.slips_this_month(uuid);
drop function private.cards_sent_this_month(uuid);

-- The person's plan and what is left of each allowance; a null "left" means unlimited. Every limit the server enforces
-- is readable here, so the app can explain a limit before a write is refused.
create view public.plus_states as
select p.id as user_id,
       private.has_plus(p.id) as has_plus,
       coalesce(not private.entitlement_is_live(e), true) and private.has_plus(p.id) as paid_by_partner,
       case when coalesce(private.entitlement_is_live(e), false) then p.id
            when private.has_plus(p.id) then private.partner_of(p.id)
            else e.user_id end as entitlement_user_id,
       private.chat_messages_left(p.id) as chat_messages_left_today,
       private.config_int(case when private.has_plus(p.id) then 'chat_messages_per_day_plus' else 'chat_messages_per_day_free' end, 0)
         as chat_messages_limit,
       private.invites_left(p.id) as invites_left_today,
       private.signals_left(p.id) as signals_left_today,
       private.partner_messages_left(p.id) as partner_messages_left_today,
       private.guest_links_left(p.id) as guest_links_left_today,
       private.support_requests_left(p.id) as support_requests_left_today,
       private.free_left(p.id, 'free_games_per_week', 3, private.games_this_week(p.id)) as games_left_this_week,
       private.free_left(p.id, 'free_rituals', 3, private.rituals_used(p.id)) as rituals_left,
       private.free_left(p.id, 'free_lists', 3, private.lists_used(p.id)) as lists_left,
       private.free_left(p.id, 'free_spice_cards_per_week', 3, private.spice_cards_this_week(p.id)) as spice_cards_left_this_week,
       coalesce(private.entitlement_is_live(e), false) and coalesce(private.entitlement_is_live(pe), false) as both_paid,
       case when coalesce(not private.entitlement_is_live(e), true) and private.has_plus(p.id)
            then (select pr.display_name from public.profiles pr where pr.id = private.partner_of(p.id)) end as covered_by_name,
       (select oe.store from public.entitlements oe
        where oe.user_id = case when coalesce(private.entitlement_is_live(e), false) then p.id else private.partner_of(p.id) end
          and private.entitlement_is_live(oe)) as owner_store,
       coalesce(e.status = 'billing_issue', false) as billing_issue
from public.profiles p
left join public.entitlements e on e.user_id = p.id
left join public.entitlements pe on pe.user_id = private.partner_of(p.id);

-- Free users get a bounded number of new games, rituals and lists. Existing rows are never locked.
create function private.before_game_session_limit() returns trigger
language plpgsql as $$
begin
  if not private.has_plus(new.invited_by)
     and private.games_this_week(new.invited_by) >= private.config_int('free_games_per_week', 3) then
    perform private.reject('FREE_LIMIT_REACHED');
  end if;
  return new;
end $$;
-- Runs after `game_sessions_before_insert` has set the couple (triggers fire in name order).
create trigger game_sessions_before_insert_limit before insert on public.game_sessions
  for each row execute function private.before_game_session_limit();

create function private.before_ritual_limit() returns trigger
language plpgsql as $$
begin
  if not private.has_plus(new.author_id) and private.rituals_used(new.author_id) >= private.config_int('free_rituals', 3) then
    perform private.reject('FREE_LIMIT_REACHED');
  end if;
  return new;
end $$;
create trigger rituals_before_insert_limit before insert on public.rituals
  for each row execute function private.before_ritual_limit();

create function private.before_list_limit() returns trigger
language plpgsql as $$
begin
  if not private.has_plus(new.author_id) and private.lists_used(new.author_id) >= private.config_int('free_lists', 3) then
    perform private.reject('FREE_LIMIT_REACHED');
  end if;
  return new;
end $$;
create trigger lists_before_insert_limit before insert on public.lists
  for each row execute function private.before_list_limit();

-- Card themes: changing to a theme outside the free list needs Plus.
create function private.before_card_theme_change() returns trigger
language plpgsql as $$
begin
  if new.card_theme is distinct from old.card_theme
     and not (new.card_theme = any (string_to_array(coalesce((select value from public.app_config where key = 'free_card_themes'), 'paper'), ',')))
     and not private.has_plus(new.user_id) then
    perform private.reject('PLUS_REQUIRED');
  end if;
  return new;
end $$;
create trigger user_settings_card_theme before update of card_theme on public.user_settings
  for each row execute function private.before_card_theme_change();

-- Plus-only content keeps its title and loses its body for a person without Plus, so the app can show the lock.
-- Tempero kinds are returned only while both people switched the mode on.
create function private.spice_on(p_user_id uuid) returns boolean
language sql stable as $$
  select coalesce((select spice_enabled from public.user_settings where user_id = p_user_id), false)
     and private.couple_of(p_user_id) is not null
     and coalesce((select spice_enabled from public.user_settings where user_id = private.partner_of(p_user_id)), false);
$$;

-- A result table of its own: the permissions of content_items would filter the plus-only rows out of the function result.
create table public.catalog_items (
  id uuid primary key,
  kind text not null,
  slug text not null,
  locale text not null,
  title text not null,
  body text,
  parent_slug text,
  position integer not null,
  tags text[] not null,
  month smallint,
  day smallint,
  country text,
  plus_only boolean not null,
  sensitive boolean not null,
  locked boolean not null
);

create function public.content_catalog(session json, kind text default null, locale text default null)
returns setof public.catalog_items language sql stable as $$
  select c.id, c.kind, c.slug, c.locale, c.title,
         case when c.plus_only and not private.has_plus(private.uid(session)) then null else c.body end,
         c.parent_slug, c.position, c.tags, c.month, c.day, c.country, c.plus_only, c.sensitive,
         c.plus_only and not private.has_plus(private.uid(session))
  from public.content_items c
  where c.published
    and (content_catalog.kind is null or c.kind = content_catalog.kind)
    and (content_catalog.locale is null or c.locale = content_catalog.locale)
    and (c.kind not in ('spice_card') or private.spice_on(private.uid(session)))
  order by c.kind, c.position, c.slug;
$$;

-- Games: Plus-only items are served to Plus people only.
create or replace function public.next_game_items(game text, session json, count integer DEFAULT 5)
returns setof public.content_items language plpgsql as $$
declare
  v_uid uuid := private.uid(session);
  v_couple uuid := private.couple_of(v_uid);
  v_locale text := (select locale from public.user_settings where user_id = v_uid);
  v_count integer := least(greatest(coalesce(count, 5), 1), 50);
  v_plus boolean := private.has_plus(v_uid);
  v_slugs text[];
begin
  select array_agg(p.slug) into v_slugs
  from (select c.slug
        from public.content_items c
        left join public.game_seen_items s on s.couple_id = v_couple and s.game = next_game_items.game and s.item_slug = c.slug
        where c.kind = next_game_items.game and c.locale = v_locale and c.published and (v_plus or not c.plus_only)
        order by s.seen_at nulls first, c.position, c.slug
        limit v_count) p;
  if v_slugs is null then return; end if;
  if v_couple is not null then
    insert into public.game_seen_items as g (couple_id, game, item_slug)
    select v_couple, next_game_items.game, u.slug from unnest(v_slugs) as u (slug)
    on conflict on constraint game_seen_items_pkey do update set seen_at = now();
  end if;
  return query
  select c.* from public.content_items c
  join unnest(v_slugs) with ordinality as u (slug, ord) on u.slug = c.slug
  where c.kind = next_game_items.game and c.locale = v_locale
  order by u.ord;
end $$;

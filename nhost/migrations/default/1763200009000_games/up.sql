-- Games: one invites, the other joins, answers stay private until the game is finished. No score, no winner.
create table public.game_sessions (
  id uuid primary key default gen_random_uuid(),
  couple_id uuid not null references public.couples (id) on delete cascade,
  game text not null references public.game_kind (value),
  invited_by uuid not null references public.profiles (id) on delete cascade,
  status text not null default 'invited' references public.game_status (value),
  item_slugs text[] not null default '{}' check (cardinality(item_slugs) <= 50),
  outcome text references public.game_outcome (value),
  -- Null once the game is finished or cancelled, so unique allows one open game per game kind.
  open_key text generated always as (case when status in ('invited', 'active') then game end) stored,
  created_at timestamptz not null default now(),
  finished_at timestamptz,
  constraint game_sessions_one_open unique (couple_id, open_key)
);
create index game_sessions_couple_idx on public.game_sessions (couple_id, created_at desc);
create index game_sessions_invited_by_idx on public.game_sessions (invited_by);

create function private.before_game_session_insert() returns trigger
language plpgsql as $$
begin
  new.couple_id := private.couple_of(new.invited_by);
  if new.couple_id is null then perform private.reject('NOT_PAIRED'); end if;
  new.status := 'invited'; new.outcome := null; new.finished_at := null; new.created_at := now();
  return new;
end $$;
create trigger game_sessions_before_insert before insert on public.game_sessions
  for each row execute function private.before_game_session_insert();

create function private.after_game_session_insert() returns trigger
language plpgsql as $$
begin
  perform private.notify(private.partner_of(new.invited_by), 'game_invite', new.id, 'game_invite:' || new.id);
  return new;
end $$;
create trigger game_sessions_after_insert after insert on public.game_sessions
  for each row execute function private.after_game_session_insert();

create table public.game_answers (
  id uuid primary key default gen_random_uuid(),
  session_id uuid not null references public.game_sessions (id) on delete cascade,
  author_id uuid not null references public.profiles (id) on delete cascade,
  idx smallint not null check (idx between 0 and 50),
  answer text not null check (char_length(answer) between 1 and 500),
  created_at timestamptz not null default now(),
  constraint game_answers_once unique (session_id, author_id, idx)
);
create index game_answers_author_idx on public.game_answers (author_id);

-- An item is locked once both partners answered it, so nobody changes an answer after seeing that the other is done.
create function private.before_game_answer_write() returns trigger
language plpgsql as $$
declare v_session public.game_sessions;
begin
  select * into v_session from public.game_sessions where id = new.session_id for update;
  if v_session.status <> 'active' then perform private.reject('GAME_NOT_ACTIVE'); end if;
  if new.idx >= coalesce(array_length(v_session.item_slugs, 1), 0) then perform private.reject('INVALID_GAME_INDEX'); end if;
  if (select count(*) from public.game_answers a where a.session_id = new.session_id and a.idx = new.idx) >= 2 then
    perform private.reject('ANSWER_LOCKED');
  end if;
  return new;
end $$;
create trigger game_answers_before_write before insert or update on public.game_answers
  for each row execute function private.before_game_answer_write();

-- Joins, cancels or finishes a game of the caller's couple. Finishing needs both partners to have answered every
-- item. No row when the action does not apply to the game's current state.
create function public.update_game("sessionId" uuid, action text, session json, outcome text default null)
returns setof public.game_sessions language plpgsql volatile as $$
declare v_uid uuid := private.uid(session); g public.game_sessions; v_items integer;
begin
  select * into g from public.game_sessions s
  where s.id = "sessionId" and s.couple_id = private.couple_of(v_uid) for update;
  if not found then return; end if;
  if action = 'join' and g.status = 'invited' and g.invited_by <> v_uid then
    return query update public.game_sessions s set status = 'active' where s.id = g.id returning s.*;
  elsif action = 'cancel' and g.status in ('invited', 'active') then
    return query update public.game_sessions s set status = 'cancelled' where s.id = g.id returning s.*;
  elsif action = 'finish' and g.status = 'active' then
    v_items := coalesce(array_length(g.item_slugs, 1), 0);
    if (select count(*) from public.game_answers a where a.session_id = g.id) < v_items * 2 then
      return;
    end if;
    return query update public.game_sessions s
      set status = 'finished', finished_at = now(), outcome = update_game.outcome
      where s.id = g.id returning s.*;
  end if;
end $$;

-- Which items a couple has already been served, so a replay starts with new ones.
create table public.game_seen_items (
  couple_id uuid not null references public.couples (id) on delete cascade,
  game text not null references public.game_kind (value),
  item_slug text not null check (char_length(item_slug) between 1 and 80),
  seen_at timestamptz not null default now(),
  primary key (couple_id, game, item_slug)
);

-- The next items of a game for the caller's couple: unseen ones first, then the least recently seen, so a replay
-- starts over instead of running out. Every item returned is recorded as seen. A person without a couple gets the
-- first items and nothing is recorded.
create function public.next_game_items(game text, session json, count integer default 5)
returns setof public.content_items language plpgsql volatile as $$
declare
  v_uid uuid := private.uid(session);
  v_couple uuid := private.couple_of(v_uid);
  v_locale text := (select locale from public.user_settings where user_id = v_uid);
  v_count integer := least(greatest(coalesce(count, 5), 1), 50);
  v_slugs text[];
begin
  select array_agg(p.slug) into v_slugs
  from (select c.slug
        from public.content_items c
        left join public.game_seen_items s on s.couple_id = v_couple and s.game = next_game_items.game and s.item_slug = c.slug
        where c.kind = next_game_items.game and c.locale = v_locale and c.published and not c.plus_only
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

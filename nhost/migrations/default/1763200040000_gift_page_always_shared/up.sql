-- The gift page holds wishes for the partner: a wish is visible to the current partner with no choice, and a date
-- gift idea stays private to its author. The page also stores where to buy the wish.

alter table public.gift_ideas
  drop column couple_id,
  drop column budget,
  add column link text check (link is null or char_length(link) <= 500);

drop index if exists public.gift_ideas_couple_idx;

create or replace function private.shared_tables() returns text[]
language sql immutable as $$
  select array['rituals', 'logistic_items', 'saved_date_ideas', 'important_dates', 'memories', 'story_events',
    'capsules', 'lists', 'agreements'];
$$;

-- Wishes are always visible to the partner, so they are not in `shared_tables`, but ending the couple still offers to
-- delete what the partner could see.
create or replace function public.resolve_shared_items(keep boolean, session json) returns setof public.profiles
language plpgsql volatile as $$
declare v_uid uuid := private.uid(session); t text;
begin
  if private.couple_of(v_uid) is not null then return; end if;
  foreach t in array private.shared_tables() loop
    if keep then
      execute format('update public.%I set couple_id = null where author_id = $1 and couple_id is not null', t) using v_uid;
    else
      execute format('delete from public.%I where author_id = $1 and couple_id is not null', t) using v_uid;
    end if;
  end loop;
  if not keep then
    delete from public.gift_ideas where author_id = v_uid and kind = 'wish';
  end if;
  return query select p.* from public.profiles p where p.id = v_uid;
end $$;

drop table public.gift_budget;

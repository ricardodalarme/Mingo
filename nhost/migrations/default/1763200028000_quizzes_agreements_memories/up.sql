-- Quizzes the person chooses to show, agreements and logistics the other confirms, and memories the partner accepts.

-- WP-12 ---------------------------------------------------------------------------------------------------------------
alter table public.quiz_results add column shared_at timestamptz;

-- A new ranking is private again until the person shows it. The time of sharing is always the server's.
create function private.before_quiz_result_update() returns trigger
language plpgsql as $$
begin
  if new.ranked is distinct from old.ranked then
    new.shared_at := null;
  elsif new.shared_at is distinct from old.shared_at and new.shared_at is not null then
    new.shared_at := now();
  end if;
  return new;
end $$;
create trigger quiz_results_before_update before update of ranked, shared_at on public.quiz_results
  for each row execute function private.before_quiz_result_update();

create function private.after_quiz_result_shared() returns trigger
language plpgsql as $$
begin
  if old.shared_at is null and new.shared_at is not null then
    perform private.notify(private.partner_of(new.author_id), 'quiz_shared', new.id,
                           'quiz_shared:' || new.id || ':' || new.shared_at);
  end if;
  return null;
end $$;
create trigger quiz_results_after_shared after update of shared_at on public.quiz_results
  for each row execute function private.after_quiz_result_shared();

-- WP-13 ---------------------------------------------------------------------------------------------------------------
-- A short text one person proposes; it counts as an agreement once the other confirms. Alone it is a private note.
create table public.agreements (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references public.profiles (id) on delete cascade,
  couple_id uuid references public.couples (id) on delete set null,
  body text not null check (char_length(btrim(body)) between 1 and 200),
  confirmed_by uuid references public.profiles (id) on delete set null,
  confirmed_at timestamptz,
  archived_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index agreements_author_idx on public.agreements (author_id, created_at desc);
create index agreements_couple_idx on public.agreements (couple_id);
create trigger agreements_set_updated_at before update on public.agreements
  for each row execute function private.set_updated_at();

-- Changing the wording, or moving it out of the couple, takes the confirmation back.
create function private.before_agreement_write() returns trigger
language plpgsql as $$
begin
  new.body := btrim(new.body);
  if tg_op = 'INSERT' then
    new.confirmed_by := null; new.confirmed_at := null;
    if not private.has_plus(new.author_id)
       and (select count(*) from public.agreements a where a.author_id = new.author_id and a.archived_at is null)
           >= private.config_int('free_agreements', 3) then
      perform private.reject('FREE_LIMIT_REACHED');
    end if;
  elsif new.body is distinct from old.body or new.couple_id is distinct from old.couple_id then
    new.confirmed_by := null; new.confirmed_at := null;
  end if;
  return new;
end $$;
create trigger agreements_before_write before insert or update on public.agreements
  for each row execute function private.before_agreement_write();

create function public.confirm_agreement("agreementId" uuid, session json) returns setof public.agreements
language plpgsql volatile as $$
declare v_uid uuid := private.uid(session);
begin
  return query
  update public.agreements a set confirmed_by = v_uid, confirmed_at = now()
  where a.id = "agreementId" and a.author_id <> v_uid and a.archived_at is null
    and a.couple_id is not null and a.couple_id = private.couple_of(v_uid)
  returning a.*;
end $$;

-- Logistics items follow the same pattern: only the other person confirms.
alter table public.logistic_items
  add column confirmed_by uuid references public.profiles (id) on delete set null,
  add column confirmed_at timestamptz;

create function private.before_logistic_item_write() returns trigger
language plpgsql as $$
begin
  if tg_op = 'INSERT' then
    new.confirmed_by := null; new.confirmed_at := null;
  elsif new.title is distinct from old.title or new.couple_id is distinct from old.couple_id then
    new.confirmed_by := null; new.confirmed_at := null;
  end if;
  return new;
end $$;
create trigger logistic_items_before_write before insert or update on public.logistic_items
  for each row execute function private.before_logistic_item_write();

create function public.confirm_logistic_item("itemId" uuid, session json) returns setof public.logistic_items
language plpgsql volatile as $$
declare v_uid uuid := private.uid(session);
begin
  return query
  update public.logistic_items i set confirmed_by = v_uid, confirmed_at = now()
  where i.id = "itemId" and i.author_id <> v_uid and i.couple_id is not null and i.couple_id = private.couple_of(v_uid)
  returning i.*;
end $$;

create or replace function private.shared_tables() returns text[]
language sql immutable as $$
  select array['rituals', 'logistic_items', 'saved_date_ideas', 'important_dates', 'memories', 'story_events',
    'capsules', 'lists', 'gift_ideas', 'agreements'];
$$;

-- WP-14 ---------------------------------------------------------------------------------------------------------------
alter table public.memories add column accepted_at timestamptz, add column declined_at timestamptz;
update public.memories set accepted_at = created_at where couple_id is not null;

-- Sharing a memory proposes it; making it private again withdraws the proposal and any answer.
create function private.before_memory_share() returns trigger
language plpgsql as $$
begin
  if new.couple_id is null then
    new.accepted_at := null; new.declined_at := null;
  elsif tg_op = 'INSERT' or old.couple_id is distinct from new.couple_id then
    new.accepted_at := null; new.declined_at := null;
  end if;
  return new;
end $$;
create trigger memories_before_share before insert or update of couple_id on public.memories
  for each row execute function private.before_memory_share();

create function private.after_memory_proposed() returns trigger
language plpgsql as $$
begin
  if new.couple_id is not null and new.accepted_at is null
     and (tg_op = 'INSERT' or old.couple_id is distinct from new.couple_id) then
    perform private.notify(private.partner_of(new.author_id), 'memory_proposed', new.id, 'memory_proposed:' || new.id);
  end if;
  return null;
end $$;
create trigger memories_after_proposed after insert or update of couple_id on public.memories
  for each row execute function private.after_memory_proposed();

-- The partner of the author accepts the proposal, or declines it and the memory goes back to being private.
create function public.respond_memory("memoryId" uuid, accept boolean, session json) returns setof public.memories
language plpgsql volatile as $$
declare v_uid uuid := private.uid(session); m public.memories;
begin
  select * into m from public.memories x
  where x.id = "memoryId" and x.author_id <> v_uid and x.couple_id is not null and x.couple_id = private.couple_of(v_uid)
    and x.accepted_at is null for update;
  if not found then return; end if;
  if accept then
    perform private.notify(m.author_id, 'memory_accepted', m.id, 'memory_accepted:' || m.id);
    return query update public.memories x set accepted_at = now() where x.id = m.id returning x.*;
  else
    update public.memories x set couple_id = null where x.id = m.id;
    perform private.notify(m.author_id, 'memory_declined', m.id, 'memory_declined:' || m.id);
    return query update public.memories x set declined_at = now() where x.id = m.id returning x.*;
  end if;
end $$;

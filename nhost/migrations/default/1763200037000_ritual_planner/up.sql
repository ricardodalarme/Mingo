-- Who plans a ritual: one of the two people in the couple, or nobody in particular.
alter table public.rituals add column planner_id uuid references public.profiles (id) on delete set null;

create function private.before_ritual_planner_write() returns trigger
language plpgsql as $$
begin
  if new.planner_id is not null and (new.couple_id is null or not exists (
       select 1 from public.couple_members m where m.couple_id = new.couple_id and m.user_id = new.planner_id)) then
    perform private.reject('INVALID_PLANNER');
  end if;
  return new;
end $$;
create trigger rituals_planner_write before insert or update of planner_id, couple_id on public.rituals
  for each row execute function private.before_ritual_planner_write();

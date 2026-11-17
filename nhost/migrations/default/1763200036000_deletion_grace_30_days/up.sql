-- A person asking to delete the account has 30 days to change their mind.
create or replace function private.before_deletion_request_insert() returns trigger
language plpgsql as $$
declare v_couple uuid := private.couple_of(new.user_id);
begin
  new.requested_at := now();
  new.purge_after := now() + interval '30 days';
  if v_couple is not null then
    perform private.end_couple(v_couple, new.user_id);
  end if;
  return new;
end $$;

alter table public.deletion_requests alter column purge_after set default now() + interval '30 days';

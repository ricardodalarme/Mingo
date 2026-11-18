-- Adult declaration, the avatar colour and illustration, and the relationship start date.

-- WP-03: consent to being an adult, needed before Spice can be switched on. `consents` is append-only; the newest row wins.
insert into public.consent_kind (value) values ('adult') on conflict do nothing;

create function private.consent_granted(p_user_id uuid, p_kind text) returns boolean
language sql stable as $$
  select coalesce((select c.granted from public.consents c
                   where c.user_id = p_user_id and c.kind = p_kind
                   order by c.created_at desc, c.id limit 1), false);
$$;

-- The newest answer per consent kind for each person.
create view public.current_consents as
select distinct on (c.user_id, c.kind) c.user_id, c.kind, c.granted, c.version, c.created_at
from public.consents c
order by c.user_id, c.kind, c.created_at desc, c.id;

create function private.before_spice_enable() returns trigger
language plpgsql as $$
begin
  if new.spice_enabled and not old.spice_enabled and not private.consent_granted(new.user_id, 'adult') then
    perform private.reject('ADULT_REQUIRED');
  end if;
  return new;
end $$;
create trigger user_settings_spice_enable before update of spice_enabled on public.user_settings
  for each row execute function private.before_spice_enable();

-- WP-04: the avatar is a photo, an illustration or the initials; the backend validates length only.
alter table public.profiles
  add column avatar_color text check (avatar_color is null or char_length(avatar_color) <= 24),
  add column avatar_illustration text check (avatar_illustration is null or char_length(avatar_illustration) <= 40);

-- A stale file cannot stay behind a non-photo avatar, and a photo avatar needs an image file.
create function private.before_avatar_write() returns trigger
language plpgsql as $$
begin
  if new.avatar_kind <> 'photo' then
    new.avatar_file_id := null;
  elsif new.avatar_file_id is null then
    perform private.reject('AVATAR_FILE_REQUIRED');
  elsif not exists (select 1 from storage.files f
                    where f.id = new.avatar_file_id and f.mime_type in ('image/jpeg', 'image/png', 'image/webp')) then
    -- Storage fills the type after the upload, so the type is checked where the file becomes an avatar.
    perform private.reject('INVALID_MEDIA');
  end if;
  return new;
end $$;
create trigger profiles_before_avatar_write before insert or update of avatar_kind, avatar_file_id on public.profiles
  for each row execute function private.before_avatar_write();

-- WP-05: children are a separate fact from the relationship phase.
alter table public.user_settings add column has_kids boolean not null default false;

-- The date the couple counts from, set by either person after they see both dates (see start_date_state).
alter table public.couples
  add column start_date date,
  add column start_date_set_by uuid references public.profiles (id) on delete set null;

-- Result of start_date_state: the only partner fact it exposes is the partner's own start date.
create table public.start_dates (
  mine date,
  partner date,
  couple date,
  matches boolean not null
);

create function public.start_date_state(session json) returns setof public.start_dates
language sql stable security definer set search_path = '' as $$
  select s.together_since, ps.together_since, c.start_date, s.together_since is not distinct from ps.together_since
  from public.user_settings s
  join public.couple_members m on m.user_id = s.user_id
  join public.couples c on c.id = m.couple_id and c.ended_at is null
  join public.couple_members pm on pm.couple_id = m.couple_id and pm.user_id <> s.user_id
  join public.user_settings ps on ps.user_id = pm.user_id
  where s.user_id = private.uid(session);
$$;

create function public.set_couple_start_date(date date, session json) returns setof public.couples
language plpgsql volatile as $$
declare v_uid uuid := private.uid(session); v_couple uuid := private.couple_of(v_uid);
begin
  if v_couple is null then return; end if;
  if set_couple_start_date.date is null or set_couple_start_date.date > private.local_date(v_uid) then
    perform private.reject('INVALID_DATE');
  end if;
  return query
  update public.couples c set start_date = set_couple_start_date.date, start_date_set_by = v_uid
  where c.id = v_couple returning c.*;
end $$;

-- Switching to initials clears the file inside the before trigger; a column-list trigger would not see that change.
drop trigger profiles_file_cleanup on public.profiles;
create trigger profiles_file_cleanup after delete or update on public.profiles
  for each row execute function private.queue_file_deletion('avatar_file_id');

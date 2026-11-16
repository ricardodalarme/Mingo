-- How a person is addressed in the app's sentences, and what they chose to do about a partner at the start.
select private.create_enum('pronoun', 'she', 'he', 'name_only');
select private.create_enum('partner_intent', 'invite', 'later', 'solo_only');

-- `profiles.pronouns` was free text; keep what maps to a choice and treat any other non-empty text as the name only.
alter table public.profiles drop constraint profiles_pronouns_check;
update public.profiles
set pronouns = case
  when btrim(pronouns) = '' then null
  when lower(pronouns) ~ '\mela\M' or lower(pronouns) ~ '\mshe\M' then 'she'
  when lower(pronouns) ~ '\mele\M' or lower(pronouns) ~ '\mhe\M' then 'he'
  else 'name_only'
end
where pronouns is not null;
alter table public.profiles add constraint profiles_pronouns_fkey foreign key (pronouns) references public.pronoun (value);

-- The partner's pronouns are the writer's own choice until the partner joins and chooses theirs.
alter table public.user_settings
  add column partner_pronouns text references public.pronoun (value),
  add column partner_intent text references public.partner_intent (value);

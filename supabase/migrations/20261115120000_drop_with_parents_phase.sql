-- "Living with parents" is gone from the product; keep the phase set to the eight that remain.
-- Existing rows move to long distance, which is the closest neutral option; there is no production data.

update public.profile_settings set phase = 'long_distance' where phase = 'with_parents';

alter type public.relationship_phase rename to relationship_phase_old;
create type public.relationship_phase as enum (
  'beginning', 'dating', 'living_together', 'married', 'with_kids', 'long_distance', 'engaged', 'restarting'
);
alter table public.profile_settings
  alter column phase type public.relationship_phase using phase::text::public.relationship_phase;
drop type public.relationship_phase_old;

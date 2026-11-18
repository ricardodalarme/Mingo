-- Closed value sets that were plain text with a check become enum tables, so GraphQL exposes each as an enum.

-- How the recipient answered a gentle request.
select private.create_enum('gentle_response', 'will_do', 'later', 'not_now', 'talk', 'more_time');
alter table public.gentle_requests drop constraint gentle_requests_response_check;
alter table public.gentle_requests
  add constraint gentle_requests_response_fkey foreign key (response) references public.gentle_response (value);

-- Why a card was held back instead of sent.
select private.create_enum('held_reason', 'absolute', 'insult', 'blame', 'contempt');
alter table public.cards drop constraint cards_held_reason_check;
alter table public.cards
  add constraint cards_held_reason_fkey foreign key (held_reason) references public.held_reason (value);

-- Where Spice stands for a person: off, only they are on, only the partner is on, or both.
select private.create_enum('spice_stage', 'off', 'waiting_partner', 'partner_wants', 'on');
alter table public.spice_states
  add constraint spice_states_state_fkey foreign key (state) references public.spice_stage (value);

-- Relationship goals had two vocabularies: a main goal with three values and a list of six. A list cannot be a GraphQL enum
-- column, so the goals become rows of one enum table, and the main goal folds into them.
insert into public.relationship_goal (value)
values ('fight_less'), ('keep_romance'), ('remember_dates'), ('organize_routine'), ('just_record');

create table public.user_goals (
  user_id uuid not null references public.user_settings (user_id) on delete cascade,
  goal text not null references public.relationship_goal (value),
  primary key (user_id, goal)
);

insert into public.user_goals (user_id, goal)
select s.user_id, g from public.user_settings s, unnest(s.goals) as g
on conflict do nothing;

insert into public.user_goals (user_id, goal)
select s.user_id, case s.goal when 'after_fight' then 'fight_less' when 'keep' then 'keep_romance' else s.goal end
from public.user_settings s
where s.goal is not null
on conflict do nothing;

alter table public.user_settings drop column goals, drop column goal;
delete from public.relationship_goal where value in ('keep', 'after_fight');

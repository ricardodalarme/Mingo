-- Games: row level security, grants and policies.

alter table public.game_sessions enable row level security;
alter table public.game_answers enable row level security;
alter table public.game_seen_items enable row level security;
grant select on public.game_sessions, public.game_answers, public.game_seen_items to authenticated;
create policy game_sessions_select_couple on public.game_sessions for select to authenticated
  using (couple_id = (select private.current_couple_id()));
create policy game_answers_select_own_or_finished on public.game_answers for select to authenticated
  using (author_id = (select auth.uid())
         or exists (select 1 from public.game_sessions g
                    where g.id = session_id and g.status = 'finished'
                      and g.couple_id = (select private.current_couple_id())));
-- No write grant: next_game_items records what it served, always for the caller's own couple.
create policy game_seen_items_select_couple on public.game_seen_items for select to authenticated
  using (couple_id = (select private.current_couple_id()));

-- Slips: row level security, grants and policies.

-- Invariant: a slip belongs to its author and is never shared as a row. A `bothered` slip is private by definition,
-- so the restrictive policy keeps it author-only even if another policy later exposes slips to the partner.
alter table public.slips enable row level security;
grant select on public.slips to authenticated;
create policy slips_select_author on public.slips for select to authenticated
  using (author_id = (select auth.uid()));
create policy slips_bothered_author_only on public.slips as restrictive for select to authenticated
  using (polarity = 'liked' or author_id = (select auth.uid()));

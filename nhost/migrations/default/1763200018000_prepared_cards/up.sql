-- Prepared cards also carry the slip category and written time the draft screen shows.
create or replace function public.prepare_card(session json) returns setof public.prepared_cards
language plpgsql volatile as $$
declare v_card uuid := private.build_card_draft(private.uid(session));
begin
  return query
  select c.id, c.kind, c.status, c.week_start, c.note,
    coalesce((select jsonb_agg(jsonb_build_object(
                  'id', i.id, 'body', i.body, 'feeling', i.feeling, 'position', i.position,
                  'category', s.category, 'writtenAt', s.created_at) order by i.position)
              from public.card_items i left join public.slips s on s.id = i.slip_id
              where i.card_id = c.id), '[]'::jsonb)
  from public.cards c where c.id = v_card;
end $$;

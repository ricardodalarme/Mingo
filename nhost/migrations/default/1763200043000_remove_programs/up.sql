-- The guided programs and their lessons are gone; the diary keeps only the journal.

delete from public.content_items where kind in ('program', 'lesson');
delete from public.content_kind where value in ('program', 'lesson');

drop table public.program_enrollments;
drop table public.lesson_progress;
drop table public.lesson_status;

create or replace function private.export_user_data(p_user_id uuid) returns jsonb
language plpgsql stable as $$
declare v_out jsonb; v jsonb; t record;
begin
  v_out := jsonb_build_object('exportedAt', now(), 'format', 1,
    'profile', (select to_jsonb(p) from public.profiles p where p.id = p_user_id));
  for t in select * from (values
      ('settings', 'user_settings', 'user_id'), ('consents', 'consents', 'user_id'),
      ('notification_settings', 'notification_settings', 'user_id'), ('notification_mutes', 'notification_mutes', 'user_id'),
      ('slips', 'slips', 'author_id'), ('annoyances', 'annoyances', 'author_id'),
      ('cards_authored', 'cards', 'author_id'), ('moods', 'moods', 'author_id'),
      ('temperature_checks', 'temperature_checks', 'author_id'), ('repair_sessions', 'repair_sessions', 'author_id'),
      ('repair_learnings', 'repair_learnings', 'author_id'), ('journal_entries', 'journal_entries', 'author_id'),
      ('partner_facts', 'partner_facts', 'author_id'),
      ('manual_entries', 'manual_entries', 'author_id'), ('learned_items', 'learned_items', 'author_id'),
      ('quiz_results', 'quiz_results', 'author_id'), ('memories_authored', 'memories', 'author_id'),
      ('story_events_authored', 'story_events', 'author_id'), ('important_dates_authored', 'important_dates', 'author_id'),
      ('rituals_authored', 'rituals', 'author_id'), ('ritual_logs', 'ritual_logs', 'author_id'),
      ('logistic_items_authored', 'logistic_items', 'author_id'), ('saved_date_ideas', 'saved_date_ideas', 'author_id'),
      ('lists_authored', 'lists', 'author_id'), ('gift_ideas_authored', 'gift_ideas', 'author_id'),
      ('capsules_authored', 'capsules', 'author_id'), ('question_answers', 'question_answers', 'author_id'),
      ('checkins', 'checkins', 'author_id'), ('game_answers', 'game_answers', 'author_id'),
      ('spice_desire_answers', 'spice_desire_answers', 'user_id'), ('agreements_authored', 'agreements', 'author_id')
    ) as x (key, tbl, col)
  loop
    execute format('select coalesce(jsonb_agg(to_jsonb(r)), ''[]''::jsonb) from public.%I r where r.%I = $1', t.tbl, t.col) into v using p_user_id;
    v_out := v_out || jsonb_build_object(t.key, v);
  end loop;

  v_out := v_out || jsonb_build_object(
    'card_items', (select coalesce(jsonb_agg(to_jsonb(i)), '[]') from public.card_items i join public.cards c on c.id = i.card_id where c.author_id = p_user_id),
    'card_reactions_made', (select coalesce(jsonb_agg(jsonb_build_object('card_id', r.card_id, 'reaction', r.reaction, 'reply', r.reply, 'reacted_at', r.reacted_at)), '[]')
      from public.card_reactions r join public.cards c on c.id = r.card_id where c.recipient_id = p_user_id and not r.from_guest),
    'list_items', (select coalesce(jsonb_agg(to_jsonb(i)), '[]') from public.list_items i join public.lists l on l.id = i.list_id where l.author_id = p_user_id),
    'gentle_requests_sent', (select coalesce(jsonb_agg(jsonb_build_object('id', g.id, 'when_text', g.when_text, 'feel_text', g.feel_text,
      'wish_text', g.wish_text, 'created_at', g.created_at)), '[]') from public.gentle_requests g where g.sender_id = p_user_id),
    'signals_sent', (select coalesce(jsonb_agg(jsonb_build_object('id', s.id, 'kind', s.kind, 'value', s.value, 'body', s.body,
      'created_at', s.created_at)), '[]') from public.signals s where s.sender_id = p_user_id),
    'partner_messages_sent', (select coalesce(jsonb_agg(jsonb_build_object('id', m.id, 'kind', m.kind, 'body', m.body,
      'duration_ms', m.duration_ms, 'created_at', m.created_at)), '[]') from public.partner_messages m where m.sender_id = p_user_id),
    'files', (select coalesce(jsonb_agg(jsonb_build_object('id', f.id, 'name', f.name, 'bucket', f.bucket_id, 'size', f.size,
      'mime_type', f.mime_type, 'created_at', f.created_at)), '[]') from storage.files f
      where f.uploaded_by_user_id = p_user_id and f.bucket_id <> 'exports'));
  return v_out;
end $$;

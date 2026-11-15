-- Launch configuration the app reads before sign-in. Every limit the server enforces is readable here.
insert into public.app_config (key, value) values
  ('free_slips_per_month', '15'),
  ('free_cards_per_month', '1'),
  ('chat_messages_per_day_free', '0'),
  ('chat_messages_per_day_plus', '20'),
  ('min_app_version', '1.0.0'),
  ('trial_days', '7')
on conflict (key) do nothing;

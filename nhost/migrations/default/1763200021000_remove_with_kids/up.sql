-- The phase list no longer offers a with-children status; whoever had it picks another phase.
update public.user_settings set phase = null where phase = 'with_kids';
delete from public.relationship_phase where value = 'with_kids';

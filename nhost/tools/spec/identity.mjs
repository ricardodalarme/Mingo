// Identity and pairing: profiles, settings, the couple, invites and the start date.
import { ME, mine, and, or, isNull, meOrPartner, ownFile, resultTable } from './_shared.mjs';

export const tables = {
  profiles: {
    object: {
      settings: { table: 'user_settings', column: 'user_id' },
      membership: { table: 'couple_members', column: 'user_id' },
      sharedMood: { table: 'shared_moods', column: 'user_id' },
      avatarFile: 'avatar_file_id',
    },
    roles: {
      user: {
        select: { columns: '*', filter: or(mine('id'), meOrPartner) },
        update: {
          columns: ['display_name', 'pronouns', 'city', 'avatar_kind', 'avatar_file_id', 'avatar_color', 'avatar_illustration', 'time_zone'],
          filter: mine('id'),
          check: ownFile('avatar_file_id', 'avatarFile'),
        },
      },
    },
  },
  user_settings: {
    object: { profile: 'user_id' },
    array: { goals: { table: 'user_goals', column: 'user_id' } },
    roles: {
      user: {
        select: { columns: '*', filter: mine('user_id') },
        update: {
          columns: ['theme', 'locale', 'phase', 'relationship_status', 'partner_name', 'partner_pronouns', 'partner_intent', 'together_since', 'onboarded_at',
            'share_read_receipts', 'holiday_countries', 'card_channel', 'card_theme', 'slips_default_for_card',
            'spice_enabled', 'low_stimulation',
            'chat_store_facts', 'has_kids', 'spice_max_level', 'spice_notifications'],
          filter: mine('user_id'),
        },
      },
    },
  },
  user_goals: {
    roles: {
      user: {
        select: { columns: '*', filter: mine('user_id') },
        insert: { columns: ['goal'], set: { user_id: ME } },
        delete: { filter: mine('user_id') },
      },
    },
  },
  couples: {
    object: { photo: { table: 'couple_photos', column: 'couple_id' } },
    array: { members: { table: 'couple_members', column: 'couple_id' } },
    roles: {
      user: {
        select: { columns: '*', filter: { members: { user_id: { _eq: ME } } } },
        // Either person can switch touch topics off for both.
        update: { columns: ['touch_topics_enabled'], filter: { members: { user_id: { _eq: ME } } } },
      },
    },
  },
  couple_members: {
    object: { couple: 'couple_id', profile: 'user_id' },
    roles: { user: { select: { columns: '*', filter: { couple: { members: { user_id: { _eq: ME } } } } } } },
  },
  invites: {
    roles: {
      user: {
        select: { columns: '*', filter: mine('created_by') },
        insert: { columns: [], check: { _not: { creator: { membership: {} } } }, set: { created_by: ME } },
        update: { columns: ['cancelled_at'], filter: and(mine('created_by'), isNull('used_at')) },
      },
    },
    object: { creator: 'created_by' },
  },
  invite_previews: resultTable(['public', 'user']),
  invite_statuses: resultTable(['public', 'user']),
  invite_accept_results: resultTable(['user']),

  start_dates: resultTable(['user']),
};

export const functions = {
  accept_invite: { session: true, roles: ['user'] },
  try_accept_invite: { session: true, roles: ['user'] },
  invite_status: { roles: ['public', 'user'] },
  invite_preview: { roles: ['public', 'user'] },
  unpair: { session: true, roles: ['user'] },
  start_date_state: { session: true, roles: ['user'] },
  set_couple_start_date: { session: true, roles: ['user'] },
  resolve_shared_items: { session: true, roles: ['user'] },
};

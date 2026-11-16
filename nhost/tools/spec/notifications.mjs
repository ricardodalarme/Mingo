// Devices, sessions, notification settings and the inbox.
import { ME, mine, and, resultTable } from './_shared.mjs';

export const tables = {
  devices: {
    roles: {
      user: {
        select: { columns: ['id', 'user_id', 'token', 'platform', 'label', 'refresh_token_id', 'created_at', 'last_seen_at'], filter: mine('user_id') },
        insert: { columns: ['token', 'platform', 'label', 'refresh_token_id'], set: { user_id: ME } },
        update: { columns: ['platform', 'label', 'refresh_token_id'], filter: mine('user_id') },
        delete: { filter: mine('user_id') },
      },
    },
  },
  session_rows: resultTable(['user']),
  notification_settings: {
    roles: {
      user: {
        select: { columns: '*', filter: mine('user_id') },
        update: { columns: ['enabled', 'card_day', 'card_hour', 'daily_max'], filter: mine('user_id') },
      },
    },
  },
  notification_mutes: {
    roles: {
      user: {
        select: { columns: '*', filter: mine('user_id') },
        insert: { columns: ['type'], set: { user_id: ME } },
        delete: { filter: mine('user_id') },
      },
    },
  },
  inbox_items: {
    roles: {
      user: {
        select: { columns: '*', filter: mine('user_id'), aggregate: true },
        update: { columns: ['read_at'], filter: mine('user_id') },
        delete: { filter: mine('user_id') },
      },
    },
  },
  'private.notifications': {
    name: 'pushNotifications',
    eventTriggers: [
      {
        name: 'push_notification',
        definition: { enable_manual: true, insert: { columns: '*' } },
        // Six tries over half an hour; after that the row stays unsettled and is pruned after 30 days.
        retry_conf: { interval_sec: 300, num_retries: 5, timeout_sec: 30 },
        webhook: '{{NHOST_FUNCTIONS_URL}}/events/push',
        headers: [{ name: 'nhost-webhook-secret', value_from_env: 'NHOST_WEBHOOK_SECRET' }],
      },
    ],
  },
};

export const functions = {
  'private.claim_notification': {},
  'private.complete_notification': {},
  set_notification_mutes: { session: true, roles: ['user'] },
  my_sessions: { session: true, roles: ['user'] },
  revoke_session: { session: true, roles: ['user'] },
};

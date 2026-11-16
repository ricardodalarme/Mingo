// Consents, account deletion and support.
import { ME, mine } from './_shared.mjs';

export const tables = {
  consents: {
    roles: {
      user: {
        select: { columns: '*', filter: mine('user_id') },
        insert: { columns: ['kind', 'granted', 'version'], set: { user_id: ME } },
      },
    },
  },
  // The newest answer per kind, so the app reads its consents without a function.
  current_consents: { roles: { user: { select: { columns: '*', filter: mine('user_id') } } } },
  deletion_requests: {
    roles: {
      user: {
        select: { columns: '*', filter: mine('user_id') },
        insert: { columns: [], set: { user_id: ME } },
        delete: { filter: mine('user_id') },
      },
    },
  },
  // The person reads what they wrote; support reads everything with the admin role.
  support_requests: {
    roles: {
      user: {
        select: { columns: ['id', 'topic', 'message', 'reply_email', 'app_version', 'created_at'], filter: mine('user_id') },
        insert: { columns: ['topic', 'message', 'reply_email', 'app_version'], set: { user_id: ME } },
      },
    },
  },

};

export const functions = {

};

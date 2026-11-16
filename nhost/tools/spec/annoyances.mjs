// Private annoyances and gentle requests.
import { mine, or, ownerOnly } from './_shared.mjs';

export const tables = {
  annoyances: ownerOnly({ insert: ['body'], update: ['body'] }),
  gentle_requests: {
    object: { sender: 'sender_id', recipient: 'recipient_id' },
    roles: {
      user: {
        select: { columns: '*', filter: or(mine('sender_id'), mine('recipient_id')) },
        // The recipient answers; the request itself is created by `sendGentleRequest` after the confirmation.
        update: { columns: ['response', 'seen_at'], filter: mine('recipient_id') },
      },
    },
  },

};

export const functions = {
  send_gentle_request: { session: true, roles: ['user'] },
  thank_gentle_request: { session: true, roles: ['user'] },
};

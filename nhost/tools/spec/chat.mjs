// The mascot chat.
import { mine, ownerOnly } from './_shared.mjs';

export const tables = {
  chat_turns: { roles: { user: { select: { columns: ['id', 'created_at'], filter: mine('user_id') } } } },
  learned_items: ownerOnly({ insert: ['target', 'text', 'excerpt'], update: ['text', 'status'] }),

};

export const functions = {
  take_chat_turn: { session: true, roles: ['user'] },
};

// Games.
import { ME, mine, and, or, inMyCouple, coupleMembers } from './_shared.mjs';

export const tables = {
  game_sessions: {
    object: { inviter: 'invited_by' },
    array: { coupleMembers, answers: { table: 'game_answers', column: 'session_id' } },
    roles: {
      user: {
        select: { columns: '*', filter: inMyCouple },
        insert: { columns: ['id', 'game', 'item_slugs'], set: { invited_by: ME } },
      },
    },
  },
  game_answers: {
    object: { session: 'session_id', author: 'author_id' },
    roles: {
      user: {
        // Answers stay private until the game is finished.
        select: { columns: '*', filter: or(mine(), { session: and({ status: { _eq: 'finished' } }, inMyCouple) }) },
        insert: {
          columns: ['id', 'session_id', 'idx', 'answer'],
          check: { session: and({ status: { _eq: 'active' } }, inMyCouple) },
          set: { author_id: ME },
        },
        update: { columns: ['answer'], filter: mine() },
      },
    },
  },
  game_seen_items: {},

};

export const functions = {
  next_game_items: { session: true, roles: ['user'] },
  update_game: { session: true, roles: ['user'] },
};

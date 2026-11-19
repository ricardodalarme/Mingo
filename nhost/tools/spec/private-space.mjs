// The private space: what only the author reads.
import { ME, mine, and, or, meOrPartner, ownerOnly } from './_shared.mjs';

export const tables = {
  temperature_checks: ownerOnly({ insert: ['level', 'note'] }),
  repair_sessions: ownerOnly({ insert: ['intensity', 'path', 'step', 'feeling_after', 'draft', 'completed_at'] }),
  repair_learnings: ownerOnly({
    insert: ['repair_session_id', 'kind', 'note'],
    update: ['kind', 'note'],
    object: { repairSession: 'repair_session_id' },
  }),
  journal_entries: ownerOnly({ insert: ['entry_date', 'body', 'mood'] }),
  moods: ownerOnly({ insert: ['day', 'mood', 'need', 'share'], update: ['mood', 'need', 'share'] }),
  shared_moods: {
    object: { profile: 'user_id' },
    roles: { user: { select: { columns: '*', filter: { profile: meOrPartner } } } },
  },
  partner_facts: ownerOnly({ insert: ['label', 'value', 'category', 'source'] }),
  manual_entries: {
    object: { author: 'author_id' },
    roles: {
      user: {
        select: { columns: '*', filter: or(mine(), and({ shared: { _eq: true } }, { author: meOrPartner })) },
        insert: { columns: ['id', 'key', 'value', 'shared'], set: { author_id: ME } },
        update: { columns: ['key', 'value', 'shared'], filter: mine() },
        delete: { filter: mine() },
      },
    },
  },
  quiz_results: {
    object: { author: 'author_id' },
    roles: {
      user: {
        // The partner sees the result only after the person chose to show it, never the answers behind it.
        select: { columns: '*', filter: or(mine(), and({ shared_at: { _is_null: false } }, { author: meOrPartner })), aggregate: true },
        insert: { columns: ['id', 'quiz_key', 'ranked'], set: { author_id: ME } },
        update: { columns: ['ranked', 'shared_at'], filter: mine() },
        delete: { filter: mine() },
      },
    },
  },

};

export const functions = {

};

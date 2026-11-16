// Tempero: the adult mode that exists only while both people switched it on.
import { ME, mine, and, inMyCouple, coupleMembers, spiceAllowed, resultTable } from './_shared.mjs';

export const tables = {
  spice_states: resultTable(['user']),
  // Nothing here has a relationship from another table, so no query can reach it by joining. Answers are the person's
  // alone; the cards and the challenge are written only through functions.
  spice_desire_answers: {
    roles: {
      user: {
        select: { columns: '*', filter: mine('user_id') },
        insert: { columns: ['content_slug', 'answer'], set: { user_id: ME } },
        update: { columns: ['answer'], filter: mine('user_id') },
        delete: { filter: mine('user_id') },
      },
    },
  },
  spice_card_plays: {
    array: { coupleMembers },
    roles: { user: { select: { columns: '*', filter: and(inMyCouple, spiceAllowed) } } },
  },
  spice_challenges: {
    array: { coupleMembers },
    roles: { user: { select: { columns: '*', filter: and(inMyCouple, spiceAllowed) } } },
  },

};

export const functions = {
  spice_state: { session: true, roles: ['user'] },
  spice_next_card: { session: true, roles: ['user'] },
  spice_respond_card: { session: true, roles: ['user'] },
  spice_matches: { session: true, roles: ['user'] },
  spice_challenge: { session: true, roles: ['user'] },
  spice_challenge_act: { session: true, roles: ['user'] },
  spice_off: { session: true, roles: ['user'] },
};

// Between partners: photos, signals, messages and the weekly answers.
import { ME, mine, and, or, inMyCouple, ownFile, coupleMembers, resultTable } from './_shared.mjs';

export const tables = {
  couple_photos: {
    object: { couple: 'couple_id', file: 'file_id', uploader: 'uploaded_by' },
    array: { coupleMembers },
    roles: {
      user: {
        select: { columns: '*', filter: inMyCouple },
        insert: {
          columns: ['couple_id', 'file_id'],
          check: and(inMyCouple, { file: { uploaded_by_user_id: { _eq: ME } } }),
          set: { uploaded_by: ME },
        },
        update: {
          columns: ['file_id'],
          filter: inMyCouple,
          check: and(inMyCouple, { file: { uploaded_by_user_id: { _eq: ME } } }),
          set: { uploaded_by: ME },
        },
        delete: { filter: inMyCouple },
      },
    },
  },
  signals: {
    object: { sender: 'sender_id', recipient: 'recipient_id' },
    roles: {
      user: {
        select: { columns: '*', filter: or(mine('sender_id'), mine('recipient_id')) },
        insert: { columns: ['id', 'kind', 'value', 'body'], set: { sender_id: ME } },
        update: { columns: ['response', 'seen_at'], filter: mine('recipient_id') },
      },
    },
  },
  partner_messages: {
    object: { sender: 'sender_id', recipient: 'recipient_id', mediaFile: 'media_file_id' },
    roles: {
      user: {
        select: { columns: '*', filter: or(mine('sender_id'), mine('recipient_id')) },
        insert: {
          columns: ['id', 'kind', 'body', 'media_file_id', 'for_widget', 'duration_ms'],
          check: ownFile('media_file_id', 'mediaFile'),
          set: { sender_id: ME },
        },
        update: { columns: ['seen_at', 'hearted_at'], filter: mine('recipient_id') },
        // The sender can take a message back.
        delete: { filter: mine('sender_id') },
      },
    },
  },
  question_answers: {
    object: { author: 'author_id' },
    array: {
      coupleMembers,
      siblings: { manual: 'question_answers', on: { couple_id: 'couple_id', question_slug: 'question_slug' } },
    },
    roles: {
      user: {
        // The partner's answer shows up only after the caller answered the same question in the same couple.
        select: { columns: '*', filter: or(mine(), and(inMyCouple, { siblings: mine() })) },
        insert: { columns: ['id', 'question_slug', 'body'], set: { author_id: ME } },
        delete: { filter: mine() },
      },
    },
  },
  checkins: {
    object: { author: 'author_id' },
    array: { coupleMembers, siblings: { manual: 'checkins', on: { couple_id: 'couple_id', week_start: 'week_start' } } },
    roles: {
      user: {
        // The partner's check-in shows up only when both finished all four answers.
        select: {
          columns: '*',
          filter: or(mine(), and({ completed: { _eq: true } }, inMyCouple, { siblings: and(mine(), { completed: { _eq: true } }) })),
        },
        insert: { columns: ['id', 'answer_1', 'answer_2', 'answer_3', 'answer_4'], set: { author_id: ME } },
        update: { columns: ['answer_1', 'answer_2', 'answer_3', 'answer_4'], filter: mine() },
        delete: { filter: mine() },
      },
    },
  },

  question_states: resultTable(['user']),
  checkin_states: resultTable(['user']),

};

export const functions = {
  partner_question_states: { session: true, roles: ['user'] },
  partner_checkin_state: { session: true, roles: ['user'] },
};

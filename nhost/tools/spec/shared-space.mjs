// The shared space: rows the author can share with the couple.
import { ME, mine, and, or, isNull, inMyCouple, meOrPartner, ownFile, coupleMembers, visibleToCouple, sharedOrPrivate, sharedWithCouple } from './_shared.mjs';

export const tables = {
  rituals: sharedWithCouple({
    insert: ['title', 'cadence', 'weekday', 'at_time', 'reminder', 'planner_id'],
    update: ['title', 'cadence', 'weekday', 'at_time', 'reminder', 'planner_id', 'archived_at'],
    array: { logs: { table: 'ritual_logs', column: 'ritual_id' } },
  }),
  ritual_logs: {
    object: { ritual: 'ritual_id', author: 'author_id' },
    roles: {
      user: {
        select: { columns: '*', filter: { ritual: visibleToCouple } },
        insert: { columns: ['id', 'ritual_id', 'done_on', 'skipped'], check: { ritual: visibleToCouple }, set: { author_id: ME } },
        update: { columns: ['skipped'], filter: { ritual: visibleToCouple } },
        delete: { filter: { ritual: visibleToCouple } },
      },
    },
  },
  logistic_items: sharedWithCouple({
    insert: ['title', 'assignee_id', 'due_on', 'week_start', 'invisible_work', 'done_at'],
    object: { assignee: 'assignee_id' },
    // A task is assigned to nobody, to the caller or to the caller's partner.
    extraCheck: or(isNull('assignee_id'), { assignee: or(mine('id'), meOrPartner) }),
  }),
  saved_date_ideas: sharedWithCouple({
    insert: ['content_slug', 'title', 'notes', 'status', 'planned_for', 'place_name', 'place_address'],
  }),
  important_dates: sharedWithCouple({
    insert: ['title', 'kind', 'month', 'day', 'year', 'yearly', 'remind_days', 'hidden', 'origin', 'holiday_key'],
  }),
  memories: sharedWithCouple({
    insert: ['title', 'body', 'happened_on', 'date_precision', 'place', 'photo_file_id', 'origin', 'source_id'],
    update: ['title', 'body', 'happened_on', 'date_precision', 'place', 'photo_file_id'],
    object: { photoFile: 'photo_file_id' },
    extraCheck: ownFile('photo_file_id', 'photoFile'),
    partnerWrites: false,
  }),
  // The partner reads an agreement but confirms it through `confirmAgreement`.
  agreements: sharedWithCouple({ insert: ['body'], update: ['body', 'archived_at'], partnerWrites: false }),
  story_events: sharedWithCouple({ insert: ['kind', 'title', 'happened_on', 'date_precision'] }),
  capsules: {
    object: { author: 'author_id', couple: 'couple_id' },
    array: { coupleMembers },
    roles: {
      user: {
        // Sealed for the partner until the open date; nobody edits a sealed capsule.
        select: { columns: '*', filter: or(mine(), and(inMyCouple, { opened_at: { _is_null: false } })) },
        insert: { columns: ['id', 'couple_id', 'body', 'opens_on'], check: sharedOrPrivate, set: { author_id: ME } },
        delete: { filter: mine() },
      },
    },
  },
  lists: sharedWithCouple({ insert: ['title', 'kind'], array: { items: { table: 'list_items', column: 'list_id' } } }),
  list_items: {
    object: { list: 'list_id', author: 'author_id' },
    roles: {
      user: {
        select: { columns: '*', filter: { list: visibleToCouple } },
        insert: { columns: ['id', 'list_id', 'title', 'status', 'position'], check: { list: visibleToCouple }, set: { author_id: ME } },
        update: { columns: ['title', 'status', 'position'], filter: { list: visibleToCouple } },
        delete: { filter: { list: visibleToCouple } },
      },
    },
  },
  gift_ideas: {
    object: { author: 'author_id', occasion: 'occasion_date_id' },
    roles: {
      user: {
        select: {
          columns: '*',
          filter: or(mine(), and({ kind: { _eq: 'wish' } }, { author: meOrPartner })),
          aggregate: true,
        },
        insert: { columns: ['id', 'kind', 'title', 'note', 'occasion_date_id', 'status', 'link'], set: { author_id: ME } },
        update: { columns: ['title', 'note', 'occasion_date_id', 'status', 'link'], filter: mine() },
        delete: { filter: mine() },
      },
    },
  },

};

export const functions = {
  confirm_agreement: { session: true, roles: ['user'] },
  confirm_logistic_item: { session: true, roles: ['user'] },
  respond_memory: { session: true, roles: ['user'] },
};

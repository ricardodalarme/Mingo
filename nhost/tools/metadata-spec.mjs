// The GraphQL surface and the authorization model, in one place. `build-metadata.mjs` turns it into Hasura metadata.
//
// Roles: `user` is a signed-in person, `public` is anyone without a token. Nothing is granted unless it is listed here.
// Filters use database column names and the relationship names declared below.

const ME = 'X-Hasura-User-Id';
const mine = (column = 'author_id') => ({ [column]: { _eq: ME } });
const and = (...rules) => ({ _and: rules });
const or = (...rules) => ({ _or: rules });
const isNull = (column) => ({ [column]: { _is_null: true } });

// The row's couple has the caller as a current member. Membership rows exist only while the couple lasts, so an
// ex-partner fails this the moment the couple ends.
const inMyCouple = { coupleMembers: { user_id: { _eq: ME } } };
// The profile is the caller or the caller's current partner.
const meOrPartner = { membership: { couple: { members: { user_id: { _eq: ME } } } } };
// A file column may only point to a file the caller uploaded.
const ownFile = (column, relation) => or(isNull(column), { [relation]: { uploaded_by_user_id: { _eq: ME } } });

const coupleMembers = { manual: 'couple_members', on: { couple_id: 'couple_id' } };

export const enums = [
  'avatar_kind', 'card_channel', 'app_theme', 'relationship_goal', 'relationship_phase', 'relationship_status', 'member_role',
  'slip_kind', 'slip_category', 'slip_polarity', 'work_area', 'card_kind', 'card_status', 'device_platform', 'notification_type',
  'content_kind', 'entitlement_plan', 'entitlement_status', 'entitlement_store', 'consent_kind', 'support_topic',
  'learned_item_status', 'learned_item_target', 'signal_kind', 'signal_response', 'partner_message_kind', 'game_kind',
  'game_status', 'game_outcome', 'game_action', 'conversation_guide', 'mood', 'mood_need', 'mood_share', 'repair_feeling',
  'repair_learning_kind', 'repair_path', 'temperature_level', 'partner_fact_category', 'partner_fact_source', 'lesson_status',
  'quiz_key', 'ritual_cadence', 'date_idea_status', 'important_date_kind', 'important_date_origin', 'date_precision',
  'memory_origin', 'story_event_kind', 'list_kind', 'list_item_status', 'gift_idea_kind', 'gift_idea_status', 'gift_budget',
];

// Private to the author: full control, nobody else sees a row.
function ownerOnly({ insert, update, object, array }) {
  return {
    object: { author: 'author_id', ...object },
    array,
    roles: {
      user: {
        select: { columns: '*', filter: mine(), aggregate: true },
        insert: { columns: ['id', ...insert], set: { author_id: ME } },
        update: { columns: update ?? insert, filter: mine() },
        delete: { filter: mine() },
      },
    },
  };
}

const visibleToCouple = or(mine(), inMyCouple);
const sharedOrPrivate = or(isNull('couple_id'), inMyCouple);
const keptInScope = or(and(isNull('couple_id'), mine()), inMyCouple);

// Owned by the author; with `couple_id` set, the current partner reads and edits it too. A row can only be moved
// into the caller's own couple, or back to private by its author.
function sharedWithCouple({ insert, update, object, array, partnerWrites = true, extraCheck }) {
  const check = extraCheck ? and(sharedOrPrivate, extraCheck) : sharedOrPrivate;
  const scope = extraCheck ? and(keptInScope, extraCheck) : keptInScope;
  return {
    object: { author: 'author_id', couple: 'couple_id', ...object },
    array: { coupleMembers, ...array },
    roles: {
      user: {
        select: { columns: '*', filter: visibleToCouple, aggregate: true },
        insert: { columns: ['id', 'couple_id', ...insert], check, set: { author_id: ME } },
        update: partnerWrites
          ? { columns: ['couple_id', ...(update ?? insert)], filter: visibleToCouple, check: scope }
          : { columns: ['couple_id', ...(update ?? insert)], filter: mine(), check },
        delete: { filter: partnerWrites ? visibleToCouple : mine() },
      },
    },
  };
}

const cardVisible = or(mine(), and(mine('recipient_id'), { status: { _eq: 'sent' } }));
const myUnsentCard = and(mine(), { status: { _neq: 'sent' } });
const receivedCard = and(mine('recipient_id'), { status: { _eq: 'sent' } });
const eligibleSlip = and(mine(), { for_card: { _eq: true } }, { kind: { _neq: 'invisible' } }, { polarity: { _eq: 'liked' } }, isNull('archived_at'));

// Spice cards exist only for a couple where both switched the mode on.
const spiceAllowed = and(
  { _exists: { _table: { schema: 'public', name: 'couple_members' }, _where: { user_id: { _eq: ME } } } },
  {
    _not: {
      _exists: {
        _table: { schema: 'public', name: 'couple_members' },
        _where: and({ couple: { members: { user_id: { _eq: ME } } } }, { profile: { settings: { spice_enabled: { _eq: false } } } }),
      },
    },
  },
);

const resultTable = (roles) => ({ roles: Object.fromEntries(roles.map((r) => [r, { select: { columns: '*' } }])) });

export const tables = {
  // Identity -------------------------------------------------------------------------------------------------------
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
          columns: ['display_name', 'pronouns', 'city', 'avatar_kind', 'avatar_file_id', 'time_zone'],
          filter: mine('id'),
          check: ownFile('avatar_file_id', 'avatarFile'),
        },
      },
    },
  },
  user_settings: {
    object: { profile: 'user_id' },
    roles: {
      user: {
        select: { columns: '*', filter: mine('user_id') },
        update: {
          columns: ['theme', 'locale', 'goal', 'goals', 'phase', 'relationship_status', 'partner_name', 'together_since', 'onboarded_at',
            'share_read_receipts', 'holiday_countries', 'card_channel', 'card_theme', 'slips_default_for_card',
            'widget_allow_partner_notes', 'widget_on_lock_screen', 'widget_show_names', 'spice_enabled', 'low_stimulation',
            'chat_enabled', 'chat_store_facts'],
          filter: mine('user_id'),
        },
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

  // Slips and cards ------------------------------------------------------------------------------------------------
  slips: ownerOnly({
    insert: ['kind', 'polarity', 'body', 'feeling', 'plan_note', 'request', 'tags', 'category', 'work_area', 'for_card', 'in_jar',
      'photo_file_id', 'occurred_on', 'created_at'],
    update: ['kind', 'polarity', 'body', 'feeling', 'plan_note', 'request', 'tags', 'category', 'work_area', 'for_card', 'in_jar',
      'photo_file_id', 'occurred_on', 'archived_at'],
    object: { photoFile: 'photo_file_id' },
  }),
  cards: {
    object: {
      author: 'author_id',
      recipient: 'recipient_id',
      reaction: { table: 'card_reactions', column: 'card_id' },
      open: { table: 'card_opens', column: 'card_id' },
    },
    array: { items: { table: 'card_items', column: 'card_id' }, guestLinks: { table: 'guest_links', column: 'card_id' } },
    roles: {
      user: {
        select: { columns: '*', filter: cardVisible, aggregate: true },
        // The author edits the note and holds the card; sending goes through `sendCard`.
        update: { columns: ['note', 'status'], filter: myUnsentCard, check: { status: { _in: ['draft', 'held'] } } },
        delete: { filter: mine() },
      },
    },
  },
  card_items: {
    object: { card: 'card_id', slip: 'slip_id' },
    roles: {
      user: {
        select: { columns: '*', filter: { card: cardVisible } },
        insert: { columns: ['id', 'card_id', 'slip_id', 'position'], check: and({ card: myUnsentCard }, { slip: eligibleSlip }) },
        update: { columns: ['position'], filter: { card: myUnsentCard } },
        delete: { filter: { card: myUnsentCard } },
      },
    },
  },
  card_reactions: {
    object: { card: 'card_id' },
    roles: {
      user: {
        select: { columns: '*', filter: { card: cardVisible } },
        insert: { columns: ['card_id', 'reaction', 'reply'], check: { card: receivedCard }, set: { from_guest: 'false' } },
        update: { columns: ['reaction', 'reply'], filter: { card: receivedCard }, set: { from_guest: 'false' } },
      },
    },
  },
  card_opens: {
    object: { card: 'card_id' },
    roles: {
      user: {
        // The author learns that a card was opened only if the recipient shares read receipts.
        select: {
          columns: '*',
          filter: { card: or(receivedCard, and(mine(), { recipient: { settings: { share_read_receipts: { _eq: true } } } })) },
        },
        insert: { columns: ['card_id'], check: { card: receivedCard } },
      },
    },
  },

  // Guest links ----------------------------------------------------------------------------------------------------
  guest_links: {
    object: { card: 'card_id' },
    roles: {
      user: {
        select: { columns: ['id', 'card_id', 'expires_at', 'revoked_at', 'opened_at', 'created_at'], filter: { card: mine() } },
        insert: { columns: ['id', 'card_id', 'token_hash'], check: { card: and(mine(), { status: { _eq: 'sent' } }) } },
        delete: { filter: { card: mine() } },
      },
    },
  },
  guest_cards: resultTable(['public']),
  guest_results: resultTable(['public']),
  prepared_cards: resultTable(['user']),
  question_states: resultTable(['user']),
  checkin_states: resultTable(['user']),

  // Notifications --------------------------------------------------------------------------------------------------
  devices: {
    roles: {
      user: {
        select: { columns: ['id', 'user_id', 'token', 'platform', 'label', 'created_at', 'last_seen_at'], filter: mine('user_id') },
        insert: { columns: ['token', 'platform', 'label'], set: { user_id: ME } },
        update: { columns: ['platform', 'label'], filter: mine('user_id') },
        delete: { filter: mine('user_id') },
      },
    },
  },
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
  'private.file_deletions': {
    name: 'fileDeletions',
    eventTriggers: [
      {
        name: 'delete_file',
        definition: { enable_manual: true, insert: { columns: '*' } },
        // A file that still cannot be removed after six tries stays queued for the daily sweep.
        retry_conf: { interval_sec: 300, num_retries: 5, timeout_sec: 30 },
        webhook: '{{NHOST_FUNCTIONS_URL}}/events/delete-file',
        headers: [{ name: 'nhost-webhook-secret', value_from_env: 'NHOST_WEBHOOK_SECRET' }],
      },
    ],
  },
  'private.job_runs': { name: 'jobRuns' },

  // Content and plan -----------------------------------------------------------------------------------------------
  app_config: { roles: { public: { select: { columns: '*' } }, user: { select: { columns: '*' } } } },
  content_items: {
    roles: {
      user: {
        select: { columns: '*', filter: and({ published: { _eq: true } }, or({ kind: { _neq: 'spice_card' } }, spiceAllowed)) },
      },
    },
  },
  entitlements: {
    object: { profile: 'user_id' },
    // Plus covers both partners, so each can see the other's plan.
    roles: { user: { select: { columns: '*', filter: or(mine('user_id'), { profile: meOrPartner }) } } },
  },
  plus_states: {
    object: { entitlement: { manual: 'entitlements', on: { entitlement_user_id: 'user_id' } } },
    roles: { user: { select: { columns: '*', filter: mine('user_id') } } },
  },

  // Account --------------------------------------------------------------------------------------------------------
  consents: {
    roles: {
      user: {
        select: { columns: '*', filter: mine('user_id') },
        insert: { columns: ['kind', 'granted', 'version'], set: { user_id: ME } },
      },
    },
  },
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

  // Mascot chat ----------------------------------------------------------------------------------------------------
  chat_turns: { roles: { user: { select: { columns: ['id', 'created_at'], filter: mine('user_id') } } } },
  learned_items: ownerOnly({ insert: ['target', 'text', 'excerpt'], update: ['text', 'status'] }),

  // Between partners -----------------------------------------------------------------------------------------------
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
          columns: ['id', 'kind', 'body', 'media_file_id', 'for_widget'],
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

  // Games ----------------------------------------------------------------------------------------------------------
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

  // Private space --------------------------------------------------------------------------------------------------
  temperature_checks: ownerOnly({ insert: ['level', 'note'] }),
  repair_sessions: ownerOnly({ insert: ['intensity', 'path', 'step', 'feeling_after', 'draft', 'completed_at'] }),
  repair_learnings: ownerOnly({
    insert: ['repair_session_id', 'kind', 'note'],
    update: ['kind', 'note'],
    object: { repairSession: 'repair_session_id' },
  }),
  journal_entries: ownerOnly({ insert: ['entry_date', 'body', 'mood'] }),
  conversation_preps: ownerOnly({ insert: ['guide', 'topic', 'notes', 'draft'] }),
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
  program_enrollments: ownerOnly({ insert: ['program_slug', 'current_day', 'completed_at'], update: ['current_day', 'completed_at'] }),
  lesson_progress: ownerOnly({ insert: ['program_slug', 'lesson_day', 'status'], update: ['status'] }),
  quiz_results: ownerOnly({ insert: ['quiz_key', 'ranked'], update: ['ranked'] }),

  // Shared space ---------------------------------------------------------------------------------------------------
  rituals: sharedWithCouple({
    insert: ['title', 'cadence', 'weekday', 'at_time', 'reminder'],
    update: ['title', 'cadence', 'weekday', 'at_time', 'reminder', 'archived_at'],
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
  gift_ideas: sharedWithCouple({
    insert: ['kind', 'title', 'note', 'occasion_date_id', 'status', 'budget'],
    object: { occasion: 'occasion_date_id' },
    partnerWrites: false,
  }),

  // Home -----------------------------------------------------------------------------------------------------------
  today: {
    object: {
      card: { manual: 'cards', on: { card_id: 'id' } },
      nextDate: { manual: 'important_dates', on: { next_date_id: 'id' } },
      partner: { manual: 'profiles', on: { partner_id: 'id' } },
      plus: { manual: 'plus_states', on: { user_id: 'user_id' } },
    },
    roles: { user: { select: { columns: '*', filter: mine('user_id') } } },
  },
  year_recaps: { roles: { user: { select: { columns: '*', filter: mine('user_id') } } } },
};

// storage.files: a person reads what they uploaded and what a partner shared with them through a row that owns the file.
export const storageFiles = {
  object: { bucket: 'bucket_id' },
  array: {
    avatarOf: { table: 'profiles', column: 'avatar_file_id' },
    memories: { table: 'memories', column: 'photo_file_id' },
    partnerMessages: { table: 'partner_messages', column: 'media_file_id' },
    couplePhotos: { table: 'couple_photos', column: 'file_id' },
  },
  roles: {
    user: {
      select: {
        columns: '*',
        filter: or(
          mine('uploaded_by_user_id'),
          { avatarOf: meOrPartner },
          { memories: inMyCouple },
          { partnerMessages: mine('recipient_id') },
          { couplePhotos: inMyCouple },
        ),
      },
      insert: {
        columns: ['id', 'bucket_id', 'name', 'size', 'mime_type', 'metadata'],
        check: { bucket_id: { _in: ['avatars', 'slips', 'memories', 'messages', 'couple-photos'] } },
        set: { uploaded_by_user_id: ME },
      },
      delete: { filter: mine('uploaded_by_user_id') },
    },
  },
};

// Tracked SQL functions. `session: true` passes the caller's session; a function without roles is for the admin
// secret only (Functions and cron).
export const functions = {
  prepare_card: { session: true, roles: ['user'] },
  send_card: { session: true, roles: ['user'] },
  send_slip: { session: true, roles: ['user'] },
  accept_invite: { session: true, roles: ['user'] },
  unpair: { session: true, roles: ['user'] },
  resolve_shared_items: { session: true, roles: ['user'] },
  daily_content: { session: true, roles: ['user'] },
  next_game_items: { session: true, roles: ['user'] },
  update_game: { session: true, roles: ['user'] },
  take_chat_turn: { session: true, roles: ['user'] },
  invite_preview: { roles: ['public', 'user'] },
  guest_card: { roles: ['public'] },
  guest_open: { roles: ['public'] },
  guest_react: { roles: ['public'] },
  guest_stop: { roles: ['public'] },
  guest_resume: { roles: ['public'] },
  guest_forget: { roles: ['public'] },
  guest_report: { roles: ['public'] },
  'private.run_job': {},
  'private.claim_notification': {},
  'private.complete_notification': {},
  partner_question_states: { session: true, roles: ['user'] },
  partner_checkin_state: { session: true, roles: ['user'] },
  set_notification_mutes: { session: true, roles: ['user'] },
  'private.apply_purchase_event': {},
};

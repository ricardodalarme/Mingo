// Slips, weekly cards, reactions and guest links.
import { mine, and, or, ownerOnly, cardVisible, myUnsentCard, receivedCard, eligibleSlip, resultTable } from './_shared.mjs';

export const tables = {
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
        // The recipient can take a reaction back.
        delete: { filter: { card: receivedCard } },
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
};

export const functions = {
  prepare_card: { session: true, roles: ['user'] },
  send_card: { session: true, roles: ['user'] },
  send_slip: { session: true, roles: ['user'] },
  guest_card: { roles: ['public'] },
  guest_open: { roles: ['public'] },
  guest_react: { roles: ['public'] },
  guest_stop: { roles: ['public'] },
  guest_resume: { roles: ['public'] },
  guest_forget: { roles: ['public'] },
  guest_report: { roles: ['public'] },
};

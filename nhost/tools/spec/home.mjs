// Today, the yearly recap and the weekly review.
import { mine, resultTable } from './_shared.mjs';

export const tables = {
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
  weekly_reviews: resultTable(['user']),
};

export const functions = {
  weekly_review: { session: true, roles: ['user'] },
};

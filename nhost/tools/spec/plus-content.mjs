// Plan, limits, launch configuration and editorial content.
import { mine, and, or, meOrPartner, SPICE_KINDS, spiceAllowed, resultTable } from './_shared.mjs';

export const tables = {
  app_config: { roles: { public: { select: { columns: '*' } }, user: { select: { columns: '*' } } } },
  content_items: {
    roles: {
      user: {
        // Plus-only rows are read through `contentCatalog`, which hides their body from a person without Plus.
        select: {
          columns: '*',
          filter: and({ published: { _eq: true } }, { plus_only: { _eq: false } }, or({ kind: { _nin: SPICE_KINDS } }, spiceAllowed)),
        },
      },
    },
  },
  entitlements: {
    object: { profile: 'user_id' },
    // Plus covers both partners, so each can see the other's plan.
    roles: { user: { select: { columns: '*', filter: or(mine('user_id'), { profile: meOrPartner }) } } },
  },
  catalog_items: resultTable(['user']),
  plus_states: {
    object: { entitlement: { manual: 'entitlements', on: { entitlement_user_id: 'user_id' } } },
    roles: { user: { select: { columns: '*', filter: mine('user_id') } } },
  },

};

export const functions = {
  daily_content: { session: true, roles: ['user'] },
  content_catalog: { session: true, roles: ['user'] },
  'private.apply_purchase_event': {},
};

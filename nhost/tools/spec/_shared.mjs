// Building blocks of the authorization model: the caller, the couple filters and the table shapes the domains reuse.

export const ME = 'X-Hasura-User-Id';
export const mine = (column = 'author_id') => ({ [column]: { _eq: ME } });
export const and = (...rules) => ({ _and: rules });
export const or = (...rules) => ({ _or: rules });
export const isNull = (column) => ({ [column]: { _is_null: true } });

// The row's couple has the caller as a current member. Membership rows exist only while the couple lasts, so an
// ex-partner fails this the moment the couple ends.
export const inMyCouple = { coupleMembers: { user_id: { _eq: ME } } };
// The profile is the caller or the caller's current partner.
export const meOrPartner = { membership: { couple: { members: { user_id: { _eq: ME } } } } };
// A file column may only point to a file the caller uploaded.
export const ownFile = (column, relation) => or(isNull(column), { [relation]: { uploaded_by_user_id: { _eq: ME } } });

export const coupleMembers = { manual: 'couple_members', on: { couple_id: 'couple_id' } };


// Private to the author: full control, nobody else sees a row.
export function ownerOnly({ insert, update, object, array }) {
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

export const visibleToCouple = or(mine(), inMyCouple);
export const sharedOrPrivate = or(isNull('couple_id'), inMyCouple);
export const keptInScope = or(and(isNull('couple_id'), mine()), inMyCouple);

// Owned by the author; with `couple_id` set, the current partner reads and edits it too. A row can only be moved
// into the caller's own couple, or back to private by its author.
export function sharedWithCouple({ insert, update, object, array, partnerWrites = true, extraCheck }) {
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

export const cardVisible = or(mine(), and(mine('recipient_id'), { status: { _eq: 'sent' } }));
export const myUnsentCard = and(mine(), { status: { _neq: 'sent' } });
export const receivedCard = and(mine('recipient_id'), { status: { _eq: 'sent' } });
export const eligibleSlip = and(mine(), { for_card: { _eq: true } }, { kind: { _neq: 'invisible' } }, isNull('archived_at'));

export const SPICE_KINDS = ['spice_card', 'spice_desire', 'spice_challenge'];

// Spice cards exist only for a couple where both switched the mode on.
export const spiceAllowed = and(
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

export const resultTable = (roles) => ({ roles: Object.fromEntries(roles.map((r) => [r, { select: { columns: '*' } }])) });

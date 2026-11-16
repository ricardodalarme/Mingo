// The GraphQL surface and the authorization model. `build-metadata.mjs` turns it into Hasura metadata.
//
// Roles: `user` is a signed-in person, `public` is anyone without a token. Nothing is granted unless it is listed here.
// Filters use database column names and the relationship names declared in the same table entry.
// Each domain lives in `spec/<domain>.mjs` with its tables and its tracked SQL functions; shared building blocks are in `spec/_shared.mjs`.
export { enums } from './spec/enums.mjs';
export { storageFiles } from './spec/storage.mjs';
import * as identity from './spec/identity.mjs';
import * as slips_cards from './spec/slips-cards.mjs';
import * as annoyances from './spec/annoyances.mjs';
import * as notifications from './spec/notifications.mjs';
import * as system from './spec/system.mjs';
import * as plus_content from './spec/plus-content.mjs';
import * as account from './spec/account.mjs';
import * as chat from './spec/chat.mjs';
import * as tempero from './spec/tempero.mjs';
import * as partner from './spec/partner.mjs';
import * as games from './spec/games.mjs';
import * as private_space from './spec/private-space.mjs';
import * as shared_space from './spec/shared-space.mjs';
import * as home from './spec/home.mjs';

const domains = [identity, slips_cards, annoyances, notifications, system, plus_content, account, chat, tempero, partner, games, private_space, shared_space, home];

export const tables = Object.assign({}, ...domains.map((d) => d.tables));

// Tracked SQL functions. `session: true` passes the caller's session; a function without roles is for the admin
// secret only (Functions and cron).
export const functions = Object.assign({}, ...domains.map((d) => d.functions));

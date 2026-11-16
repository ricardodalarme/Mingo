import { test } from 'node:test';
import { adminSecret, assert, gql, ok, sql, urls } from '../lib.ts';
// @ts-expect-error the spec is plain JavaScript, which Node runs as is.
import { enums, functions as functionSpec, tables as tableSpec } from '../../tools/metadata-spec.mjs';

const qualify = (name: string) => (name.includes('.') ? name : `public.${name}`);

const publicQueries = new Set([
  'appConfig', 'appConfigByPk', 'guestCard', 'guestCards', 'guestCardsByPk', 'guestResults', 'guestResultsByPk',
  'invitePreview', 'invitePreviews', 'invitePreviewsByPk', 'inviteStatus', 'inviteStatuses',
]);
const publicMutations = new Set(['guestOpen', 'guestReact', 'guestStop', 'guestResume', 'guestForget', 'guestReport']);

/** The metadata the engine is actually serving, as exported by its metadata API. */
async function liveMetadata(): Promise<any> {
  const res = await fetch(`${urls.hasura}/v1/metadata`, {
    method: 'POST',
    headers: { 'x-hasura-admin-secret': adminSecret, 'content-type': 'application/json' },
    body: JSON.stringify({ type: 'export_metadata', args: {} }),
  });
  const body = (await res.json()) as any;
  assert.ok(res.ok, JSON.stringify(body));
  return body.sources.find((source: any) => source.name === 'default');
}

async function roots(role: 'public' | 'user') {
  const { __schema } = await ok(role, `{ __schema { queryType { fields { name } } mutationType { fields { name } } } }`);
  return {
    queries: new Set<string>(__schema.queryType.fields.map((f: any) => f.name)),
    mutations: new Set<string>(__schema.mutationType.fields.map((f: any) => f.name)),
  };
}

test('the anonymous role reaches the app config, the guest pages and nothing else', async () => {
  const { queries, mutations } = await roots('public');
  for (const field of publicQueries) assert.ok(queries.has(field), `public lost ${field}`);
  for (const field of publicQueries) {
    const expected = field.startsWith('guest') || field.startsWith('invitePreview') ? field : field;
    assert.ok(queries.has(expected), expected);
  }
  assert.deepEqual([...queries].filter((f) => !publicQueries.has(f)).sort(), [], 'no other query is open to anyone');
  assert.deepEqual([...mutations].sort(), [...publicMutations].sort());
});

test('the anonymous role cannot reach a table it is not meant to see', async () => {
  for (const field of ['profiles', 'slips', 'cards', 'couples', 'devices', 'entitlements', 'chatTurns', 'files', 'supportRequests']) {
    assert.ok((await gql('public', `{ ${field} { __typename } }`)).errors?.length, field);
  }
});

test('a signed-in person never sees the admin queue, the job history or the file queue', async () => {
  const { queries, mutations } = await roots('user');
  for (const field of ['pushNotifications', 'jobRuns', 'fileDeletions', 'purchaseEvents', 'inviteAttempts']) {
    assert.equal(queries.has(field), false, field);
  }
  for (const field of ['runJob', 'claimNotification', 'completeNotification', 'applyPurchaseEvent']) {
    assert.equal(mutations.has(field), false, field);
  }
});

test('no type scores the relationship', async () => {
  const { __schema } = await ok('user', `{ __schema { types { name fields { name } } } }`);
  const offenders: string[] = [];
  for (const type of __schema.types) {
    for (const field of type.fields ?? []) {
      if (/score|winner|points|ranking/i.test(field.name) || /score|winner|points|ranking/i.test(type.name)) {
        offenders.push(`${type.name}.${field.name}`);
      }
    }
  }
  assert.deepEqual(offenders, [], 'a score, a winner, points or a ranking would break a product rule');
});

test('nothing tracks the partner location or activity', async () => {
  const tables = await sql(`select table_name from information_schema.tables
    where table_schema in ('public', 'private') and table_name ~* 'location|latitude|longitude|geolocation|gps|surveillance|activity_log'`);
  assert.deepEqual(tables, []);
  const columns = await sql(`select table_name, column_name from information_schema.columns
    where table_schema in ('public', 'private') and column_name ~* 'latitude|longitude|geolocation|gps_coord|surveillance'`);
  assert.deepEqual(columns, []);
});

test('nothing about safety triage is stored or exposed', async () => {
  const tables = await sql(`select table_schema, table_name from information_schema.tables
    where table_schema in ('public', 'private') and (table_name ~* 'safe|safety')`);
  assert.deepEqual(tables, []);
  const columns = await sql(`select table_name, column_name from information_schema.columns
    where table_schema in ('public', 'private') and (column_name ~* 'safe|safety|helpline|crisis')`);
  assert.deepEqual(columns, []);
  const { __schema } = await ok('user', `{ __schema { types { name fields { name } } } }`);
  const exposed = __schema.types
    .filter((t: any) => /safe|safety/i.test(t.name))
    .flatMap((t: any) => [t.name, ...(t.fields ?? []).map((f: any) => f.name)])
    .filter((name: string) => /safe|safety|helpline|crisis/i.test(name));
  assert.deepEqual(exposed, []);
});

test('every tracked table is an explicit entry or an enum', async () => {
  const source = await liveMetadata();
  const tracked: [string, string][] = source.tables.map((t: any) => [t.table.schema, t.table.name]);
  const declared = new Set([...Object.keys(tableSpec).map(qualify), ...enums.map((e: string) => `public.${e}`)]);
  const missing = tracked.map(([schema, name]) => `${schema}.${name}`)
    .filter((name) => !name.startsWith('auth.') && !name.startsWith('storage.') && !declared.has(name));
  assert.deepEqual(missing.sort(), [], 'a tracked table without an entry in the spec');
  const known = new Set(tracked.map(([schema, name]) => `${schema}.${name}`));
  const stale = [...declared].filter((name) => !known.has(name));
  assert.deepEqual(stale.sort(), [], 'the spec lists a table that is not tracked');
  for (const table of source.tables.filter((t: any) => t.table.schema === 'public' || t.table.schema === 'private')) {
    const roles = new Set(['insert', 'select', 'update', 'delete']
      .flatMap((kind) => (table[kind + '_permissions'] ?? []).map((p: any) => p.role)));
    assert.deepEqual([...roles].filter((r) => r !== 'user' && r !== 'public').sort(), [],
      `${table.table.schema}.${table.table.name} grants an unexpected role`);
  }
});

test('every tracked function is an explicit entry, with roles or for the admin only', async () => {
  const source = await liveMetadata();
  const tracked: [string, string][] = source.functions.map((f: any) => [f.function.schema, f.function.name]);
  const declared = new Set(Object.keys(functionSpec).map(qualify));
  const missing = tracked.map(([schema, name]) => `${schema}.${name}`).filter((name) => !declared.has(name));
  assert.deepEqual(missing.sort(), [], 'a tracked function without an entry in the spec');
  const known = new Set(tracked.map(([schema, name]) => `${schema}.${name}`));
  assert.deepEqual([...declared].filter((name) => !known.has(name)).sort(), [], 'the spec tracks a function that does not exist');
  const roles = new Set(Object.entries(functionSpec).flatMap(([, spec]: [string, any]) => spec.roles ?? []));
  assert.deepEqual([...roles].sort(), ['public', 'user'], 'no function is granted to an unexpected role');
});

test('one person alone can use the app without a partner', async () => {
  const solo = (await import('../lib.ts')).person;
  const p = await solo();
  const slip = (await ok(p, `mutation { insertSlipsOne(object: {body: "um bom momento comigo"}) { id } }`)).insertSlipsOne;
  const card = (await ok(p, `mutation { prepareCard { cardId status items } }`)).prepareCard[0];
  assert.equal(card.items[0].body, 'um bom momento comigo');
  const sent = (await ok(p, `mutation { sendCard(args: {cardId: "${card.cardId}"}) { id status recipientId } }`)).sendCard[0];
  assert.deepEqual([sent.status, sent.recipientId], ['sent', null]);
  const link = await ok(p, `mutation ($h: String!) { insertGuestLinksOne(object: {cardId: "${card.cardId}", tokenHash: $h}) { id } }`, {
    h: (crypto.randomUUID() + crypto.randomUUID()).replace(/-/g, ''),
  });
  assert.ok(link.insertGuestLinksOne.id);
  assert.deepEqual((await ok(p, `{ couples { id } coupleMembers { userId } partnerMessages { id } }`)), { couples: [], coupleMembers: [], partnerMessages: [] });
  assert.equal((await ok(p, `{ today { partnerId hasPendingInvite } }`)).today[0].partnerId, null);
  void slip;
});

test('a function that is not admin-only is granted to itself and never inferred', async () => {
  const { __schema } = await ok('user', `{ __schema { mutationType { fields { name } } queryType { fields { name } } } }`);
  const userRoots = new Set([...__schema.mutationType.fields, ...__schema.queryType.fields].map((f: any) => f.name));
  for (const [name, spec] of Object.entries(functionSpec) as [string, any][]) {
    const root = name.split('.').pop()!.replace(/_([a-z0-9])/g, (_: string, c: string) => c.toUpperCase());
    const granted = (spec.roles ?? []).includes('user');
    assert.equal(userRoots.has(root), granted, `${root} is ${granted ? 'missing' : 'open'} for the user role`);
  }
});

test('the launch configuration is readable before sign-in and holds every limit the server enforces', async () => {
  const { appConfig } = await ok('public', `{ appConfig { key value } }`);
  const config = Object.fromEntries(appConfig.map((r: any) => [r.key, r.value]));
  for (const key of ['chat_messages_per_day_free', 'chat_messages_per_day_plus', 'free_games_per_week', 'free_rituals', 'free_lists',
    'free_spice_cards_per_week', 'free_agreements', 'free_card_themes', 'min_app_version', 'min_app_version_ios', 'min_app_version_android',
    'store_url_ios', 'store_url_android']) {
    assert.ok(key in config, `missing ${key}`);
  }
  assert.deepEqual([config.chat_messages_per_day_free, config.chat_messages_per_day_plus, config.free_games_per_week, config.free_rituals,
    config.free_lists, config.free_spice_cards_per_week, config.free_card_themes], ['5', '20', '3', '3', '3', '3', 'paper']);
  assert.equal('free_slips_per_month' in config || 'free_cards_per_month' in config, false, 'the removed limits are gone');
});

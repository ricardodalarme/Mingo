import { test } from 'node:test';
import { assert, couple, denied, ok, person, plus, randomUUID, sql } from '../lib.ts';

test('the free plan starts 3 games a week for the couple and Plus lifts it', async () => {
  const { a, b } = await couple();
  for (const kind of ['me_or_you', 'how_well', 'never_have_we']) {
    await ok(a, `mutation { insertGameSessionsOne(object: {game: ${kind}, itemSlugs: ["a"]}) { id } }`);
  }
  assert.equal((await ok(a, `{ plusStates { gamesLeftThisWeek } }`)).plusStates[0].gamesLeftThisWeek, 0);
  const refused = await denied(b, `mutation { insertGameSessionsOne(object: {game: mission, itemSlugs: ["a"]}) { id } }`);
  assert.match(JSON.stringify(refused.errors), /FREE_LIMIT_REACHED/);
  await plus(a);
  await ok(b, `mutation { insertGameSessionsOne(object: {game: mission, itemSlugs: ["a"]}) { id } }`);
  assert.equal((await ok(b, `{ plusStates { gamesLeftThisWeek hasPlus paidByPartner } }`)).plusStates[0].gamesLeftThisWeek, null);
});

test('a cancelled game still counts toward the weekly limit', async () => {
  const { a } = await couple();
  for (let i = 0; i < 3; i++) {
    const { insertGameSessionsOne } = await ok(a, `mutation { insertGameSessionsOne(object: {game: me_or_you, itemSlugs: ["a"]}) { id } }`);
    await ok(a, `mutation ($id: uuid!) { updateGame(args: {sessionId: $id, action: "cancel"}) { id } }`, { id: insertGameSessionsOne.id });
  }
  await denied(a, `mutation { insertGameSessionsOne(object: {game: me_or_you, itemSlugs: ["a"]}) { id } }`);
});

test('the free plan keeps 3 active rituals and 3 lists per person', async () => {
  const a = await person();
  for (let i = 0; i < 3; i++) {
    await ok(a, `mutation { insertRitualsOne(object: {title: "r"}) { id } insertListsOne(object: {title: "l"}) { id } }`);
  }
  assert.deepEqual((await ok(a, `{ plusStates { ritualsLeft listsLeft } }`)).plusStates[0], { ritualsLeft: 0, listsLeft: 0 });
  const refused = await denied(a, `mutation { insertRitualsOne(object: {title: "r4"}) { id } }`);
  assert.match(JSON.stringify(refused.errors), /FREE_LIMIT_REACHED/);
  await denied(a, `mutation { insertListsOne(object: {title: "l4"}) { id } }`);
  await sql(`update public.rituals set archived_at = now() where id = (select id from public.rituals where author_id = '${a.id}' limit 1)`);
  await ok(a, `mutation { insertRitualsOne(object: {title: "r4"}) { id } }`);
  await plus(a);
  await ok(a, `mutation { insertRitualsOne(object: {title: "r5"}) { id } insertListsOne(object: {title: "l4"}) { id } }`);
});

test('a partner covered by Plus lifts the limits and learns who pays; billing issues stay with the owner', async () => {
  const { a, b } = await couple();
  await plus(a);
  const covered = (await ok(b, `{ plusStates { hasPlus paidByPartner coveredByName bothPaid billingIssue ownerStore } }`)).plusStates[0];
  assert.equal(covered.hasPlus, true);
  assert.equal(covered.paidByPartner, true);
  assert.equal(covered.coveredByName, 'Ana');
  assert.equal(covered.bothPaid, false);
  await sql(`update public.entitlements set status = 'billing_issue', store = 'app_store' where user_id = '${a.id}'`);
  const owner = (await ok(a, `{ plusStates { hasPlus billingIssue ownerStore } }`)).plusStates[0];
  assert.deepEqual(owner, { hasPlus: true, billingIssue: true, ownerStore: 'app_store' });
  assert.equal((await ok(b, `{ plusStates { billingIssue hasPlus } }`)).plusStates[0].billingIssue, false);
  await plus(b);
  assert.equal((await ok(a, `{ plusStates { bothPaid } }`)).plusStates[0].bothPaid, true, 'a billing issue is still live');
});

test('an entitlement that expired a minute ago is not Plus', async () => {
  const a = await person();
  await sql(`insert into public.entitlements (user_id, plan, status, expires_at) values ('${a.id}', 'plus_annual', 'active', now() - interval '1 minute')`);
  assert.equal((await ok(a, `{ plusStates { hasPlus } }`)).plusStates[0].hasPlus, false);
});

test('a card theme outside the free list needs Plus, on change only', async () => {
  const a = await person();
  const set = (theme: string) => `mutation { updateUserSettingsByPk(pk_columns: {userId: "${a.id}"}, _set: {cardTheme: "${theme}"}) { cardTheme } }`;
  await ok(a, set('paper'));
  const refused = await denied(a, set('midnight'));
  assert.match(JSON.stringify(refused.errors), /PLUS_REQUIRED/);
  await plus(a);
  await ok(a, set('midnight'));
  await sql(`delete from public.entitlements where user_id = '${a.id}'`);
  await ok(a, `mutation { updateUserSettingsByPk(pk_columns: {userId: "${a.id}"}, _set: {chatEnabled: true}) { chatEnabled } }`);
});

test('plus-only content keeps its title and loses its body for a person without Plus', async () => {
  const a = await person();
  const slug = `locked-${randomUUID()}`;
  await sql(`insert into public.content_items (kind, slug, locale, title, body, plus_only) values ('date_idea', '${slug}', 'pt-BR', 'Trancado', 'segredo', true)`);
  const query = `query { contentCatalog(args: {kind: "date_idea", locale: "pt-BR"}, where: {slug: {_eq: "${slug}"}}) { title body plusOnly locked } contentItems(where: {slug: {_eq: "${slug}"}}) { id } }`;
  const free = await ok(a, query);
  assert.deepEqual(free.contentCatalog, [{ title: 'Trancado', body: null, plusOnly: true, locked: true }]);
  assert.deepEqual(free.contentItems, [], 'a direct query never returns plus-only rows');
  await plus(a);
  assert.equal((await ok(a, query)).contentCatalog[0].body, 'segredo');
});

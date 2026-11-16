import { test, before } from 'node:test';
import { readFileSync, readdirSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { adult, assert, couple, denied, gql, ok, person, plus, sql, type Person } from './lib.ts';

const metadataDir = join(dirname(fileURLToPath(import.meta.url)), '..', 'metadata', 'databases', 'default', 'tables');

// Test content sorts before any shipped content, so the first pick of a function is one of these.
before(async () => {
  await sql(`delete from public.content_items where slug like 'tt-%'`);
  await sql(`insert into public.content_items (kind, slug, locale, title, body, level, position, plus_only, sensitive) values
    ('spice_card', 'tt-card-1', 'pt-BR', 'Cartão 1', 'x', 1, -1000, false, true),
    ('spice_card', 'tt-card-2', 'pt-BR', 'Cartão 2', 'x', 1, -999, false, true),
    ('spice_card', 'tt-card-3', 'pt-BR', 'Cartão 3', 'x', 1, -998, false, true),
    ('spice_card', 'tt-card-4', 'pt-BR', 'Cartão 4', 'x', 1, -997, false, true),
    ('spice_card', 'tt-card-hot', 'pt-BR', 'Cartão quente', 'x', 3, -1001, false, true),
    ('spice_desire', 'tt-desire-1', 'pt-BR', 'Desejo 1', 'x', 1, -1000, true, true),
    ('spice_desire', 'tt-desire-2', 'pt-BR', 'Desejo 2', 'x', 1, -999, true, true),
    ('spice_desire', 'tt-desire-3', 'pt-BR', 'Desejo 3', 'x', 1, -998, true, true),
    ('spice_challenge', 'tt-challenge-1', 'pt-BR', 'Desafio 1', 'x', 1, -1000, false, true),
    ('spice_challenge', 'tt-challenge-2', 'pt-BR', 'Desafio 2', 'x', 1, -999, false, true),
    ('spice_challenge', 'tt-challenge-3', 'pt-BR', 'Desafio 3', 'x', 1, -998, false, true),
    ('spice_challenge', 'tt-challenge-4', 'pt-BR', 'Desafio 4', 'x', 1, -997, false, true),
    ('spice_challenge', 'tt-challenge-5', 'pt-BR', 'Desafio 5', 'x', 1, -996, false, true)`);
});

const set = (who: Person, field: string, value: string | number | boolean) =>
  ok(who, `mutation { updateUserSettingsByPk(pk_columns: {userId: "${who.id}"}, _set: {${field}: ${JSON.stringify(value)}}) { userId } }`);
const spiceOn = async (who: Person) => { await adult(who); await set(who, 'spiceEnabled', true); };
const state = (who: Person) => ok(who, `{ spiceState { state myLevel coupleLevel } }`).then((d) => d.spiceState[0]);
const spiceCouple = async () => {
  const c = await couple();
  await spiceOn(c.a);
  await spiceOn(c.b);
  return c;
};
const nextCard = (who: Person) => ok(who, `mutation { spiceNextCard { id contentSlug proposedBy acceptedBy declinedAt } }`).then((d) => d.spiceNextCard[0]);
const answer = (who: Person, slug: string, value: string) =>
  ok(who, `mutation { insertSpiceDesireAnswersOne(object: {contentSlug: "${slug}", answer: ${value}}) { contentSlug } }`);
const inbox = (who: Person, type: string) => ok(who, `{ inboxItems(where: {type: {_eq: ${type}}}) { id } }`).then((d) => d.inboxItems);

test('the handshake: each side sees only what it may, and the level is the gentlest of the two', async () => {
  const { a, b } = await couple();
  assert.deepEqual(await state(a), { state: 'off', myLevel: 1, coupleLevel: null });
  await spiceOn(a);
  assert.equal((await state(a)).state, 'waiting_partner');
  assert.deepEqual(await state(b), { state: 'partner_wants', myLevel: 1, coupleLevel: null });
  await set(a, 'spiceMaxLevel', 3);
  await spiceOn(b);
  await set(b, 'spiceMaxLevel', 2);
  assert.deepEqual(await state(a), { state: 'on', myLevel: 3, coupleLevel: 2 });
  assert.deepEqual(await state(b), { state: 'on', myLevel: 2, coupleLevel: 2 });
  assert.deepEqual((await ok(await person(), `{ spiceState { state } }`)).spiceState, [{ state: 'off' }]);
});

test('turning it on tells the partner with no content; the push needs their explicit yes, the inbox row does not', async () => {
  const { a, b } = await couple();
  await spiceOn(a);
  assert.equal((await inbox(b, 'spice_invite')).length, 1);
  const push = await sql(`select id from private.notifications where user_id = '${b.id}' and type = 'spice_invite'`);
  assert.equal(push.length, 1);
  assert.equal((await sql(`select count(*) from private.claim_notification('${push[0][0]}')`))[0][0], '0');
  assert.deepEqual(await sql(`select outcome from private.notifications where id = '${push[0][0]}'`), [['dropped']]);

  const c = await couple();
  await sql(`update public.user_settings set spice_notifications = true where user_id = '${c.b.id}'`);
  await spiceOn(c.a);
  const id = (await sql(`select id from private.notifications where user_id = '${c.b.id}' and type = 'spice_invite'`))[0][0];
  await sql(`select count(*) from private.claim_notification('${id}')`);
  assert.deepEqual(await sql(`select outcome from private.notifications where id = '${id}'`), [['no_device']], 'allowed, and only the missing device stopped it');
});

test('evening cards: one at a time, the other person answers, a "no" tells nothing, levels are respected', async () => {
  const { a, b } = await spiceCouple();
  const first = await nextCard(a);
  assert.notEqual(first.contentSlug, 'tt-card-hot', 'a level 3 card never reaches a level 1 couple');
  assert.equal((await nextCard(b)).id, first.id, 'the open card is shown again, not a second one');
  const own = await ok(a, `mutation ($id: uuid!) { spiceRespondCard(args: {playId: $id, accept: true}) { id } }`, { id: first.id });
  assert.deepEqual(own.spiceRespondCard, [], 'the proposer cannot answer their own card');
  const before = Number((await sql(`select count(*) from private.notifications where user_id = '${a.id}'`))[0][0]);
  const declined = await ok(b, `mutation ($id: uuid!) { spiceRespondCard(args: {playId: $id, accept: false}) { declinedAt acceptedBy } }`, { id: first.id });
  assert.ok(declined.spiceRespondCard[0].declinedAt);
  assert.equal(Number((await sql(`select count(*) from private.notifications where user_id = '${a.id}'`))[0][0]), before, 'a no is not announced');
  const second = await nextCard(b);
  assert.notEqual(second.contentSlug, first.contentSlug, 'a card is never repeated');
  const accepted = await ok(a, `mutation ($id: uuid!) { spiceRespondCard(args: {playId: $id, accept: true}) { acceptedBy } }`, { id: second.id });
  assert.deepEqual(accepted.spiceRespondCard, [{ acceptedBy: a.id }]);
  assert.equal((await ok(a, `{ spiceCardPlays { id } }`)).spiceCardPlays.length, 2);
  assert.equal((await ok(b, `{ spiceCardPlays { id } }`)).spiceCardPlays.length, 2);
});

test('the free plan opens 3 evening cards a week; Plus lifts it', async () => {
  const { a, b } = await spiceCouple();
  for (let i = 0; i < 3; i++) {
    const card = await nextCard(a);
    await ok(b, `mutation ($id: uuid!) { spiceRespondCard(args: {playId: $id, accept: true}) { id } }`, { id: card.id });
  }
  assert.equal((await ok(a, `{ plusStates { spiceCardsLeftThisWeek } }`)).plusStates[0].spiceCardsLeftThisWeek, 0);
  const refused = await denied(a, `mutation { spiceNextCard { id } }`);
  assert.match(JSON.stringify(refused.errors), /FREE_LIMIT_REACHED/);
  await plus(a);
  assert.ok(await nextCard(b));
});

test('cards need the mode on for both: nothing is created and nothing is returned', async () => {
  const { a } = await couple();
  // The result is gated by the read permission, so the function does not even run while the mode is not on.
  assert.deepEqual((await ok(a, `mutation { spiceNextCard { id } }`)).spiceNextCard, []);
  await spiceOn(a);
  assert.deepEqual((await ok(a, `mutation { spiceNextCard { id } spiceChallenge { id } }`)), { spiceNextCard: [], spiceChallenge: [] });
  assert.deepEqual(await sql(`select 1 from public.spice_card_plays where proposed_by = '${a.id}'`), []);
});

test('desires are Plus, private to the person, and only what both want is shown', async () => {
  const { a, b } = await spiceCouple();
  const refused = await denied(a, `mutation { insertSpiceDesireAnswersOne(object: {contentSlug: "tt-desire-1", answer: want}) { contentSlug } }`);
  assert.match(JSON.stringify(refused.errors), /PLUS_REQUIRED/);
  await plus(a);
  await answer(a, 'tt-desire-1', 'want');
  await answer(a, 'tt-desire-2', 'want');
  await answer(a, 'tt-desire-3', 'maybe');
  await answer(b, 'tt-desire-1', 'want');
  await answer(b, 'tt-desire-2', 'not_today');
  await answer(b, 'tt-desire-3', 'want');
  assert.deepEqual((await ok(b, `{ spiceDesireAnswers { contentSlug answer } }`)).spiceDesireAnswers.map((r: any) => r.contentSlug).sort(), ['tt-desire-1', 'tt-desire-2', 'tt-desire-3']);
  assert.equal((await ok(a, `{ spiceDesireAnswers(where: {userId: {_eq: "${b.id}"}}) { answer } }`)).spiceDesireAnswers.length, 0, 'the partner answers are never readable');
  const matches = (await ok(a, `{ spiceMatches { slug title locked } }`)).spiceMatches;
  assert.deepEqual(matches, [{ slug: 'tt-desire-1', title: 'Desejo 1', locked: false }]);
  assert.deepEqual((await ok(b, `{ spiceMatches { slug } }`)).spiceMatches, [{ slug: 'tt-desire-1' }]);
  await ok(b, `mutation { updateSpiceDesireAnswersByPk(pk_columns: {userId: "${b.id}", contentSlug: "tt-desire-1"}, _set: {answer: maybe}) { answer } }`);
  assert.deepEqual((await ok(a, `{ spiceMatches { slug } }`)).spiceMatches, [], 'a change of mind removes the match');
});

test('matches need Plus, and a person without the mode on sees nothing', async () => {
  const { a } = await spiceCouple();
  const refused = await denied(a, `mutation { insertSpiceDesireAnswersOne(object: {contentSlug: "tt-desire-1", answer: want}) { contentSlug } }`);
  assert.ok(refused.errors);
  const matches = await denied(a, `{ spiceMatches { slug } }`);
  assert.match(JSON.stringify(matches.errors), /PLUS_REQUIRED/);
  const { a: solo } = await couple();
  assert.deepEqual((await ok(solo, `{ spiceMatches { slug } }`)).spiceMatches, []);
});

test('the weekly challenge: one per week for the couple, no score, up to 3 swaps', async () => {
  const { a, b } = await spiceCouple();
  const first = (await ok(a, `mutation { spiceChallenge { id contentSlug swaps } }`)).spiceChallenge[0];
  const again = (await ok(b, `mutation { spiceChallenge { id contentSlug } }`)).spiceChallenge[0];
  assert.equal(again.id, first.id);
  const act = (who: Person, action: string) => ok(who, `mutation { spiceChallengeAct(args: {action: "${action}"}) { contentSlug swaps seenBy acceptedBy doneBy } }`).then((d) => d.spiceChallengeAct[0]);
  assert.deepEqual((await act(a, 'seen')).seenBy, [a.id]);
  assert.deepEqual((await act(a, 'seen')).seenBy, [a.id], 'idempotent');
  assert.deepEqual((await act(b, 'accept')).acceptedBy, [b.id]);
  assert.deepEqual((await act(a, 'accept')).acceptedBy.sort(), [a.id, b.id].sort());
  assert.deepEqual((await act(b, 'done')).doneBy, [b.id]);
  let slug = first.contentSlug;
  for (let i = 1; i <= 3; i++) {
    const swapped = await act(a, 'swap');
    assert.notEqual(swapped.contentSlug, slug);
    assert.deepEqual([swapped.swaps, swapped.acceptedBy, swapped.doneBy], [i, [], []]);
    slug = swapped.contentSlug;
  }
  const limit = await denied(a, `mutation { spiceChallengeAct(args: {action: "swap"}) { id } }`);
  assert.match(JSON.stringify(limit.errors), /SWAP_LIMIT/);
  await denied(a, `mutation { spiceChallengeAct(args: {action: "points"}) { id } }`);
  assert.equal((await ok(a, `{ spiceChallenges { id } }`)).spiceChallenges.length, 1);
});

test('spiceOff removes everything for both, tells the other person once, and a second call does nothing', async () => {
  const { a, b } = await spiceCouple();
  await plus(a);
  await answer(a, 'tt-desire-1', 'want');
  await answer(b, 'tt-desire-1', 'want');
  await nextCard(a);
  await ok(a, `mutation { spiceChallenge { id } }`);
  const off = await ok(b, `mutation { spiceOff { spiceEnabled } }`);
  assert.deepEqual(off.spiceOff, [{ spiceEnabled: false }]);
  for (const who of [a, b]) {
    assert.equal((await state(who)).state, 'off');
    const left = await ok(who, `{ spiceDesireAnswers { contentSlug } spiceCardPlays { id } spiceChallenges { id } }`);
    assert.deepEqual(left, { spiceDesireAnswers: [], spiceCardPlays: [], spiceChallenges: [] });
  }
  assert.equal((await inbox(a, 'spice_off')).length, 1);
  assert.equal((await inbox(b, 'spice_off')).length, 0, 'the person who turned it off is not told');
  assert.deepEqual((await ok(a, `mutation { spiceOff { spiceEnabled } }`)).spiceOff, [], 'already off');
  assert.equal((await inbox(a, 'spice_off')).length, 1);
});

test('switching it off directly leaves nothing behind either, and notifies a partner who was on', async () => {
  const { a, b } = await spiceCouple();
  await plus(a);
  await answer(a, 'tt-desire-1', 'want');
  await nextCard(a);
  await set(a, 'spiceEnabled', false);
  assert.deepEqual((await ok(a, `{ spiceDesireAnswers { contentSlug } }`)).spiceDesireAnswers, []);
  assert.deepEqual(await sql(`select 1 from public.spice_card_plays where proposed_by = '${a.id}'`), []);
  assert.equal((await state(b)).state, 'waiting_partner');
  assert.equal((await inbox(b, 'spice_off')).length, 1);
});

test('unpairing removes the mode for both, with everything it kept, and says nothing about it', async () => {
  const { a, b } = await spiceCouple();
  await plus(a);
  await answer(b, 'tt-desire-2', 'want');
  await nextCard(a);
  await ok(a, `mutation { unpair { id } }`);
  assert.deepEqual(await sql(`select spice_enabled from public.user_settings where user_id in ('${a.id}', '${b.id}')`), [['f'], ['f']]);
  assert.deepEqual(await sql(`select 1 from public.spice_desire_answers where user_id in ('${a.id}', '${b.id}')`), []);
  assert.deepEqual(await sql(`select 1 from public.spice_card_plays p join public.couple_members m on false`), []);
  assert.equal((await inbox(b, 'spice_off')).length, 0);
  assert.equal((await inbox(b, 'unpaired')).length, 1);
});

test('the catalog and direct reads hide Tempero content unless both are on', async () => {
  const { a } = await couple();
  const read = (who: Person) => ok(who, `{ contentCatalog(args: {kind: "spice_card"}, where: {slug: {_like: "tt-%"}}) { slug } contentItems(where: {slug: {_like: "tt-%"}}) { slug } }`);
  assert.deepEqual(await read(a), { contentCatalog: [], contentItems: [] });
  const both = await spiceCouple();
  const seen = await read(both.a);
  assert.ok(seen.contentCatalog.length >= 5);
  assert.deepEqual(seen.contentItems.map((r: any) => r.slug).filter((s: string) => s.startsWith('tt-desire')), [], 'plus-only desires only through the functions');
});

test('plays and challenges are read by the couple while the mode is on, and by nobody else', async () => {
  const { a, b } = await spiceCouple();
  await nextCard(a);
  const stranger = await person();
  assert.deepEqual((await ok(stranger, `{ spiceCardPlays { id } spiceChallenges { id } }`)), { spiceCardPlays: [], spiceChallenges: [] });
  await set(b, 'spiceEnabled', false);
  assert.deepEqual((await ok(a, `{ spiceCardPlays { id } }`)).spiceCardPlays, []);
  assert.equal((await gql('public', `{ spiceCardPlays { id } }`)).data, undefined);
});

test('no other table or type can reach Tempero by joining', async () => {
  const files = readdirSync(metadataDir).filter((f) => f.endsWith('.yaml') && f !== 'tables.yaml' && !f.includes('spice_'));
  for (const file of files) {
    const text = readFileSync(join(metadataDir, file), 'utf8');
    assert.doesNotMatch(text, /name: spice_(desire_answers|card_plays|challenges)/, `${file} points at a Tempero table`);
  }
  const { data } = await gql({ id: (await person()).id }, `{ __schema { types { name kind fields { name type { name kind ofType { name kind ofType { name kind ofType { name } } } } } } } }`);
  const named = (t: any): string => (t.name ?? (t.ofType ? named(t.ofType) : ''));
  const roots = new Set(['query_root', 'mutation_root', 'subscription_root']);
  const leaks: string[] = [];
  for (const type of data.__schema.types) {
    if (type.kind !== 'OBJECT' || roots.has(type.name) || type.name.startsWith('spice') || type.name.startsWith('__')) continue;
    for (const field of type.fields ?? []) {
      if (/^spice_(card_plays|challenges|desire_answers)/.test(named(field.type))) leaks.push(`${type.name}.${field.name}`);
    }
  }
  assert.deepEqual(leaks, []);
});

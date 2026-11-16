import { test } from 'node:test';
import { createHash, randomBytes } from 'node:crypto';
import { assert, couple, denied, ok, person, plus, randomUUID, sql, type Person } from '../lib.ts';

const addSlip = (who: Person, fields = 'body: "made coffee"') =>
  ok(who, `mutation { insertSlipsOne(object: { ${fields} }) { id authorId forCard kind polarity request body } }`).then((d) => d.insertSlipsOne);

async function sentCard(a: Person): Promise<string> {
  await addSlip(a);
  const { prepareCard } = await ok(a, `mutation { prepareCard { cardId status } }`);
  const { sendCard } = await ok(a, `mutation ($id: uuid!) { sendCard(args: {cardId: $id}) { id status recipientId sentAt } }`, { id: prepareCard[0].cardId });
  assert.equal(sendCard[0].status, 'sent');
  return sendCard[0].id;
}

test('a slip is visible to its author only, never to the partner or a stranger', async () => {
  const { a, b } = await couple();
  const stranger = await person();
  const slip = await addSlip(a);
  assert.equal(slip.authorId, a.id);
  for (const other of [b, stranger]) {
    const data = await ok(other, `query ($id: uuid!) { slips { id } slipsByPk(id: $id) { id } slipsAggregate { aggregate { count } } }`, { id: slip.id });
    assert.deepEqual(data, { slips: [], slipsByPk: null, slipsAggregate: { aggregate: { count: 0 } } });
    const changed = await ok(other, `mutation ($id: uuid!) {
      updateSlipsByPk(pk_columns: {id: $id}, _set: {body: "x"}) { id } deleteSlipsByPk(id: $id) { id } }`, { id: slip.id });
    assert.deepEqual(changed, { updateSlipsByPk: null, deleteSlipsByPk: null });
  }
});

test('the author of a slip is always the caller, whatever the client sends', async () => {
  const a = await person();
  const b = await person();
  await denied(a, `mutation ($b: uuid!) { insertSlipsOne(object: {body: "x", authorId: $b}) { id } }`, { b: b.id });
  const id = randomUUID();
  await addSlip(a, `id: "${id}", body: "mine"`);
  const stolen = await ok(b, `mutation ($id: uuid!) { insertSlipsOne(object: {id: $id, body: "stolen"},
    on_conflict: {constraint: slips_pkey, update_columns: [body]}) { id } }`, { id });
  assert.equal(stolen.insertSlipsOne, null);
  const again = await ok(a, `mutation ($id: uuid!) { insertSlipsOne(object: {id: $id, body: "edited"},
    on_conflict: {constraint: slips_pkey, update_columns: [body]}) { body } }`, { id });
  assert.equal(again.insertSlipsOne.body, 'edited', 'saving the same id again edits the slip');
});

test('an invisible slip never reaches a card, and a bothered slip can no longer be written', async () => {
  const a = await person();
  await denied(a, `mutation { insertSlipsOne(object: {body: "left the dishes", polarity: bothered}) { id } }`);
  const invisible = await addSlip(a, 'body: "planned the week", kind: invisible, forCard: true');
  assert.equal(invisible.forCard, false);
  const liked = await addSlip(a, 'body: "nice", request: "ignored"');
  assert.equal(liked.request, null);
  const { prepareCard } = await ok(a, `mutation { prepareCard { cardId } }`);
  assert.deepEqual((await ok(a, `{ cardItems { slipId } }`)).cardItems, [{ slipId: liked.id }]);
  await denied(a, `mutation ($c: uuid!, $s: uuid!) { insertCardItemsOne(object: {cardId: $c, slipId: $s}) { id } }`, { c: prepareCard[0].cardId, s: invisible.id });
  await denied(a, `mutation ($s: uuid!) { updateSlipsByPk(pk_columns: {id: $s}, _set: {polarity: bothered}) { id } }`, { s: liked.id });
  assert.deepEqual((await ok(a, `mutation ($s: uuid!) { sendSlip(args: {slipId: $s}) { id } }`, { s: invisible.id })).sendSlip, []);
});

test('slips are unlimited on the free plan', async () => {
  const a = await person();
  await sql(`insert into public.slips (author_id, body) select '${a.id}', 'seed ' || g from generate_series(1, 100) g`);
  await addSlip(a);
  assert.equal((await ok(a, `{ slipsAggregate { aggregate { count } } }`)).slipsAggregate.aggregate.count, 101);
});

test('a sent card is frozen: later edits and deletes of the slip do not change it, and it cannot be edited', async () => {
  const { a, b } = await couple();
  const slip = await addSlip(a);
  const { prepareCard } = await ok(a, `mutation { prepareCard { cardId } }`);
  await ok(a, `mutation ($id: uuid!) { sendCard(args: {cardId: $id}) { id } }`, { id: prepareCard[0].cardId });
  await ok(a, `mutation ($s: uuid!) { updateSlipsByPk(pk_columns: {id: $s}, _set: {body: "changed"}) { id } }`, { s: slip.id });
  await ok(a, `mutation ($s: uuid!) { deleteSlipsByPk(id: $s) { id } }`, { s: slip.id });
  assert.deepEqual((await ok(b, `{ cardItems { body slipId } }`)).cardItems, [{ body: 'made coffee', slipId: null }]);
  const edit = await ok(a, `mutation ($id: uuid!) { updateCardsByPk(pk_columns: {id: $id}, _set: {note: "late"}) { id } deleteCardItems(where: {}) { affected_rows } }`, { id: prepareCard[0].cardId });
  assert.deepEqual(edit, { updateCardsByPk: null, deleteCardItems: { affected_rows: 0 } });
  assert.deepEqual((await ok(a, `mutation ($id: uuid!) { sendCard(args: {cardId: $id}) { id } }`, { id: prepareCard[0].cardId })).sendCard, [], 'not sent twice');
});

test('the free plan sends as many cards as the person asks', async () => {
  const { a } = await couple();
  await sentCard(a);
  const slip = await addSlip(a);
  const single = (await ok(a, `mutation ($s: uuid!) { sendSlip(args: {slipId: $s, note: "now"}) { kind status note } }`, { s: slip.id })).sendSlip[0];
  assert.deepEqual(single, { kind: 'single', status: 'sent', note: 'now' });
  assert.equal((await ok(a, `{ cards { id } }`)).cards.length, 2);
});

test('only the recipient reacts and opens; the author sees the open only with shared read receipts', async () => {
  const { a, b } = await couple();
  const stranger = await person();
  const card = await sentCard(a);
  for (const who of [a, stranger]) {
    await denied(who, `mutation ($c: uuid!) { insertCardReactionsOne(object: {cardId: $c, reaction: "❤️"}) { cardId } }`, { c: card });
    await denied(who, `mutation ($c: uuid!) { insertCardOpensOne(object: {cardId: $c}) { cardId } }`, { c: card });
  }
  await ok(b, `mutation ($c: uuid!) { insertCardOpensOne(object: {cardId: $c}) { cardId } }`, { c: card });
  const reaction = await ok(b, `mutation ($c: uuid!) { insertCardReactionsOne(object: {cardId: $c, reaction: "❤️", reply: " obrigado "},
    on_conflict: {constraint: card_reactions_pkey, update_columns: [reaction, reply]}) { reply fromGuest } }`, { c: card });
  assert.deepEqual(reaction.insertCardReactionsOne, { reply: 'obrigado', fromGuest: false });
  const before = (await ok(a, `{ cards { open { openedAt } reaction { reaction } } }`)).cards[0];
  assert.deepEqual(before, { open: null, reaction: { reaction: '❤️' } });
  assert.equal((await ok(b, `{ today { unopenedCards } }`)).today[0].unopenedCards, 0);
  await ok(b, `mutation ($id: uuid!) { updateUserSettingsByPk(pk_columns: {userId: $id}, _set: {shareReadReceipts: true}) { userId } }`, { id: b.id });
  assert.notEqual((await ok(a, `{ cards { open { openedAt } } }`)).cards[0].open, null);
  assert.deepEqual((await ok(stranger, `{ cardOpens { cardId } cardReactions { cardId } }`)), { cardOpens: [], cardReactions: [] });
});

test('the author deletes a card for both sides', async () => {
  const { a, b } = await couple();
  const card = await sentCard(a);
  assert.equal((await ok(b, `mutation ($c: uuid!) { deleteCardsByPk(id: $c) { id } }`, { c: card })).deleteCardsByPk, null);
  await ok(a, `mutation ($c: uuid!) { deleteCardsByPk(id: $c) { id } }`, { c: card });
  assert.deepEqual((await ok(b, `{ cards { id } }`)).cards, []);
});

const newToken = () => {
  const token = randomBytes(24).toString('hex');
  return { token, hash: createHash('sha256').update(token).digest('hex') };
};
const guest = (field: string, args: string) => ok('public', `mutation { ${field}(args: {${args}}) { done } }`).then((d) => d[field][0].done);
const guestCard = (token: string) => ok('public', `query ($t: String!) { guestCard(args: {token: $t}) { senderName note opened items reaction reply } }`, { t: token }).then((d) => d.guestCard);

test('a guest link shows one sent card to whoever holds the token, and nothing else', async () => {
  const a = await person('Ana');
  const card = await sentCard(a);
  const { token, hash } = newToken();
  const link = (await ok(a, `mutation ($c: uuid!, $h: String!) { insertGuestLinksOne(object: {cardId: $c, tokenHash: $h}) { id expiresAt } }`, { c: card, h: hash })).insertGuestLinksOne;
  await denied(a, `{ guestLinks { tokenHash } }`);
  const stranger = await person();
  assert.deepEqual((await ok(stranger, `{ guestLinks { id } }`)).guestLinks, []);
  await denied(stranger, `mutation ($c: uuid!, $h: String!) { insertGuestLinksOne(object: {cardId: $c, tokenHash: $h}) { id } }`, { c: card, h: newToken().hash });

  const [shown] = await guestCard(token);
  assert.deepEqual(shown, { senderName: 'Ana', note: null, opened: false, items: [{ body: 'made coffee', feeling: null }], reaction: null, reply: null });
  assert.deepEqual(await guestCard(newToken().token), [], 'an unknown token shows nothing');
  assert.deepEqual((await ok('public', `{ guestCards { linkId } }`)).guestCards, [], 'the result table itself is empty');

  assert.equal(await guest('guestOpen', `token: "${token}"`), true);
  assert.equal(await guest('guestReact', `token: "${token}", reaction: "🥹", reply: "amei"`), true);
  const mine = (await ok(a, `{ cards { reaction { reaction reply fromGuest } open { openedAt } } }`)).cards[0];
  assert.deepEqual(mine.reaction, { reaction: '🥹', reply: 'amei', fromGuest: true });
  assert.equal(mine.open, null, 'a guest open is not a read receipt');

  await ok(a, `mutation ($id: uuid!) { deleteGuestLinksByPk(id: $id) { id } }`, { id: link.id });
  assert.deepEqual(await guestCard(token), [], 'a revoked link is gone');
});

test('a guest can stop a sender, come back, report and be forgotten; the sender is never told', async () => {
  const a = await person('Ana');
  const card = await sentCard(a);
  const { token, hash } = newToken();
  await ok(a, `mutation ($c: uuid!, $h: String!) { insertGuestLinksOne(object: {cardId: $c, tokenHash: $h}) { id } }`, { c: card, h: hash });
  await guest('guestReact', `token: "${token}", reaction: "🙂"`);
  assert.equal(await guest('guestStop', `token: "${token}"`), true);
  assert.deepEqual(await guestCard(token), []);
  const second = newToken();
  await ok(a, `mutation ($c: uuid!, $h: String!) { insertGuestLinksOne(object: {cardId: $c, tokenHash: $h}) { id } }`, { c: card, h: second.hash });
  assert.deepEqual(await guestCard(second.token), [], 'new links of a stopped sender never resolve');
  assert.deepEqual((await ok(a, `{ guestLinks(order_by: {createdAt: desc}, limit: 1) { revokedAt } }`)).guestLinks, [{ revokedAt: null }]);
  assert.equal(await guest('guestResume', `token: "${token}"`), true);
  assert.equal((await guestCard(token)).length, 1);
  assert.equal(await guest('guestReport', `token: "${token}", reason: "spam", includeCard: true`), true);
  assert.equal((await sql(`select count(*) from private.abuse_reports where card_id = '${card}'`))[0][0], '1');
  assert.equal(await guest('guestForget', `token: "${token}"`), true);
  assert.equal((await ok(a, `{ cards { reaction { reaction } } }`)).cards[0].reaction, null);
  assert.equal(await guest('guestOpen', `token: "${newToken().token}"`), false);
});

test('a signed-in person cannot call the guest functions or read the abuse reports', async () => {
  const a = await person();
  await denied(a, `{ guestCard(args: {token: "x"}) { linkId } }`);
  await denied(a, `{ abuseReports { id } }`);
});

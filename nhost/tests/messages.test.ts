import { test } from 'node:test';
import { M4A, assert, couple, denied, ok, signUp, sql, upload, type Session } from './lib.ts';

async function pairSessions(): Promise<{ a: Session; b: Session }> {
  const a = await signUp('Ana');
  const b = await signUp('Bruno');
  const { insertInvitesOne } = await ok(a, `mutation { insertInvitesOne(object: {}) { code } }`);
  await ok(b, `mutation ($c: String!) { acceptInvite(args: {code: $c}) { id } }`, { c: insertInvitesOne.code });
  return { a, b };
}

const draft = async (who: any, body: string, note: string | null = null) => {
  await ok(who, `mutation ($b: String!) { insertSlipsOne(object: {body: $b}) { id } }`, { b: body });
  const { prepareCard } = await ok(who, `mutation { prepareCard { cardId } }`);
  if (note) await ok(who, `mutation ($id: uuid!, $n: String!) { updateCardsByPk(pk_columns: {id: $id}, _set: {note: $n}) { id } }`, { id: prepareCard[0].cardId, n: note });
  return prepareCard[0].cardId as string;
};
const send = (who: any, id: string, anyway = false) =>
  ok(who, `mutation ($id: uuid!, $a: Boolean!) { sendCard(args: {cardId: $id, anyway: $a}) { id status heldReason } }`, { id, a: anyway }).then((d) => d.sendCard[0]);

test('a harsh note holds the card with a reason, nothing is delivered, and sending anyway delivers it', async () => {
  const { a, b } = await couple();
  const id = await draft(a, 'fez o jantar', 'Você sempre esquece de tudo');
  const held = await send(a, id);
  assert.deepEqual([held.status, held.heldReason], ['held', 'absolute']);
  assert.deepEqual((await ok(b, `{ cards { id } }`)).cards, [], 'a held card is not delivered');
  assert.equal((await sql(`select count(*) from private.notifications where user_id = '${b.id}' and type = 'card_received'`))[0][0], '0');
  await ok(a, `mutation ($id: uuid!) { updateCardsByPk(pk_columns: {id: $id}, _set: {note: "Obrigada por tudo"}) { id } }`, { id });
  const sent = await send(a, id);
  assert.deepEqual([sent.status, sent.heldReason], ['sent', null], 'a clean rewrite sends without the override');
  assert.equal((await ok(b, `{ cards { id } }`)).cards.length, 1);
});

test('the person can send a held card anyway, and the item text is checked too', async () => {
  const { a, b } = await couple();
  const id = await draft(a, 'seu burro, mas eu amo');
  assert.equal((await send(a, id)).status, 'held');
  const sent = await send(a, id, true);
  assert.deepEqual([sent.status, sent.heldReason], ['sent', null]);
  assert.equal((await ok(b, `{ cardItems { body } }`)).cardItems.length, 1);
});

test('English wording is held too, and a kind note is not', async () => {
  const { a } = await couple();
  assert.equal((await send(a, await draft(a, 'made tea', 'It was your fault'))).heldReason, 'blame');
  const { a: c } = await couple();
  assert.equal((await send(c, await draft(c, 'made tea', 'thank you for the week'))).status, 'sent');
});

test('a single slip with a harsh note comes back as a held card that can be edited and sent anyway', async () => {
  const { a, b } = await couple();
  const slip = (await ok(a, `mutation { insertSlipsOne(object: {body: "lavou a louça"}) { id } }`)).insertSlipsOne;
  const held = (await ok(a, `mutation ($s: uuid!) { sendSlip(args: {slipId: $s, note: "eu odeio quando você some"}) { id status kind heldReason } }`, { s: slip.id })).sendSlip[0];
  assert.deepEqual([held.status, held.kind, held.heldReason], ['held', 'single', 'contempt']);
  assert.deepEqual((await ok(b, `{ cards { id } }`)).cards, []);
  assert.equal((await send(a, held.id, true)).status, 'sent');
});

test('the recipient can clear a reaction and the author cannot', async () => {
  const { a, b } = await couple();
  const id = await draft(a, 'fez café');
  await send(a, id);
  await ok(b, `mutation ($c: uuid!) { insertCardReactionsOne(object: {cardId: $c, reaction: "❤️"}) { cardId } }`, { c: id });
  const byAuthor = await ok(a, `mutation ($c: uuid!) { deleteCardReactionsByPk(cardId: $c) { cardId } }`, { c: id });
  assert.equal(byAuthor.deleteCardReactionsByPk, null);
  const cleared = await ok(b, `mutation ($c: uuid!) { deleteCardReactionsByPk(cardId: $c) { cardId } }`, { c: id });
  assert.equal(cleared.deleteCardReactionsByPk.cardId, id);
  assert.deepEqual((await ok(a, `{ cardReactions { cardId } }`)).cardReactions, []);
});

test('a voice note needs a short audio file of the sender, and the partner can read it', async () => {
  const { a, b } = await pairSessions();
  const audio = await upload(a.token, 'messages', M4A, 'v.m4a', 'audio/mp4');
  const mime = (await sql(`select mime_type from storage.files where id = '${audio.id}'`))[0][0];
  assert.match(mime, /^audio\//, `Storage detected ${mime}`);
  const voice = (id: string, ms: number) =>
    `mutation { insertPartnerMessagesOne(object: {kind: voice, mediaFileId: "${id}", durationMs: ${ms}}) { id durationMs } }`;
  assert.equal((await ok(a, voice(audio.id, 12_000))).insertPartnerMessagesOne.durationMs, 12_000);
  await denied(a, voice(audio.id, 30_001));
  await denied(a, voice(audio.id, 0));
  await denied(a, `mutation { insertPartnerMessagesOne(object: {kind: voice, mediaFileId: "${audio.id}"}) { id } }`);
  const refused = await denied(a, `mutation { insertPartnerMessagesOne(object: {kind: voice, durationMs: 1000, body: "só texto"}) { id } }`);
  assert.match(JSON.stringify(refused.errors), /INVALID_MEDIA/);
  const image = await upload(a.token, 'messages');
  const wrong = await denied(a, voice(image.id, 5_000));
  assert.match(JSON.stringify(wrong.errors), /INVALID_MEDIA/);
  assert.equal((await ok(b, `{ partnerMessages { kind durationMs } }`)).partnerMessages.length, 1);
});

test('a voice note cannot use a file somebody else uploaded or from another bucket, and a drawing must be an image', async () => {
  const { a, b } = await pairSessions();
  const theirs = await upload(b.token, 'messages', M4A, 'v.m4a', 'audio/mp4');
  await denied(a, `mutation { insertPartnerMessagesOne(object: {kind: voice, mediaFileId: "${theirs.id}", durationMs: 1000}) { id } }`);
  const slipFile = await upload(a.token, 'slips');
  await denied(a, `mutation { insertPartnerMessagesOne(object: {kind: drawing, mediaFileId: "${slipFile.id}"}) { id } }`);
  const audio = await upload(a.token, 'messages', M4A, 'v.m4a', 'audio/mp4');
  await denied(a, `mutation { insertPartnerMessagesOne(object: {kind: drawing, mediaFileId: "${audio.id}"}) { id } }`);
  const drawing = await upload(a.token, 'messages');
  await ok(a, `mutation { insertPartnerMessagesOne(object: {kind: drawing, mediaFileId: "${drawing.id}"}) { id } }`);
  await denied(a, `mutation { insertPartnerMessagesOne(object: {kind: note}) { id } }`);
});

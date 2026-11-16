import { test } from 'node:test';
import { assert, couple, denied, download, ok, plus, signUp, sql, upload, waitFor, type Session } from './lib.ts';

const inbox = (who: any, type: string) => ok(who, `{ inboxItems(where: {type: {_eq: ${type}}}) { refId } }`).then((d) => d.inboxItems);

async function pairSessions(): Promise<{ a: Session; b: Session; coupleId: string }> {
  const a = await signUp('Ana');
  const b = await signUp('Bruno');
  const { insertInvitesOne } = await ok(a, `mutation { insertInvitesOne(object: {}) { code } }`);
  await ok(b, `mutation ($c: String!) { acceptInvite(args: {code: $c}) { id } }`, { c: insertInvitesOne.code });
  return { a, b, coupleId: (await ok(a, `{ couples { id } }`)).couples[0].id };
}

// Quizzes ---------------------------------------------------------------------------------------------------------------
test('a quiz result is private until shown, the partner is told once, and a retake is private again', async () => {
  const { a, b } = await couple();
  const quiz = (await ok(a, `mutation { insertQuizResultsOne(object: {quizKey: loved, ranked: ["a", "b"]}) { id sharedAt } }`)).insertQuizResultsOne;
  assert.equal(quiz.sharedAt, null);
  assert.deepEqual((await ok(b, `{ quizResults { id } }`)).quizResults, []);
  await ok(a, `mutation ($id: uuid!) { updateQuizResultsByPk(pk_columns: {id: $id}, _set: {sharedAt: "2020-01-01T00:00:00Z"}) { sharedAt } }`, { id: quiz.id });
  const seen = (await ok(b, `{ quizResults { ranked sharedAt } }`)).quizResults;
  assert.equal(seen.length, 1);
  assert.deepEqual(seen[0].ranked, ['a', 'b']);
  assert.ok(new Date(seen[0].sharedAt).getFullYear() >= 2026, 'the server sets the time of sharing');
  assert.deepEqual(await inbox(b, 'quiz_shared'), [{ refId: quiz.id }]);

  await ok(a, `mutation ($id: uuid!) { updateQuizResultsByPk(pk_columns: {id: $id}, _set: {ranked: ["b", "a"]}) { sharedAt } }`, { id: quiz.id });
  assert.deepEqual((await ok(b, `{ quizResults { id } }`)).quizResults, [], 'a new result is shown again explicitly');
  await ok(a, `mutation ($id: uuid!) { updateQuizResultsByPk(pk_columns: {id: $id}, _set: {sharedAt: "2020-01-01T00:00:00Z"}) { sharedAt } }`, { id: quiz.id });
  assert.equal((await inbox(b, 'quiz_shared')).length, 2);
  await ok(a, `mutation { unpair { id } }`);
  assert.deepEqual((await ok(b, `{ quizResults { id } }`)).quizResults, [], 'unpairing removes the access');
  const mine = await ok(b, `mutation ($id: uuid!) { updateQuizResultsByPk(pk_columns: {id: $id}, _set: {ranked: []}) { id } }`, { id: quiz.id });
  assert.equal(mine.updateQuizResultsByPk, null);
});

// Agreements ------------------------------------------------------------------------------------------------------------
test('an agreement counts once the other person confirms, and editing it takes the confirmation back', async () => {
  const { a, b, coupleId } = await couple();
  const solo = (await ok(a, `mutation { insertAgreementsOne(object: {body: "só uma nota"}) { id confirmedAt } }`)).insertAgreementsOne;
  assert.deepEqual((await ok(b, `{ agreements { id } }`)).agreements, []);
  const shared = (await ok(a, `mutation ($c: uuid!) { insertAgreementsOne(object: {body: "sem celular na mesa", coupleId: $c}) { id } }`, { c: coupleId })).insertAgreementsOne;
  const confirm = (who: any, id: string) => ok(who, `mutation ($id: uuid!) { confirmAgreement(args: {agreementId: $id}) { confirmedBy confirmedAt } }`, { id }).then((d) => d.confirmAgreement);
  assert.deepEqual(await confirm(a, shared.id), [], 'the author cannot confirm their own proposal');
  assert.deepEqual(await confirm(b, solo.id), [], 'a private note cannot be confirmed');
  const done = await confirm(b, shared.id);
  assert.equal(done[0].confirmedBy, b.id);
  await denied(b, `mutation ($id: uuid!) { updateAgreementsByPk(pk_columns: {id: $id}, _set: {confirmedAt: null}) { id } }`, { id: shared.id });
  assert.equal((await ok(b, `mutation ($id: uuid!) { updateAgreementsByPk(pk_columns: {id: $id}, _set: {body: "x"}) { id } }`, { id: shared.id })).updateAgreementsByPk, null, 'the partner cannot edit');
  await ok(a, `mutation ($id: uuid!) { updateAgreementsByPk(pk_columns: {id: $id}, _set: {body: "celular longe da mesa"}) { id } }`, { id: shared.id });
  assert.deepEqual((await ok(a, `{ agreementsByPk(id: "${shared.id}") { confirmedAt confirmedBy } }`)).agreementsByPk, { confirmedAt: null, confirmedBy: null });
});

test('the free plan keeps 3 active agreements and Plus lifts it', async () => {
  const { a } = await couple();
  for (let i = 0; i < 3; i++) await ok(a, `mutation { insertAgreementsOne(object: {body: "acordo"}) { id } }`);
  const refused = await denied(a, `mutation { insertAgreementsOne(object: {body: "quarto"}) { id } }`);
  assert.match(JSON.stringify(refused.errors), /FREE_LIMIT_REACHED/);
  await plus(a);
  await ok(a, `mutation { insertAgreementsOne(object: {body: "quarto"}) { id } }`);
});

test('a logistics item becomes agreed only when the other person confirms it', async () => {
  const { a, b, coupleId } = await couple();
  const item = (await ok(a, `mutation ($c: uuid!) { insertLogisticItemsOne(object: {title: "mercado", coupleId: $c}) { id confirmedAt } }`, { c: coupleId })).insertLogisticItemsOne;
  const confirm = (who: any) => ok(who, `mutation ($id: uuid!) { confirmLogisticItem(args: {itemId: $id}) { confirmedBy } }`, { id: item.id }).then((d) => d.confirmLogisticItem);
  assert.deepEqual(await confirm(a), []);
  assert.equal((await confirm(b))[0].confirmedBy, b.id);
  await denied(b, `mutation ($id: uuid!) { updateLogisticItemsByPk(pk_columns: {id: $id}, _set: {confirmedAt: null}) { id } }`, { id: item.id });
  await ok(b, `mutation ($id: uuid!) { updateLogisticItemsByPk(pk_columns: {id: $id}, _set: {title: "feira"}) { id } }`, { id: item.id });
  assert.deepEqual((await ok(a, `{ logisticItems { confirmedAt } }`)).logisticItems, [{ confirmedAt: null }]);
});

// Memories --------------------------------------------------------------------------------------------------------------
test('a shared memory is a proposal until the partner accepts; its photo opens only after that', async () => {
  const { a, b, coupleId } = await pairSessions();
  const file = await upload(a.token, 'memories');
  const memory = (await ok(a, `mutation ($c: uuid!, $f: uuid!) { insertMemoriesOne(object: {title: "Praia", happenedOn: "2024-01-01", coupleId: $c, photoFileId: $f}) { id acceptedAt } }`, { c: coupleId, f: file.id })).insertMemoriesOne;
  assert.equal(memory.acceptedAt, null);
  assert.deepEqual(await inbox(b, 'memory_proposed'), [{ refId: memory.id }]);
  assert.deepEqual((await ok(b, `{ memories { id acceptedAt } }`)).memories, [{ id: memory.id, acceptedAt: null }], 'the partner sees the proposal');
  assert.equal(await download(b.token, file.id), 404, 'the photo waits for the answer');
  const respond = (who: any, accept: boolean) => ok(who, `mutation ($id: uuid!, $a: Boolean!) { respondMemory(args: {memoryId: $id, accept: $a}) { acceptedAt declinedAt coupleId } }`, { id: memory.id, a: accept }).then((d) => d.respondMemory);
  assert.deepEqual(await respond(a, true), [], 'the author cannot answer their own proposal');
  const accepted = await respond(b, true);
  assert.ok(accepted[0].acceptedAt);
  assert.deepEqual(await inbox(a, 'memory_accepted'), [{ refId: memory.id }]);
  assert.equal(await download(b.token, file.id), 200);
  assert.deepEqual(await respond(b, true), [], 'answered once');
});

test('declining a shared memory returns it to the author as a private one', async () => {
  const { a, b, coupleId } = await couple();
  const memory = (await ok(a, `mutation ($c: uuid!) { insertMemoriesOne(object: {title: "x", happenedOn: "2024-01-01", coupleId: $c}) { id } }`, { c: coupleId })).insertMemoriesOne;
  // The memory leaves the partner's sight at once, so the row is not returned to the person who declined.
  await ok(b, `mutation ($id: uuid!) { respondMemory(args: {memoryId: $id, accept: false}) { id } }`, { id: memory.id });
  assert.deepEqual((await ok(b, `{ memories { id } }`)).memories, []);
  assert.deepEqual((await ok(a, `{ memories { coupleId acceptedAt declinedAt } }`)).memories.map((m: any) => [m.coupleId, m.acceptedAt, m.declinedAt !== null]), [[null, null, true]]);
  assert.deepEqual(await inbox(a, 'memory_declined'), [{ refId: memory.id }]);
});

test('older shared memories count as accepted, and sharing again starts a new proposal', async () => {
  const { a, b, coupleId } = await couple();
  const memory = (await ok(a, `mutation { insertMemoriesOne(object: {title: "x", happenedOn: "2024-01-01"}) { id } }`)).insertMemoriesOne;
  await ok(a, `mutation ($id: uuid!, $c: uuid!) { updateMemoriesByPk(pk_columns: {id: $id}, _set: {coupleId: $c}) { id } }`, { id: memory.id, c: coupleId });
  assert.deepEqual(await inbox(b, 'memory_proposed'), [{ refId: memory.id }]);
  await ok(b, `mutation ($id: uuid!) { respondMemory(args: {memoryId: $id, accept: true}) { id } }`, { id: memory.id });
  await ok(a, `mutation ($id: uuid!) { updateMemoriesByPk(pk_columns: {id: $id}, _set: {coupleId: null}) { id } }`, { id: memory.id });
  assert.deepEqual((await ok(a, `{ memories { acceptedAt } }`)).memories, [{ acceptedAt: null }]);
});

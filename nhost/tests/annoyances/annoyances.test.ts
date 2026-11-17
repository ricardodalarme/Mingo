import { test } from 'node:test';
import { assert, couple, denied, ok, person, sql } from '../lib.ts';

async function run(job: string): Promise<number> {
  const { runJob } = await ok('admin', `mutation ($job: String!) { runJob(args: {job: $job}) { affected } }`, { job });
  return runJob[0].affected;
}

const annoy = (who: any, body = 'deixou a louça') =>
  ok(who, `mutation ($b: String!) { insertAnnoyancesOne(object: {body: $b}) { id expiresAt } }`, { b: body }).then((d) => d.insertAnnoyancesOne);

const send = (who: any, extra = '') =>
  ok(who, `mutation { sendGentleRequest(args: {whenText: "Quando a louça fica", feelText: "Eu me sinto sozinha", wishText: "Eu gostaria de dividir" ${extra}}) { id recipientId response } }`)
    .then((d) => d.sendGentleRequest[0]);

test('an annoyance is private to its author, never extended by the client, and gone after 14 days', async () => {
  const { a, b } = await couple();
  const note = await annoy(a);
  assert.deepEqual((await ok(b, `{ annoyances { id } annoyancesAggregate { aggregate { count } } }`)).annoyances, []);
  const days = Number((await sql(`select extract(epoch from (expires_at - created_at)) / 86400 from public.annoyances where id = '${note.id}'`))[0][0]);
  assert.equal(Math.round(days), 14);
  await denied(a, `mutation { insertAnnoyancesOne(object: {body: "x", expiresAt: "2999-01-01T00:00:00Z"}) { id } }`);
  await denied(a, `mutation ($id: uuid!) { updateAnnoyancesByPk(pk_columns: {id: $id}, _set: {expiresAt: "2999-01-01T00:00:00Z"}) { id } }`, { id: note.id });
  await ok(a, `mutation ($id: uuid!) { updateAnnoyancesByPk(pk_columns: {id: $id}, _set: {body: "outra"}) { id } }`, { id: note.id });
    assert.deepEqual((await ok(b, `mutation ($id: uuid!) { deleteAnnoyancesByPk(id: $id) { id } }`, { id: note.id })).deleteAnnoyancesByPk, null);

  await sql(`update public.annoyances set expires_at = now() - interval '1 minute' where id = '${note.id}'`);
  assert.ok((await run('expire_annoyances')) >= 1);
  assert.deepEqual((await ok(a, `{ annoyances { id } }`)).annoyances, []);
});

test('on day 10 the author is asked once whether it still bothers, in the inbox only', async () => {
  const { a } = await couple();
  const note = await annoy(a);
  await run('expire_annoyances');
  assert.deepEqual((await ok(a, `{ inboxItems(where: {type: {_eq: annoyance_check}}) { id } }`)).inboxItems, []);
  await sql(`update public.annoyances set created_at = now() - interval '11 days', expires_at = now() + interval '3 days' where id = '${note.id}'`);
  await run('expire_annoyances');
  await run('expire_annoyances');
  const items = (await ok(a, `{ inboxItems(where: {type: {_eq: annoyance_check}}) { refId } }`)).inboxItems;
  assert.deepEqual(items, [{ refId: note.id }]);
  assert.deepEqual(await sql(`select 1 from private.notifications where user_id = '${a.id}' and type = 'annoyance_check'`), []);
});

test('an old bothered slip is not a slip any more: no table of the partner, the card, the recap or the today view shows it', async () => {
  const { a, b } = await couple();
  const note = await annoy(a, 'texto-secreto-xyz');
  for (const who of [a, b]) {
    const data = await ok(who, `{ slips { body } today { slipsTotal } yearRecaps { slips } }`);
    assert.deepEqual(data.slips, []);
    assert.equal(data.today[0].slipsTotal, 0);
    assert.deepEqual(data.yearRecaps.map((r: any) => r.slips), [0]);
  }
  assert.ok(note.id);
});

test('a gentle request goes to the partner with three parts, and the annoyance it came from leaves', async () => {
  const { a, b } = await couple();
  const note = await annoy(a);
  const request = await send(a, `, annoyanceId: "${note.id}"`);
  assert.equal(request.recipientId, b.id);
  assert.deepEqual((await ok(a, `{ annoyances { id } }`)).annoyances, []);
  const seen = (await ok(b, `{ gentleRequests { whenText feelText wishText response } }`)).gentleRequests;
  assert.deepEqual(seen, [{ whenText: 'Quando a louça fica', feelText: 'Eu me sinto sozinha', wishText: 'Eu gostaria de dividir', response: null }]);
  const pushes = await sql(`select type from private.notifications where user_id = '${b.id}' and type = 'gentle_request'`);
  assert.equal(pushes.length, 1);
  assert.deepEqual((await ok(b, `{ inboxItems(where: {type: {_eq: gentle_request}}) { refId } }`)).inboxItems, [{ refId: request.id }]);
  await denied(b, `mutation { insertGentleRequestsOne(object: {whenText: "a", feelText: "b", wishText: "c"}) { id } }`);
});

test('a request without a partner is rejected, and a stranger sees nothing', async () => {
  const solo = await person();
  const refused = await denied(solo, `mutation { sendGentleRequest(args: {whenText: "a", feelText: "b", wishText: "c"}) { id } }`);
  assert.match(JSON.stringify(refused.errors), /NOT_PAIRED/);
  const { a } = await couple();
  await send(a);
  assert.deepEqual((await ok(solo, `{ gentleRequests { id } }`)).gentleRequests, []);
});

test('the answer is told to the sender, the request fades 7 days later, and the sender can thank once', async () => {
  const { a, b } = await couple();
  const request = await send(a);
  const bySender = await ok(a, `mutation ($id: uuid!) { updateGentleRequestsByPk(pk_columns: {id: $id}, _set: {response: will_do}) { id } }`, { id: request.id });
  assert.equal(bySender.updateGentleRequestsByPk, null, 'the sender cannot answer their own request');
  await denied(b, `mutation ($id: uuid!) { updateGentleRequestsByPk(pk_columns: {id: $id}, _set: {whenText: "x"}) { id } }`, { id: request.id });
  await ok(b, `mutation ($id: uuid!) { updateGentleRequestsByPk(pk_columns: {id: $id}, _set: {response: will_do}) { response respondedAt } }`, { id: request.id });
  const types = (await ok(a, `{ inboxItems(where: {type: {_eq: gentle_request_answered}}) { refId } }`)).inboxItems;
  assert.deepEqual(types, [{ refId: request.id }]);
  const days = Number((await sql(`select extract(epoch from (purge_after - responded_at)) / 86400 from public.gentle_requests where id = '${request.id}'`))[0][0]);
  assert.equal(Math.round(days), 7);

  assert.deepEqual((await ok(b, `mutation ($id: uuid!) { thankGentleRequest(args: {requestId: $id, body: "obrigada"}) { id } }`, { id: request.id })).thankGentleRequest, []);
  const thanks = (await ok(a, `mutation ($id: uuid!) { thankGentleRequest(args: {requestId: $id, body: "obrigada por lavar a louça"}) { body polarity category kind authorId } }`, { id: request.id })).thankGentleRequest;
  assert.deepEqual(thanks, [{ body: 'obrigada por lavar a louça', polarity: 'liked', category: 'said', kind: 'quick', authorId: a.id }]);
  assert.deepEqual((await ok(a, `mutation ($id: uuid!) { thankGentleRequest(args: {requestId: $id, body: "de novo"}) { id } }`, { id: request.id })).thankGentleRequest, []);
  assert.equal((await ok(a, `{ slipsAggregate { aggregate { count } } }`)).slipsAggregate.aggregate.count, 1);
  assert.deepEqual((await ok(b, `{ slips { id } }`)).slips, []);

  await sql(`update public.gentle_requests set purge_after = now() - interval '1 second' where id = '${request.id}'`);
  await run('expire_annoyances');
  assert.deepEqual((await ok(b, `{ gentleRequests { id } }`)).gentleRequests, []);
});

test('only answers that were not "will do" cannot be thanked, and an unanswered request fades after 30 days', async () => {
  const { a, b } = await couple();
  const request = await send(a);
  const days = Number((await sql(`select extract(epoch from (purge_after - created_at)) / 86400 from public.gentle_requests where id = '${request.id}'`))[0][0]);
  assert.equal(Math.round(days), 30);
  await ok(b, `mutation ($id: uuid!) { updateGentleRequestsByPk(pk_columns: {id: $id}, _set: {response: later}) { id } }`, { id: request.id });
  assert.deepEqual((await ok(a, `mutation ($id: uuid!) { thankGentleRequest(args: {requestId: $id, body: "x"}) { id } }`, { id: request.id })).thankGentleRequest, []);
});

test('a request ends with the couple', async () => {
  const { a, b } = await couple();
  await send(a);
  await ok(a, `mutation { unpair { id } }`);
  assert.deepEqual((await ok(b, `{ gentleRequests { id } }`)).gentleRequests, []);
});

test('an answer to a gentle request is one of five, in the schema and in the database', async () => {
  const { a, b } = await couple();
  const request = await send(a);

  await denied(b, `mutation ($id: uuid!) { updateGentleRequestsByPk(pk_columns: {id: $id}, _set: {response: whenever}) { id } }`, { id: request.id });
  await assert.rejects(sql(`update public.gentle_requests set response = 'whenever' where id = '${request.id}'`));

  const values = (await sql(`select value from public.gentle_response order by value`)).map((row) => row[0]);
  assert.deepEqual(values, ['later', 'more_time', 'not_now', 'talk', 'will_do']);
});

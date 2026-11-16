import { test } from 'node:test';
import { adult, assert, ok, signUp, sql, urls, type Session } from './lib.ts';
import { loadContext, type CallerQuery } from '../../functions/_lib/chat_context.ts';

const as = (s: Session): CallerQuery => async (query, variables = {}) => {
  const res = await fetch(urls.graphql, { method: 'POST', headers: { 'content-type': 'application/json', authorization: `Bearer ${s.token}` }, body: JSON.stringify({ query, variables }) });
  const body = (await res.json()) as any;
  if (body.errors?.length || !body.data) throw new Error(body.errors?.[0]?.message ?? 'failed');
  return body.data;
};

async function pairSessions() {
  const a = await signUp('Ana');
  const b = await signUp('Bruno');
  const { insertInvitesOne } = await ok(a, `mutation { insertInvitesOne(object: {}) { code } }`);
  await ok(b, `mutation ($c: String!) { acceptInvite(args: {code: $c}) { id } }`, { c: insertInvitesOne.code });
  const coupleId = (await ok(a, `{ couples { id } }`)).couples[0].id;
  return { a, b, coupleId };
}

const ALL = ['slips', 'mood', 'week', 'dates', 'lists', 'logistics', 'rituals', 'plan'];

test('no loader runs unless the request names it', async () => {
  const { a } = await pairSessions();
  await ok(a, `mutation { insertSlipsOne(object: {body: "segredo-de-a"}) { id } }`);
  const none = await loadContext(as(a), undefined);
  assert.equal(none.text, '');
  const unknown = await loadContext(as(a), ['annoyances', 'spice', 'journal', 42]);
  assert.equal(unknown.text, '', 'unknown names load nothing');
  const slips = await loadContext(as(a), ['slips']);
  assert.match(slips.text, /segredo-de-a/);
  assert.doesNotMatch(slips.text, /mood|plan:/);
});

test('with every loader on, nothing the partner keeps private, no annoyance, no Tempero and no repair text comes back', async () => {
  const { a, b, coupleId } = await pairSessions();
  await ok(b, `mutation { insertSlipsOne(object: {body: "slip-privado-de-b"}) { id } insertAnnoyancesOne(object: {body: "incomodo-de-b"}) { id }
    insertMoodsOne(object: {day: "2026-01-01", mood: sad}) { id } insertTemperatureChecksOne(object: {level: fight, note: "nota-de-b"}) { id }
    insertJournalEntriesOne(object: {entryDate: "2026-01-01", body: "diario-de-b"}) { id }
    insertRepairSessionsOne(object: {intensity: 2, path: quick, draft: "rascunho-de-reparo-b"}) { id } }`);
  await ok(a, `mutation { insertSlipsOne(object: {body: "slip-de-a"}) { id } insertAnnoyancesOne(object: {body: "incomodo-de-a"}) { id }
    insertJournalEntriesOne(object: {entryDate: "2026-01-01", body: "diario-de-a"}) { id } }`);
  await ok(a, `mutation ($c: uuid!) { insertListsOne(object: {title: "lista-privada-de-a"}) { id } insertImportantDatesOne(object: {title: "data-compartilhada", month: 5, day: 12, coupleId: $c}) { id } }`, { c: coupleId });
  await ok(b, `mutation { insertListsOne(object: {title: "lista-privada-de-b"}) { id } insertRitualsOne(object: {title: "ritual-privado-de-b"}) { id } insertLogisticItemsOne(object: {title: "tarefa-privada-de-b"}) { id } }`);
  await sql(`insert into public.entitlements (user_id, plan, status) values ('${b.id}', 'plus_annual', 'active')`);
  await adult(b);
  await sql(`update public.user_settings set spice_enabled = true where user_id = '${b.id}'`);
  await sql(`insert into public.spice_desire_answers (user_id, content_slug, answer) values ('${b.id}', 'desejo-secreto-b', 'want')`);
  await sql(`delete from public.entitlements where user_id = '${b.id}'`);

  const { text } = await loadContext(as(a), ALL);
  assert.match(text, /slip-de-a/);
  assert.match(text, /lista-privada-de-a/);
  assert.match(text, /data-compartilhada/);
  assert.match(text, /plan: Free, 5 of 5/);
  for (const secret of ['slip-privado-de-b', 'incomodo-de-b', 'incomodo-de-a', 'nota-de-b', 'diario-de-b', 'diario-de-a', 'rascunho-de-reparo-b',
    'lista-privada-de-b', 'ritual-privado-de-b', 'tarefa-privada-de-b', 'desejo-secreto-b']) {
    assert.doesNotMatch(text, new RegExp(secret), `the context leaks ${secret}`);
  }
});

test('a diary entry is read only when its id is listed and the caller owns it', async () => {
  const { a, b } = await pairSessions();
  const mine = (await ok(a, `mutation { insertJournalEntriesOne(object: {entryDate: "2026-01-01", body: "diario-meu"}) { id } }`)).insertJournalEntriesOne.id;
  const theirs = (await ok(b, `mutation { insertJournalEntriesOne(object: {entryDate: "2026-01-02", body: "diario-do-parceiro"}) { id } }`)).insertJournalEntriesOne.id;
  assert.doesNotMatch((await loadContext(as(a), ALL)).text, /diario/);
  const text = (await loadContext(as(a), [], [mine, theirs, 'not-a-uuid'])).text;
  assert.match(text, /diario-meu/);
  assert.doesNotMatch(text, /diario-do-parceiro/);
});

test('the pronouns are the ones the person stated, or none', async () => {
  const { a, b } = await pairSessions();
  assert.deepEqual(await loadContext(as(a), []), { text: '', pronouns: null, partnerPronouns: null, partnerName: null });
  await ok(a, `mutation ($id: uuid!) { updateProfilesByPk(pk_columns: {id: $id}, _set: {pronouns: she}) { id } updateUserSettingsByPk(pk_columns: {userId: $id}, _set: {partnerPronouns: he, partnerName: "Bruno"}) { userId } }`, { id: a.id });
  await ok(b, `mutation ($id: uuid!) { updateProfilesByPk(pk_columns: {id: $id}, _set: {pronouns: name_only}) { id } }`, { id: b.id });
  const ctx = await loadContext(as(a), []);
  assert.deepEqual([ctx.pronouns, ctx.partnerPronouns, ctx.partnerName], ['she', 'he', 'Bruno']);
  await ok(a, `mutation ($id: uuid!) { updateUserSettingsByPk(pk_columns: {userId: $id}, _set: {partnerPronouns: null}) { userId } }`, { id: a.id });
  assert.equal((await loadContext(as(a), [])).partnerPronouns, 'name_only', 'falls back to what the partner declared');
});

test('a failing block is left out and the chat still gets the rest', async () => {
  const { a } = await pairSessions();
  await ok(a, `mutation { insertSlipsOne(object: {body: "ainda-aqui"}) { id } }`);
  const flaky: CallerQuery = async (query, variables) => {
    if (query.includes('moods(')) throw new Error('boom');
    return as(a)(query, variables);
  };
  const { text } = await loadContext(flaky, ['mood', 'slips']);
  assert.match(text, /ainda-aqui/);
});

test('the person with nothing set up gets an empty context, not an error', async () => {
  const lone = await signUp('Sozinha');
  const ctx = await loadContext(as(lone), ALL);
  assert.match(ctx.text, /plan: Free/);
});

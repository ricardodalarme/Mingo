import { test } from 'node:test';
import { assert, ok, person, sql } from '../lib.ts';

const status = (who: any, code: string) =>
  ok(who, `query ($c: String!) { inviteStatus(args: {code: $c}) { state inviterName expiresAt } }`, { c: code }).then((d) => d.inviteStatus[0]);
const accept = (who: any, code: string) =>
  ok(who, `mutation ($c: String!) { tryAcceptInvite(args: {code: $c}) { state } }`, { c: code }).then((d) => d.tryAcceptInvite[0].state);
const invite = async (who: any) => (await ok(who, `mutation { insertInvitesOne(object: {}) { id code } }`)).insertInvitesOne;

test('a code is valid, used, expired, cancelled or unknown, and only a valid one shows the name', async () => {
  const a = await person('Ana Souza');
  const b = await person('Bruno');
  const i = await invite(a);
  const valid = await status('public', i.code.toLowerCase());
  assert.equal(valid.state, 'valid');
  assert.equal(valid.inviterName, 'Ana');
  assert.ok(valid.expiresAt);
  assert.deepEqual(await status('public', 'NOPE123'), { state: 'unknown', inviterName: null, expiresAt: null });
  assert.equal(await accept(b, i.code), 'accepted');
  assert.deepEqual(await status('public', i.code), { state: 'used', inviterName: null, expiresAt: null });

  const c = await person('Carla');
  const old = await invite(c);
  await sql(`update public.invites set expires_at = now() - interval '1 minute' where id = '${old.id}'`);
  assert.equal((await status(b, old.code)).state, 'expired');
  const d = await person('Davi');
  const gone = await invite(d);
  await ok(d, `mutation ($id: uuid!) { updateInvitesByPk(pk_columns: {id: $id}, _set: {cancelledAt: "2026-01-01T00:00:00Z"}) { id } }`, { id: gone.id });
  assert.equal((await status('public', gone.code)).state, 'cancelled');
});

test('accepting says why it did not work', async () => {
  const a = await person('Ana');
  const b = await person('Bruno');
  const c = await person('Carla');
  const i = await invite(a);
  assert.equal(await accept(a, i.code), 'own_code');
  assert.equal(await accept(b, 'NOPE123'), 'unknown');
  assert.equal(await accept(b, i.code), 'accepted');
  assert.equal(await accept(b, i.code), 'already_connected');
  assert.equal(await accept(c, i.code), 'used');

  const d = await person('Davi');
  const e = await person('Eva');
  const j = await invite(d);
  await sql(`update public.invites set expires_at = now() - interval '1 minute' where id = '${j.id}'`);
  assert.equal(await accept(e, j.code), 'expired');

  const f = await person('Fabio');
  const k = await invite(f);
  await ok(f, `mutation ($id: uuid!) { updateInvitesByPk(pk_columns: {id: $id}, _set: {cancelledAt: "2026-01-01T00:00:00Z"}) { id } }`, { id: k.id });
  assert.equal(await accept(e, k.code), 'cancelled');
});

test('a paired person cannot join another code', async () => {
  const a = await person('Ana');
  const b = await person('Bruno');
  assert.equal(await accept(b, (await invite(a)).code), 'accepted');
  const x = await person('Xavier');
  assert.equal(await accept(b, (await invite(x)).code), 'you_are_paired');
});

test('the code can be tried 10 times an hour', async () => {
  const a = await person();
  for (let i = 0; i < 10; i++) assert.equal(await accept(a, `NOPE${i}`), 'unknown');
  assert.equal(await accept(a, 'NOPE11'), 'rate_limited');
});

test('the legacy accept still works for older apps', async () => {
  const a = await person('Ana');
  const b = await person('Bruno');
  const i = await invite(a);
  const accepted = await ok(b, `mutation ($c: String!) { acceptInvite(args: {code: $c}) { id } }`, { c: i.code });
  assert.deepEqual(accepted.acceptInvite, [{ id: b.id }]);
});

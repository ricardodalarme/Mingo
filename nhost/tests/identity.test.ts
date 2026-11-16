import { test } from 'node:test';
import { assert, couple, denied, gql, ok, pair, person, sql } from './lib.ts';

test('a new auth user gets a profile, settings and notification settings', async () => {
  const p = await person('Ana Souza');
  const data = await ok(p, `{ profiles { id displayName timeZone avatarKind } userSettings { userId locale theme } notificationSettings { userId enabled } }`);
  assert.deepEqual(data.profiles, [{ id: p.id, displayName: 'Ana Souza', timeZone: 'America/Sao_Paulo', avatarKind: 'initials' }]);
  assert.equal(data.userSettings[0].userId, p.id);
  assert.equal(data.notificationSettings[0].enabled, true);
});

test('an e-mail is never used as a display name', async () => {
  const p = await person();
  const data = await ok(p, `{ profiles { displayName } }`);
  assert.equal(data.profiles[0].displayName, null);
});

test('a stranger sees no profile, settings, couple or membership of someone else', async () => {
  const { a, coupleId } = await couple();
  const stranger = await person();
  const data = await ok(stranger, `query ($id: uuid!, $c: uuid!) {
    profilesByPk(id: $id) { id } userSettingsByPk(userId: $id) { userId } couplesByPk(id: $c) { id }
    coupleMembers(where: { coupleId: { _eq: $c } }) { userId } }`, { id: a.id, c: coupleId });
  assert.deepEqual(data, { profilesByPk: null, userSettingsByPk: null, couplesByPk: null, coupleMembers: [] });
});

test('a partner sees the profile but never the private settings', async () => {
  const { a, b } = await couple();
  const data = await ok(b, `query ($id: uuid!) { profilesByPk(id: $id) { id displayName timeZone } userSettingsByPk(userId: $id) { userId } }`, { id: a.id });
  assert.equal(data.profilesByPk.displayName, 'Ana');
  assert.equal(data.userSettingsByPk, null);
  await denied(b, `query ($id: uuid!) { profilesByPk(id: $id) { settings { spiceEnabled } id } userSettings(where: {userId: {_eq: $id}}) { nope } }`, { id: a.id });
  const nested = await ok(b, `query ($id: uuid!) { profilesByPk(id: $id) { settings { userId } } }`, { id: a.id });
  assert.equal(nested.profilesByPk.settings, null);
});

test('a person edits only their own profile and settings', async () => {
  const { a, b } = await couple();
  const mine = await ok(a, `mutation ($id: uuid!) { updateProfilesByPk(pk_columns: {id: $id}, _set: {displayName: "Aninha"}) { displayName } }`, { id: a.id });
  assert.equal(mine.updateProfilesByPk.displayName, 'Aninha');
  const theirs = await ok(a, `mutation ($id: uuid!) {
    updateProfilesByPk(pk_columns: {id: $id}, _set: {displayName: "x"}) { id }
    updateUserSettingsByPk(pk_columns: {userId: $id}, _set: {spiceEnabled: true}) { userId } }`, { id: b.id });
  assert.deepEqual(theirs, { updateProfilesByPk: null, updateUserSettingsByPk: null });
  await denied(a, `mutation ($id: uuid!) { updateProfilesByPk(pk_columns: {id: $id}, _set: {id: "00000000-0000-0000-0000-000000000000"}) { id } }`, { id: a.id });
});

test('an invite code pairs two people and can be read again by its creator only', async () => {
  const a = await person('Ana');
  const b = await person('Bruno');
  const { insertInvitesOne: invite } = await ok(a, `mutation { insertInvitesOne(object: {}) { id code expiresAt createdBy } }`);
  assert.match(invite.code, /^[A-Z2-9]{8}$/);
  assert.equal(invite.createdBy, a.id);
  assert.deepEqual((await ok(b, `{ invites { id } }`)).invites, []);
  const preview = await ok('public', `query ($c: String!) { invitePreview(args: {code: $c}) { inviterName expiresAt } }`, { c: invite.code.toLowerCase() });
  assert.equal(preview.invitePreview[0].inviterName, 'Ana');
  const accepted = await ok(b, `mutation ($c: String!) { acceptInvite(args: {code: $c}) { id } }`, { c: invite.code });
  assert.deepEqual(accepted.acceptInvite, [{ id: b.id }]);
  const { couples } = await ok(a, `{ couples { id members { userId role } } }`);
  assert.deepEqual(couples[0].members.map((m: any) => m.role).sort(), ['invitee', 'inviter']);
  const again = await ok(b, `mutation ($c: String!) { acceptInvite(args: {code: $c}) { id } }`, { c: invite.code });
  assert.deepEqual(again.acceptInvite, [{ id: b.id }], 'a retry succeeds again');
  assert.deepEqual((await ok('public', `query ($c: String!) { invitePreview(args: {code: $c}) { inviterName } }`, { c: invite.code })).invitePreview, []);
});

test('every unusable code gets the same empty answer', async () => {
  const a = await person();
  const b = await person();
  const c = await person();
  const accept = (who: any, code: string) => ok(who, `mutation ($c: String!) { acceptInvite(args: {code: $c}) { id } }`, { c: code }).then((d) => d.acceptInvite);
  const { insertInvitesOne: own } = await ok(a, `mutation { insertInvitesOne(object: {}) { id code } }`);
  assert.deepEqual(await accept(a, own.code), [], 'own code');
  assert.deepEqual(await accept(b, 'ZZZZZZZZ'), [], 'unknown code');
  await ok(a, `mutation ($id: uuid!) { updateInvitesByPk(pk_columns: {id: $id}, _set: {cancelledAt: "2000-01-01"}) { cancelledAt } }`, { id: own.id });
  assert.deepEqual(await accept(b, own.code), [], 'cancelled code');
  const { insertInvitesOne: fresh } = await ok(a, `mutation { insertInvitesOne(object: {}) { id code } }`);
  await sql(`update public.invites set expires_at = now() - interval '1 minute' where id = '${fresh.id}'`);
  assert.deepEqual(await accept(b, fresh.code), [], 'expired code');
  const { insertInvitesOne: live } = await ok(a, `mutation { insertInvitesOne(object: {}) { code } }`);
  await pair(b, c);
  assert.deepEqual(await accept(b, live.code), [], 'caller already paired');
});

test('a new invite replaces the pending one, and a paired person cannot invite', async () => {
  const a = await person();
  const first = (await ok(a, `mutation { insertInvitesOne(object: {}) { id } }`)).insertInvitesOne;
  await ok(a, `mutation { insertInvitesOne(object: {}) { id } }`);
  const rows = (await ok(a, `{ invites(order_by: {createdAt: asc}) { id cancelledAt } }`)).invites;
  assert.equal(rows.length, 2);
  assert.equal(rows.find((r: any) => r.id === first.id).cancelledAt !== null, true);
  const { a: paired } = await couple();
  await denied(paired, `mutation { insertInvitesOne(object: {}) { id } }`);
});

test('accepting is limited to ten attempts an hour', async () => {
  const a = await person();
  const b = await person();
  for (let i = 0; i < 10; i++) await ok(b, `mutation { acceptInvite(args: {code: "NOPE${i}"}) { id } }`);
  const { insertInvitesOne } = await ok(a, `mutation { insertInvitesOne(object: {}) { code } }`);
  const result = await ok(b, `mutation ($c: String!) { acceptInvite(args: {code: $c}) { id } }`, { c: insertInvitesOne.code });
  assert.deepEqual(result.acceptInvite, []);
});

test('a couple never has a third member', async () => {
  const { coupleId } = await couple();
  const c = await person();
  const res = await fetch('http://localhost:8080/v2/query', { method: 'POST', headers: { 'x-hasura-admin-secret': (await import('./lib.ts')).adminSecret },
    body: JSON.stringify({ type: 'run_sql', args: { sql: `insert into public.couple_members (couple_id, user_id, role) values ('${coupleId}', '${c.id}', 'invitee')` } }) });
  assert.equal(res.ok, false);
});

test('unpairing cuts the ex-partner off at once and notifies only the other person', async () => {
  const { a, b, coupleId } = await couple();
  const out = await ok(a, `mutation { unpair { id } }`);
  assert.equal(out.unpair[0].id, a.id);
  for (const who of [a, b]) {
    const data = await ok(who, `query ($c: uuid!) { couplesByPk(id: $c) { id } coupleMembers { userId } profiles { id } }`, { c: coupleId });
    assert.equal(data.couplesByPk, null);
    assert.deepEqual(data.coupleMembers, []);
    assert.deepEqual(data.profiles, [{ id: who.id }]);
  }
  const notices = await sql(`select user_id from private.notifications where type = 'unpaired' and ref_id = '${coupleId}'`);
  assert.deepEqual(notices, [[b.id]]);
  assert.deepEqual((await ok(a, `mutation { unpair { id } }`)).unpair, [], 'nothing to end the second time');
});

test('the anonymous role reaches nothing of a person', async () => {
  for (const field of ['profiles', 'userSettings', 'couples', 'invites', 'slips', 'cards']) {
    await denied('public', `{ ${field} { __typename } }`);
  }
  assert.deepEqual((await gql('public', `mutation { unpair { id } }`)).data, undefined);
});

test('pronouns and the partner intent are closed sets a person chooses for themselves', async () => {
  const { a, b } = await couple();
  const chosen = await ok(a, `mutation ($id: uuid!) {
    updateProfilesByPk(pk_columns: {id: $id}, _set: {pronouns: she}) { pronouns }
    updateUserSettingsByPk(pk_columns: {userId: $id}, _set: {partnerPronouns: he, partnerIntent: solo_only}) { partnerPronouns partnerIntent } }`, { id: a.id });
  assert.deepEqual(chosen, {
    updateProfilesByPk: { pronouns: 'she' },
    updateUserSettingsByPk: { partnerPronouns: 'he', partnerIntent: 'solo_only' },
  });
  await denied(a, `mutation ($id: uuid!) { updateProfilesByPk(pk_columns: {id: $id}, _set: {pronouns: "any text"}) { id } }`, { id: a.id });
  await denied(a, `mutation ($id: uuid!) { updateUserSettingsByPk(pk_columns: {userId: $id}, _set: {partnerIntent: "never"}) { userId } }`, { id: a.id });
  assert.deepEqual(
    await ok(b, `mutation ($id: uuid!) { updateUserSettingsByPk(pk_columns: {userId: $id}, _set: {partnerIntent: invite}) { userId } }`, { id: a.id }),
    { updateUserSettingsByPk: null },
    'nobody sets another person\'s choice',
  );
  const own = await ok(a, `{ userSettings { partnerPronouns partnerIntent } }`);
  assert.deepEqual(own.userSettings, [{ partnerPronouns: 'he', partnerIntent: 'solo_only' }]);
});

test('the partner reads the pronouns a person chose but never their partner intent', async () => {
  const { a, b } = await couple();
  await ok(a, `mutation ($id: uuid!) {
    updateProfilesByPk(pk_columns: {id: $id}, _set: {pronouns: name_only}) { id }
    updateUserSettingsByPk(pk_columns: {userId: $id}, _set: {partnerIntent: later}) { userId } }`, { id: a.id });
  const seen = await ok(b, `query ($id: uuid!) { profilesByPk(id: $id) { pronouns } userSettingsByPk(userId: $id) { partnerIntent } }`, { id: a.id });
  assert.deepEqual(seen, { profilesByPk: { pronouns: 'name_only' }, userSettingsByPk: null });
});

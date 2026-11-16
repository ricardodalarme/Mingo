import { test } from 'node:test';
import { adult, assert, couple, denied, ok, person, signUp, sql, upload, download } from '../lib.ts';

const enableSpice = (who: { id: string }) =>
  `mutation { updateUserSettingsByPk(pk_columns: {userId: "${who.id}"}, _set: {spiceEnabled: true}) { spiceEnabled } }`;

test('Tempero needs the adult declaration, and withdrawing it blocks a later enable', async () => {
  const a = await person();
  const refused = await denied(a, enableSpice(a));
  assert.match(JSON.stringify(refused.errors), /ADULT_REQUIRED/);
  await adult(a);
  assert.deepEqual((await ok(a, `{ currentConsents { kind granted } }`)).currentConsents, [{ kind: 'adult', granted: true }]);
  await ok(a, enableSpice(a));
  await ok(a, `mutation { updateUserSettingsByPk(pk_columns: {userId: "${a.id}"}, _set: {spiceEnabled: false}) { spiceEnabled } }`);
  await new Promise((r) => setTimeout(r, 5));
  await adult(a, false);
  await denied(a, enableSpice(a));
  assert.deepEqual((await ok(a, `{ currentConsents { kind granted } }`)).currentConsents, [{ kind: 'adult', granted: false }]);
});

test('current consents show the newest answer per kind, and only to their owner', async () => {
  const { a, b } = await couple();
  await ok(a, `mutation { insertConsentsOne(object: {kind: terms, granted: true, version: "1"}) { id } }`);
  await ok(a, `mutation { insertConsentsOne(object: {kind: analytics, granted: true, version: "1"}) { id } }`);
  await new Promise((r) => setTimeout(r, 5));
  await ok(a, `mutation { insertConsentsOne(object: {kind: analytics, granted: false, version: "2"}) { id } }`);
  const mine = (await ok(a, `{ currentConsents(order_by: {kind: asc}) { kind granted version } }`)).currentConsents;
  assert.deepEqual(mine, [{ kind: 'analytics', granted: false, version: '2' }, { kind: 'terms', granted: true, version: '1' }]);
  assert.deepEqual((await ok(b, `{ currentConsents { kind } }`)).currentConsents, []);
});

test('the partner sees my avatar colour and file; a stranger does not; initials queue the old file', async () => {
  const ana = await signUp('Ana');
  const bruno = await signUp('Bruno');
  const stranger = await signUp('Carla');
  const file = await upload(ana.token, 'avatars');
  await ok(ana, `mutation ($id: uuid!) { updateProfilesByPk(pk_columns: {id: "${ana.id}"}, _set: {avatarKind: photo, avatarFileId: $id, avatarColor: "rose", avatarIllustration: "fox"}) { id } }`, { id: file.id });
  const { insertInvitesOne } = await ok(ana, `mutation { insertInvitesOne(object: {}) { code } }`);
  await ok(bruno, `mutation ($c: String!) { acceptInvite(args: {code: $c}) { id } }`, { c: insertInvitesOne.code });
  const seen = (await ok(bruno, `{ profiles(where: {id: {_eq: "${ana.id}"}}) { avatarColor avatarIllustration avatarFileId } }`)).profiles;
  assert.deepEqual(seen, [{ avatarColor: 'rose', avatarIllustration: 'fox', avatarFileId: file.id }]);
  assert.equal(await download(bruno.token, file.id), 200);
  assert.deepEqual((await ok(stranger, `{ profiles(where: {id: {_eq: "${ana.id}"}}) { id } }`)).profiles, []);
  await ok(ana, `mutation { updateProfilesByPk(pk_columns: {id: "${ana.id}"}, _set: {avatarKind: initials}) { avatarFileId } }`);
  assert.equal((await ok(ana, `{ profiles { avatarFileId } }`)).profiles[0].avatarFileId, null);
  // The queue row is consumed by the delete-file event, so the proof is that the file leaves Storage.
  for (let i = 0; i < 20 && (await sql(`select 1 from storage.files where id = '${file.id}'`)).length; i++) await new Promise((r) => setTimeout(r, 250));
  assert.deepEqual(await sql(`select 1 from storage.files where id = '${file.id}'`), []);
});

test('a photo avatar needs its file, and an over-long colour is refused', async () => {
  const a = await person();
  const refused = await denied(a, `mutation { updateProfilesByPk(pk_columns: {id: "${a.id}"}, _set: {avatarKind: photo}) { id } }`);
  assert.match(JSON.stringify(refused.errors), /AVATAR_FILE_REQUIRED/);
  await denied(a, `mutation { updateProfilesByPk(pk_columns: {id: "${a.id}"}, _set: {avatarColor: "${'x'.repeat(25)}"}) { id } }`);
});

test('an avatar must be an image of a known type', async () => {
  const a = await signUp('Ana');
  const form = new FormData();
  form.append('bucket-id', 'avatars');
  form.append('file[]', new Blob([new TextEncoder().encode('%PDF-1.4 test')], { type: 'application/pdf' }), 'a.pdf');
  const res = await fetch('http://localhost:8484/v1/files', { method: 'POST', headers: { authorization: `Bearer ${a.token}` }, body: form });
  const pdf = ((await res.json()) as any).processedFiles[0];
  const refused = await denied(a, `mutation ($id: uuid!) { updateProfilesByPk(pk_columns: {id: "${a.id}"}, _set: {avatarKind: photo, avatarFileId: $id}) { id } }`, { id: pdf.id });
  assert.match(JSON.stringify(refused.errors), /INVALID_MEDIA/);
});

test('a couple counts from the date either person sets, after seeing both dates', async () => {
  const { a, b } = await couple();
  await ok(a, `mutation { updateUserSettingsByPk(pk_columns: {userId: "${a.id}"}, _set: {togetherSince: "2020-02-01", hasKids: true}) { hasKids } }`);
  await ok(b, `mutation { updateUserSettingsByPk(pk_columns: {userId: "${b.id}"}, _set: {togetherSince: "2020-03-01"}) { userId } }`);
  const state = (await ok(a, `{ startDateState { mine partner couple matches } }`)).startDateState[0];
  assert.deepEqual(state, { mine: '2020-02-01', partner: '2020-03-01', couple: null, matches: false });
  assert.deepEqual((await ok(b, `{ startDateState { mine partner } }`)).startDateState[0], { mine: '2020-03-01', partner: '2020-02-01' });
  await ok(b, `mutation { setCoupleStartDate(args: {date: "2020-02-01"}) { id startDate startDateSetBy } }`);
  assert.deepEqual((await ok(a, `{ couples { startDate startDateSetBy } }`)).couples, [{ startDate: '2020-02-01', startDateSetBy: b.id }]);
  assert.equal((await ok(a, `{ userSettings { hasKids } }`)).userSettings[0].hasKids, true);
  assert.equal((await ok(b, `{ userSettings { hasKids } }`)).userSettings[0].hasKids, false, 'kids stay a personal answer');
});

test('the start date cannot be in the future, and a stranger or a solo person cannot set one', async () => {
  const { a } = await couple();
  const solo = await person();
  const future = new Date(Date.now() + 3 * 86_400_000).toISOString().slice(0, 10);
  const refused = await denied(a, `mutation { setCoupleStartDate(args: {date: "${future}"}) { id } }`);
  assert.match(JSON.stringify(refused.errors), /INVALID_DATE/);
  assert.deepEqual((await ok(solo, `mutation { setCoupleStartDate(args: {date: "2020-01-01"}) { id } }`)).setCoupleStartDate, []);
  assert.deepEqual((await ok(solo, `{ startDateState { mine } }`)).startDateState, []);
});

test('pronouns: the partner reads mine, my note about them stays private, and only the known values exist', async () => {
  const { a, b } = await couple();
  await ok(a, `mutation { updateProfilesByPk(pk_columns: {id: "${a.id}"}, _set: {pronouns: she}) { id } }`);
  assert.equal((await ok(b, `{ profiles(where: {id: {_eq: "${a.id}"}}) { pronouns } }`)).profiles[0].pronouns, 'she');
  await ok(a, `mutation { updateUserSettingsByPk(pk_columns: {userId: "${a.id}"}, _set: {partnerPronouns: he}) { userId } }`);
  assert.deepEqual((await ok(b, `{ userSettings(where: {userId: {_eq: "${a.id}"}}) { partnerPronouns } }`)).userSettings, []);
  await ok(a, `mutation { updateProfilesByPk(pk_columns: {id: "${a.id}"}, _set: {pronouns: name_only}) { pronouns } }`);
  await denied(a, `mutation { updateProfilesByPk(pk_columns: {id: "${a.id}"}, _set: {pronouns: they}) { id } }`);
  await sql(`select 1`);
  const refused = await sql(`select count(*) from public.pronoun where value in ('they', 'elu')`);
  assert.equal(refused[0][0], '0');
});

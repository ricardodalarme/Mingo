import { test } from 'node:test';
import { assert, couple, denied, download, ok, person, signUp, sql, upload, waitFor, zoneAtHour } from './lib.ts';

async function run(job: string): Promise<number> {
  const { runJob } = await ok('admin', `mutation ($job: String!) { runJob(args: {job: $job}) { affected job } }`, { job });
  assert.equal(runJob[0].job, job);
  return runJob[0].affected;
}

async function setZone(userId: string, hour: number): Promise<string> {
  const zone = await zoneAtHour(hour);
  await sql(`update public.profiles set time_zone = '${zone}' where id = '${userId}'`);
  return zone;
}

async function noHolidays(userId: string): Promise<void> {
  await sql(`update public.user_settings set holiday_countries = '{}' where user_id = '${userId}'`);
}

test('the weekly job creates one draft for the chosen day and hour, in the person own time zone', async () => {
  const p = await person();
  const zone = await setZone(p.id, 18);
  const dow = (await sql(`select extract(dow from now() at time zone '${zone}')::int`))[0][0];
  await sql(`update public.notification_settings set card_day = ${dow}, card_hour = 18 where user_id = '${p.id}'`);
  await ok(p, `mutation { insertSlipsOne(object: {body: "trouxe café"}) { id } }`);
  await run('weekly_cards');
  const cards = await ok(p, `{ cards { id status kind weekStart items { body } } }`);
  assert.equal(cards.cards.length, 1);
  assert.deepEqual([cards.cards[0].status, cards.cards[0].kind], ['draft', 'weekly']);
  assert.deepEqual(cards.cards[0].items.map((i: any) => i.body), ['trouxe café']);
  assert.deepEqual(await sql(`select type from private.notifications where user_id = '${p.id}' and type = 'card_ready'`), [['card_ready']]);
  await run('weekly_cards');
  assert.equal((await ok(p, `{ cards { id } }`)).cards.length, 1, 'a second run in the same week adds nothing');
});

test('the weekly job waits for the chosen day and hour of the person', async () => {
  const p = await person();
  const zone = await setZone(p.id, 18);
  const dow = (await sql(`select extract(dow from now() at time zone '${zone}')::int`))[0][0];
  await ok(p, `mutation { insertSlipsOne(object: {body: "um elogio"}) { id } }`);
  await sql(`update public.notification_settings set card_day = ${dow}, card_hour = (18 + 2) % 24 where user_id = '${p.id}'`);
  await run('weekly_cards');
  assert.deepEqual((await ok(p, `{ cards { id } }`)).cards, [], 'the hour has not arrived');
  await sql(`update public.notification_settings set card_day = (${dow} + 1) % 7, card_hour = 18 where user_id = '${p.id}'`);
  await run('weekly_cards');
  assert.deepEqual((await ok(p, `{ cards { id } }`)).cards, [], 'the day has not arrived');
});

test('the weekly job does not depend on the server time zone', async () => {
  const p = await person();
  const zone = await setZone(p.id, 18);
  const dow = (await sql(`select extract(dow from now() at time zone '${zone}')::int`))[0][0];
  await sql(`update public.notification_settings set card_day = ${dow}, card_hour = 18 where user_id = '${p.id}'`);
  await ok(p, `mutation { insertSlipsOne(object: {body: "um bilhete"}) { id } }`);
  const other = await zoneAtHour((18 + 12) % 24);
  assert.notEqual(other, zone);
  await run('weekly_cards');
  assert.equal((await ok(p, `{ cards { id } }`)).cards.length, 1);
});

test('a week without an eligible slip has no card', async () => {
  const p = await person();
  const zone = await setZone(p.id, 18);
  const dow = (await sql(`select extract(dow from now() at time zone '${zone}')::int`))[0][0];
  await sql(`update public.notification_settings set card_day = ${dow}, card_hour = 18 where user_id = '${p.id}'`);
  await ok(p, `mutation { insertSlipsOne(object: {body: "algo que ficou entre nós", kind: invisible, forCard: false}) { id } }`);
  await run('weekly_cards');
  assert.deepEqual((await ok(p, `{ cards { id } }`)).cards, []);
});

test('reminders arrive once in the local morning and dedupe on a repeated run', async () => {
  const p = await person();
  await setZone(p.id, 10);
  await noHolidays(p.id);
  const tomorrow = (await sql(`select (now() at time zone (select time_zone from public.profiles where id = '${p.id}') + interval '1 day')::date`))[0][0];
  const [month, day] = tomorrow.split('-').slice(1).map((v: string) => Number(v));
  await ok(p, `mutation ($m: smallint!, $d: smallint!) {
    insertImportantDatesOne(object: {title: "Aniversário", kind: birthday, month: $m, day: $d, year: 1990, remindDays: [1]}) { id }
  }`, { m: month, d: day });
  await run('reminders');
  await run('reminders');
  const rows = await sql(`select type, count(*) from private.notifications where user_id = '${p.id}' group by 1`);
  assert.deepEqual(rows, [['date_coming', '1']]);
});

test('reminders stay quiet outside the local morning', async () => {
  const p = await person();
  await setZone(p.id, 10);
  await noHolidays(p.id);
  const tomorrow = (await sql(`select (now() at time zone (select time_zone from public.profiles where id = '${p.id}') + interval '1 day')::date`))[0][0];
  const [month, day] = tomorrow.split('-').slice(1).map((v: string) => Number(v));
  await ok(p, `mutation ($m: smallint!, $d: smallint!) {
    insertImportantDatesOne(object: {title: "Aniversário", kind: birthday, month: $m, day: $d, year: 1990, remindDays: [1]}) { id }
  }`, { m: month, d: day });
  await setZone(p.id, 11);
  await run('reminders');
  assert.deepEqual(await sql(`select count(*) from private.notifications where user_id = '${p.id}'`), [['0']]);
});

test('a due capsule opens for both partners once', async () => {
  const { a, b, coupleId } = await couple();
  const capsule = (await ok(a, `mutation ($c: uuid!) { insertCapsulesOne(object: {coupleId: $c, body: "para o nosso futuro", opensOn: "2030-01-01"}) { id openedAt } }`, { c: coupleId })).insertCapsulesOne;
  assert.equal(capsule.openedAt, null);
  assert.deepEqual((await ok(b, `{ capsules { id } }`)).capsules, [], 'sealed for the partner');
  await sql(`update public.capsules set opens_on = private.local_date('${a.id}') where id = '${capsule.id}'`);
  await run('open_capsules');
  assert.deepEqual(await sql(`select opened_at is not null from public.capsules where id = '${capsule.id}'`), [['t']]);
  assert.deepEqual((await ok(b, `{ capsules { id } }`)).capsules, [{ id: capsule.id }]);
  assert.deepEqual((await sql(`select user_id from private.notifications where type = 'capsule_opened' and ref_id = '${capsule.id}' order by user_id`)).map((r) => r[0]).sort(), [a.id, b.id].sort());
  await run('open_capsules');
  assert.deepEqual(await sql(`select count(*) from private.notifications where type = 'capsule_opened' and ref_id = '${capsule.id}'`), [['2']]);
});

test('the purge job erases the account and removes its files', async () => {
  const session = await signUp('Apagar');
  const partner = await signUp('Fica');
  const file = await upload(session.token, 'memories', [1, 2, 3, 4]);
  const { insertInvitesOne } = await ok(session, `mutation { insertInvitesOne(object: {}) { code } }`);
  await ok(partner, `mutation ($c: String!) { acceptInvite(args: {code: $c}) { id } }`, { c: insertInvitesOne.code });
  assert.equal(await download(session.token, file.id), 200);
  await ok(session, `mutation { insertDeletionRequestsOne(object: {}) { userId purgeAfter } }`);
  assert.deepEqual((await ok(partner, `{ coupleMembers { userId } }`)).coupleMembers, [], 'the pairing ends at once');
  assert.deepEqual((await sql(`select type from private.notifications where user_id = '${partner.id}' and type = 'unpaired'`)), [['unpaired']]);
  await sql(`update public.deletion_requests set purge_after = now() - interval '1 minute' where user_id = '${session.id}'`);
  await run('purge_accounts');
  assert.deepEqual(await sql(`select count(*) from auth.users where id = '${session.id}'`), [['0']]);
  assert.deepEqual(await sql(`select count(*) from public.profiles where id = '${session.id}'`), [['0']]);
  await waitFor(async () => (await download(session.token, file.id)) === 404);
  await waitFor(async () => (await sql(`select count(*) from private.file_deletions where file_id = '${file.id}'`))[0][0] === '0');
});

test('a deletion request can be cancelled before the purge', async () => {
  const p = await person();
  await ok(p, `mutation { insertDeletionRequestsOne(object: {}) { userId } }`);
  assert.deepEqual((await ok(p, `{ today { deletionPending } }`)).today[0].deletionPending, true);
  await ok(p, `mutation { deleteDeletionRequestsByPk(userId: "${p.id}") { userId } }`);
  assert.deepEqual((await ok(p, `{ today { deletionPending } }`)).today[0].deletionPending, false);
});

test('a person cannot run a job, read the job history or make one up', async () => {
  const p = await person();
  assert.ok((await denied(p, `mutation { runJob(args: {job: "prune"}) { id } }`)).errors?.length);
  assert.ok((await denied(p, `{ jobRuns { id } }`)).errors?.length);
  assert.ok((await denied('admin', `mutation { runJob(args: {job: "not_a_job"}) { id } }`)).errors?.length);
});

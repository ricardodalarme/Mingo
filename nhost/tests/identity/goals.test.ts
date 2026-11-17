import { test } from 'node:test';
import { assert, couple, denied, ok, person, sql } from '../lib.ts';

const goals = (who: any) =>
  ok(who, `{ userSettingsByPk(userId: "${who.id}") { goals(order_by: {goal: asc}) { goal } } }`).then((d) =>
    d.userSettingsByPk.goals.map((row: any) => row.goal),
  );

const add = (who: any, ...values: string[]) =>
  ok(who, `mutation ($objects: [userGoals_insert_input!]!) { insertUserGoals(objects: $objects) { affected_rows } }`, {
    objects: values.map((goal) => ({ goal })),
  });

test('a person keeps their goals as rows of one closed set, and nobody else reads them', async () => {
  const { a, b } = await couple();
  await add(a, 'reconnect', 'fight_less');

  assert.deepEqual(await goals(a), ['fight_less', 'reconnect']);
  assert.deepEqual((await ok(b, `{ userGoals { goal } }`)).userGoals, [], 'the partner reads none of them');
  assert.deepEqual((await ok(b, `{ userSettings { goals { goal } } }`)).userSettings.flatMap((row: any) => row.goals), []);
});

test('the owner of a goal is the caller; a client cannot name another person', async () => {
  const { a, b } = await couple();
  await denied(a, `mutation { insertUserGoals(objects: [{goal: reconnect, userId: "${b.id}"}]) { affected_rows } }`);
  await add(a, 'keep_romance');

  assert.deepEqual(await sql(`select user_id from public.user_goals where user_id in ('${a.id}', '${b.id}')`), [[a.id]]);
});

test('a goal is added once and removed by its owner only', async () => {
  const { a, b } = await couple();
  await add(a, 'just_record');
  await denied(a, `mutation { insertUserGoals(objects: [{goal: just_record}]) { affected_rows } }`);

  const stranger = await ok(b, `mutation { deleteUserGoals(where: {goal: {_eq: just_record}}) { affected_rows } }`);
  assert.equal(stranger.deleteUserGoals.affected_rows, 0, 'the partner removes nothing');
  const own = await ok(a, `mutation { deleteUserGoals(where: {goal: {_eq: just_record}}) { affected_rows } }`);
  assert.equal(own.deleteUserGoals.affected_rows, 1);
});

test('replacing the goals is one request: the old ones go and the new ones stay', async () => {
  const a = await person();
  await add(a, 'reconnect', 'fight_less');

  await ok(
    a,
    `mutation { deleteUserGoals(where: {}) { affected_rows } insertUserGoals(objects: [{goal: remember_dates}]) { affected_rows } }`,
  );

  assert.deepEqual(await goals(a), ['remember_dates']);
});

test('only the six goals the app offers exist, in the schema and in the database', async () => {
  const a = await person();
  await denied(a, `mutation { insertUserGoals(objects: [{goal: world_peace}]) { affected_rows } }`);
  await assert.rejects(sql(`insert into public.user_goals (user_id, goal) values ('${a.id}', 'world_peace')`));

  const values = (await sql(`select value from public.relationship_goal order by value`)).map((row) => row[0]);
  assert.deepEqual(values, ['fight_less', 'just_record', 'keep_romance', 'organize_routine', 'reconnect', 'remember_dates']);
});

test('deleting the account removes the goals with it', async () => {
  const a = await person();
  await add(a, 'reconnect');

  await sql(`delete from public.user_settings where user_id = '${a.id}'`);

  assert.deepEqual(await sql(`select 1 from public.user_goals where user_id = '${a.id}'`), []);
});

import { test } from 'node:test';
import { assert, couple, ok, person } from './lib.ts';

test('a person learns whether the partner answered a question without seeing the answer', async () => {
  const { a, b } = await couple();
  const stranger = await person();
  await ok(a, `mutation { insertQuestionAnswersOne(object: {questionSlug: "q-one", body: "segredo"}) { id } }`);
  await ok(b, `mutation { insertQuestionAnswersOne(object: {questionSlug: "q-two", body: "outro"}) { id } }`);

  const partner = await ok(b, `query ($s: jsonb!) { partnerQuestionStates(args: {questionSlugs: $s}) { questionSlug partnerAnswered } }`, {
    s: ['q-one', 'q-two'],
  });
  assert.deepEqual(
    partner.partnerQuestionStates.map((row: any) => [row.questionSlug, row.partnerAnswered]),
    [['q-one', true], ['q-two', false]],
  );
  assert.deepEqual((await ok(a, `query ($s: jsonb!) { partnerQuestionStates(args: {questionSlugs: $s}) { partnerAnswered } }`, {
    s: ['q-one'],
  })).partnerQuestionStates, [{ partnerAnswered: false }], 'the caller does not count as the partner');
  assert.deepEqual((await ok(stranger, `query ($s: jsonb!) { partnerQuestionStates(args: {questionSlugs: $s}) { partnerAnswered } }`, {
    s: ['q-one'],
  })).partnerQuestionStates, []);
  assert.deepEqual((await ok(b, `{ questionAnswers { body } }`)).questionAnswers.map((row: any) => row.body), ['outro'], 'the partner answer stays hidden');
});

test('a person learns whether the partner finished this week check-in', async () => {
  const { a, b } = await couple();
  assert.deepEqual((await ok(b, `{ partnerCheckinState { partnerCompleted } }`)).partnerCheckinState, [{ partnerCompleted: false }]);
  await ok(a, `mutation { insertCheckinsOne(object: {answer1: "a", answer2: "b", answer3: "c", answer4: "d"}) { id completed } }`);
  assert.deepEqual((await ok(b, `{ partnerCheckinState { partnerCompleted } }`)).partnerCheckinState, [{ partnerCompleted: true }]);
  await ok(a, `mutation { unpair { id } }`);
  assert.deepEqual((await ok(b, `{ partnerCheckinState { partnerCompleted } }`)).partnerCheckinState, []);
});

test('muting types replaces the whole set in one call', async () => {
  const p = await person();
  const set = (types: string[]) =>
    ok(p, `mutation ($t: jsonb!) { setNotificationMutes(args: {types: $t}) { type } }`, { t: types }).then((data) =>
      data.setNotificationMutes.map((row: any) => row.type).sort());
  assert.deepEqual(await set(['ritual', 'daily_idea']), ['daily_idea', 'ritual']);
  assert.deepEqual(await set(['ritual']), ['ritual']);
  assert.deepEqual(await set([]), []);
  assert.deepEqual((await ok(p, `{ notificationMutes { type } }`)).notificationMutes, []);
});

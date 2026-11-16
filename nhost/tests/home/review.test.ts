import { test } from 'node:test';
import { assert, couple, ok, person, sql } from '../lib.ts';

const review = (who: any, week: string | null = null) =>
  ok(who, `query { weeklyReview(args: {${week ? `weekStart: "${week}"` : ''}}) { weekStart slips activeDays streakDays moodsLogged ritualsDone cardsSent cardsReceived checkinDone partnerCardsSent coupleRitualsDone bothCheckinDone lowData missing } }`)
    .then((d) => d.weeklyReview[0]);

// Dates are relative to the person's own week so the tests do not depend on the weekday they run.
async function week(who: { id: string }): Promise<{ start: string; day: (n: number) => string }> {
  const start = (await sql(`select private.local_week_start('${who.id}')`))[0][0];
  return { start, day: (n) => `${start}`.replace(/.*/, () => new Date(Date.parse(start) + n * 86_400_000).toISOString().slice(0, 10)) };
}

test('an empty week says what is missing and never scores', async () => {
  const a = await person();
  const r = await review(a);
  assert.deepEqual([r.slips, r.activeDays, r.streakDays, r.moodsLogged, r.ritualsDone, r.cardsSent, r.cardsReceived], [0, 0, 0, 0, 0, 0, 0]);
  assert.deepEqual([r.lowData, r.missing, r.checkinDone], [true, ['slips', 'mood', 'ritual'], false]);
  assert.deepEqual([r.partnerCardsSent, r.coupleRitualsDone, r.bothCheckinDone], [null, null, null], 'nothing about a partner without a couple');
});

test('the week counts own slips, moods and rituals, and a streak of consecutive days', async () => {
  const a = await person();
  const w = await week(a);
  const past = '2025-03-10';
  await sql(`insert into public.slips (author_id, body, created_at) values
    ('${a.id}', 'um', '${past}T12:00:00Z'), ('${a.id}', 'dois', '${past}T13:00:00Z'), ('${a.id}', 'três', '2025-03-11T12:00:00Z')`);
  await sql(`insert into public.moods (author_id, day, mood) values ('${a.id}', '2025-03-12', 'happy')`);
  const r = await review(a, '2025-03-12');
  assert.equal(r.weekStart, '2025-03-10');
  assert.deepEqual([r.slips, r.activeDays, r.streakDays, r.moodsLogged], [3, 3, 3, 1]);
  assert.deepEqual(r.missing, ['ritual']);
  assert.equal(r.lowData, false);
  const next = await review(a, '2025-03-17');
  assert.deepEqual([next.slips, next.streakDays, next.lowData], [0, 0, true]);
  assert.equal(w.start.length, 10);
});

test('the streak ends at the last active day of a past week and reaches into the week before', async () => {
  const a = await person();
  await sql(`insert into public.slips (author_id, body, created_at) values
    ('${a.id}', 'a', '2025-03-08T12:00:00Z'), ('${a.id}', 'b', '2025-03-09T12:00:00Z'), ('${a.id}', 'c', '2025-03-10T12:00:00Z')`);
  const r = await review(a, '2025-03-10');
  assert.deepEqual([r.activeDays, r.streakDays], [1, 3]);
});

test('this week a streak that is older than yesterday no longer counts', async () => {
  const a = await person();
  const w = await week(a);
  const today = (await sql(`select private.local_date('${a.id}')`))[0][0];
  await sql(`insert into public.slips (author_id, body, created_at) values ('${a.id}', 'hoje', now())`);
  assert.deepEqual((await review(a)).streakDays, 1);
  await sql(`delete from public.slips where author_id = '${a.id}'`);
  const ritual = (await ok(a, `mutation { insertRitualsOne(object: {title: "r"}) { id } }`)).insertRitualsOne;
  await sql(`insert into public.ritual_logs (ritual_id, author_id, done_on) values ('${ritual.id}', '${a.id}', '${today}'::date - 3)`);
  assert.deepEqual((await review(a)).streakDays, 0);
  assert.ok(w.start);
});

test('together shows only counts: the partner cards, shared rituals and a check-in both finished', async () => {
  const { a, b, coupleId } = await couple();
  const ritual = (await ok(a, `mutation ($c: uuid!) { insertRitualsOne(object: {title: "café", coupleId: $c}) { id } }`, { c: coupleId })).insertRitualsOne;
  const second = (await ok(a, `mutation ($c: uuid!) { insertRitualsOne(object: {title: "chá", coupleId: $c}) { id } }`, { c: coupleId })).insertRitualsOne;
  const solo = (await ok(a, `mutation { insertRitualsOne(object: {title: "meu"}) { id } }`)).insertRitualsOne;
  const w = (await sql(`select private.local_week_start('${a.id}')`))[0][0];
  await sql(`insert into public.ritual_logs (ritual_id, author_id, done_on) values ('${ritual.id}', '${a.id}', '${w}'), ('${second.id}', '${b.id}', '${w}'), ('${solo.id}', '${a.id}', '${w}')`);
  await sql(`insert into public.slips (author_id, body) values ('${b.id}', 'segredo')`);
  assert.deepEqual((await review(a)).bothCheckinDone, false);
  for (const who of [a, b]) {
    await ok(who, `mutation { insertCheckinsOne(object: {answer1: "a", answer2: "b", answer3: "c", answer4: "d"}) { id } }`);
  }
  const r = await review(a);
  assert.deepEqual([r.coupleRitualsDone, r.ritualsDone, r.bothCheckinDone, r.checkinDone], [2, 2, true, true]);
  assert.deepEqual([r.slips, r.partnerCardsSent], [0, 0], 'the partner slips are not visible, not even as a count');
  assert.equal((await review(b)).coupleRitualsDone, 2);
  assert.equal((await review(b)).ritualsDone, 1);
});

test('the review does not read annoyances, notes or Tempero', async () => {
  const a = await person();
  await ok(a, `mutation { insertAnnoyancesOne(object: {body: "segredo"}) { id } }`);
  const text = JSON.stringify(await review(a));
  assert.doesNotMatch(text, /segredo/);
  assert.equal((await review(a)).activeDays, 0, 'an annoyance is not an active day');
});

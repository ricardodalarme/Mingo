import { test } from 'node:test';
import { adult, assert, couple, denied, gql, ok, pair, person, randomUUID, sql, type Person } from '../lib.ts';

// table -> a minimal valid row, for the tables that are private to their author.
const privateTables: Record<string, string> = {
  temperatureChecks: 'level: fight',
  repairSessions: 'intensity: 5',
  repairLearnings: 'kind: trigger, note: "tom de voz"',
  journalEntries: 'body: "hoje foi bom"',
  conversationPreps: 'topic: "dinheiro"',
  moods: 'mood: tired',
  partnerFacts: 'label: "café", value: "sem açúcar"',
  manualEntries: 'key: "quando estou triste", value: "preciso de silêncio"',
  programEnrollments: 'programSlug: "gratitude-7"',
  lessonProgress: 'programSlug: "gratitude-7", lessonDay: 1',
  quizResults: 'quizKey: loved, ranked: ["words", "time"]',
  learnedItems: 'target: partner_fact, text: "gosta de café"',
};
const cap = (s: string) => s[0].toUpperCase() + s.slice(1);

for (const [table, row] of Object.entries(privateTables)) {
  test(`${table}: only the author reads, changes and deletes a row`, async () => {
    const { a, b } = await couple();
    const stranger = await person();
    const created = (await ok(a, `mutation { insert${cap(table)}One(object: {${row}}) { id authorId } }`))[`insert${cap(table)}One`];
    assert.equal(created.authorId, a.id);
    await denied(a, `mutation ($o: uuid!) { insert${cap(table)}One(object: {${row}, authorId: $o}) { id } }`, { o: b.id });
    for (const other of [b, stranger]) {
      const read = await ok(other, `query ($id: uuid!) { ${table} { id } ${table}ByPk(id: $id) { id } }`, { id: created.id });
      assert.deepEqual(read, { [table]: [], [`${table}ByPk`]: null });
      const removed = await ok(other, `mutation ($id: uuid!) { delete${cap(table)}ByPk(id: $id) { id } }`, { id: created.id });
      assert.equal(removed[`delete${cap(table)}ByPk`], null);
    }
    await denied('public', `{ ${table} { id } }`);
    assert.equal((await ok(a, `mutation ($id: uuid!) { delete${cap(table)}ByPk(id: $id) { id } }`, { id: created.id }))[`delete${cap(table)}ByPk`].id, created.id);
  });
}

test('the partner sees a mood only when it is shared, only the current one, and the need only when asked', async () => {
  const { a, b } = await couple();
  const stranger = await person();
  const partnerMood = (who: Person) => ok(who, `query ($id: uuid!) { sharedMoods(where: {userId: {_eq: $id}}) { mood need day } }`, { id: a.id }).then((d) => d.sharedMoods);
  const mood = (await ok(a, `mutation { insertMoodsOne(object: {mood: tired, need: rest}) { id day share } }`)).insertMoodsOne;
  assert.equal(mood.share, 'none');
  assert.deepEqual(await partnerMood(b), []);
  await ok(a, `mutation ($id: uuid!) { updateMoodsByPk(pk_columns: {id: $id}, _set: {share: mood}) { id } }`, { id: mood.id });
  assert.deepEqual(await partnerMood(b), [{ mood: 'tired', need: null, day: mood.day }]);
  await ok(a, `mutation ($id: uuid!) { updateMoodsByPk(pk_columns: {id: $id}, _set: {share: mood_need}) { id } }`, { id: mood.id });
  assert.deepEqual(await partnerMood(b), [{ mood: 'tired', need: 'rest', day: mood.day }]);
  assert.deepEqual(await partnerMood(stranger), []);
  assert.deepEqual((await ok(b, `{ moods { id } }`)).moods, [], 'the mood rows themselves stay private');
  await sql(`insert into public.moods (author_id, day, mood, share) values ('${a.id}', current_date - 3, 'sad', 'mood')`);
  assert.equal((await partnerMood(b))[0].mood, 'tired', 'an older day never replaces the current mood');
  assert.equal((await sql(`select count(*) from public.shared_moods where user_id = '${a.id}'`))[0][0], '1', 'no history is kept for the partner');
  await ok(a, `mutation ($id: uuid!) { updateMoodsByPk(pk_columns: {id: $id}, _set: {share: none}) { id } }`, { id: mood.id });
  assert.deepEqual(await partnerMood(b), []);
});

test('the partner reads only the manual entries marked as shared', async () => {
  const { a, b } = await couple();
  await ok(a, `mutation { insertManualEntries(objects: [{key: "private", value: "x"}, {key: "open", value: "y", shared: true}]) { affected_rows } }`);
  assert.deepEqual((await ok(b, `{ manualEntries { key } }`)).manualEntries, [{ key: 'open' }]);
  await ok(a, `mutation { unpair { id } }`);
  assert.deepEqual((await ok(b, `{ manualEntries { key } }`)).manualEntries, []);
});

// table -> a minimal valid row, for the tables an author can share with the couple.
const sharedTables: Record<string, string> = {
  rituals: 'title: "café de domingo"',
  logisticItems: 'title: "mercado"',
  savedDateIdeas: 'title: "piquenique"',
  importantDates: 'title: "aniversário", month: 5, day: 12',
  memories: 'title: "primeira viagem", happenedOn: "2024-02-01"',
  storyEvents: 'kind: met, happenedOn: "2020-01-01"',
  lists: 'title: "filmes"',
  agreements: 'body: "sem celular na mesa"',
};

for (const [table, row] of Object.entries(sharedTables)) {
  test(`${table}: private by default, shared with the current partner by choice, lost by an ex-partner at once`, async () => {
    const { a, b, coupleId } = await couple();
    const other = await couple();
    const insert = `mutation ($c: uuid) { insert${cap(table)}One(object: {${row}, coupleId: $c}) { id authorId coupleId } }`;
    const priv = (await ok(a, insert, { c: null }))[`insert${cap(table)}One`];
    const shared = (await ok(a, insert, { c: coupleId }))[`insert${cap(table)}One`];
    assert.equal(shared.authorId, a.id);
    await denied(a, insert, { c: other.coupleId });
    const seenBy = (who: Person) => ok(who, `{ ${table}(order_by: {createdAt: asc}) { id } }`).then((d) => d[table].map((r: any) => r.id));
    assert.deepEqual(await seenBy(a), [priv.id, shared.id]);
    assert.deepEqual(await seenBy(b), [shared.id]);
    assert.deepEqual(await seenBy(other.a), []);
    await denied(a, `mutation ($id: uuid!, $c: uuid!) { update${cap(table)}ByPk(pk_columns: {id: $id}, _set: {coupleId: $c}) { id } }`, { id: shared.id, c: other.coupleId });
    const hidden = await ok(b, `mutation ($id: uuid!) { delete${cap(table)}ByPk(id: $id) { id } }`, { id: priv.id });
    assert.equal(hidden[`delete${cap(table)}ByPk`], null);
    await ok(a, `mutation { unpair { id } }`);
    assert.deepEqual(await seenBy(b), [], 'the ex-partner loses the shared row at once');
    assert.deepEqual(await seenBy(a), [priv.id, shared.id], 'the author keeps it');
  });
}

test('a wish is always visible to the current partner; a date gift idea stays private', async () => {
  const a = await person('Ana');
  const b = await person('Bruno');
  const wish = (await ok(a, `mutation { insertGiftIdeasOne(object: {title: "livro", kind: wish, link: "https://example.com/livro"}) { id link } }`)).insertGiftIdeasOne;
  const idea = (await ok(a, `mutation { insertGiftIdeasOne(object: {title: "caneca", kind: idea, link: "https://example.com/caneca"}) { id } }`)).insertGiftIdeasOne;
  assert.equal(wish.link, 'https://example.com/livro');
  const seenBy = (who: Person) => ok(who, `{ giftIdeas(order_by: {title: asc}) { id title kind } }`).then((d) => d.giftIdeas);
  assert.deepEqual(await seenBy(b), [], 'there is no partner yet');
  await pair(a, b);
  assert.deepEqual(await seenBy(b), [{ id: wish.id, title: 'livro', kind: 'wish' }], 'pairing shares wishes added before it');
  assert.deepEqual(await seenBy(a), [
    { id: idea.id, title: 'caneca', kind: 'idea' },
    { id: wish.id, title: 'livro', kind: 'wish' },
  ]);
  await ok(a, `mutation { unpair { id } }`);
  assert.deepEqual(await seenBy(b), [], 'an ex-partner loses the wishes at once');
});

test('after the couple ends, the author keeps the shared rows as private ones or deletes them', async () => {
  const keep = await couple();
  await ok(keep.a, `mutation ($c: uuid!) { insertListsOne(object: {title: "x", coupleId: $c}) { id } }`, { c: keep.coupleId });
  assert.deepEqual((await ok(keep.a, `mutation { resolveSharedItems(args: {keep: true}) { id } }`)).resolveSharedItems, [], 'not while still paired');
  await ok(keep.a, `mutation { unpair { id } }`);
  await ok(keep.a, `mutation { resolveSharedItems(args: {keep: true}) { id } }`);
  assert.deepEqual((await ok(keep.a, `{ lists { coupleId } }`)).lists, [{ coupleId: null }]);
  const drop = await couple();
  await ok(drop.a, `mutation ($c: uuid!) { insertListsOne(object: {title: "x", coupleId: $c}) { id } insertRitualsOne(object: {title: "mine"}) { id } }`, { c: drop.coupleId });
  await ok(drop.a, `mutation { insertGiftIdeasOne(object: {title: "livro", kind: wish}) { id } }`);
  await ok(drop.a, `mutation { unpair { id } }`);
  await ok(drop.a, `mutation { resolveSharedItems(args: {keep: false}) { id } }`);
  assert.deepEqual(await ok(drop.a, `{ lists { id } rituals { title } giftIdeas { id } }`), { lists: [], rituals: [{ title: 'mine' }], giftIdeas: [] });
});

test('the partner edits shared rows but not gift wishes or memories, and never a private row', async () => {
  const { a, b, coupleId } = await couple();
  const mk = (table: string, row: string) => ok(a, `mutation ($c: uuid!) { insert${table}One(object: {${row}, coupleId: $c}) { id } }`, { c: coupleId }).then((d) => d[`insert${table}One`].id);
  const ritual = await mk('Rituals', 'title: "café"');
  const memory = await mk('Memories', 'title: "viagem", happenedOn: "2024-01-01"');
  const gift = (await ok(a, 'mutation { insertGiftIdeasOne(object: {title: "livro", kind: wish}) { id } }')).insertGiftIdeasOne.id;
  const out = await ok(b, `mutation ($r: uuid!, $g: uuid!, $m: uuid!) {
    updateRitualsByPk(pk_columns: {id: $r}, _set: {title: "chá"}) { title }
    updateGiftIdeasByPk(pk_columns: {id: $g}, _set: {title: "x"}) { id }
    deleteGiftIdeasByPk(id: $g) { id }
    updateMemoriesByPk(pk_columns: {id: $m}, _set: {title: "x"}) { id } }`, { r: ritual, g: gift, m: memory });
  assert.deepEqual(out, { updateRitualsByPk: { title: 'chá' }, updateGiftIdeasByPk: null, deleteGiftIdeasByPk: null, updateMemoriesByPk: null });
  await denied(b, `mutation ($r: uuid!) { updateRitualsByPk(pk_columns: {id: $r}, _set: {coupleId: null}) { id } }`, { r: ritual });
  await denied(b, `mutation ($r: uuid!, $me: uuid!) { updateRitualsByPk(pk_columns: {id: $r}, _set: {authorId: $me}) { id } }`, { r: ritual, me: b.id });
});

test('ritual logs and list items follow the visibility of their parent', async () => {
  const { a, b, coupleId } = await couple();
  const stranger = await person();
  const { insertListsOne: shared } = await ok(a, `mutation ($c: uuid!) { insertListsOne(object: {title: "filmes", coupleId: $c}) { id } }`, { c: coupleId });
  const { insertListsOne: priv } = await ok(a, `mutation { insertListsOne(object: {title: "só meu"}) { id } }`);
  const add = (who: Person, list: string) => gql(who, `mutation ($l: uuid!) { insertListItemsOne(object: {listId: $l, title: "item"}) { id authorId } }`, { l: list });
  const mine = await add(a, shared.id);
  const theirs = await add(b, shared.id);
  assert.equal(theirs.data.insertListItemsOne.authorId, b.id);
  assert.ok((await add(b, priv.id)).errors, 'no item in a private list of the partner');
  assert.ok((await add(stranger, shared.id)).errors);
  assert.equal((await ok(b, `{ listItems { id } }`)).listItems.length, 2);
  assert.deepEqual((await ok(stranger, `{ listItems { id } }`)).listItems, []);
  const reorder = await ok(b, `mutation ($x: uuid!, $y: uuid!) { updateListItemsMany(updates: [
    {where: {id: {_eq: $x}}, _set: {position: 1}}, {where: {id: {_eq: $y}}, _set: {position: 0}}]) { affected_rows } }`,
    { x: mine.data.insertListItemsOne.id, y: theirs.data.insertListItemsOne.id });
  assert.deepEqual(reorder.updateListItemsMany, [{ affected_rows: 1 }, { affected_rows: 1 }]);
  const { insertRitualsOne: ritual } = await ok(a, `mutation ($c: uuid!) { insertRitualsOne(object: {title: "café", coupleId: $c}) { id } }`, { c: coupleId });
  const log = (await ok(b, `mutation ($r: uuid!) { insertRitualLogsOne(object: {ritualId: $r}) { id doneOn authorId } }`, { r: ritual.id })).insertRitualLogsOne;
  assert.equal(log.authorId, b.id);
  await denied(stranger, `mutation ($r: uuid!) { insertRitualLogsOne(object: {ritualId: $r}) { id } }`, { r: ritual.id });
  await ok(a, `mutation { unpair { id } }`);
  assert.deepEqual(await ok(b, `{ listItems { id } ritualLogs { id } }`), { listItems: [], ritualLogs: [] });
});

test('a capsule is sealed for the partner until it opens, and nobody edits it', async () => {
  const { a, b, coupleId } = await couple();
  const soon = new Date(Date.now() + 3 * 864e5).toISOString().slice(0, 10);
  const later = new Date(Date.now() + 30 * 864e5).toISOString().slice(0, 10);
  await denied(a, `mutation ($c: uuid!) { insertCapsulesOne(object: {body: "x", opensOn: "${soon}", coupleId: $c}) { id } }`, { c: coupleId });
  const capsule = (await ok(a, `mutation ($c: uuid!) { insertCapsulesOne(object: {body: "para depois", opensOn: "${later}", coupleId: $c}) { id openedAt } }`, { c: coupleId })).insertCapsulesOne;
  assert.deepEqual((await ok(b, `{ capsules { id } }`)).capsules, []);
  await denied(a, `mutation ($id: uuid!) { updateCapsulesByPk(pk_columns: {id: $id}, _set: {body: "changed"}) { id } }`, { id: capsule.id });
  await denied(a, `mutation ($c: uuid!) { insertCapsulesOne(object: {body: "x", opensOn: "${later}", coupleId: $c, openedAt: "now()"}) { id } }`, { c: coupleId });
  await sql(`update public.capsules set opens_on = current_date - 1 where id = '${capsule.id}'`);
  await ok('admin', `mutation { runJob(args: {job: "open_capsules"}) { affected } }`);
  assert.deepEqual((await ok(b, `{ capsules { body } }`)).capsules, [{ body: 'para depois' }]);
  assert.equal((await ok(b, `mutation ($id: uuid!) { deleteCapsulesByPk(id: $id) { id } }`, { id: capsule.id })).deleteCapsulesByPk, null);
  assert.equal((await sql(`select count(*) from private.notifications where type = 'capsule_opened' and ref_id = '${capsule.id}'`))[0][0], '2');
});

test('a task is assigned to the caller or the partner, never to a stranger', async () => {
  const { a, b, coupleId } = await couple();
  const stranger = await person();
  const add = (assignee: string) => gql(a, `mutation ($c: uuid!, $who: uuid!) { insertLogisticItemsOne(object: {title: "mercado", coupleId: $c, assigneeId: $who}) { id } }`, { c: coupleId, who: assignee });
  assert.equal((await add(b.id)).errors, undefined);
  assert.equal((await add(a.id)).errors, undefined);
  assert.ok((await add(stranger.id)).errors);
});

test('spice cards exist only when both partners switched the mode on', async () => {
  await sql(`insert into public.content_items (kind, slug, locale, title) values ('spice_card', 'spice-1', 'pt-BR', 'x'), ('question', 'unpublished', 'pt-BR', 'x') on conflict do nothing;
             update public.content_items set published = false where slug = 'unpublished'`);
  const { a, b } = await couple();
  const solo = await person();
  const spice = (who: Person) => ok(who, `{ contentItems(where: {kind: {_eq: spice_card}}) { slug } }`).then((d) => d.contentItems.length);
  const enable = (who: Person, on: boolean) => ok(who, `mutation ($id: uuid!, $on: Boolean!) { updateUserSettingsByPk(pk_columns: {userId: $id}, _set: {spiceEnabled: $on}) { userId } }`, { id: who.id, on });
  for (const who of [a, b, solo]) await adult(who);
  await enable(a, true);
  await enable(solo, true);
  assert.deepEqual([await spice(a), await spice(b), await spice(solo)], [0, 0, 0]);
  await enable(b, true);
  const publishedSpice = Number((await sql(`select count(*) from public.content_items where kind = 'spice_card' and published and not plus_only`))[0][0]);
  assert.ok(publishedSpice > 0, 'the seed has spice cards');
  assert.deepEqual([await spice(a), await spice(b)], [publishedSpice, publishedSpice]);
  assert.deepEqual((await ok(a, `{ contentItems(where: {slug: {_eq: "unpublished"}}) { slug } }`)).contentItems, []);
  await denied('public', `{ contentItems { slug } }`);
});

test('both partners get the same daily content', async () => {
  await sql(`insert into public.content_items (kind, slug, locale, title, position)
             select 'question', 'dq-' || g, 'pt-BR', 'q ' || g, g from generate_series(1, 5) g on conflict do nothing`);
  const { a, b } = await couple();
  const pick = (who: Person) => ok(who, `{ dailyContent(args: {kind: "question"}) { slug } }`).then((d) => d.dailyContent);
  const [mine, theirs] = [await pick(a), await pick(b)];
  assert.equal(mine.length, 1);
  assert.deepEqual(mine, theirs);
  assert.deepEqual((await ok(a, `{ dailyContent(args: {kind: "spice_card"}) { slug } }`)).dailyContent, []);
});

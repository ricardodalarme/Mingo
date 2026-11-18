import assert from 'node:assert/strict';
import { test } from 'node:test';
import type { CallerQuery } from '../../_lib/graphql.ts';
import { loadContext } from '../_context.ts';

const ID = '0b7b1f1e-6f0a-4f4e-8a34-2f6a1c9d3b21';

/** A caller that answers each document by a word it contains, and fails for the ones in [failing]. */
const caller = (answers: Record<string, unknown>, failing: string[] = []): CallerQuery =>
  (async ({ query }: { query: string }) => {
    const key = Object.keys(answers).find((word) => query.includes(word));
    if (!key || failing.includes(key)) throw new Error('not readable');
    return answers[key];
  }) as CallerQuery;

const PRONOUNS = {
  userSettings: [{ userId: 'me', partnerPronouns: 'she/her', partnerName: '  Ana  ' }],
  profiles: [
    { id: 'me', pronouns: 'he/him' },
    { id: 'her', pronouns: 'they/them' },
  ],
};

test('pronouns are always loaded and the partner setting wins over the partner profile', async () => {
  const context = await loadContext(caller({ userSettings: PRONOUNS }), [], []);
  assert.equal(context.pronouns, 'he/him');
  assert.equal(context.partnerPronouns, 'she/her');
  assert.equal(context.partnerName, 'Ana');
  assert.equal(context.text, '');
});

test('without pronouns every field is null and the chat still answers', async () => {
  const context = await loadContext(caller({}), [], []);
  assert.deepEqual(context, { pronouns: null, partnerPronouns: null, partnerName: null, text: '' });
});

test('a block is loaded only when it is named, as one line per fact', async () => {
  const answers = {
    userSettings: PRONOUNS,
    'slips(': { slips: [{ body: 'made  coffee' }], cards: [{ items: [{ body: 'a card line' }] }] },
    'rituals(': { rituals: [{ title: 'Walk', cadence: 'daily' }] },
  };
  const context = await loadContext(caller(answers), ['slips'], []);
  assert.equal(context.text, 'slip: made coffee\ncard item: a card line');
});

test('a block that cannot be read is left out and the others stay', async () => {
  const answers = {
    userSettings: PRONOUNS,
    'rituals(': { rituals: [{ title: 'Walk', cadence: 'daily' }] },
    'logisticItems(': { logisticItems: [] },
  };
  const context = await loadContext(caller(answers, ['logisticItems(']), ['logistics', 'rituals'], []);
  assert.equal(context.text, 'ritual: Walk (daily)');
});

test('journal entries are read only for the ids listed, and clipped', async () => {
  const answers = {
    userSettings: PRONOUNS,
    journalEntries: { journalEntries: [{ entryDate: '2026-01-02', body: 'x'.repeat(900) }] },
  };
  const none = await loadContext(caller(answers), [], []);
  assert.equal(none.text, '');
  const some = await loadContext(caller(answers), [], [ID]);
  assert.match(some.text, /^diary 2026-01-02 \(shared by the person for this chat\): x{600}$/);
});

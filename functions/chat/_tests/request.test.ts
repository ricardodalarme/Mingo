import assert from 'node:assert/strict';
import { test } from 'node:test';
import { LIMITS, parseChatRequest } from '../_request.ts';

const ID = '0b7b1f1e-6f0a-4f4e-8a34-2f6a1c9d3b21';

test('a body with no message has nothing to answer', () => {
  assert.equal(parseChatRequest(undefined), null);
  assert.equal(parseChatRequest({}), null);
  assert.equal(parseChatRequest({ message: '   ' }), null);
  assert.equal(parseChatRequest('hello'), null);
});

test('the defaults are a free chat in Portuguese with actions on', () => {
  const request = parseChatRequest({ message: ' oi ' });
  assert.equal(request?.message, 'oi');
  assert.equal(request?.locale, 'pt-BR');
  assert.equal(request?.mode, 'free');
  assert.equal(request?.actions, true);
  assert.deepEqual(request?.history, []);
  assert.deepEqual(request?.contextFlags, []);
});

test('the message is cut to the limit', () => {
  assert.equal(parseChatRequest({ message: 'a'.repeat(5000) })?.message.length, LIMITS.message);
});

test('only the known mode and a well formed session are kept', () => {
  assert.equal(parseChatRequest({ message: 'x', mode: 'hard_conversation' })?.mode, 'hard_conversation');
  assert.equal(parseChatRequest({ message: 'x', mode: 'anything' })?.mode, 'free');
  assert.equal(parseChatRequest({ message: 'x', session: 'abc_123-XYZ' })?.session, 'abc_123-XYZ');
  const generated = parseChatRequest({ message: 'x', session: 'bad session!' })?.session;
  assert.match(generated ?? '', /^[0-9a-f-]{36}$/);
});

test('the history keeps the latest valid turns, cut to the limit', () => {
  const turns = [
    ...Array.from({ length: 20 }, (_, i) => ({ role: i % 2 ? 'mascot' : 'user', text: `turn ${i}` })),
    { role: 'system', text: 'ignored role' },
    { role: 'user', text: 7 },
    null,
  ];
  const { history } = parseChatRequest({ message: 'x', history: turns }) ?? { history: [] };
  assert.equal(history.length, LIMITS.history);
  assert.equal(history.at(-1)?.text, 'turn 19');
  assert.ok(history.every((turn) => turn.role === 'user' || turn.role === 'mascot'));
  assert.equal(
    parseChatRequest({ message: 'x', history: [{ role: 'user', text: 'a'.repeat(5000) }] })?.history[0]?.text.length,
    LIMITS.message,
  );
});

test('context flags are known, unique and journal ids are uuids, at most three', () => {
  const request = parseChatRequest({
    message: 'x',
    context: ['slips', 'slips', 'mood', 'secrets', 7],
    journalEntryIds: [ID, ID, ID, ID, 'not-a-uuid', 7],
  });
  assert.deepEqual(request?.contextFlags, ['slips', 'mood']);
  assert.deepEqual(request?.journalEntryIds, [ID, ID, ID]);
});

test('actions are off only when the app says false', () => {
  assert.equal(parseChatRequest({ message: 'x', actions: false })?.actions, false);
  assert.equal(parseChatRequest({ message: 'x', actions: 'no' })?.actions, true);
});

import { test } from 'node:test';
import assert from 'node:assert/strict';
import { jsonEnv, parseOptions, relay, type ChatEvent } from '../_relay.ts';

const chunk = (text: string) => new TextEncoder().encode(text);
const sse = (pieces: string[]) =>
  (async function* () {
    for (const piece of pieces) yield chunk(`data: ${JSON.stringify({ choices: [{ delta: { content: piece } }] })}\n\n`);
    yield chunk('data: [DONE]\n\n');
  })();

test('the options line is read as up to three short chips', () => {
  assert.deepEqual(parseOptions('Oi! Como foi o dia?\n[[options: calmo | cansado | difícil]]'), ['calmo', 'cansado', 'difícil']);
  assert.deepEqual(parseOptions('Hello\n[[options: a | b | c | d]]'), ['a', 'b', 'c']);
  assert.deepEqual(parseOptions('Hello\n[[options: a | b | c ]] trailing'), ['a', 'b', 'c']);
  assert.deepEqual(parseOptions('no chips here'), []);
  assert.deepEqual(parseOptions('[[OPTIONS: yes | no]]'), ['yes', 'no'], 'the marker is case insensitive');
});

test('chips never show up as text and the text streams in order', async () => {
  const events: ChatEvent[] = [];
  await relay(sse(['Oi, ', 'tudo ', 'bem?', '\n[[options: sim | não]]']), (event) => events.push(event));
  const text = events.filter((e) => e.type === 'delta').map((e: any) => e.text).join('');
  assert.equal(text, 'Oi, tudo bem?\n');
  assert.deepEqual(events.at(-1), { type: 'done', options: ['sim', 'não'] });
});

test('a partial marker at the end of a chunk is held back, not shown and repeated', async () => {
  const events: ChatEvent[] = [];
  await relay(sse(['one [', '[options: a | b]]']), (event) => events.push(event));
  const text = events.filter((e) => e.type === 'delta').map((e: any) => e.text).join('');
  assert.equal(text, 'one ');
  assert.deepEqual(events.at(-1), { type: 'done', options: ['a', 'b'] });
});

test('a reply with no chips streams whole', async () => {
  const events: ChatEvent[] = [];
  await relay(sse(['nothing ', 'to ', 'add']), (event) => events.push(event));
  assert.equal(events.filter((e) => e.type === 'delta').map((e: any) => e.text).join(''), 'nothing to add');
  assert.deepEqual(events.at(-1), { type: 'done', options: [] });
});

test('malformed and empty chunks are skipped', async () => {
  const events: ChatEvent[] = [];
  const input = (async function* () {
    yield chunk('data: not json\n\n');
    yield chunk('data: {"choices":[{"delta":{}}]}\n\n');
    yield chunk('event: ping\n\n');
  })();
  await relay(input, (event) => events.push(event));
  assert.deepEqual(events, [{ type: 'done', options: [] }]);
});

test('jsonEnv reads an object and ignores anything else', () => {
  process.env.CHAT_TEST_JSON = '{"a":1}';
  assert.deepEqual(jsonEnv('CHAT_TEST_JSON'), { a: 1 });
  process.env.CHAT_TEST_JSON = '[1,2]';
  assert.deepEqual(jsonEnv('CHAT_TEST_JSON'), {});
  process.env.CHAT_TEST_JSON = 'not json';
  assert.deepEqual(jsonEnv('CHAT_TEST_JSON'), {});
  delete process.env.CHAT_TEST_JSON;
  assert.deepEqual(jsonEnv('CHAT_TEST_JSON'), {});
});

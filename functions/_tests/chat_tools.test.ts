import { test } from 'node:test';
import assert from 'node:assert/strict';
import { TOOLS, toolDefinitions, validateAction } from '../_lib/chat_tools.ts';
import { relay, systemPrompt, type ChatEvent } from '../_lib/chat.ts';

const chunk = (text: string) => new TextEncoder().encode(text);
const sse = (deltas: unknown[]) =>
  (async function* () {
    for (const delta of deltas) yield chunk(`data: ${JSON.stringify({ choices: [{ delta }] })}\n\n`);
    yield chunk('data: [DONE]\n\n');
  })();

test('the catalog has the 25 final tool names and marks what reaches the partner', () => {
  assert.deepEqual(Object.keys(TOOLS).sort(), [
    'add_logistic_item_for_both', 'add_to_private_list', 'change_distance_count', 'change_widget_or_time', 'create_calendar_event',
    'create_private_reminder', 'create_private_slip', 'create_shared_date', 'draft_card', 'draft_logistic_item', 'draft_note',
    'invite_to_game', 'log_mood', 'open_purchase', 'save_learning', 'save_private_memory', 'search_slips', 'send_card',
    'send_note_or_drawing', 'send_repair_card', 'send_slip_to_partner', 'share_memory', 'share_mood', 'suggest_couple_question',
    'suggest_notification_change',
  ].sort());
  const confirm = Object.entries(TOOLS).filter(([, t]) => t.confirm).map(([name]) => name).sort();
  assert.deepEqual(confirm, ['add_logistic_item_for_both', 'change_distance_count', 'change_widget_or_time', 'create_calendar_event',
    'create_shared_date', 'invite_to_game', 'open_purchase', 'send_card', 'send_note_or_drawing', 'send_repair_card', 'send_slip_to_partner',
    'share_memory', 'share_mood']);
  for (const name of ['create_private_slip', 'log_mood', 'draft_card', 'save_private_memory', 'draft_note', 'search_slips']) {
    assert.equal(TOOLS[name].confirm, false, name);
  }
});

test('a valid call is trimmed and returned with its confirmation rule', () => {
  assert.deepEqual(validateAction('create_private_slip', { body: '  fez café  ' }), { tool: 'create_private_slip', args: { body: 'fez café' }, confirm: false });
  assert.deepEqual(validateAction('share_mood', { mood: 'happy' }), { tool: 'share_mood', args: { mood: 'happy' }, confirm: true });
  assert.deepEqual(validateAction('open_purchase', {}), { tool: 'open_purchase', args: {}, confirm: true });
  assert.deepEqual(validateAction('create_calendar_event', { title: 'Jantar', date: '2026-12-01', time: '19:30' })?.args, { title: 'Jantar', date: '2026-12-01', time: '19:30' });
});

test('an unknown tool, an extra or missing argument and a value out of bounds are refused', () => {
  assert.equal(validateAction('delete_everything', {}), null);
  assert.equal(validateAction('constructor', {}), null);
  assert.equal(validateAction('__proto__', {}), null);
  assert.equal(validateAction('create_private_slip', { body: 'x', admin: true }), null);
  assert.equal(validateAction('create_private_slip', {}), null);
  assert.equal(validateAction('create_private_slip', { body: '   ' }), null);
  assert.equal(validateAction('create_private_slip', { body: 'x'.repeat(281) }), null);
  assert.equal(validateAction('log_mood', { mood: 'angry' }), null);
  assert.equal(validateAction('create_shared_date', { title: 'x', month: 13, day: 1 }), null);
  assert.equal(validateAction('create_shared_date', { title: 'x', month: 5, day: 1.5 }), null);
  assert.equal(validateAction('create_calendar_event', { title: 'x', date: '01/12/2026' }), null);
  assert.equal(validateAction('create_calendar_event', { title: 'x', date: '2026-12-01', time: '25:00' }), null);
  assert.equal(validateAction('send_note_or_drawing', { kind: 'drawing', body: 'x' }), null);
  assert.equal(validateAction('draft_card', 'a string'), null);
  assert.equal(validateAction('draft_card', ['x']), null);
  assert.equal(validateAction('draft_card', null), null);
});

test('the tool definitions are strict objects with the bounds of the catalog', () => {
  const defs = toolDefinitions();
  assert.equal(defs.length, Object.keys(TOOLS).length);
  const slip = defs.find((d) => d.function.name === 'create_private_slip')!;
  assert.equal(slip.function.parameters.additionalProperties, false);
  assert.deepEqual(slip.function.parameters.required, ['body']);
  assert.deepEqual((slip.function.parameters.properties as any).body, { type: 'string', maxLength: 280 });
});

test('a streamed tool call becomes one action event before the end, and a bad one is dropped', async () => {
  const events: ChatEvent[] = [];
  await relay(
    sse([
      { content: 'Posso guardar isso.' },
      { tool_calls: [{ index: 0, function: { name: 'create_private_', arguments: '{"body":' } }] },
      { tool_calls: [{ index: 0, function: { name: 'slip', arguments: '"fez café"}' } }] },
      { tool_calls: [{ index: 1, function: { name: 'send_card', arguments: '{"note":"x","evil":1}' } }] },
      { tool_calls: [{ index: 2, function: { name: 'open_purchase', arguments: '' } }] },
      { tool_calls: [{ index: 3, function: { name: 'nope', arguments: '{}' } }] },
    ]),
    (event) => events.push(event),
    validateAction,
  );
  assert.deepEqual(events.map((e) => e.type), ['delta', 'action', 'action', 'done']);
  assert.deepEqual(events[1], { type: 'action', tool: 'create_private_slip', args: { body: 'fez café' }, confirm: false });
  assert.deepEqual(events[2], { type: 'action', tool: 'open_purchase', args: {}, confirm: true });
});

test('at most three actions are relayed, and none without a validator', async () => {
  const many = Array.from({ length: 6 }, (_, index) => ({ tool_calls: [{ index, function: { name: 'open_purchase', arguments: '{}' } }] }));
  const withValidator: ChatEvent[] = [];
  await relay(sse(many), (e) => withValidator.push(e), validateAction);
  assert.equal(withValidator.filter((e) => e.type === 'action').length, 3);
  const without: ChatEvent[] = [];
  await relay(sse(many), (e) => without.push(e));
  assert.deepEqual(without, [{ type: 'done', options: [] }]);
});

test('the prompt carries the stated pronouns, never a guess, and the context', () => {
  const stated = systemPrompt('en', 'free', { pronouns: 'she', partnerPronouns: 'he', partnerName: 'Bruno', actions: true, context: 'slip: made tea' });
  for (const word of ['she/her', 'he/him', 'Bruno', 'never guess', 'slip: made tea', 'tools provided']) assert.ok(stated.includes(word), word);
  const unknown = systemPrompt('pt-BR', 'free', { pronouns: null, partnerPronouns: 'name_only' });
  assert.ok(unknown.includes('não informado') && unknown.includes('só o nome') && unknown.includes('nunca adivinhe'));
  assert.equal(systemPrompt('en', 'free'), systemPrompt('en', 'free', null), 'without options the prompt is the plain one');
});

import assert from 'node:assert/strict';
import { test } from 'node:test';
import { systemPrompt } from '../index.ts';

test('the system prompt forbids diagnosis, scores and pressure, in both languages', () => {
  for (const [locale, words] of [
    ['pt-BR', ['Nunca diagnostique', 'Não use pontuação', 'nunca pressione']],
    ['en', ['Never diagnose', 'No scores', 'never push']],
  ] as const) {
    const prompt = systemPrompt(locale, 'free');
    for (const word of words) assert.ok(prompt.includes(word), `${locale} is missing ${word}`);
    assert.ok(!prompt.includes('hard conversation: first listen'), 'the free mode has no preparation instructions');
  }
});

test('the hard conversation mode adds preparation instructions', () => {
  assert.ok(systemPrompt('en', 'hard_conversation').includes('prepare for a hard conversation'));
  assert.ok(systemPrompt('pt-BR', 'hard_conversation').includes('conversa difícil'));
});

test('the prompt carries the stated pronouns, never a guess, and the context', () => {
  const stated = systemPrompt('en', 'free', {
    pronouns: 'she',
    partnerPronouns: 'he',
    partnerName: 'Bruno',
    actions: true,
    context: 'slip: made tea',
  });
  for (const word of ['she/her', 'he/him', 'Bruno', 'never guess', 'slip: made tea', 'tools provided'])
    assert.ok(stated.includes(word), word);
  const unknown = systemPrompt('pt-BR', 'free', {
    pronouns: null,
    partnerPronouns: 'name_only',
  });
  assert.ok(unknown.includes('não informado') && unknown.includes('só o nome') && unknown.includes('nunca adivinhe'));
  assert.equal(
    systemPrompt('en', 'free'),
    systemPrompt('en', 'free', null),
    'without options the prompt is the plain one',
  );
});

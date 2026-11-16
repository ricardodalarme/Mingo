// Turns an OpenAI-compatible streaming response into the app's events, and keeps the answer chips
// (a final `[[options: a | b | c]]` line) out of the text.
export const OPTIONS_MARKER = '[[options:';

export type ChatEvent =
  | { type: 'delta'; text: string }
  | { type: 'action'; tool: string; args: Record<string, unknown>; confirm: boolean }
  | { type: 'done'; options: string[] }
  | { type: 'error'; code: string };

const MAX_ACTIONS = 3;
/** Turns a streamed tool call into a validated action, or null when it is not one the app can run. */
export type ActionValidator = (name: string, args: unknown) => { tool: string; args: Record<string, unknown>; confirm: boolean } | null;

/** Reads the answer chips from the end of a full reply, or an empty list when there are none. */
export function parseOptions(full: string): string[] {
  const at = full.toLowerCase().indexOf(OPTIONS_MARKER);
  if (at < 0) return [];
  return full
    .slice(at + OPTIONS_MARKER.length)
    .replace(/\]\].*$/s, '')
    .split('|')
    .map((option) => option.trim())
    .filter(Boolean)
    .slice(0, 3)
    .map((option) => option.slice(0, 40));
}

/**
 * Reads the upstream stream and calls [send] for each piece of text and once at the end.
 * Text from a possible options marker on is held back, so the chips never show up as text.
 */
export async function relay(chunks: AsyncIterable<Uint8Array>, send: (event: ChatEvent) => void, validate?: ActionValidator): Promise<void> {
  const decoder = new TextDecoder();
  let buffered = '';
  let full = '';
  let emitted = 0;
  const calls = new Map<number, { name: string; args: string }>();
  for await (const value of chunks) {
    buffered += decoder.decode(value, { stream: true });
    const lines = buffered.split('\n');
    buffered = lines.pop() ?? '';
    for (const line of lines) {
      if (!line.startsWith('data:')) continue;
      const data = line.slice(5).trim();
      if (!data || data === '[DONE]') continue;
      let piece = '';
      try {
        const delta = JSON.parse(data).choices?.[0]?.delta;
        piece = delta?.content ?? '';
        for (const call of Array.isArray(delta?.tool_calls) ? delta.tool_calls : []) {
          const entry = calls.get(call.index ?? 0) ?? { name: '', args: '' };
          if (call.function?.name) entry.name += call.function.name;
          if (call.function?.arguments) entry.args += call.function.arguments;
          calls.set(call.index ?? 0, entry);
        }
      } catch {
        continue;
      }
      if (!piece) continue;
      full += piece;
      const marker = full.indexOf('[[');
      let safeEnd = marker >= 0 ? marker : full.length;
      if (marker < 0 && full.endsWith('[')) safeEnd = full.length - 1;
      if (safeEnd > emitted) {
        send({ type: 'delta', text: full.slice(emitted, safeEnd) });
        emitted = safeEnd;
      }
    }
  }
  if (validate) {
    let sent = 0;
    for (const call of calls.values()) {
      if (sent >= MAX_ACTIONS) break;
      let parsed: unknown = null;
      try {
        parsed = JSON.parse(call.args || '{}');
      } catch {
        continue;
      }
      const action = validate(call.name, parsed);
      if (action) {
        send({ type: 'action', ...action });
        sent++;
      }
    }
  }
  const options = parseOptions(full);
  if (!full.toLowerCase().includes(OPTIONS_MARKER) && emitted < full.length) {
    send({ type: 'delta', text: full.slice(emitted) });
  }
  send({ type: 'done', options });
}

export type PromptOptions = {
  pronouns?: string | null;
  partnerPronouns?: string | null;
  partnerName?: string | null;
  context?: string;
  actions?: boolean;
};

const PRONOUN_WORDS: Record<string, { pt: string; en: string }> = {
  she: { pt: 'ela/dela', en: 'she/her' },
  he: { pt: 'ele/dele', en: 'he/him' },
  name_only: { pt: 'sem pronomes: use só o nome', en: 'no pronouns: use the name only' },
};

function pronounRule(pt: boolean, options: PromptOptions): string {
  const word = (key?: string | null) => (key && PRONOUN_WORDS[key] ? PRONOUN_WORDS[key][pt ? 'pt' : 'en'] : null);
  const own = word(options.pronouns);
  const partner = word(options.partnerPronouns);
  const name = options.partnerName ? (pt ? ` O nome do parceiro é ${options.partnerName}.` : ` The partner's name is ${options.partnerName}.`) : '';
  if (pt) {
    return ` Pronomes: a pessoa usa ${own ?? 'não informado'}; o parceiro usa ${partner ?? 'não informado'}.${name} Use exatamente esses pronomes; quando não estiverem informados, use o nome ou frases neutras e nunca adivinhe.`;
  }
  return ` Pronouns: the person uses ${own ?? 'not stated'}; their partner uses ${partner ?? 'not stated'}.${name} Use exactly these pronouns; when they are not stated, use the name or neutral phrasing and never guess.`;
}

export function systemPrompt(locale: string, mode: string, options: PromptOptions | null = null): string {
  const pt = locale.startsWith('pt');
  const base = pt
    ? 'Você é a mascote de um app para casais: calma, acolhedora e curta. Responda em português do Brasil, em no máximo 90 palavras, com no máximo uma pergunta. Nunca diagnostique, nunca dê conselho médico, jurídico ou clínico, nunca tome partido contra a outra pessoa e nunca pressione a pessoa a ficar ou a terminar. Não use pontuação, ranking ou cobrança. Só se a pessoa descrever perigo real, sugira procurar alguém de confiança ou o serviço de emergência da região; em qualquer outra conversa não mencione isso. Termine sempre com uma última linha no formato [[options: resposta curta 1 | resposta curta 2 | resposta curta 3]], com no máximo três opções de até quatro palavras.'
    : 'You are the mascot of a couples app: calm, warm and brief. Answer in English, in at most 90 words, with at most one question. Never diagnose, never give medical, legal or clinical advice, never take sides against the other person and never push the person to stay or to leave. No scores, rankings or guilt. Only if the person describes real danger, suggest reaching someone they trust or local emergency services; in any other conversation do not mention it. Always end with a last line in the format [[options: short answer 1 | short answer 2 | short answer 3]], with at most three options of up to four words.';
  let prompt = base;
  if (mode === 'hard_conversation') {
    prompt += pt
      ? ' Neste modo você ajuda a pessoa a se preparar para uma conversa difícil: primeiro escute, depois ajude a nomear o que ela sente e precisa, e por fim ofereça uma frase de abertura suave que ela possa dizer com as próprias palavras.'
      : ' In this mode you help the person prepare for a hard conversation: first listen, then help name what they feel and need, and finally offer one soft opening sentence they can say in their own words.';
  }
  if (!options) return prompt;
  prompt += pronounRule(pt, options);
  if (options.actions) {
    prompt += pt
      ? ' Você pode sugerir ações com as ferramentas oferecidas. Nunca diga que algo foi feito: o app pergunta à pessoa antes de qualquer coisa que chegue ao parceiro.'
      : ' You may suggest actions with the tools provided. Never say something was done: the app asks the person before anything that reaches their partner.';
  }
  if (options.context) {
    prompt += (pt ? '\n\nO que a pessoa deixou você ler (privado, não repita literalmente):\n' : '\n\nWhat the person let you read (private, do not quote verbatim):\n') + options.context;
  }
  return prompt;
}

/** A JSON object from an environment variable, or an empty object when it is unset or not an object. */
export function jsonEnv(name: string): Record<string, unknown> {
  try {
    const value = JSON.parse(process.env[name] ?? '{}');
    return value && typeof value === 'object' && !Array.isArray(value) ? value : {};
  } catch {
    return {};
  }
}

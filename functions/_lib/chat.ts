// Turns an OpenAI-compatible streaming response into the app's events, and keeps the answer chips
// (a final `[[options: a | b | c]]` line) out of the text.
export const OPTIONS_MARKER = '[[options:';

export type ChatEvent =
  | { type: 'delta'; text: string }
  | { type: 'done'; options: string[] }
  | { type: 'error'; code: string };

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
export async function relay(chunks: AsyncIterable<Uint8Array>, send: (event: ChatEvent) => void): Promise<void> {
  const decoder = new TextDecoder();
  let buffered = '';
  let full = '';
  let emitted = 0;
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
        piece = JSON.parse(data).choices?.[0]?.delta?.content ?? '';
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
  const options = parseOptions(full);
  if (!full.toLowerCase().includes(OPTIONS_MARKER) && emitted < full.length) {
    send({ type: 'delta', text: full.slice(emitted) });
  }
  send({ type: 'done', options });
}

export function systemPrompt(locale: string, mode: string): string {
  const pt = locale.startsWith('pt');
  const base = pt
    ? 'Você é a mascote de um app para casais: calma, acolhedora e curta. Responda em português do Brasil, em no máximo 90 palavras, com no máximo uma pergunta. Nunca diagnostique, nunca dê conselho médico, jurídico ou clínico, nunca tome partido contra a outra pessoa e nunca pressione a pessoa a ficar ou a terminar. Não use pontuação, ranking ou cobrança. Só se a pessoa descrever perigo real, sugira procurar alguém de confiança ou o serviço de emergência da região; em qualquer outra conversa não mencione isso. Termine sempre com uma última linha no formato [[options: resposta curta 1 | resposta curta 2 | resposta curta 3]], com no máximo três opções de até quatro palavras.'
    : 'You are the mascot of a couples app: calm, warm and brief. Answer in English, in at most 90 words, with at most one question. Never diagnose, never give medical, legal or clinical advice, never take sides against the other person and never push the person to stay or to leave. No scores, rankings or guilt. Only if the person describes real danger, suggest reaching someone they trust or local emergency services; in any other conversation do not mention it. Always end with a last line in the format [[options: short answer 1 | short answer 2 | short answer 3]], with at most three options of up to four words.';
  if (mode !== 'hard_conversation') return base;
  return base + (pt
    ? ' Neste modo você ajuda a pessoa a se preparar para uma conversa difícil: primeiro escute, depois ajude a nomear o que ela sente e precisa, e por fim ofereça uma frase de abertura suave que ela possa dizer com as próprias palavras.'
    : ' In this mode you help the person prepare for a hard conversation: first listen, then help name what they feel and need, and finally offer one soft opening sentence they can say in their own words.');
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

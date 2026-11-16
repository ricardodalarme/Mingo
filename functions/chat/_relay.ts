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

/** A JSON object from an environment variable, or an empty object when it is unset or not an object. */
export function jsonEnv(name: string): Record<string, unknown> {
  try {
    const value = JSON.parse(process.env[name] ?? '{}');
    return value && typeof value === 'object' && !Array.isArray(value) ? value : {};
  } catch {
    return {};
  }
}

// Turns an OpenAI-compatible streaming response into the app's events, and keeps the answer chips
// (a final `[[options: a | b | c]]` line) out of the text.
import * as v from 'valibot';
import type { ErrorCode } from '../_lib/http.ts';
import { parse } from '../_lib/payloads.ts';

const MARKER_OPEN = '[[';
export const OPTIONS_MARKER = '[[options:';
const MARKER_CLOSE = /\]\].*$/s;
const MAX_OPTIONS = 3;
const MAX_OPTION_LENGTH = 40;
const MAX_ACTIONS = 3;

export type ChatErrorCode = Extract<ErrorCode, 'CHAT_UNAVAILABLE' | 'CHAT_LIMIT' | 'UPSTREAM'>;

export type Action = { tool: string; args: Record<string, unknown>; confirm: boolean };

export type ChatEvent =
  | { type: 'delta'; text: string }
  | ({ type: 'action' } & Action)
  | { type: 'done'; options: string[] }
  | { type: 'error'; code: ChatErrorCode };

/** Turns a streamed tool call into a validated action, or null when it is not one the app can run. */
export type ActionValidator = (name: string, args: unknown) => Action | null;

const Chunk = v.object({
  choices: v.optional(
    v.array(
      v.object({
        delta: v.optional(
          v.object({
            content: v.nullish(v.string()),
            tool_calls: v.optional(
              v.array(
                v.object({
                  index: v.nullish(v.number()),
                  function: v.optional(v.object({ name: v.nullish(v.string()), arguments: v.nullish(v.string()) })),
                }),
              ),
            ),
          }),
        ),
      }),
    ),
  ),
});
type Delta = NonNullable<NonNullable<v.InferOutput<typeof Chunk>['choices']>[number]['delta']>;
type PartialCall = { name: string; args: string };

/** Reads the answer chips from the end of a full reply, or an empty list when there are none. */
export function parseOptions(full: string): string[] {
  const at = full.toLowerCase().indexOf(OPTIONS_MARKER);
  if (at < 0) return [];
  return full
    .slice(at + OPTIONS_MARKER.length)
    .replace(MARKER_CLOSE, '')
    .split('|')
    .map((option) => option.trim())
    .filter(Boolean)
    .slice(0, MAX_OPTIONS)
    .map((option) => option.slice(0, MAX_OPTION_LENGTH));
}

/** The complete lines of a byte stream. A last line that never gets its newline is dropped. */
async function* linesOf(chunks: AsyncIterable<Uint8Array>): AsyncGenerator<string> {
  const decoder = new TextDecoder();
  let pending = '';
  for await (const chunk of chunks) {
    pending += decoder.decode(chunk, { stream: true });
    const lines = pending.split('\n');
    pending = lines.pop() ?? '';
    yield* lines;
  }
}

/** The payload of a server-sent events line, or null for a line that carries none. */
function payloadOf(line: string): string | null {
  if (!line.startsWith('data:')) return null;
  const data = line.slice('data:'.length).trim();
  return !data || data === '[DONE]' ? null : data;
}

const deltaOf = (data: string): Delta | undefined => {
  let json: unknown;
  try {
    json = JSON.parse(data);
  } catch {
    return undefined;
  }
  return parse(Chunk, json)?.choices?.[0]?.delta;
};

/** Adds the pieces of a streamed tool call to the calls collected so far. */
function collectCalls(calls: Map<number, PartialCall>, delta: Delta): void {
  for (const call of delta.tool_calls ?? []) {
    const index = call.index ?? 0;
    const entry = calls.get(index) ?? { name: '', args: '' };
    entry.name += call.function?.name ?? '';
    entry.args += call.function?.arguments ?? '';
    calls.set(index, entry);
  }
}

/** How much of [full] can be shown: everything before a possible options marker. */
function visibleLength(full: string): number {
  const marker = full.indexOf(MARKER_OPEN);
  if (marker >= 0) return marker;
  return full.endsWith('[') ? full.length - 1 : full.length;
}

/** The validated actions of the collected tool calls, at most [MAX_ACTIONS]. */
function toActions(calls: Iterable<PartialCall>, validate: ActionValidator): Action[] {
  const actions: Action[] = [];
  for (const call of calls) {
    if (actions.length >= MAX_ACTIONS) break;
    let args: unknown;
    try {
      args = JSON.parse(call.args || '{}');
    } catch {
      continue;
    }
    const action = validate(call.name, args);
    if (action) actions.push(action);
  }
  return actions;
}

/**
 * Reads the upstream stream and calls [send] for each piece of text and once at the end.
 * Text from a possible options marker on is held back, so the chips never show up as text.
 */
export async function relay(
  chunks: AsyncIterable<Uint8Array>,
  send: (event: ChatEvent) => void,
  validate?: ActionValidator,
): Promise<void> {
  const calls = new Map<number, PartialCall>();
  let full = '';
  let emitted = 0;
  for await (const line of linesOf(chunks)) {
    const data = payloadOf(line);
    const delta = data === null ? undefined : deltaOf(data);
    if (!delta) continue;
    collectCalls(calls, delta);
    full += delta.content ?? '';
    const end = visibleLength(full);
    if (end > emitted) {
      send({ type: 'delta', text: full.slice(emitted, end) });
      emitted = end;
    }
  }
  for (const action of validate ? toActions(calls.values(), validate) : []) send({ type: 'action', ...action });
  if (!full.toLowerCase().includes(OPTIONS_MARKER) && emitted < full.length) {
    send({ type: 'delta', text: full.slice(emitted) });
  }
  send({ type: 'done', options: parseOptions(full) });
}

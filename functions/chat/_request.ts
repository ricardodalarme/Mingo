import { randomUUID } from 'node:crypto';
import { UUID } from '../_lib/payloads.ts';
import { type ContextFlag, isContextFlag } from './_context.ts';

export const LIMITS = { message: 1000, history: 12, journalEntries: 3 } as const;
const DEFAULT_LOCALE = 'pt-BR';
const SESSION = /^[A-Za-z0-9_-]{1,80}$/;

export type Turn = { role: 'user' | 'mascot'; text: string };
export type ChatMode = 'free' | 'hard_conversation';

/** What the person asked for, clamped to what the function accepts. */
export type ChatRequest = {
  message: string;
  locale: string;
  mode: ChatMode;
  session: string;
  history: Turn[];
  contextFlags: ContextFlag[];
  journalEntryIds: string[];
  /** Whether the app asked for suggested actions; the server can still switch them off. */
  actions: boolean;
};

type Body = Record<string, unknown>;

const isBody = (value: unknown): value is Body => typeof value === 'object' && value !== null && !Array.isArray(value);

const isTurn = (value: unknown): value is Turn =>
  isBody(value) && (value.role === 'user' || value.role === 'mascot') && typeof value.text === 'string';

const list = (value: unknown): unknown[] => (Array.isArray(value) ? value : []);

/** The request in a body, or null when there is no message to answer. */
export function parseChatRequest(raw: unknown): ChatRequest | null {
  const body: Body = isBody(raw) ? raw : {};
  const message = String(body.message ?? '')
    .trim()
    .slice(0, LIMITS.message);
  if (!message) return null;
  return {
    message,
    locale: typeof body.locale === 'string' ? body.locale : DEFAULT_LOCALE,
    mode: body.mode === 'hard_conversation' ? 'hard_conversation' : 'free',
    session: typeof body.session === 'string' && SESSION.test(body.session) ? body.session : randomUUID(),
    history: list(body.history)
      .filter(isTurn)
      .slice(-LIMITS.history)
      .map((turn) => ({ role: turn.role, text: turn.text.slice(0, LIMITS.message) })),
    contextFlags: [...new Set(list(body.context).filter(isContextFlag))],
    journalEntryIds: list(body.journalEntryIds)
      .filter((id): id is string => typeof id === 'string' && UUID.test(id))
      .slice(0, LIMITS.journalEntries),
    actions: body.actions !== false,
  };
}

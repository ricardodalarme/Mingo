// Calm chat with the mascot. Signed-in people only; the reply streams as server-sent events.
//   POST /chat  { message, history?: [{ role: "user" | "mascot", text }], locale?: "pt-BR" | "en", mode?: "free" | "hard_conversation", session?,
//               context?: ("slips" | "mood" | "week" | "dates" | "lists" | "logistics" | "rituals" | "plan")[], journalEntryIds?: uuid[], actions?: boolean }
//   -> text/event-stream, one JSON object per `data:` line:
//        { type: "delta", text }       a piece of the reply
//        { type: "action", tool, args, confirm }  an action the app may run; `confirm` means it needs the person's yes first
//        { type: "done", options }     the end, with up to three short answer chips
//        { type: "error", code }       CHAT_UNAVAILABLE | CHAT_LIMIT | UPSTREAM
// Nothing the person writes and nothing the model answers is stored or logged: a turn is a row without text that
// counts against the daily allowance, and that is all.
// Needs CHAT_API_URL (an OpenAI-compatible base, e.g. https://host/v1), CHAT_API_KEY and CHAT_MODEL;
// CHAT_EXTRA_BODY and CHAT_EXTRA_HEADERS (JSON objects) are optional.
import { randomUUID } from 'node:crypto';
import { asAdmin, asCaller, header, log, type Req, type Res } from './_lib/backend';
import { type ChatEvent, jsonEnv, relay, systemPrompt } from './_lib/chat';
import { loadContext } from './_lib/chat_context';
import { toolDefinitions, validateAction } from './_lib/chat_tools';

const MAX_MESSAGE = 1000;
const MAX_HISTORY = 12;
const SESSION = /^[A-Za-z0-9_-]{1,80}$/;

type Turn = { role: 'user' | 'mascot'; text: string };

function oneEvent(res: Res, status: number, event: ChatEvent) {
  res.status(status);
  res.setHeader('content-type', 'text/event-stream');
  res.setHeader('cache-control', 'no-store');
  res.write(`data: ${JSON.stringify(event)}\n\n`);
  res.end();
}

export default async (req: Req, res: Res) => {
  if (req.method !== 'POST') return res.status(405).json({ error: 'METHOD_NOT_ALLOWED' });
  if (!/^Bearer\s+\S+/i.test(header(req, 'authorization'))) return res.status(401).json({ error: 'UNAUTHORIZED' });

  const body = req.body ?? {};
  const message = String(body.message ?? '').trim().slice(0, MAX_MESSAGE);
  if (!message) return res.status(400).json({ error: 'EMPTY_MESSAGE' });
  const locale = String(body.locale ?? 'pt-BR');
  const mode = body.mode === 'hard_conversation' ? 'hard_conversation' : 'free';
  const session = typeof body.session === 'string' && SESSION.test(body.session) ? body.session : randomUUID();
  const history: Turn[] = (Array.isArray(body.history) ? body.history : [])
    .filter((t: Turn) => (t?.role === 'user' || t?.role === 'mascot') && typeof t?.text === 'string')
    .slice(-MAX_HISTORY)
    .map((t: Turn) => ({ role: t.role, text: t.text.slice(0, MAX_MESSAGE) }));

  const apiUrl = process.env.CHAT_API_URL;
  const apiKey = process.env.CHAT_API_KEY;
  const model = process.env.CHAT_MODEL;

  // The turn is taken as the caller, so the token is verified by the GraphQL engine and the person's own
  // setting and allowance apply. No row means the chat is switched off or today's allowance is gone.
  let turnId: string | undefined;
  try {
    const data = await asCaller<{ takeChatTurn: { id: string }[] }>(req, `mutation { takeChatTurn { id } }`);
    turnId = data.takeChatTurn[0]?.id;
  } catch {
    return res.status(401).json({ error: 'UNAUTHORIZED' });
  }
  if (!turnId) return oneEvent(res, 429, { type: 'error', code: 'CHAT_LIMIT' });
  const refund = () => asAdmin(`mutation ($id: uuid!) { deleteChatTurnsByPk(id: $id) { id } }`, { id: turnId }).catch(() => {});

  if (!apiUrl || !apiKey || !model) {
    await refund();
    return oneEvent(res, 503, { type: 'error', code: 'CHAT_UNAVAILABLE' });
  }

  // What the person lets the mascot read, and the pronouns, both loaded as the caller. A failure only leaves them out.
  const context = await loadContext((query, variables) => asCaller(req, query, variables), body.context, body.journalEntryIds).catch(() => null);
  const actions = body.actions !== false && process.env.CHAT_TOOLS !== 'off';
  const prompt = systemPrompt(locale, mode, {
    pronouns: context?.pronouns, partnerPronouns: context?.partnerPronouns, partnerName: context?.partnerName,
    context: context?.text, actions,
  });

  const extraHeaders = Object.fromEntries(
    Object.entries(jsonEnv('CHAT_EXTRA_HEADERS')).map(([k, v]) => [k, String(v).replace('{session}', session)]));
  const upstream = await fetch(`${apiUrl.replace(/\/$/, '')}/chat/completions`, {
    method: 'POST',
    signal: AbortSignal.timeout(30_000),
    headers: { 'content-type': 'application/json', authorization: `Bearer ${apiKey}`, ...extraHeaders },
    body: JSON.stringify({
      model,
      messages: [
        { role: 'system', content: prompt },
        ...history.map((t) => ({ role: t.role === 'mascot' ? 'assistant' : 'user', content: t.text })),
        { role: 'user', content: message },
      ],
      stream: true,
      ...(actions ? { tools: toolDefinitions() } : {}),
      temperature: 0.6,
      max_tokens: 600,
      ...jsonEnv('CHAT_EXTRA_BODY'),
    }),
  }).catch(() => null);
  if (!upstream?.ok || !upstream.body) {
    await refund();
    log('chat_upstream_failed', { status: upstream?.status ?? 0 });
    return oneEvent(res, 502, { type: 'error', code: 'UPSTREAM' });
  }

  res.status(200);
  res.setHeader('content-type', 'text/event-stream');
  res.setHeader('cache-control', 'no-store');
  res.setHeader('x-accel-buffering', 'no');
  res.flushHeaders?.();
  const send = (event: ChatEvent) => res.write(`data: ${JSON.stringify(event)}\n\n`);
  try {
    await relay(upstream.body as unknown as AsyncIterable<Uint8Array>, send, actions ? validateAction : undefined);
  } catch {
    // A break after the first token keeps the charge: the person already saw part of the reply.
    log('chat_stream_failed');
    send({ type: 'error', code: 'UPSTREAM' });
  }
  res.end();
};

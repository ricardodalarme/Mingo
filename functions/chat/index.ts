// Calm chat with the mascot. Signed-in people only; the reply streams as server-sent events.
//   POST /chat  { message, history?, locale?, mode?, session?, context?, journalEntryIds?, actions? }  (see ChatRequest)
//   -> text/event-stream, one JSON object per `data:` line (see ChatEvent):
//        { type: "delta", text }       a piece of the reply
//        { type: "action", tool, args, confirm }  an action the app may run; `confirm` means it needs the person's yes first
//        { type: "done", options }     the end, with up to three short answer chips
//        { type: "error", code }       CHAT_UNAVAILABLE | CHAT_LIMIT | UPSTREAM
// Nothing the person writes and nothing the model answers is stored or logged: a turn is a row without text that
// counts against the daily allowance, and that is all.
// Needs CHAT_API_URL (an OpenAI-compatible base, e.g. https://host/v1), CHAT_API_KEY and CHAT_MODEL;
// CHAT_EXTRA_BODY and CHAT_EXTRA_HEADERS (JSON objects) are optional.

import { env } from '../_lib/env.ts';
import { callerQuery } from '../_lib/graphql.ts';
import { handler } from '../_lib/handler.ts';
import { fail, type Req, type Res } from '../_lib/http.ts';
import { log } from '../_lib/log.ts';
import { type Context, loadContext } from './_context.ts';
import { type ModelConfig, modelConfig, startCompletion } from './_model.ts';
import { systemPrompt } from './_prompts/index.ts';
import { relay } from './_relay.ts';
import { type ChatRequest, parseChatRequest } from './_request.ts';
import { endWithError, openStream } from './_sse.ts';
import { validateAction } from './_tools.ts';
import { refundTurn, takeTurn } from './_turns.ts';

/** What the person lets the mascot read, and the pronouns, both loaded as the caller. A failure only leaves them out. */
const readContext = (req: Req, request: ChatRequest): Promise<Context | null> =>
  loadContext(callerQuery(req), request.contextFlags, request.journalEntryIds).catch(() => null);

/** Answers a request that already holds a turn. Resolves once the reply has been written or refused. */
async function answer(req: Req, res: Res, request: ChatRequest, config: ModelConfig, turnId: string): Promise<void> {
  const context = await readContext(req, request);
  const actions = request.actions && env('CHAT_TOOLS') !== 'off';
  const prompt = systemPrompt(request.locale, request.mode, {
    pronouns: context?.pronouns,
    partnerPronouns: context?.partnerPronouns,
    partnerName: context?.partnerName,
    context: context?.text,
    actions,
  });

  const clientLeft = new AbortController();
  res.on('close', () => {
    if (!res.writableEnded) clientLeft.abort();
  });
  const upstream = await startCompletion(config, {
    prompt,
    history: request.history,
    message: request.message,
    session: request.session,
    actions,
    signal: clientLeft.signal,
  });
  if (!upstream?.body) {
    await refundTurn(turnId);
    return endWithError(res, 'UPSTREAM');
  }

  const send = openStream(res);
  try {
    await relay(upstream.body, send, actions ? validateAction : undefined);
  } catch {
    // A break after the first token keeps the charge: the person already saw part of the reply.
    if (clientLeft.signal.aborted) log.info('chat_client_left');
    else {
      log.warn('chat_stream_failed');
      send({ type: 'error', code: 'UPSTREAM' });
    }
  }
  res.end();
}

export default handler({ method: 'POST', guard: { kind: 'bearer' } }, async (req, res) => {
  const request = parseChatRequest(req.body);
  if (!request) return fail(res, 'EMPTY_MESSAGE');

  let turnId: string | null;
  try {
    turnId = await takeTurn(req);
  } catch {
    return fail(res, 'UNAUTHORIZED');
  }
  if (!turnId) return endWithError(res, 'CHAT_LIMIT');

  const config = modelConfig();
  if (!config) {
    await refundTurn(turnId);
    return endWithError(res, 'CHAT_UNAVAILABLE');
  }
  try {
    await answer(req, res, request, config, turnId);
  } catch (error) {
    await refundTurn(turnId);
    throw error;
  }
});

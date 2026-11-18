import assert from 'node:assert/strict';
import { afterEach, beforeEach, mock, test } from 'node:test';
import {
  BACKEND_ENV,
  eventsOf,
  type FetchCall,
  gql,
  json,
  queryOf,
  request,
  response,
  restoreEnv,
  setEnv,
  stubFetch,
} from '../../_lib/_testing.ts';
import chat from '../index.ts';

const MODEL_ENV = { CHAT_API_URL: 'http://model.test/v1/', CHAT_API_KEY: 'key', CHAT_MODEL: 'tiny' };
const signedIn = { authorization: 'Bearer token' };

beforeEach(() => setEnv({ ...BACKEND_ENV, ...MODEL_ENV }));
afterEach(() => {
  restoreEnv();
  mock.restoreAll();
});

const frame = (delta: unknown) => `data: ${JSON.stringify({ choices: [{ delta }] })}\n\n`;
const stream = (...deltas: unknown[]) => new Response([...deltas.map(frame), 'data: [DONE]\n\n'].join(''));

type Routes = { turn?: unknown[]; model?: (call: FetchCall) => Response | Promise<Response>; engineRefuses?: boolean };

/** A stand-in for the database and the model gateway. */
function backend({
  turn = [{ id: 'turn-1' }],
  model = () => stream({ content: 'Oi!' }),
  engineRefuses = false,
}: Routes = {}) {
  return stubFetch((call) => {
    if (call.url.includes('model.test')) return model(call);
    const query = queryOf(call);
    if (query.includes('takeChatTurn'))
      return engineRefuses ? json({ errors: [{ message: 'jwt' }] }) : gql({ takeChatTurn: turn });
    if (query.includes('userSettings')) return gql({ userSettings: [], profiles: [] });
    return gql({});
  });
}

const ask = async (body: unknown = { message: 'oi' }, headers: Record<string, string> = signedIn) => {
  const res = response();
  await chat(request({ headers, body }), res);
  return res;
};

const refunds = (calls: FetchCall[]) =>
  calls.filter((call) => call.url.includes('graphql') && queryOf(call).includes('deleteChatTurnsByPk'));

test('a request without a token is refused', async () => {
  const res = await ask({ message: 'oi' }, {});
  assert.equal(res.statusCode, 401);
  assert.deepEqual(res.payload, { error: 'UNAUTHORIZED' });
});

test('an empty message is refused before a turn is taken', async () => {
  const calls = backend();
  const res = await ask({ message: '  ' });
  assert.equal(res.statusCode, 400);
  assert.deepEqual(res.payload, { error: 'EMPTY_MESSAGE' });
  assert.equal(calls.length, 0);
});

test('a token the engine refuses is answered with 401', async () => {
  backend({ engineRefuses: true });
  assert.equal((await ask()).statusCode, 401);
});

test('with no turn left the person gets a limit event', async () => {
  const calls = backend({ turn: [] });
  const res = await ask();
  assert.equal(res.statusCode, 429);
  assert.deepEqual(eventsOf(res), [{ type: 'error', code: 'CHAT_LIMIT' }]);
  assert.equal(
    calls.some((call) => call.url.includes('model.test')),
    false,
  );
});

test('a gateway that is not configured gives the turn back and says unavailable', async () => {
  setEnv({ CHAT_API_KEY: '' });
  const calls = backend();
  const res = await ask();
  assert.equal(res.statusCode, 503);
  assert.deepEqual(eventsOf(res), [{ type: 'error', code: 'CHAT_UNAVAILABLE' }]);
  assert.equal(refunds(calls).length, 1);
});

test('the reply streams as events and the turn is kept', async () => {
  const calls = backend({ model: () => stream({ content: 'Oi, ' }, { content: 'tudo bem?\n[[options: sim | não]]' }) });
  const res = await ask({ message: 'oi', session: 'abc' });
  assert.equal(res.statusCode, 200);
  assert.equal(res.headers['content-type'], 'text/event-stream');
  assert.deepEqual(eventsOf(res), [
    { type: 'delta', text: 'Oi, ' },
    { type: 'delta', text: 'tudo bem?\n' },
    { type: 'done', options: ['sim', 'não'] },
  ]);
  assert.equal(res.writableEnded, true);
  assert.equal(refunds(calls).length, 0);
});

test('the model gets the system prompt, the message, the session and the key', async () => {
  const calls = backend();
  await ask({ message: 'oi', session: 'abc', history: [{ role: 'mascot', text: 'antes' }] });
  const call = calls.find((c) => c.url.includes('model.test'));
  assert.equal(call?.url, 'http://model.test/v1/chat/completions');
  const headers = new Headers(call?.init.headers);
  assert.equal(headers.get('authorization'), 'Bearer key');
  assert.equal(headers.get('x-opencode-session'), 'abc');
  const body = JSON.parse(String(call?.init.body));
  assert.equal(body.model, 'tiny');
  assert.equal(body.stream, true);
  assert.deepEqual(
    body.messages.map((m: { role: string }) => m.role),
    ['system', 'assistant', 'user'],
  );
  assert.ok(Array.isArray(body.tools));
});

test('tools are left out when the app or the server turns actions off', async () => {
  const calls = backend();
  await ask({ message: 'oi', actions: false });
  setEnv({ CHAT_TOOLS: 'off' });
  await ask({ message: 'oi' });
  const bodies = calls.filter((c) => c.url.includes('model.test')).map((c) => JSON.parse(String(c.init.body)));
  assert.equal(bodies.length, 2);
  assert.ok(bodies.every((body) => body.tools === undefined));
});

test('a valid tool call becomes an action event and an invalid one is dropped', async () => {
  backend({
    model: () =>
      stream(
        { tool_calls: [{ index: 0, function: { name: 'create_private_slip', arguments: '{"body":"made coffee"}' } }] },
        { tool_calls: [{ index: 1, function: { name: 'delete_everything', arguments: '{}' } }] },
      ),
  });
  const events = eventsOf(await ask());
  assert.deepEqual(events[0], {
    type: 'action',
    tool: 'create_private_slip',
    args: { body: 'made coffee' },
    confirm: false,
  });
  assert.equal(events.filter((e) => e.type === 'action').length, 1);
});

test('a model failure gives the turn back and answers 502', async () => {
  mock.method(console, 'error', () => undefined);
  const calls = backend({ model: () => json({}, 500) });
  const res = await ask();
  assert.equal(res.statusCode, 502);
  assert.deepEqual(eventsOf(res), [{ type: 'error', code: 'UPSTREAM' }]);
  assert.equal(refunds(calls).length, 1);
});

test('a stream that breaks after the first token keeps the turn and says so', async () => {
  mock.method(console, 'warn', () => undefined);
  const calls = backend({
    model: () => {
      const body = new ReadableStream<Uint8Array>({
        start(controller) {
          controller.enqueue(new TextEncoder().encode(frame({ content: 'Oi' })));
          controller.error(new Error('connection reset'));
        },
      });
      return new Response(body);
    },
  });
  const res = await ask();
  assert.deepEqual(eventsOf(res).at(-1), { type: 'error', code: 'UPSTREAM' });
  assert.equal(refunds(calls).length, 0);
});

test('when the person closes the app the call to the model is cancelled', async () => {
  let modelSignal: AbortSignal | undefined;
  backend({
    model: (call) => {
      modelSignal = call.init.signal as AbortSignal;
      const body = new ReadableStream<Uint8Array>({
        start(controller) {
          controller.enqueue(new TextEncoder().encode(frame({ content: 'Oi' })));
          modelSignal?.addEventListener('abort', () => controller.error(new DOMException('aborted', 'AbortError')));
        },
      });
      return new Response(body);
    },
  });
  const res = response();
  const done = chat(request({ headers: signedIn, body: { message: 'oi' } }), res);
  while (!modelSignal) await new Promise((resolve) => setTimeout(resolve, 1));
  while (res.frames.length === 0) await new Promise((resolve) => setTimeout(resolve, 1));
  res.close();
  await done;
  assert.equal(modelSignal.aborted, true);
  assert.equal(
    eventsOf(res).some((e) => e.type === 'error'),
    false,
    'nobody is listening, so no error is sent',
  );
});

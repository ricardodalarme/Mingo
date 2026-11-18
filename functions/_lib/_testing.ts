// Helpers for the tests of the functions: a request, a recording response and a stubbed `fetch`.
import { mock } from 'node:test';
import type { Req, Res } from './http.ts';

type RequestInit_ = { method?: string; headers?: Record<string, string>; body?: unknown };

export const request = ({ method = 'POST', headers = {}, body = {} }: RequestInit_ = {}): Req => ({
  method,
  headers,
  body,
});

export type RecordedResponse = Omit<Res, 'headersSent' | 'writableEnded'> & {
  headersSent: boolean;
  writableEnded: boolean;
  statusCode: number;
  payload: unknown;
  frames: string[];
  headers: Record<string, string>;
  /** Fires the listeners of the `close` event, as the server does when the connection ends. */
  close(): void;
};

export function response(): RecordedResponse {
  const listeners: (() => void)[] = [];
  const res: RecordedResponse = {
    statusCode: 200,
    payload: undefined,
    frames: [],
    headers: {},
    headersSent: false,
    writableEnded: false,
    status(code) {
      res.statusCode = code;
      return res;
    },
    json(body) {
      res.payload = body;
      res.headersSent = true;
      res.writableEnded = true;
    },
    setHeader(name, value) {
      res.headers[name] = value;
    },
    write(chunk) {
      res.headersSent = true;
      res.frames.push(chunk);
    },
    end() {
      res.writableEnded = true;
    },
    on(_event, listener) {
      listeners.push(listener);
    },
    close() {
      for (const listener of listeners) listener();
    },
  };
  return res;
}

/** The events of a streamed response, one object per `data:` line. */
export const eventsOf = (res: RecordedResponse): { type: string; [key: string]: unknown }[] =>
  res.frames.flatMap((frame) =>
    frame
      .split('\n')
      .filter((line) => line.startsWith('data: '))
      .map((line) => JSON.parse(line.slice('data: '.length))),
  );

export type FetchCall = { url: string; init: RequestInit };

/** Replaces `fetch` until `mock.restoreAll()`, and records every call. */
export function stubFetch(respond: (call: FetchCall) => Response | Promise<Response>): FetchCall[] {
  const calls: FetchCall[] = [];
  mock.method(globalThis, 'fetch', async (input: string | URL | Request, init: RequestInit = {}) => {
    const call = { url: String(input), init };
    calls.push(call);
    return respond(call);
  });
  return calls;
}

export const json = (body: unknown, status = 200): Response =>
  new Response(JSON.stringify(body), { status, headers: { 'content-type': 'application/json' } });

/** A GraphQL success response. */
export const gql = (data: unknown): Response => json({ data });

/** The text of the GraphQL document a recorded call sent. */
const sent = (call: FetchCall | undefined): { query: string; variables: Record<string, unknown> } => {
  if (!call) throw new Error('the call was never made');
  return JSON.parse(String(call.init.body));
};

export const queryOf = (call: FetchCall | undefined): string => sent(call).query;

/** The variables a recorded GraphQL call sent. */
export const variablesOf = (call: FetchCall | undefined): Record<string, unknown> => sent(call).variables;

/** Sets environment variables for a test; [restoreEnv] puts the previous values back. */
export function setEnv(values: Record<string, string>): void {
  for (const [name, value] of Object.entries(values)) {
    if (!saved.has(name)) saved.set(name, process.env[name]);
    process.env[name] = value;
  }
}

const saved = new Map<string, string | undefined>();

export function restoreEnv(): void {
  for (const [name, value] of saved) {
    if (value === undefined) delete process.env[name];
    else process.env[name] = value;
  }
  saved.clear();
}

export const BACKEND_ENV = {
  NHOST_GRAPHQL_URL: 'http://graphql.test/v1',
  NHOST_STORAGE_URL: 'http://storage.test/v1',
  NHOST_ADMIN_SECRET: 'admin-secret',
  NHOST_WEBHOOK_SECRET: 'webhook-secret',
};

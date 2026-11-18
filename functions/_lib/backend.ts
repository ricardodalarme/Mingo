import { createHash, timingSafeEqual } from 'node:crypto';

// The parts of the Express request and response the functions use.
export type Req = {
  method: string;
  headers: Record<string, string | string[] | undefined>;
  body: any;
  on(event: 'close', listener: () => void): void;
};
export type Res = {
  status(code: number): Res;
  json(body: unknown): void;
  setHeader(name: string, value: string): void;
  write(chunk: string): void;
  end(): void;
  flushHeaders?(): void;
};

export const header = (req: Req, name: string): string => {
  const value = req.headers[name];
  return (Array.isArray(value) ? value[0] : value) ?? '';
};

/** Compares two strings without leaking, through timing, how many leading characters match. */
export function safeEqual(a: string, b: string): boolean {
  const digest = (v: string) => createHash('sha256').update(v).digest();
  return timingSafeEqual(digest(a), digest(b));
}

/** Whether the request comes from an event or cron trigger of this project. */
export function isTrigger(req: Req): boolean {
  const secret = process.env.NHOST_WEBHOOK_SECRET;
  return !!secret && safeEqual(header(req, 'nhost-webhook-secret'), secret);
}

export type GraphqlResult<T> = { data?: T; errors?: { message: string }[] };

async function post<T>(headers: Record<string, string>, query: string, variables: Record<string, unknown>): Promise<T> {
  const res = await fetch(process.env.NHOST_GRAPHQL_URL!, {
    method: 'POST',
    headers: { 'content-type': 'application/json', ...headers },
    body: JSON.stringify({ query, variables }),
    signal: AbortSignal.timeout(20_000),
  });
  const body = (await res.json()) as GraphqlResult<T>;
  if (!res.ok || body.errors?.length || !body.data) {
    throw new Error(`graphql request failed: ${body.errors?.[0]?.message ?? res.status}`);
  }
  return body.data;
}

/** Runs a system operation with the admin secret. The secret never leaves the function. */
export const asAdmin = <T>(query: string, variables: Record<string, unknown> = {}) =>
  post<T>({ 'x-hasura-admin-secret': process.env.NHOST_ADMIN_SECRET! }, query, variables);

/** Runs an operation as the caller, so the caller's permissions apply. */
export const asCaller = <T>(req: Req, query: string, variables: Record<string, unknown> = {}) =>
  post<T>({ authorization: header(req, 'authorization') }, query, variables);

/** Swallows a rejection from cleanup that is allowed to fail. */
export const ignoreError = (): void => undefined;

/** One log line per event, as JSON. Never pass message text, tokens or secrets. */
export const log = (event: string, fields: Record<string, unknown> = {}) =>
  // biome-ignore lint/suspicious/noConsole: stdout is the platform log sink
  console.log(JSON.stringify({ event, ...fields }));

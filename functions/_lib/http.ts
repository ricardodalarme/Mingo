/** The parts of the Express request the functions use. */
export type Req = {
  method: string;
  headers: Record<string, string | string[] | undefined>;
  body: unknown;
};

/** The parts of the Express response the functions use. */
export type Res = {
  status(code: number): Res;
  json(body: unknown): void;
  setHeader(name: string, value: string): void;
  write(chunk: string): void;
  end(): void;
  on(event: 'close', listener: () => void): void;
  flushHeaders?(): void;
  readonly headersSent?: boolean;
  readonly writableEnded?: boolean;
};

const STATUS = {
  METHOD_NOT_ALLOWED: 405,
  UNAUTHORIZED: 401,
  INVALID_EVENT: 400,
  UNKNOWN_JOB: 400,
  EMPTY_MESSAGE: 400,
  CHAT_LIMIT: 429,
  EXPORT_LIMIT: 429,
  CHAT_UNAVAILABLE: 503,
  UPSTREAM: 502,
  EXPORT_FAILED: 500,
  STORAGE_UNAVAILABLE: 500,
  FCM_UNAVAILABLE: 500,
  FCM_AUTH_FAILED: 500,
  FCM_SERVICE_ACCOUNT_INVALID: 500,
  INTERNAL: 500,
} as const satisfies Record<string, number>;

/** Every error code a function answers with, each tied to one HTTP status. */
export type ErrorCode = keyof typeof STATUS;

export const statusOf = (code: ErrorCode): number => STATUS[code];

/** The first value of a request header, or an empty string when it is missing. */
export const header = (req: Req, name: string): string => {
  const value = req.headers[name];
  return (Array.isArray(value) ? value[0] : value) ?? '';
};

/** Answers 200 with a JSON body. */
export const ok = (res: Res, body: unknown = { ok: true }): void => res.status(200).json(body);

/** Answers with the status of [code] and `{ error: code }`. */
export const fail = (res: Res, code: ErrorCode): void => res.status(STATUS[code]).json({ error: code });

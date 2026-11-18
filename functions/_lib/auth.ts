import { createHash, timingSafeEqual } from 'node:crypto';
import { type EnvName, env } from './env.ts';
import { header, type Req } from './http.ts';

const BEARER = /^Bearer\s+\S+/i;

/** Compares two strings without leaking, through timing, how many leading characters match. */
export function safeEqual(a: string, b: string): boolean {
  const digest = (value: string) => createHash('sha256').update(value).digest();
  return timingSafeEqual(digest(a), digest(b));
}

/** Whether the request carries a bearer token. The GraphQL engine verifies it when the function acts as the caller. */
export const hasBearer = (req: Req): boolean => BEARER.test(header(req, 'authorization'));

/** Whether [name] is set and the request sends the same value in [headerName]. */
export function matchesSecret(req: Req, headerName: string, name: EnvName): boolean {
  const secret = env(name);
  return !!secret && safeEqual(header(req, headerName), secret);
}

/** Whether the request comes from an event or cron trigger of this project. */
export const isTrigger = (req: Req): boolean => matchesSecret(req, 'nhost-webhook-secret', 'NHOST_WEBHOOK_SECRET');

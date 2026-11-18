import { createSign } from 'node:crypto';
import * as v from 'valibot';
import { HOUR_MS, TIMEOUT_MS } from '../_lib/config.ts';
import { NonEmptyString, parse } from '../_lib/payloads.ts';

const TOKEN_URL = 'https://oauth2.googleapis.com/token';
const SCOPE = 'https://www.googleapis.com/auth/firebase.messaging';
const GRANT_TYPE = 'urn:ietf:params:oauth:grant-type:jwt-bearer';
const ASSERTION_LIFETIME_SECONDS = 3600;
/** A cached access token is replaced this long before Google would expire it. */
const TOKEN_REFRESH_MARGIN_MS = 5 * 60 * 1000;
/** FCM answers 400 for a malformed token and 404 for one that is no longer registered. */
const DEAD_TOKEN_STATUSES: readonly number[] = [400, 404];

const AccountSchema = v.object({
  client_email: NonEmptyString,
  private_key: NonEmptyString,
  project_id: NonEmptyString,
});
export type Account = v.InferOutput<typeof AccountSchema>;

export type AccountState = { state: 'unset' } | { state: 'invalid' } | { state: 'ready'; account: Account };

/** Reads the Firebase service account JSON: unset when it is missing, invalid when it is not usable. */
export function loadAccount(raw: string | undefined): AccountState {
  if (!raw) return { state: 'unset' };
  let json: unknown;
  try {
    json = JSON.parse(raw);
  } catch {
    return { state: 'invalid' };
  }
  const account = parse(AccountSchema, json);
  return account ? { state: 'ready', account } : { state: 'invalid' };
}

const b64 = (value: string | Buffer) => Buffer.from(value).toString('base64url');

/** The service-account assertion that Google trades for an access token. */
export function assertion(account: Account, now = Math.floor(Date.now() / 1000)): string {
  const head = b64(JSON.stringify({ alg: 'RS256', typ: 'JWT' }));
  const claims = b64(
    JSON.stringify({
      iss: account.client_email,
      scope: SCOPE,
      aud: TOKEN_URL,
      iat: now,
      exp: now + ASSERTION_LIFETIME_SECONDS,
    }),
  );
  const signature = createSign('RSA-SHA256').update(`${head}.${claims}`).sign(account.private_key);
  return `${head}.${claims}.${b64(signature)}`;
}

const TokenResponse = v.object({
  access_token: NonEmptyString,
  expires_in: v.optional(v.number(), ASSERTION_LIFETIME_SECONDS),
});

export type TokenCache = Map<string, { token: string; expiresAt: number }>;

/** Access tokens kept while the function instance stays warm, one per service account. */
export const tokenCache: TokenCache = new Map();

/** Trades the service account key for an OAuth access token that can send messages, reusing one that is still valid. */
export async function accessToken(
  account: Account,
  fetcher: typeof fetch = fetch,
  cache: TokenCache = tokenCache,
  now: () => number = Date.now,
): Promise<string> {
  const cached = cache.get(account.client_email);
  if (cached && cached.expiresAt > now()) return cached.token;
  const res = await fetcher(TOKEN_URL, {
    method: 'POST',
    signal: AbortSignal.timeout(TIMEOUT_MS.push),
    headers: { 'content-type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({ grant_type: GRANT_TYPE, assertion: assertion(account) }),
  });
  if (!res.ok) throw new Error(`token endpoint answered ${res.status}`);
  const token = parse(TokenResponse, await res.json());
  if (!token) throw new Error('token endpoint sent no access token');
  const lifetime = Math.min(token.expires_in * 1000, HOUR_MS) - TOKEN_REFRESH_MARGIN_MS;
  cache.set(account.client_email, { token: token.access_token, expiresAt: now() + lifetime });
  return token.access_token;
}

export type Push = { id: string; type: string; refId: string | null };
export type Delivery = 'sent' | 'dead' | 'transient';

/** Sends one data-only message; the app renders the localized text for the type. */
export async function send(
  account: Account,
  bearer: string,
  token: string,
  push: Push,
  fetcher: typeof fetch = fetch,
): Promise<Delivery> {
  try {
    const res = await fetcher(`https://fcm.googleapis.com/v1/projects/${account.project_id}/messages:send`, {
      method: 'POST',
      signal: AbortSignal.timeout(TIMEOUT_MS.push),
      headers: { authorization: `Bearer ${bearer}`, 'content-type': 'application/json' },
      body: JSON.stringify({
        message: {
          token,
          data: { type: push.type, ref: push.refId ?? '', id: push.id },
          apns: { payload: { aps: { 'mutable-content': 1, 'content-available': 1 } } },
          android: { priority: 'high' },
        },
      }),
    });
    if (res.ok) return 'sent';
    return DEAD_TOKEN_STATUSES.includes(res.status) ? 'dead' : 'transient';
  } catch {
    return 'transient';
  }
}

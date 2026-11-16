import { createSign } from 'node:crypto';

export type Account = { client_email: string; private_key: string; project_id: string };

const TOKEN_URL = 'https://oauth2.googleapis.com/token';
const SCOPE = 'https://www.googleapis.com/auth/firebase.messaging';

/** Reads the Firebase service account JSON: null when it is not set, "invalid" when it is not usable. */
export function loadAccount(raw: string | undefined): Account | null | 'invalid' {
  if (!raw) return null;
  try {
    const account = JSON.parse(raw);
    return account?.client_email && account?.private_key && account?.project_id ? account : 'invalid';
  } catch {
    return 'invalid';
  }
}

const b64 = (value: string | Buffer) => Buffer.from(value).toString('base64url');

/** The service-account assertion that Google trades for an access token. */
export function assertion(account: Account, now = Math.floor(Date.now() / 1000)): string {
  const head = b64(JSON.stringify({ alg: 'RS256', typ: 'JWT' }));
  const claims = b64(JSON.stringify({ iss: account.client_email, scope: SCOPE, aud: TOKEN_URL, iat: now, exp: now + 3600 }));
  const signature = createSign('RSA-SHA256').update(`${head}.${claims}`).sign(account.private_key);
  return `${head}.${claims}.${b64(signature)}`;
}

/** Trades the service account key for an OAuth access token that can send messages. */
export async function accessToken(account: Account, fetcher: typeof fetch = fetch): Promise<string> {
  const res = await fetcher(TOKEN_URL, {
    method: 'POST',
    signal: AbortSignal.timeout(10_000),
    headers: { 'content-type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({ grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer', assertion: assertion(account) }),
  });
  if (!res.ok) throw new Error(`token endpoint answered ${res.status}`);
  const { access_token } = (await res.json()) as { access_token?: unknown };
  if (typeof access_token !== 'string' || !access_token) throw new Error('token endpoint sent no access token');
  return access_token;
}

export type Push = { id: string; type: string; refId: string | null };
export type Delivery = 'sent' | 'dead' | 'transient';

/** Sends one data-only message; the app renders the localized text for the type. */
export async function send(account: Account, bearer: string, token: string, push: Push, fetcher: typeof fetch = fetch): Promise<Delivery> {
  try {
    const res = await fetcher(`https://fcm.googleapis.com/v1/projects/${account.project_id}/messages:send`, {
      method: 'POST',
      signal: AbortSignal.timeout(10_000),
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
    return res.status === 400 || res.status === 404 ? 'dead' : 'transient';
  } catch {
    return 'transient';
  }
}

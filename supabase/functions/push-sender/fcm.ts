import { importPKCS8, SignJWT } from "npm:jose@6.2.17";

export type Account = { client_email: string; private_key: string; project_id: string };

const TOKEN_URL = "https://oauth2.googleapis.com/token";
const SCOPE = "https://www.googleapis.com/auth/firebase.messaging";

// Reads the Firebase service account JSON: null when it is not set, "invalid" when it is not usable.
export function loadAccount(raw: string | undefined): Account | null | "invalid" {
  if (!raw) return null;
  try {
    const account = JSON.parse(raw);
    return account?.client_email && account?.private_key && account?.project_id ? account : "invalid";
  } catch (_e) {
    return "invalid";
  }
}

// Trades a JWT signed with the service account key for an OAuth access token that can send messages.
export async function accessToken(account: Account, fetcher: typeof fetch = fetch): Promise<string> {
  const key = await importPKCS8(account.private_key, "RS256");
  const assertion = await new SignJWT({ scope: SCOPE })
    .setProtectedHeader({ alg: "RS256", typ: "JWT" })
    .setIssuer(account.client_email)
    .setAudience(TOKEN_URL)
    .setIssuedAt()
    .setExpirationTime("1h")
    .sign(key);
  const res = await fetcher(TOKEN_URL, {
    method: "POST",
    signal: AbortSignal.timeout(10_000),
    headers: { "content-type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({ grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer", assertion }),
  });
  if (!res.ok) throw new Error(`token endpoint answered ${res.status}`);
  const { access_token } = await res.json();
  if (typeof access_token !== "string" || !access_token) throw new Error("token endpoint sent no access token");
  return access_token;
}

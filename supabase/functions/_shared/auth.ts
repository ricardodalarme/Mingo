// Caller checks: who is behind a request. `callerId` is for the app's users; `isServiceCaller` is for functions that run
// with verify_jwt = false and are invoked by a server (pg_cron through pg_net, a webhook).
import { verifyAuth } from "npm:@supabase/server@1.9.2/core";

const encoder = new TextEncoder();

const digest = async (value: string) => new Uint8Array(await crypto.subtle.digest("SHA-256", encoder.encode(value)));

// Compares two strings without leaking, through timing, how many leading characters match.
export async function safeEqual(a: string, b: string): Promise<boolean> {
  const [x, y] = await Promise.all([digest(a), digest(b)]);
  let diff = 0;
  for (let i = 0; i < x.length; i++) diff |= x[i] ^ y[i];
  return diff === 0;
}

// Secret keys of the project: the named keys in SUPABASE_SECRET_KEYS plus the legacy service-role key.
function secretKeys(): string[] {
  const keys: string[] = [];
  const legacy = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (legacy) keys.push(legacy);
  try {
    const named = JSON.parse(Deno.env.get("SUPABASE_SECRET_KEYS") ?? "{}");
    for (const value of Object.values(named)) if (typeof value === "string" && value) keys.push(value);
  } catch (_e) {
    // A malformed dictionary leaves only the legacy key.
  }
  return keys;
}

// Whether the request presents a project secret key in the `apikey` header or as a bearer token.
export async function isServiceCaller(req: Request): Promise<boolean> {
  const presented = [req.headers.get("apikey"), (req.headers.get("authorization") ?? "").replace(/^Bearer\s+/i, "")]
    .filter((value): value is string => !!value);
  const keys = secretKeys();
  let ok = false;
  for (const candidate of presented) {
    for (const key of keys) if (await safeEqual(candidate, key)) ok = true;
  }
  return ok;
}

// The id of the signed-in user who made the request, or null for anyone else.
// verify_jwt = true also lets the project's API keys through, so the user token is verified here against the project's
// signing keys: an API key, an expired token, a token from another project or one for another audience never passes.
export async function callerId(req: Request): Promise<string | null> {
  const { data } = await verifyAuth(req, { auth: "user", audience: "authenticated" });
  return data?.userClaims?.role === "authenticated" ? data.userClaims.id : null;
}

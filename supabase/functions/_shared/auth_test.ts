import { assertEquals } from "jsr:@std/assert@1";
import { exportJWK, generateKeyPair, SignJWT } from "npm:jose@6";
import { callerId, isServiceCaller, safeEqual } from "./auth.ts";

const request = (headers: Record<string, string>) => new Request("https://example.test/fn", { method: "POST", headers });

Deno.test("safeEqual matches equal strings only", async () => {
  assertEquals(await safeEqual("abc", "abc"), true);
  assertEquals(await safeEqual("abc", "abd"), false);
  assertEquals(await safeEqual("abc", "abcd"), false);
  assertEquals(await safeEqual("", ""), true);
});

Deno.test("isServiceCaller accepts the apikey header with a named secret key", async () => {
  Deno.env.set("SUPABASE_SECRET_KEYS", JSON.stringify({ default: "sb_secret_default", automations: "sb_secret_auto" }));
  Deno.env.delete("SUPABASE_SERVICE_ROLE_KEY");
  assertEquals(await isServiceCaller(request({ apikey: "sb_secret_default" })), true);
  assertEquals(await isServiceCaller(request({ apikey: "sb_secret_auto" })), true);
  assertEquals(await isServiceCaller(request({ apikey: "sb_secret_other" })), false);
});

Deno.test("isServiceCaller still accepts the legacy service-role bearer token", async () => {
  Deno.env.delete("SUPABASE_SECRET_KEYS");
  Deno.env.set("SUPABASE_SERVICE_ROLE_KEY", "legacy.jwt.value");
  assertEquals(await isServiceCaller(request({ authorization: "Bearer legacy.jwt.value" })), true);
  assertEquals(await isServiceCaller(request({ authorization: "bearer legacy.jwt.value" })), true);
  assertEquals(await isServiceCaller(request({ authorization: "Bearer wrong" })), false);
});

Deno.test("isServiceCaller rejects requests without credentials or without any configured key", async () => {
  Deno.env.set("SUPABASE_SERVICE_ROLE_KEY", "legacy.jwt.value");
  assertEquals(await isServiceCaller(request({})), false);
  Deno.env.delete("SUPABASE_SERVICE_ROLE_KEY");
  Deno.env.delete("SUPABASE_SECRET_KEYS");
  assertEquals(await isServiceCaller(request({ apikey: "anything", authorization: "Bearer anything" })), false);
});

Deno.test("isServiceCaller ignores a malformed key dictionary", async () => {
  Deno.env.set("SUPABASE_SECRET_KEYS", "not json");
  Deno.env.set("SUPABASE_SERVICE_ROLE_KEY", "legacy.jwt.value");
  assertEquals(await isServiceCaller(request({ apikey: "legacy.jwt.value" })), true);
  assertEquals(await isServiceCaller(request({ apikey: "not json" })), false);
});

const signingKey = await generateKeyPair("ES256");
const otherKey = await generateKeyPair("ES256");
const USER = "6f1b1b46-4a3e-4f5a-9c53-0b4a3a1d2e10";

async function token(options: { key?: CryptoKey; audience?: string; role?: string; expires?: string } = {}) {
  return await new SignJWT({ role: options.role ?? "authenticated" })
    .setProtectedHeader({ alg: "ES256", kid: "test" })
    .setSubject(USER)
    .setAudience(options.audience ?? "authenticated")
    .setIssuedAt()
    .setExpirationTime(options.expires ?? "1h")
    .sign(options.key ?? signingKey.privateKey);
}

async function withProjectKeys(run: () => Promise<void>) {
  const jwk = { ...(await exportJWK(signingKey.publicKey)), alg: "ES256", kid: "test" };
  Deno.env.set("SUPABASE_URL", "https://project.test");
  Deno.env.set("SUPABASE_JWKS", JSON.stringify({ keys: [jwk] }));
  try {
    await run();
  } finally {
    Deno.env.delete("SUPABASE_URL");
    Deno.env.delete("SUPABASE_JWKS");
  }
}

Deno.test("callerId returns the user id of a valid user token", async () => {
  await withProjectKeys(async () => {
    assertEquals(await callerId(request({ authorization: `Bearer ${await token()}` })), USER);
  });
});

Deno.test("callerId rejects an expired token, a foreign key, the wrong audience and a non-user role", async () => {
  await withProjectKeys(async () => {
    assertEquals(await callerId(request({ authorization: `Bearer ${await token({ expires: "-1h" })}` })), null);
    assertEquals(await callerId(request({ authorization: `Bearer ${await token({ key: otherKey.privateKey })}` })), null);
    assertEquals(await callerId(request({ authorization: `Bearer ${await token({ audience: "anon" })}` })), null);
    assertEquals(await callerId(request({ authorization: `Bearer ${await token({ role: "anon" })}` })), null);
  });
});

Deno.test("callerId rejects API keys, garbage and a missing header", async () => {
  await withProjectKeys(async () => {
    assertEquals(await callerId(request({ authorization: "Bearer sb_publishable_abc" })), null);
    assertEquals(await callerId(request({ apikey: "sb_secret_abc" })), null);
    assertEquals(await callerId(request({ authorization: "Bearer not.a.token" })), null);
    assertEquals(await callerId(request({ authorization: `Bearer ${await token()}`.replace(/.$/, "x") })), null);
    assertEquals(await callerId(request({})), null);
  });
});

Deno.test("callerId rejects everyone when the project has no signing keys to check against", async () => {
  Deno.env.delete("SUPABASE_URL");
  Deno.env.delete("SUPABASE_JWKS");
  assertEquals(await callerId(request({ authorization: `Bearer ${await token()}` })), null);
});

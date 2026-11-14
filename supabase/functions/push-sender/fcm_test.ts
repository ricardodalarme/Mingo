import { assert, assertEquals, assertRejects } from "jsr:@std/assert@1";
import { exportPKCS8, generateKeyPair, jwtVerify } from "npm:jose@6.2.17";
import { type Account, accessToken, loadAccount } from "./fcm.ts";

const { publicKey, privateKey } = await generateKeyPair("RS256", { extractable: true });
const account: Account = {
  client_email: "push@project.iam.gserviceaccount.com",
  private_key: await exportPKCS8(privateKey),
  project_id: "project",
};

Deno.test("loadAccount tells a missing, a broken and a usable service account apart", () => {
  assertEquals(loadAccount(undefined), null);
  assertEquals(loadAccount(""), null);
  assertEquals(loadAccount("not json"), "invalid");
  assertEquals(loadAccount(JSON.stringify({ client_email: "a", project_id: "p" })), "invalid");
  assertEquals(loadAccount(JSON.stringify(account)), account);
});

Deno.test("accessToken sends a signed assertion to Google and returns the access token", async () => {
  let sent: { url: string; method?: string; body: URLSearchParams } | undefined;
  const fetcher = ((url: string | URL | Request, init?: RequestInit) => {
    sent = { url: String(url), method: init?.method, body: init?.body as URLSearchParams };
    return Promise.resolve(Response.json({ access_token: "ya29.token", expires_in: 3600 }));
  }) as typeof fetch;

  assertEquals(await accessToken(account, fetcher), "ya29.token");

  assertEquals(sent?.url, "https://oauth2.googleapis.com/token");
  assertEquals(sent?.method, "POST");
  assertEquals(sent?.body.get("grant_type"), "urn:ietf:params:oauth:grant-type:jwt-bearer");
  const { payload, protectedHeader } = await jwtVerify(sent!.body.get("assertion")!, publicKey, {
    issuer: account.client_email,
    audience: "https://oauth2.googleapis.com/token",
  });
  assertEquals(protectedHeader.alg, "RS256");
  assertEquals(payload.scope, "https://www.googleapis.com/auth/firebase.messaging");
  assert(payload.exp! - payload.iat! <= 3600, "the assertion lives at most one hour");
});

Deno.test("accessToken fails when Google refuses or answers without a token", async () => {
  const refuse = (() => Promise.resolve(new Response("denied", { status: 400 }))) as typeof fetch;
  const empty = (() => Promise.resolve(Response.json({}))) as typeof fetch;
  await assertRejects(() => accessToken(account, refuse), Error, "400");
  await assertRejects(() => accessToken(account, empty), Error, "no access token");
});

Deno.test("accessToken fails on a private key that is not a key", async () => {
  await assertRejects(() => accessToken({ ...account, private_key: "nope" }, (() => Promise.resolve(Response.json({}))) as typeof fetch));
});

// Helpers for the backend tests: create people, pair them, and run GraphQL as a role.
// The suite runs only against the local stack started by `nhost/tools/up.sh`.
import assert from 'node:assert/strict';
import { randomUUID } from 'node:crypto';
import { readFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = join(dirname(fileURLToPath(import.meta.url)), '..', '..');

export const urls = {
  hasura: process.env.NHOST_HASURA_URL ?? 'http://localhost:8080',
  graphql: process.env.NHOST_GRAPHQL_URL ?? 'http://localhost:8080/v1/graphql',
  auth: process.env.NHOST_AUTH_URL ?? 'http://localhost:4000',
  storage: process.env.NHOST_STORAGE_URL ?? 'http://localhost:8484/v1',
  functions: process.env.NHOST_FUNCTIONS_URL ?? 'http://localhost:3030',
};

function secret(name: string): string {
  const fromEnv = process.env[name];
  if (fromEnv) return fromEnv;
  const line = readFileSync(join(root, '.secrets'), 'utf8').split('\n').find((l) => l.startsWith(name));
  if (!line) throw new Error(`secret ${name} is not set`);
  return line.slice(line.indexOf('=') + 1).trim().replace(/^'|'$/g, '');
}
export const adminSecret = secret('HASURA_GRAPHQL_ADMIN_SECRET');
export const webhookSecret = secret('NHOST_WEBHOOK_SECRET');

/** Who runs a request: the admin secret alone, the anonymous role, or a signed-in person. */
export type Actor = 'admin' | 'public' | { id: string };

export type Result = { data: any; errors?: { message: string; extensions?: { code?: string } }[] };

function headers(actor: Actor): Record<string, string> {
  const base: Record<string, string> = { 'content-type': 'application/json', 'x-hasura-admin-secret': adminSecret };
  if (actor === 'admin') return base;
  if (actor === 'public') return { ...base, 'x-hasura-role': 'public' };
  return { ...base, 'x-hasura-role': 'user', 'x-hasura-user-id': actor.id };
}

export async function gql(actor: Actor, query: string, variables: Record<string, unknown> = {}): Promise<Result> {
  const res = await fetch(urls.graphql, { method: 'POST', headers: headers(actor), body: JSON.stringify({ query, variables }) });
  return (await res.json()) as Result;
}

/** Runs a request that must succeed and returns its data. */
export async function ok(actor: Actor, query: string, variables: Record<string, unknown> = {}): Promise<any> {
  const result = await gql(actor, query, variables);
  assert.equal(result.errors, undefined, `expected success, got ${JSON.stringify(result.errors)}\n${query}`);
  return result.data;
}

/** Runs a request that must be refused, by the schema or by a permission or constraint. */
export async function denied(actor: Actor, query: string, variables: Record<string, unknown> = {}): Promise<Result> {
  const result = await gql(actor, query, variables);
  assert.ok(result.errors?.length, `expected a refusal, got ${JSON.stringify(result.data)}\n${query}`);
  return result;
}

export async function sql(text: string): Promise<string[][]> {
  const res = await fetch(`${urls.hasura}/v2/query`, {
    method: 'POST',
    headers: { 'x-hasura-admin-secret': adminSecret },
    body: JSON.stringify({ type: 'run_sql', args: { source: 'default', sql: text } }),
  });
  const body = (await res.json()) as any;
  assert.ok(res.ok, `sql failed: ${JSON.stringify(body)}`);
  return (body.result ?? []).slice(1);
}

/** Records the adult declaration the app collects before Tempero can be switched on. */
export async function adult(p: { id: string }, granted = true): Promise<void> {
  await sql(`insert into public.consents (user_id, kind, granted, version) values ('${p.id}', 'adult', ${granted}, '1')`);
}

export type Person = { id: string; email: string };

/** Creates an auth user the way the Auth service does; the profile rows come from the database trigger. */
export async function person(name: string | null = null): Promise<Person> {
  const id = randomUUID();
  const email = `${id}@test.mingo.local`;
  await ok('admin', `mutation ($o: users_insert_input!) { insertUser(object: $o) { id } }`, {
    o: { id, email, displayName: name ?? email, locale: 'en' },
  });
  return { id, email };
}

/** Pairs two people through the same calls the app makes. */
export async function pair(inviter: Person, invitee: Person): Promise<string> {
  const { insertInvitesOne } = await ok(inviter, `mutation { insertInvitesOne(object: {}) { code } }`);
  const { acceptInvite } = await ok(invitee, `mutation ($code: String!) { acceptInvite(args: { code: $code }) { id } }`, {
    code: insertInvitesOne.code,
  });
  assert.equal(acceptInvite.length, 1, 'the invite was not accepted');
  const { couples } = await ok(invitee, `{ couples { id } }`);
  return couples[0].id;
}

export async function couple(): Promise<{ a: Person; b: Person; coupleId: string }> {
  const a = await person('Ana');
  const b = await person('Bruno');
  return { a, b, coupleId: await pair(a, b) };
}

export async function plus(p: Person): Promise<void> {
  await sql(`insert into public.entitlements (user_id, plan, status) values ('${p.id}', 'plus_annual', 'active')
             on conflict (user_id) do update set status = 'active', expires_at = null`);
}

/** A real sign-up through Auth, with the access token it hands back. */
export type Session = { id: string; email: string; token: string };

export async function signUp(name: string | null = null): Promise<Session> {
  const email = `${randomUUID()}@test.mingo.local`;
  const res = await fetch(`${urls.auth}/v1/signup/email-password`, {
    method: 'POST',
    headers: { 'content-type': 'application/json' },
    body: JSON.stringify({ email, password: 'segredo-forte-1', options: name ? { displayName: name } : {} }),
  });
  const body = (await res.json()) as any;
  assert.equal(res.status, 200, `sign-up failed: ${JSON.stringify(body)}`);
  return { id: body.session.user.id, email, token: body.session.accessToken };
}

/** Runs GraphQL with a real access token, so the JWT claims decide the role and the person. */
export async function gqlToken(token: string, query: string, variables: Record<string, unknown> = {}): Promise<Result> {
  const res = await fetch(urls.graphql, {
    method: 'POST',
    headers: { 'content-type': 'application/json', authorization: `Bearer ${token}` },
    body: JSON.stringify({ query, variables }),
  });
  return (await res.json()) as Result;
}

export async function okToken(token: string, query: string, variables: Record<string, unknown> = {}): Promise<any> {
  const result = await gqlToken(token, query, variables);
  assert.equal(result.errors, undefined, `expected success, got ${JSON.stringify(result.errors)}`);
  return result.data;
}

export type StoredFile = { id: string; name: string; size: number; bucketId: string };

/** Uploads bytes through the Storage service with the caller's token, as the app does. */
// A real 1x1 PNG: Storage detects the type from the content, so a made-up payload would be stored as octet-stream.
export const PNG = [
  0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a, 0x00, 0x00, 0x00, 0x0d, 0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1f, 0x15, 0xc4, 0x89, 0x00, 0x00, 0x00, 0x0d, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9c, 0x63, 0xf8, 0xff, 0xff, 0x3f,
  0x00, 0x05, 0xfe, 0x02, 0xfe, 0xa7, 0x35, 0x81, 0x84, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4e, 0x44, 0xae, 0x42, 0x60, 0x82,
];

export async function upload(token: string, bucket: string, bytes: number[] = PNG, name = 'photo.png', type = 'image/png'): Promise<StoredFile> {
  const form = new FormData();
  form.append('bucket-id', bucket);
  form.append('file[]', new Blob([new Uint8Array(bytes)], { type }), name);
  const res = await fetch(`${urls.storage}/files`, { method: 'POST', headers: { authorization: `Bearer ${token}` }, body: form });
  const body = (await res.json()) as any;
  assert.equal(res.status, 201, `upload failed: ${JSON.stringify(body)}`);
  return body.processedFiles[0];
}

// A minimal MPEG-4 audio header; Storage detects the type from the content.
export const M4A = [0, 0, 0, 0x20, 0x66, 0x74, 0x79, 0x70, 0x4d, 0x34, 0x41, 0x20, 0, 0, 0, 0, 0x4d, 0x34, 0x41, 0x20, 0x6d, 0x70, 0x34, 0x32, 0x69, 0x73, 0x6f, 0x6d, 0, 0, 0, 0];

/** The HTTP status a download gets: 200 when the caller may read the file, 404 when they may not. */
export async function download(token: string, fileId: string): Promise<number> {
  const res = await fetch(`${urls.storage}/files/${fileId}`, { headers: { authorization: `Bearer ${token}` } });
  return res.status;
}

/** Calls a Function, by default with the trigger secret an event or cron trigger sends. */
export async function webhook(path: string, body: unknown, secret: string | null = webhookSecret): Promise<{ status: number; body: any }> {
  const headers: Record<string, string> = { 'content-type': 'application/json' };
  if (secret !== null) headers['nhost-webhook-secret'] = secret;
  const res = await fetch(`${urls.functions}${path}`, { method: 'POST', headers, body: JSON.stringify(body) });
  return { status: res.status, body: (await res.json().catch(() => null)) as any };
}

/** Retries [fn] until it returns something, for the asynchronous path of an event trigger. */
export async function waitFor<T>(fn: () => Promise<T | undefined | null | false>, timeout = 20_000): Promise<T> {
  const until = Date.now() + timeout;
  for (;;) {
    const value = await fn();
    if (value) return value;
    if (Date.now() > until) throw new Error('timed out waiting for the expected state');
    await new Promise((resolve) => setTimeout(resolve, 250));
  }
}

/** The local hour of the given zone, to place a test at a specific time of day. */
export async function zoneAtHour(hour: number): Promise<string> {
  const rows = await sql(
    `select name from pg_catalog.pg_timezone_names where extract(hour from now() at time zone name) = ${hour} order by name limit 1`,
  );
  assert.ok(rows[0], `no time zone with local hour ${hour}`);
  return rows[0][0];
}

export { assert, randomUUID };

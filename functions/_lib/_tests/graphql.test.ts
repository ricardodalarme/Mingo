import assert from 'node:assert/strict';
import { afterEach, beforeEach, mock, test } from 'node:test';
import { BACKEND_ENV, gql, json, queryOf, request, restoreEnv, setEnv, stubFetch, variablesOf } from '../_testing.ts';
import { asAdmin, asCaller, callerQuery, operation } from '../graphql.ts';

beforeEach(() => setEnv(BACKEND_ENV));
afterEach(() => {
  restoreEnv();
  mock.restoreAll();
});

const WHO = operation<{ who: string }>('{ who }');
const BY_ID = operation<{ byId: string }, { id: string }>('query ($id: uuid!) { byId(id: $id) }');

test('an admin operation sends the admin secret and returns the typed data', async () => {
  const calls = stubFetch(() => gql({ who: 'me' }));
  const data = await asAdmin(WHO);
  assert.equal(data.who, 'me');
  assert.equal(calls[0]?.url, 'http://graphql.test/v1');
  assert.equal(new Headers(calls[0]?.init.headers).get('x-hasura-admin-secret'), 'admin-secret');
});

test('variables travel with the query', async () => {
  const calls = stubFetch(() => gql({ byId: 'x' }));
  await asAdmin(BY_ID, { id: '7' });
  assert.equal(queryOf(calls[0]), 'query ($id: uuid!) { byId(id: $id) }');
  assert.deepEqual(variablesOf(calls[0]), { id: '7' });
});

test('a caller operation forwards the caller token and never the admin secret', async () => {
  const calls = stubFetch(() => gql({ who: 'me' }));
  await asCaller(request({ headers: { authorization: 'Bearer abc' } }), WHO);
  const headers = new Headers(calls[0]?.init.headers);
  assert.equal(headers.get('authorization'), 'Bearer abc');
  assert.equal(headers.get('x-hasura-admin-secret'), null);
});

test('callerQuery runs operations as the request sender', async () => {
  const calls = stubFetch(() => gql({ who: 'me' }));
  const query = callerQuery(request({ headers: { authorization: 'Bearer zzz' } }));
  assert.equal((await query(WHO)).who, 'me');
  assert.equal(new Headers(calls[0]?.init.headers).get('authorization'), 'Bearer zzz');
});

test('GraphQL errors, HTTP errors and an empty answer all throw', async () => {
  stubFetch(() => json({ errors: [{ message: 'permission denied' }] }));
  await assert.rejects(asAdmin(WHO), /permission denied/);
  mock.restoreAll();
  stubFetch(() => json({}, 502));
  await assert.rejects(asAdmin(WHO), /502/);
  mock.restoreAll();
  stubFetch(() => json({}));
  await assert.rejects(asAdmin(WHO), /graphql request failed/);
});

test('a missing endpoint is a configuration error, not a failed fetch', async () => {
  restoreEnv();
  setEnv({ NHOST_ADMIN_SECRET: 'admin-secret' });
  await assert.rejects(asAdmin(WHO), /NHOST_GRAPHQL_URL is not set/);
});

import { test } from 'node:test';
import { assert, okToken, person, signUp, urls } from '../lib.ts';

async function gqlAnonymous(query: string) {
  const res = await fetch(urls.graphql, {
    method: 'POST',
    headers: { 'content-type': 'application/json' },
    body: JSON.stringify({ query }),
  });
  return (await res.json()) as any;
}

async function gqlAsRole(token: string, role: string, query: string) {
  const res = await fetch(urls.graphql, {
    method: 'POST',
    headers: { 'content-type': 'application/json', authorization: `Bearer ${token}`, 'x-hasura-role': role },
    body: JSON.stringify({ query }),
  });
  return (await res.json()) as any;
}

test('a real sign-up gets a working session, a profile and the user role only', async () => {
  const session = await signUp('Ana');
  const claims = JSON.parse(Buffer.from(session.token.split('.')[1], 'base64url').toString());
  assert.deepEqual(claims['https://hasura.io/jwt/claims']['x-hasura-allowed-roles'], ['user']);
  assert.equal(claims['https://hasura.io/jwt/claims']['x-hasura-user-id'], session.id);
  assert.equal(claims['https://hasura.io/jwt/claims']['x-hasura-default-role'], 'user');
  const data = await okToken(session.token, `{ profiles { id displayName } userSettings { locale } notificationSettings { enabled } }`);
  assert.equal(data.profiles[0].id, session.id);
  assert.equal(data.profiles[0].displayName, 'Ana');
  assert.equal(data.userSettings[0].locale, 'pt-BR');
  assert.equal(data.notificationSettings[0].enabled, true);
});

test('an e-mail is never used as a display name, and an explicit name is kept', async () => {
  const anonymous = await signUp();
  assert.equal((await okToken(anonymous.token, `{ profiles { displayName } }`)).profiles[0].displayName, null);
  const named = await signUp('Bruno');
  assert.equal((await okToken(named.token, `{ profiles { displayName } }`)).profiles[0].displayName, 'Bruno');
});

test('a token cannot act as another person and carries no anonymous role', async () => {
  const session = await signUp();
  const other = await person();
  const data = await okToken(session.token, `query ($id: uuid!) { profilesByPk(id: $id) { id } }`, { id: other.id });
  assert.equal(data.profilesByPk, null);
  assert.equal((await gqlAnonymous(`{ __typename }`)).data.__typename, 'query_root');
  const smuggled = await gqlAsRole(session.token, 'public', `{ profiles { id } }`);
  assert.equal(smuggled.data, undefined, 'the token carries no public role');
  assert.ok(smuggled.errors?.length || smuggled.error, 'the request is refused');
});

test('the profile and settings of a new person start from a known state', async () => {
  const session = await signUp();
  const data = await okToken(session.token, `{ profiles { avatarKind timeZone } userSettings { theme relationshipStatus shareReadReceipts spiceEnabled chatEnabled locale }
    plusStates { hasPlus chatMessagesLeftToday chatMessagesLimit gamesLeftThisWeek } }`);
  assert.deepEqual(data.profiles[0], { avatarKind: 'initials', timeZone: 'America/Sao_Paulo' });
  assert.deepEqual(data.userSettings[0], {
    theme: 'neutro', relationshipStatus: 'together', shareReadReceipts: false, spiceEnabled: false, chatEnabled: false, locale: 'pt-BR',
  });
  assert.deepEqual(data.plusStates[0], { hasPlus: false, chatMessagesLeftToday: 5, chatMessagesLimit: 5, gamesLeftThisWeek: 3 });
});

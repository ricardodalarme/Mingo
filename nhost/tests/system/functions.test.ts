import { test } from 'node:test';
import { assert, ok, person, randomUUID, signUp, sql, urls, waitFor, webhook } from '../lib.ts';

const revenueCatSecret = 'local-revenuecat-secret';

async function revenueCat(body: unknown): Promise<{ status: number; body: any }> {
  const res = await fetch(`${urls.functions}/purchases`, {
    method: 'POST',
    headers: { 'content-type': 'application/json', authorization: revenueCatSecret },
    body: JSON.stringify(body),
  });
  return { status: res.status, body: (await res.json().catch(() => null)) as any };
}

const purchase = (userId: string, eventId: string, type = 'INITIAL_PURCHASE', at = Date.now()) => ({
  event: {
    id: eventId,
    app_user_id: userId,
    type,
    event_timestamp_ms: at,
    product_id: 'mingo_plus_annual',
    period_type: 'NORMAL',
    expiration_at_ms: at + 31_536_000_000,
    store: 'APP_STORE',
  },
});

test('a trigger endpoint refuses a call without its secret', async () => {
  for (const [path, body] of [['/events/jobs', { payload: { job: 'prune' } }], ['/events/push', { event: { data: { new: {} } } }],
    ['/events/delete-file', { event: { data: { new: {} } } }]] as const) {
    const answer = await webhook(path, body, null);
    assert.equal(answer.status, 401, path);
    const wrong = await webhook(path, body, 'wrong-secret');
    assert.equal(wrong.status, 401, `${path} with a wrong secret`);
  }
});

test('a cron call runs the job and records it', async () => {
  const before = Number((await sql(`select count(*) from private.job_runs where job = 'prune'`))[0][0]);
  const answer = await webhook('/events/jobs', { payload: { job: 'prune' } });
  assert.equal(answer.status, 200);
  assert.equal(answer.body.job, 'prune');
  const after = Number((await sql(`select count(*) from private.job_runs where job = 'prune'`))[0][0]);
  assert.equal(after, before + 1);
  assert.equal((await webhook('/events/jobs', { payload: { job: 'not_a_job' } })).status, 400);
  assert.equal((await webhook('/events/jobs', { payload: {} })).status, 400);
});

test('the file sweep runs as a job of its own', async () => {
  const answer = await webhook('/events/jobs', { payload: { job: 'sweep_files' } });
  assert.equal(answer.status, 200);
  assert.equal(answer.body.job, 'sweep_files');
});

test('a purchase webhook applies the entitlement once, whatever the retries', async () => {
  const p = await person();
  const event = purchase(p.id, `evt-${randomUUID()}`);
  const first = await revenueCat(event);
  assert.equal(first.status, 200);
  assert.deepEqual(first.body, { ok: true, applied: true });
  const second = await revenueCat(event);
  assert.equal(second.status, 200);
  assert.deepEqual(second.body, { ok: true, applied: false }, 'the same event id changes nothing twice');
  const rows = await sql(`select plan, status from public.entitlements where user_id = '${p.id}'`);
  assert.deepEqual(rows, [['plus_annual', 'active']]);
  assert.deepEqual(await sql(`select count(*) from private.purchase_events where user_id = '${p.id}'`), [['1']]);
});

test('an older purchase event does not undo a newer one', async () => {
  const p = await person();
  const now = Date.now();
  await revenueCat(purchase(p.id, `evt-${randomUUID()}`, 'INITIAL_PURCHASE', now));
  await revenueCat(purchase(p.id, `evt-${randomUUID()}`, 'EXPIRATION', now - 86_400_000));
  assert.deepEqual(await sql(`select status from public.entitlements where user_id = '${p.id}'`), [['active']]);
});

test('a purchase for an unknown person or an unknown event is acknowledged and ignored', async () => {
  const unknown = await revenueCat(purchase(randomUUID(), `evt-${randomUUID()}`));
  assert.deepEqual(unknown, { status: 200, body: { ok: true, applied: false } });
  const anonymous = await revenueCat({ event: { ...purchase('$RCAnonymousID:abc', `evt-${randomUUID()}`).event } });
  assert.deepEqual(anonymous, { status: 200, body: { ok: true, ignored: true } });
});

test('an unauthenticated purchase webhook is refused', async () => {
  const res = await fetch(`${urls.functions}/purchases`, {
    method: 'POST',
    headers: { 'content-type': 'application/json', authorization: 'wrong' },
    body: JSON.stringify(purchase(randomUUID(), 'evt')),
  });
  assert.equal(res.status, 401);
});

test('the push trigger is delivered even when no push can be sent', async () => {
  const p = await person();
  await sql(`select private.notify('${p.id}', 'card_ready', null, 'delivery:${randomUUID()}')`);
  const delivered = await waitFor(async () => {
    const rows = await sql(`select delivered from hdb_catalog.event_log
      where trigger_name = 'push_notification' order by created_at desc limit 1`);
    return rows[0]?.[0] === 't' ? rows : null;
  });
  assert.deepEqual(delivered, [['t']], 'Hasura called /events/push and the function accepted the event');
  const invocation = await sql(`select status from hdb_catalog.event_invocation_logs order by created_at desc limit 1`);
  assert.deepEqual(invocation, [['200']]);
});

test('the chat endpoint answers as server-sent events, and refuses an anonymous caller', async () => {
  const anonymous = await fetch(`${urls.functions}/chat`, {
    method: 'POST',
    headers: { 'content-type': 'application/json' },
    body: JSON.stringify({ message: 'oi' }),
  });
  assert.equal(anonymous.status, 401);

  const session = await signUp();
  const previous = (await sql(`select value from public.app_config where key = 'chat_messages_per_day_free'`))[0]?.[0] ?? '0';
  await sql(`insert into public.app_config (key, value) values ('chat_messages_per_day_free', '5')
             on conflict (key) do update set value = '5'`);
  try {
    const res = await fetch(`${urls.functions}/chat`, {
      method: 'POST',
      headers: { 'content-type': 'application/json', authorization: `Bearer ${session.token}` },
      body: JSON.stringify({ message: 'estou cansada hoje', locale: 'pt-BR' }),
    });
    assert.equal(res.headers.get('content-type'), 'text/event-stream');
    const text = await res.text();
    assert.match(text, /^data: /, 'the body is an event stream, not a buffered JSON document');
    // Without a provider the turn fails and is refunded; with one configured the reply ends in `done` and the turn counts.
    const unavailable = /"type":"error","code":"CHAT_UNAVAILABLE"/.test(text);
    if (!unavailable) assert.match(text, /"type":"done"/, 'a configured provider ends the stream with done');
    assert.deepEqual(await sql(`select count(*) from public.chat_turns where user_id = '${session.id}'`), [[unavailable ? '0' : '1']],
      'a failed turn is refunded and an answered turn is counted');
  } finally {
    await sql(`update public.app_config set value = '${previous}' where key = 'chat_messages_per_day_free'`);
  }
});

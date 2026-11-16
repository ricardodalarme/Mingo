import { test } from 'node:test';
import { adminSecret, assert, couple, denied, ok, person, urls } from '../lib.ts';

type Actor = 'public' | { id: string };

/** One `graphql-transport-ws` connection, queued so a test can await results in order. */
class Live {
  private readonly queue: any[] = [];
  private waiters: ((value: any) => void)[] = [];
  private readonly socket: WebSocket;

  private constructor(socket: WebSocket) {
    this.socket = socket;
  }

  static async open(actor: Actor, query: string): Promise<Live> {
    const socket = new WebSocket(urls.graphql.replace(/^http/, 'ws'), 'graphql-transport-ws');
    const live = new Live(socket);
    const ready = new Promise<void>((resolve, reject) => {
      const timer = setTimeout(() => reject(new Error('the socket did not connect')), 10_000);
      socket.onopen = () => {
        const headers: Record<string, string> = { 'x-hasura-admin-secret': adminSecret };
        if (actor === 'public') headers['x-hasura-role'] = 'public';
        else Object.assign(headers, { 'x-hasura-role': 'user', 'x-hasura-user-id': actor.id });
        socket.send(JSON.stringify({ type: 'connection_init', payload: { headers } }));
      };
      socket.onmessage = (event) => {
        const message = JSON.parse(String(event.data));
        if (message.type === 'ping') {
          socket.send(JSON.stringify({ type: 'pong' }));
          return;
        }
        if (message.type === 'connection_ack') {
          socket.send(JSON.stringify({ id: '1', type: 'subscribe', payload: { query } }));
          clearTimeout(timer);
          resolve();
          return;
        }
        if (message.type === 'next') live.push(message.payload);
        else if (message.type === 'error' || message.type === 'connection_error') live.push({ error: message.payload });
      };
      socket.onerror = () => reject(new Error('socket error'));
    });
    await ready;
    return live;
  }

  private push(value: any) {
    const waiter = this.waiters.shift();
    if (waiter) waiter(value);
    else this.queue.push(value);
  }

  /** The next update, or null when none arrives within the timeout. */
  next(timeout = 5_000): Promise<any | null> {
    if (this.queue.length) return Promise.resolve(this.queue.shift());
    return new Promise((resolve) => {
      const timer = setTimeout(() => {
        this.waiters = this.waiters.filter((w) => w !== waiter);
        resolve(null);
      }, timeout);
      const waiter = (value: any) => {
        clearTimeout(timer);
        resolve(value);
      };
      this.waiters.push(waiter);
    });
  }

  close() {
    this.socket.close();
  }
}

test('a subscription carries a partner message to the partner and nothing to a stranger', async () => {
  const { a, b } = await couple();
  const stranger = await person();
  const messages = await Live.open(b, `subscription { partnerMessages { id body } }`);
  const slips = await Live.open(b, `subscription { slips { id body } }`);
  const other = await Live.open(stranger, `subscription { partnerMessages { id } }`);
  try {
    assert.deepEqual((await messages.next())?.data, { partnerMessages: [] });
    assert.deepEqual((await slips.next())?.data, { slips: [] });
    assert.deepEqual((await other.next())?.data, { partnerMessages: [] });

    await ok(a, `mutation { insertSlipsOne(object: {body: "só minha"}) { id } }`);
    assert.equal(await slips.next(2_500), null, 'a private slip is never pushed to the partner');

    const message = (await ok(a, `mutation { insertPartnerMessagesOne(object: {kind: note, body: "pensei em você"}) { id } }`)).insertPartnerMessagesOne;
    const update = await messages.next();
    assert.deepEqual(update?.data?.partnerMessages, [{ id: message.id, body: 'pensei em você' }]);
    assert.equal(await other.next(2_500), null, 'a stranger subscription stays empty');
  } finally {
    messages.close();
    slips.close();
    other.close();
  }
});

test('after unpairing the ex-partner receives no further update', async () => {
  const { a, b } = await couple();
  const live = await Live.open(b, `subscription { partnerMessages { id body } }`);
  try {
    assert.deepEqual((await live.next())?.data, { partnerMessages: [] });
    await ok(a, `mutation { unpair { id } }`);
    await denied(a, `mutation { insertPartnerMessagesOne(object: {kind: note, body: "depois"}) { id } }`);
    assert.equal(await live.next(2_500), null);
  } finally {
    live.close();
  }
});

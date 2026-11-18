// Delivers one queued notification. Called by the `push_notification` event trigger for every new row.
// Preferences (muted types, daily cap, quiet moments) are decided in SQL by `claimNotification`; this only delivers.
// The payload is generic: a type and a reference id, never names or content.
// Outcomes: 200 = settled, or nothing to do; 500 = transient failure, the trigger retries (six tries in half an hour).
import * as v from 'valibot';
import { mapLimit, retry } from '../_lib/async.ts';
import { env } from '../_lib/env.ts';
import { asAdmin } from '../_lib/graphql.ts';
import { handler } from '../_lib/handler.ts';
import { fail, ok } from '../_lib/http.ts';
import { log } from '../_lib/log.ts';
import { insertedRow, NonEmptyString, parse } from '../_lib/payloads.ts';
import { accessToken, type Delivery, loadAccount, send } from './_fcm.ts';
import { claimNotification, completeNotification } from './_operations.ts';

const DEVICES_IN_PARALLEL = 5;
/** A failed completion after delivery makes the trigger retry and send again, so it is retried here first. */
const COMPLETE_ATTEMPTS = 3;

const NewNotification = insertedRow(v.object({ id: NonEmptyString, type: v.string(), ref_id: v.nullish(v.string()) }));

export default handler({ method: 'POST', guard: { kind: 'trigger' } }, async (req, res) => {
  const row = parse(NewNotification, req.body)?.event.data.new;
  if (!row) return fail(res, 'INVALID_EVENT');

  const loaded = loadAccount(env('FCM_SERVICE_ACCOUNT'));
  if (loaded.state === 'unset') return ok(res, { skipped: 'FCM_SERVICE_ACCOUNT not set' });
  if (loaded.state === 'invalid') {
    log.error('push_config_invalid');
    return fail(res, 'FCM_SERVICE_ACCOUNT_INVALID');
  }
  const { account } = loaded;

  // A retried event claims again: a settled row returns no device, so a notification is never sent twice after success.
  const { claimNotification: devices } = await asAdmin(claimNotification, { id: row.id });
  if (devices.length === 0) return ok(res, { sent: 0 });

  let bearer: string;
  try {
    bearer = await accessToken(account);
  } catch {
    log.error('push_auth_failed');
    return fail(res, 'FCM_AUTH_FAILED');
  }

  const push = { id: row.id, type: row.type, refId: row.ref_id ?? null };
  const outcomes = await mapLimit(devices, DEVICES_IN_PARALLEL, ({ token }) => send(account, bearer, token, push));
  const count = (outcome: Delivery) => outcomes.filter((o) => o === outcome).length;
  const delivered = count('sent');
  if (delivered === 0 && count('transient') > 0) {
    log.warn('push_retry', { type: row.type });
    return fail(res, 'FCM_UNAVAILABLE');
  }
  const dead = devices.filter((_, index) => outcomes[index] === 'dead').map(({ token }) => token);
  await retry(COMPLETE_ATTEMPTS, () => asAdmin(completeNotification, { id: row.id, dead }));
  log.info('push_sent', { type: row.type, delivered, dead: dead.length });
  ok(res, { sent: delivered });
});

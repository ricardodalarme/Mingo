// Delivers one queued notification. Called by the `push_notification` event trigger for every new row.
// Preferences (muted types, daily cap, quiet moments) are decided in SQL by `claimNotification`; this only delivers.
// The payload is generic: a type and a reference id, never names or content.
// Outcomes: 200 = settled, or nothing to do; 500 = transient failure, the trigger retries (six tries in half an hour).
import { asAdmin, isTrigger, log, type Req, type Res } from '../_lib/backend';
import { accessToken, loadAccount, send } from './_fcm';

type Device = { token: string };
type Row = { id: string; type: string; ref_id: string | null };

export default async (req: Req, res: Res) => {
  if (!isTrigger(req)) return res.status(401).json({ error: 'UNAUTHORIZED' });
  const row: Row | undefined = req.body?.event?.data?.new;
  if (!row?.id) return res.status(400).json({ error: 'INVALID_EVENT' });

  const account = loadAccount(process.env.FCM_SERVICE_ACCOUNT);
  if (account === null) return res.status(200).json({ skipped: 'FCM_SERVICE_ACCOUNT not set' });
  if (account === 'invalid') {
    log('push_config_invalid');
    return res.status(500).json({ error: 'FCM_SERVICE_ACCOUNT_INVALID' });
  }

  // A retried event claims again: a settled row returns no device, so a notification is never sent twice after success.
  const { claimNotification: devices } = await asAdmin<{ claimNotification: Device[] }>(
    `mutation ($id: uuid!) { claimNotification(args: { notification_id: $id }) { token } }`, { id: row.id });
  if (devices.length === 0) return res.status(200).json({ sent: 0 });

  let bearer: string;
  try {
    bearer = await accessToken(account);
  } catch {
    log('push_auth_failed');
    return res.status(500).json({ error: 'FCM_AUTH_FAILED' });
  }

  const dead: string[] = [];
  let delivered = 0;
  let transient = 0;
  for (const { token } of devices) {
    const outcome = await send(account, bearer, token, { id: row.id, type: row.type, refId: row.ref_id });
    if (outcome === 'sent') delivered++;
    else if (outcome === 'dead') dead.push(token);
    else transient++;
  }
  if (delivered === 0 && transient > 0) {
    log('push_retry', { type: row.type });
    return res.status(500).json({ error: 'FCM_UNAVAILABLE' });
  }
  await asAdmin(`mutation ($id: uuid!, $dead: jsonb!) { completeNotification(args: { notification_id: $id, failed_tokens: $dead }) { id } }`,
    { id: row.id, dead });
  log('push_sent', { type: row.type, delivered, dead: dead.length });
  return res.status(200).json({ sent: delivered });
};

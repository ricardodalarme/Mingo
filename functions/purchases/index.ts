// RevenueCat webhook: keeps the entitlement of a person in step with the stores.
// The Authorization header must equal the secret REVENUECAT_WEBHOOK_AUTH. The app user id is the Nhost user id
// (`Purchases.logIn(userId)` in the app). Idempotent by event id; an event older than the stored state is ignored in SQL.
import { asAdmin, header, log, type Req, type Res, safeEqual } from '../_lib/backend';
import { toPurchaseEvent } from './_event';

export default async (req: Req, res: Res) => {
  const secret = process.env.REVENUECAT_WEBHOOK_AUTH;
  if (!secret || !safeEqual(header(req, 'authorization'), secret))
    return res.status(401).json({ error: 'UNAUTHORIZED' });
  if (req.method !== 'POST') return res.status(405).json({ error: 'METHOD_NOT_ALLOWED' });
  const event = toPurchaseEvent(req.body?.event);
  if (!event) return res.status(200).json({ ok: true, ignored: true });
  const { applyPurchaseEvent } = await asAdmin<{
    applyPurchaseEvent: unknown[];
  }>(
    `mutation ($id: String!, $user: uuid!, $type: String!, $at: String!, $plan: String!, $status: String!,
               $expires: String, $renew: Boolean!, $store: String!) {
       applyPurchaseEvent(args: { p_event_id: $id, p_user_id: $user, p_type: $type, p_event_at: $at, p_plan: $plan,
         p_status: $status, p_expires_at: $expires, p_will_renew: $renew, p_store: $store }) { userId } }`,
    {
      id: event.eventId,
      user: event.userId,
      type: event.type,
      at: event.eventAt,
      plan: event.plan,
      status: event.status,
      expires: event.expiresAt,
      renew: event.willRenew,
      store: event.store,
    },
  );
  const applied = applyPurchaseEvent.length > 0;
  log('purchase_event', { type: event.type, applied });
  return res.status(200).json({ ok: true, applied });
};

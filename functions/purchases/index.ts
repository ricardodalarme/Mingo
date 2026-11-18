// RevenueCat webhook: keeps the entitlement of a person in step with the stores.
// The Authorization header must equal the secret REVENUECAT_WEBHOOK_AUTH. The app user id is the Nhost user id
// (`Purchases.logIn(userId)` in the app). Idempotent by event id; an event older than the stored state is ignored in SQL.

import * as v from 'valibot';
import { asAdmin } from '../_lib/graphql.ts';
import { handler } from '../_lib/handler.ts';
import { ok } from '../_lib/http.ts';
import { log } from '../_lib/log.ts';
import { parse } from '../_lib/payloads.ts';
import { toPurchaseEvent } from './_event.ts';
import { applyPurchaseEvent, purchaseVariables } from './_operations.ts';

const Webhook = v.object({ event: v.unknown() });

export default handler(
  { method: 'POST', guard: { kind: 'secret', header: 'authorization', env: 'REVENUECAT_WEBHOOK_AUTH' } },
  async (req, res) => {
    const event = toPurchaseEvent(parse(Webhook, req.body)?.event);
    if (!event) return ok(res, { ok: true, ignored: true });
    const result = await asAdmin(applyPurchaseEvent, purchaseVariables(event));
    const applied = result.applyPurchaseEvent.length > 0;
    log.info('purchase_event', { type: event.type, applied });
    ok(res, { ok: true, applied });
  },
);

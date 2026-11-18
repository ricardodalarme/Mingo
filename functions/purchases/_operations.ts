import { operation } from '../_lib/graphql.ts';
import type { PurchaseEvent } from './_event.ts';

export const applyPurchaseEvent = operation<
  { applyPurchaseEvent: unknown[] },
  {
    id: string;
    user: string;
    type: string;
    at: string;
    plan: string;
    status: string;
    expires: string | null;
    renew: boolean;
    store: string;
  }
>(
  `mutation ($id: String!, $user: uuid!, $type: String!, $at: String!, $plan: String!, $status: String!,
             $expires: String, $renew: Boolean!, $store: String!) {
     applyPurchaseEvent(args: { p_event_id: $id, p_user_id: $user, p_type: $type, p_event_at: $at, p_plan: $plan,
       p_status: $status, p_expires_at: $expires, p_will_renew: $renew, p_store: $store }) { userId } }`,
);

/** The variables of [applyPurchaseEvent] for an event. */
export const purchaseVariables = (event: PurchaseEvent) => ({
  id: event.eventId,
  user: event.userId,
  type: event.type,
  at: event.eventAt,
  plan: event.plan,
  status: event.status,
  expires: event.expiresAt,
  renew: event.willRenew,
  store: event.store,
});

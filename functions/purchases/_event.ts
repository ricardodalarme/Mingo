// Maps a RevenueCat webhook event to the entitlement it leaves behind.
import * as v from 'valibot';
import { parse, UUID } from '../_lib/payloads.ts';

export type PurchaseStatus = 'active' | 'trialing' | 'billing_issue' | 'expired' | 'refunded';
export type Plan = 'plus_monthly' | 'plus_annual' | 'plus_gift';
export type Store = 'app_store' | 'play_store' | 'promo';

export type PurchaseEvent = {
  eventId: string;
  userId: string;
  type: string;
  eventAt: string;
  plan: Plan;
  status: PurchaseStatus;
  expiresAt: string | null;
  willRenew: boolean;
  store: Store;
};

const STATUS_OF_TYPE: Record<string, PurchaseStatus> = {
  INITIAL_PURCHASE: 'active',
  RENEWAL: 'active',
  UNCANCELLATION: 'active',
  PRODUCT_CHANGE: 'active',
  CANCELLATION: 'active',
  BILLING_ISSUE: 'billing_issue',
  EXPIRATION: 'expired',
  SUBSCRIPTION_PAUSED: 'expired',
};

const TYPES_THAT_STOP_RENEWAL = ['CANCELLATION', 'EXPIRATION', 'BILLING_ISSUE'];
const ANNUAL_PRODUCT = /annual|year/i;

const RevenueCatEvent = v.object({
  id: v.pipe(v.string(), v.minLength(1)),
  app_user_id: v.pipe(v.string(), v.regex(UUID)),
  type: v.string(),
  cancel_reason: v.nullish(v.string()),
  period_type: v.nullish(v.string()),
  product_id: v.nullish(v.string()),
  store: v.nullish(v.string()),
  event_timestamp_ms: v.nullish(v.number()),
  expiration_at_ms: v.nullish(v.number()),
});

const planOf = (event: v.InferOutput<typeof RevenueCatEvent>): Plan => {
  if (event.period_type === 'PROMOTIONAL') return 'plus_gift';
  return ANNUAL_PRODUCT.test(event.product_id ?? '') ? 'plus_annual' : 'plus_monthly';
};

const storeOf = (store: string | null | undefined): Store => {
  if (store === 'PLAY_STORE') return 'play_store';
  return store === 'APP_STORE' ? 'app_store' : 'promo';
};

const statusOf = (event: v.InferOutput<typeof RevenueCatEvent>): PurchaseStatus | null => {
  const status = STATUS_OF_TYPE[event.type];
  if (!status) return null;
  if (event.type === 'CANCELLATION' && event.cancel_reason === 'CUSTOMER_SUPPORT') return 'refunded';
  return status === 'active' && event.period_type === 'TRIAL' ? 'trialing' : status;
};

/** The entitlement change of an event, or null for an event that changes nothing (unknown type, anonymous user). */
export function toPurchaseEvent(input: unknown): PurchaseEvent | null {
  const event = parse(RevenueCatEvent, input);
  const status = event && statusOf(event);
  if (!event || !status) return null;
  return {
    eventId: event.id,
    userId: event.app_user_id,
    type: event.type,
    eventAt: new Date(event.event_timestamp_ms ?? Date.now()).toISOString(),
    plan: planOf(event),
    status,
    expiresAt: event.expiration_at_ms ? new Date(event.expiration_at_ms).toISOString() : null,
    willRenew: !TYPES_THAT_STOP_RENEWAL.includes(event.type),
    store: storeOf(event.store),
  };
}

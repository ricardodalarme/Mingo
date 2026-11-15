// Maps a RevenueCat webhook event to the entitlement it leaves behind.

const STATUS: Record<string, string> = {
  INITIAL_PURCHASE: 'active', RENEWAL: 'active', UNCANCELLATION: 'active', PRODUCT_CHANGE: 'active',
  CANCELLATION: 'active', BILLING_ISSUE: 'billing_issue', EXPIRATION: 'expired', SUBSCRIPTION_PAUSED: 'expired',
};

export type PurchaseEvent = {
  eventId: string; userId: string; type: string; eventAt: string; plan: string; status: string;
  expiresAt: string | null; willRenew: boolean; store: string;
};

/** The entitlement change of an event, or null for an event that changes nothing (unknown type, anonymous user). */
export function toPurchaseEvent(event: any): PurchaseEvent | null {
  if (!event?.id || typeof event.app_user_id !== 'string' || !/^[0-9a-f-]{36}$/.test(event.app_user_id)) return null;
  let status = STATUS[event.type];
  if (!status) return null;
  if (event.type === 'CANCELLATION' && event.cancel_reason === 'CUSTOMER_SUPPORT') status = 'refunded';
  if (status === 'active' && event.period_type === 'TRIAL') status = 'trialing';
  return {
    eventId: String(event.id),
    userId: event.app_user_id,
    type: event.type,
    eventAt: new Date(event.event_timestamp_ms ?? Date.now()).toISOString(),
    plan: event.period_type === 'PROMOTIONAL' ? 'plus_gift' : /annual|year/i.test(event.product_id ?? '') ? 'plus_annual' : 'plus_monthly',
    status,
    expiresAt: event.expiration_at_ms ? new Date(event.expiration_at_ms).toISOString() : null,
    willRenew: !['CANCELLATION', 'EXPIRATION', 'BILLING_ISSUE'].includes(event.type),
    store: event.store === 'PLAY_STORE' ? 'play_store' : event.store === 'APP_STORE' ? 'app_store' : 'promo',
  };
}

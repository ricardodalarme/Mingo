import assert from 'node:assert/strict';
import { test } from 'node:test';
import { toPurchaseEvent } from '../_event.ts';

const USER = '0b7b1f1e-6f0a-4f4e-8a34-2f6a1c9d3b21';
const NOW = 1794784036000;

const revenueCat = (overrides: Record<string, unknown> = {}) => ({
  event: {
    id: 'evt-1',
    app_user_id: USER,
    type: 'INITIAL_PURCHASE',
    event_timestamp_ms: NOW,
    product_id: 'mingo_plus_annual',
    period_type: 'NORMAL',
    expiration_at_ms: NOW + 31_536_000_000,
    store: 'APP_STORE',
    ...overrides,
  },
});

test('an annual app store purchase becomes an active annual entitlement', () => {
  assert.deepEqual(toPurchaseEvent(revenueCat().event), {
    eventId: 'evt-1',
    userId: USER,
    type: 'INITIAL_PURCHASE',
    eventAt: new Date(NOW).toISOString(),
    plan: 'plus_annual',
    status: 'active',
    expiresAt: new Date(NOW + 31_536_000_000).toISOString(),
    willRenew: true,
    store: 'app_store',
  });
});

test('each event type maps to the state it leaves behind', () => {
  const status = (type: string, extra = {}) => toPurchaseEvent(revenueCat({ type, ...extra }).event)?.status;
  assert.equal(status('RENEWAL'), 'active');
  assert.equal(status('UNCANCELLATION'), 'active');
  assert.equal(status('PRODUCT_CHANGE'), 'active');
  assert.equal(status('CANCELLATION'), 'active', 'a cancelled subscription keeps access until it expires');
  assert.equal(status('BILLING_ISSUE'), 'billing_issue');
  assert.equal(status('EXPIRATION'), 'expired');
  assert.equal(status('SUBSCRIPTION_PAUSED'), 'expired');
});

test('a support refund is recorded as refunded', () => {
  assert.equal(
    toPurchaseEvent(revenueCat({ type: 'CANCELLATION', cancel_reason: 'CUSTOMER_SUPPORT' }).event)?.status,
    'refunded',
  );
});

test('a trial is recorded as trialing', () => {
  assert.equal(toPurchaseEvent(revenueCat({ period_type: 'TRIAL' }).event)?.status, 'trialing');
});

test('a promotional grant is a gift no store is charged for', () => {
  const event = toPurchaseEvent(revenueCat({ period_type: 'PROMOTIONAL', store: 'PROMOTIONAL' }).event);
  assert.equal(event?.plan, 'plus_gift');
  assert.equal(event?.store, 'promo');
});

test('a monthly product and a play store purchase map to plus_monthly on play_store', () => {
  const event = toPurchaseEvent(revenueCat({ product_id: 'mingo_plus_monthly', store: 'PLAY_STORE' }).event);
  assert.equal(event?.plan, 'plus_monthly');
  assert.equal(event?.store, 'play_store');
});

test('renewal is off after cancellation, expiration or a billing issue', () => {
  const renew = (type: string) => toPurchaseEvent(revenueCat({ type }).event)?.willRenew;
  assert.equal(renew('CANCELLATION'), false);
  assert.equal(renew('BILLING_ISSUE'), false);
  assert.equal(renew('INITIAL_PURCHASE'), true);
});

test('an unknown type, a missing event id and an anonymous user change nothing', () => {
  assert.equal(toPurchaseEvent(revenueCat({ type: 'SOMETHING_NEW' }).event), null);
  assert.equal(toPurchaseEvent({ ...revenueCat().event, id: undefined }), null);
  assert.equal(toPurchaseEvent(revenueCat({ app_user_id: '$RCAnonymousID:abc' }).event), null);
  assert.equal(toPurchaseEvent(undefined), null);
});

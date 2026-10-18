import { type Accounts, DAY_MS } from "./accounts";
import { HttpError, readJson } from "./http";
import { verifyGoogleServiceToken } from "./identity";
import { type PlayCheck, googleAccess, listVoidedPurchases } from "./play";

/*
 * Google Play refunds reach the account within seconds (README, "Refunds"; the user, 16 Oct 2026: "if I purchase
 * something and get a refund, it should be revoked immediately"). Two paths, as Google describes them:
 *
 * 1. **Real-time developer notifications** (developer.android.com/google/play/billing/rtdn-reference): Google Play
 *    publishes to our Pub/Sub topic the moment a purchase is voided (refunded, revoked or charged back) or a one-time
 *    purchase is cancelled, and Pub/Sub pushes it here (`POST /v1/google/notifications`) with an OIDC token from our push
 *    service account. A push we don't answer with 2xx is delivered again, with backoff, for up to 7 days.
 * 2. **The Voided Purchases API**, read once a day (`sweepVoided`): the backstop for a notification that never came (our
 *    endpoint down for longer than Pub/Sub keeps messages, a setting changed in Play Console).
 *
 * A void is final: the token is remembered (`voided_purchases`) and never counts again. The daily re-check of purchases
 * on `GET /v1/account` stays as a third, slower path. Nothing here logs a token or a body (D11).
 */

/** Google Play's notification, inside Pub/Sub's message (base64 `data`). Only the fields the Worker reads. */
interface DeveloperNotification {
  packageName?: unknown;
  oneTimeProductNotification?: { notificationType?: unknown; purchaseToken?: unknown; sku?: unknown };
  voidedPurchaseNotification?: { purchaseToken?: unknown; productType?: unknown; refundType?: unknown };
  subscriptionNotification?: unknown;
  pendingRefundReviewNotification?: unknown;
  testNotification?: unknown;
}

const ONE_TIME_PRODUCT_PURCHASED = 1;
const ONE_TIME_PRODUCT_CANCELED = 2;
const PRODUCT_TYPE_ONE_TIME = 2;
const REFUND_TYPE_QUANTITY_BASED_PARTIAL = 2;

/**
 * `POST /v1/google/notifications`: one Pub/Sub push. 204 once handled (Pub/Sub then forgets it); 401 without Pub/Sub's
 * token; 503 when Google Play or the database can't be asked now, so Pub/Sub delivers it again. A message we can't read
 * is acknowledged and logged (the daily sweep still catches any void in it), so it isn't retried for a week.
 */
export async function playNotification(request: Request, env: Env, accounts: Accounts, check: (product: string, token: string) => Promise<PlayCheck>): Promise<Response> {
  const auth = /^Bearer (\S{20,8192})$/.exec(request.headers.get("authorization") ?? "");
  if (!auth) throw new HttpError(401, "unauthorized", "Not allowed.");
  await verifyGoogleServiceToken(auth[1]!, env.GOOGLE_PUBSUB_AUDIENCE, env.GOOGLE_PUBSUB_SERVICE_ACCOUNT);

  const body = await readJson(request, 64 * 1024);
  const message = (body.message ?? {}) as { data?: unknown; messageId?: unknown; message_id?: unknown };
  const messageId = typeof message.messageId === "string" ? message.messageId : typeof message.message_id === "string" ? message.message_id : null;
  if (!messageId || messageId.length > 200) return done("rtdn: a push without a message ID");
  if (await accounts.notificationSeen(messageId)) return done(null);

  const notification = decode(message.data);
  if (!notification) return handled(accounts, messageId, "rtdn: unreadable message");
  if (notification.packageName !== env.PLAY_PACKAGE) return handled(accounts, messageId, "rtdn: another app's notification");

  const voided = notification.voidedPurchaseNotification;
  if (voided) {
    if (typeof voided.purchaseToken !== "string" || !voided.purchaseToken) return handled(accounts, messageId, "rtdn: voided, without a token");
    if (voided.productType !== PRODUCT_TYPE_ONE_TIME) return handled(accounts, messageId, "rtdn: voided subscription (we sell none)");
    // A partial refund applies only to a purchase of several at once; ours are one at a time, and the last part of any
    // refund comes as a full one.
    if (voided.refundType === REFUND_TYPE_QUANTITY_BASED_PARTIAL) return handled(accounts, messageId, "rtdn: partial refund, nothing ends");
    const held = await accounts.voidPurchase(voided.purchaseToken, "notification");
    return handled(accounts, messageId, `rtdn: voided one-time purchase (${held ? "held by an account: what it paid for ended" : "not held by any account: remembered"})`);
  }

  const oneTime = notification.oneTimeProductNotification;
  if (oneTime) {
    const type = oneTime.notificationType;
    if (typeof oneTime.purchaseToken !== "string" || !oneTime.purchaseToken || (type !== ONE_TIME_PRODUCT_PURCHASED && type !== ONE_TIME_PRODUCT_CANCELED)) {
      return handled(accounts, messageId, "rtdn: one-time notification we don't use");
    }
    // Google: the notification only says the state changed; ask the Play Developer API for the state itself. Only a
    // purchase an account holds can change anything: a new one reaches its account when the app sends it.
    const held = await accounts.heldPurchase(oneTime.purchaseToken);
    if (!held) return handled(accounts, messageId, `rtdn: one-time ${type === ONE_TIME_PRODUCT_CANCELED ? "cancelled" : "purchased"}, not held by any account`);
    const answer = await check(held.product, oneTime.purchaseToken); // 503 if Google can't be asked: Pub/Sub tries again
    await accounts.recheck(held.accountId, oneTime.purchaseToken, answer);
    return handled(accounts, messageId, `rtdn: one-time ${type === ONE_TIME_PRODUCT_CANCELED ? "cancelled" : "purchased"}, checked: ${answer.state}`);
  }

  if (notification.testNotification) return handled(accounts, messageId, "rtdn: Play Console's test notification");
  // A chargeback Google asks us to review: we don't contest refunds, so Google decides and its void reaches us as above.
  if (notification.pendingRefundReviewNotification) return handled(accounts, messageId, "rtdn: pending refund review (left to Google)");
  if (notification.subscriptionNotification) return handled(accounts, messageId, "rtdn: subscription notification (we sell none)");
  return handled(accounts, messageId, "rtdn: notification of a kind we don't know");
}

function decode(data: unknown): DeveloperNotification | null {
  if (typeof data !== "string" || data.length === 0 || data.length > 48 * 1024) return null;
  try {
    const bytes = Uint8Array.from(atob(data), (c) => c.charCodeAt(0));
    const value = JSON.parse(new TextDecoder().decode(bytes)) as unknown;
    return value && typeof value === "object" && !Array.isArray(value) ? (value as DeveloperNotification) : null;
  } catch {
    return null;
  }
}

async function handled(accounts: Accounts, messageId: string, what: string): Promise<Response> {
  await accounts.notificationHandled(messageId);
  return done(what);
}

function done(what: string | null): Response {
  if (what) console.log(what);
  return new Response(null, { status: 204, headers: { "cache-control": "no-store" } });
}

/** Overlap between sweeps: the API filters by when it first saw a void, which may settle a little after the fact. */
export const SWEEP_OVERLAP_MS = 60 * 60 * 1000;
/** The API never returns voids it first saw more than 30 days ago; stay a little inside that. */
const SWEEP_MAX_BACK_MS = 30 * DAY_MS - 10 * 60 * 1000;
/**
 * One run's budget on the Workers Free plan (50 calls out, 1,000 database calls, 10 ms of CPU): 20 pages of 1,000 voids
 * (2 calls to sign in to Google, one per page) at about 13 database calls a page, and at most 120 held purchases ended
 * one by one (about 5 calls each). What doesn't fit is done by the next day's run.
 */
export const SWEEP_MAX_PAGES = 20;
export const SWEEP_MAX_HELD = 120;

/**
 * Every day: every one-time purchase Google voided since the last sweep (with an hour's overlap; the first sweep goes
 * 30 days back), a page at a time through `voidMany`, which ends a held purchase exactly as a notification does. The
 * cursor moves only after a whole sweep is done, so a run that failed or ran out of its budget is simply carried on next
 * day (purchases it already ended are no longer active, so each run gets further). Safe to repeat.
 */
export async function sweepVoided(env: Env, accounts: Accounts, now = Date.now()): Promise<{ voided: number; held: number; done: boolean }> {
  const until = Number(await accounts.state("voided_until"));
  const start = Math.max(Number.isFinite(until) && until > 0 ? until - SWEEP_OVERLAP_MS : 0, now - SWEEP_MAX_BACK_MS);
  const google = googleAccess(env);
  let voided = 0;
  let held = 0;
  let page: string | undefined;
  for (let i = 0; i < SWEEP_MAX_PAGES; i++) {
    const result = await listVoidedPurchases(google, env.PLAY_PACKAGE, start, now, page);
    // A partial refund (never asked for: see playNotification) ends nothing.
    const tokens = result.voided.filter((v) => v.voidedQuantity === undefined).map((v) => v.purchaseToken);
    voided += tokens.length;
    const ended = await accounts.voidMany(tokens, "voided_api", SWEEP_MAX_HELD - held);
    held += ended.held;
    if (!ended.done) return { voided, held, done: false };
    if (!result.nextPageToken) {
      await accounts.setState("voided_until", String(now));
      return { voided, held, done: true };
    }
    page = result.nextPageToken;
  }
  // More than 20,000 voids in one window: keep what was done, and carry on the next day.
  return { voided, held, done: false };
}

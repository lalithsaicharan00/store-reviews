import type { PurchaseRecord } from "./account";
import { purchaseOwner } from "./directory";
import { accountStub } from "./stubs";

/**
 * The one email we ever send: the purchase confirmation (Architecture/Email Delivery Decision.md). Once per purchase
 * (`purchase_email`, keyed by store + purchase ID), never blocking Plus, rechecked before every send (the account still
 * exists, the purchase isn't refunded, there's an address), retried by the daily cron for 7 days. Sent through Resend
 * when `RESEND_API_KEY` is set; until then jobs wait. Templates live here, never at the provider.
 */

const DAY_MS = 86_400_000;
/** "Not now" buyers who sign in later still get it, if the purchase is under 30 days old (§1). */
export const CONFIRM_WITHIN_MS = 30 * DAY_MS;
const RETRY_FOR_MS = 7 * DAY_MS;
const MAX_ATTEMPTS = 5;

interface EmailEnv extends Env {
  RESEND_API_KEY?: string;
  EMAIL_FROM?: string;
}

const PRODUCT_NAMES: Record<string, string> = {
  "com.oftenenough.app.plus": "Often Enough Plus",
  "com.oftenenough.app.plusfamily": "Often Enough Plus Family",
  "com.oftenenough.app.plusfamily.upgrade": "Often Enough Plus Family (upgrade from Plus)",
};

export interface Message {
  to: string;
  subject: string;
  text: string;
  html: string;
}

/** Only verified details: the product, lifetime, the date and the store. No price, currency or invoice number (§2). */
export function confirmationMessage(to: string, purchase: Pick<PurchaseRecord, "productId" | "purchasedAt" | "store">): Message {
  const product = PRODUCT_NAMES[purchase.productId] ?? "Often Enough Plus";
  const date = new Date(purchase.purchasedAt).toLocaleDateString("en-GB", { day: "numeric", month: "long", year: "numeric", timeZone: "UTC" });
  const store = purchase.store === "apple" ? "the App Store" : "Google Play";
  const text = [
    `Thank you for buying ${product}.`,
    "",
    "It's yours for life, on every device you sign in on. There's no subscription and nothing to cancel.",
    "",
    `Product: ${product} (lifetime)`,
    `Bought: ${date}, through ${store}`,
    "",
    `This isn't a receipt: ${store} sends that. If Plus ever goes missing, open Often Enough and sign in, or use Restore Purchases.`,
    "",
    "Questions? Reply to support@oftenenough.com or see https://oftenenough.com/support",
    "",
    "This is the only email we send you.",
  ].join("\n");
  const esc = (s: string) => s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
  const html = `<!doctype html><html><body style="font-family:-apple-system,Segoe UI,Roboto,sans-serif;line-height:1.5;color:#1d1d1b;max-width:520px">
<p>Thank you for buying <strong>${esc(product)}</strong>.</p>
<p>It's yours for life, on every device you sign in on. There's no subscription and nothing to cancel.</p>
<table style="border-collapse:collapse"><tr><td style="padding:2px 12px 2px 0;color:#5f5e5a">Product</td><td>${esc(product)} (lifetime)</td></tr>
<tr><td style="padding:2px 12px 2px 0;color:#5f5e5a">Bought</td><td>${esc(date)}, through ${esc(store)}</td></tr></table>
<p>This isn't a receipt: ${esc(store)} sends that. If Plus ever goes missing, open Often Enough and sign in, or use Restore Purchases.</p>
<p>Questions? Write to <a href="mailto:support@oftenenough.com">support@oftenenough.com</a> or see <a href="https://oftenenough.com/support">oftenenough.com/support</a>.</p>
<p style="color:#5f5e5a">This is the only email we send you.</p>
</body></html>`;
  return { to, subject: `Your ${product} purchase`, text, html };
}

/** The sender interface (§3): one adapter today, Resend. */
async function sendWithResend(env: EmailEnv, message: Message): Promise<boolean> {
  const response = await fetch("https://api.resend.com/emails", {
    method: "POST",
    headers: { authorization: `Bearer ${env.RESEND_API_KEY}`, "content-type": "application/json" },
    body: JSON.stringify({ from: env.EMAIL_FROM || "Often Enough <hello@oftenenough.com>", to: [message.to], subject: message.subject, text: message.text, html: message.html, reply_to: "support@oftenenough.com" }),
  }).catch(() => null);
  return response?.ok === true;
}

/** Records the job for a newly verified purchase, once ever. True if this call created it (so it should be sent). */
export async function scheduleConfirmation(env: Env, purchase: PurchaseRecord, now = Date.now()): Promise<boolean> {
  if (purchase.revokedAt !== null || now - purchase.purchasedAt > CONFIRM_WITHIN_MS) return false;
  const result = await env.DIRECTORY.prepare(
    "INSERT INTO purchase_email (store, original_id, status, created_at, updated_at) VALUES (?, ?, 'pending', ?, ?) ON CONFLICT DO NOTHING",
  ).bind(purchase.store, purchase.originalId, now, now).run();
  return result.meta.changes === 1;
}

type JobResult = "sent" | "waiting" | "retry" | "failed" | `cancelled:${string}`;

/** Sends one pending job after rechecking everything (§2). Safe to call again; a sent job is never sent twice. */
export async function processConfirmation(env: Env, store: string, originalId: string, now = Date.now()): Promise<JobResult> {
  const db = env.DIRECTORY;
  const job = await db.prepare("SELECT status, attempts FROM purchase_email WHERE store = ? AND original_id = ?").bind(store, originalId).first<{ status: string; attempts: number }>();
  if (!job || job.status !== "pending") return "failed";
  const finish = async (status: string, reason: string | null) => {
    await db.prepare("UPDATE purchase_email SET status = ?, reason = ?, updated_at = ? WHERE store = ? AND original_id = ?").bind(status, reason, now, store, originalId).run();
  };
  const owner = await purchaseOwner(db, store, originalId);
  if (!owner) { await finish("cancelled", "no_account"); return "cancelled:no_account"; }
  const stub = accountStub(env, owner);
  const purchase = (await stub.entitlements())?.purchases.find((p) => p.store === store && p.originalId === originalId);
  if (!purchase) { await finish("cancelled", "no_account"); return "cancelled:no_account"; }
  if (purchase.revokedAt !== null) { await finish("cancelled", "refunded"); return "cancelled:refunded"; }
  const address = (await stub.summary())?.keys.find((k) => k.email)?.email;
  if (!address) { await finish("cancelled", "no_address"); return "cancelled:no_address"; }
  const e = env as EmailEnv;
  if (!e.RESEND_API_KEY) return "waiting";
  // Claim the attempt before sending, so two runs can't both send.
  const claim = await db.prepare("UPDATE purchase_email SET attempts = attempts + 1, updated_at = ? WHERE store = ? AND original_id = ? AND status = 'pending' AND attempts = ?")
    .bind(now, store, originalId, job.attempts).run();
  if (claim.meta.changes !== 1) return "failed";
  if (await sendWithResend(e, confirmationMessage(address, purchase))) {
    await finish("sent", null);
    console.log(JSON.stringify({ event: "purchase_email_sent" }));
    return "sent";
  }
  if (job.attempts + 1 >= MAX_ATTEMPTS) { await finish("failed", "provider"); return "failed"; }
  return "retry";
}

/** The daily cron: retries pending jobs from the last 7 days; older ones fail. */
export async function retryConfirmations(env: Env, now = Date.now()): Promise<{ processed: number }> {
  const db = env.DIRECTORY;
  await db.prepare("UPDATE purchase_email SET status = 'failed', reason = 'expired', updated_at = ? WHERE status = 'pending' AND created_at < ?").bind(now, now - RETRY_FOR_MS).run();
  const jobs = (await db.prepare("SELECT store, original_id FROM purchase_email WHERE status = 'pending' ORDER BY created_at LIMIT 50").all<{ store: string; original_id: string }>()).results;
  for (const job of jobs) await processConfirmation(env, job.store, job.original_id, now);
  return { processed: jobs.length };
}

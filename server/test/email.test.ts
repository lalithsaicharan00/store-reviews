import { env } from "cloudflare:workers";
import { CompactSign, importPKCS8 } from "jose";
import { afterEach, describe, expect, it, vi } from "vitest";
import type { Account } from "../src/account";
import { confirmationMessage, processConfirmation, retryConfirmations } from "../src/email";
import intermediatePem from "./fixtures/test-intermediate.pem?raw";
import leafKeyPem from "./fixtures/test-leaf.pk8?raw";
import leafPem from "./fixtures/test-leaf.pem?raw";
import rootPem from "./fixtures/test-root.pem?raw";
import { call, freeSignIn } from "./helpers";

/** The one email: the purchase confirmation (Architecture/Email Delivery Decision.md §5 acceptance checks). */

afterEach(() => vi.restoreAllMocks());

const withResend = { ...env, RESEND_API_KEY: "re_test" } as unknown as Env;
const der = (pem: string) => pem.replace(/-----[^-]+-----/g, "").replace(/\s/g, "");
async function sign(payload: Record<string, unknown>) {
  return new CompactSign(new TextEncoder().encode(JSON.stringify(payload)))
    .setProtectedHeader({ alg: "ES256", x5c: [leafPem, intermediatePem, rootPem].map(der) })
    .sign(await importPKCS8(leafKeyPem, "ES256"));
}
function transaction(overrides: Record<string, unknown> = {}) {
  const id = String(2_000_000_000 + Math.floor(Math.random() * 1e9));
  const now = Date.now();
  return { transactionId: id, originalTransactionId: id, bundleId: "com.oftenenough.app", productId: "com.oftenenough.app.plus",
    purchaseDate: now, originalPurchaseDate: now, signedDate: now, environment: "Xcode", ...overrides };
}
const stub = (accountId: string) => env.ACCOUNT.get(env.ACCOUNT.idFromName(accountId)) as DurableObjectStub<Account>;

/** A signed-in buyer whose sign-in gave us an address. */
async function buyer(email: string | null = "buyer@example.com") {
  const me = await freeSignIn();
  if (email) await stub(me.json.accountId).addKey({ provider: "test", subject: `addr-${crypto.randomUUID()}`, email, isPrivateEmail: false });
  return me;
}
const verify = async (token: string, t: Record<string, unknown>) => call("POST", "/v1/purchases/verify", { jws: await sign(t) }, token);
const job = (t: { originalTransactionId: string }) =>
  env.DIRECTORY.prepare("SELECT status, reason, attempts FROM purchase_email WHERE store = 'apple' AND original_id = ?").bind(t.originalTransactionId).first<{ status: string; reason: string | null; attempts: number }>();

function resend(ok = true) {
  const sent: any[] = [];
  const realFetch = globalThis.fetch;
  vi.spyOn(globalThis, "fetch").mockImplementation(async (input, init) => {
    const url = typeof input === "string" ? input : input instanceof URL ? input.href : input.url;
    if (!url.startsWith("https://api.resend.com/")) return realFetch(input, init);
    sent.push(JSON.parse(String(init?.body)));
    return ok ? Response.json({ id: "e" }) : new Response("down", { status: 500 });
  });
  return sent;
}

describe("the purchase confirmation", () => {
  it("says only verified things: product, lifetime, date and store; no price; not a receipt", () => {
    const m = confirmationMessage("a@b.c", { productId: "com.oftenenough.app.plusfamily", purchasedAt: Date.UTC(2026, 9, 1, 12), store: "apple" });
    expect(m.subject).toBe("Your Often Enough Plus Family purchase");
    expect(m.text).toContain("Bought: 1 October 2026, through the App Store");
    expect(m.text).toContain("lifetime");
    expect(m.text).toContain("isn't a receipt");
    expect(m.text).not.toMatch(/[$€£₹]|price|invoice/i);
    expect(m.html).toContain("Often Enough Plus Family");
  });

  it("a new purchase gets exactly one email; verifying it again, or restoring it, sends nothing more", async () => {
    const sent = resend();
    const me = await buyer();
    const t = transaction(); // no appAccountToken, so it can be restored on another account later
    expect((await verify(me.json.accessToken, t)).json.plus).toBe(true);
    expect((await job(t))?.status).toBe("pending"); // no Resend key in this environment: it waits
    expect(await processConfirmation(withResend, "apple", t.originalTransactionId)).toBe("sent");
    expect(sent).toHaveLength(1);
    expect(sent[0]).toMatchObject({ to: ["buyer@example.com"], subject: "Your Often Enough Plus purchase" });

    await verify(me.json.accessToken, t);
    await processConfirmation(withResend, "apple", t.originalTransactionId);
    await retryConfirmations(withResend);
    expect(sent).toHaveLength(1);

    // The account is deleted and the purchase restored on a new one: still no second email.
    await call("POST", "/v1/account/delete", {}, me.json.accessToken);
    const again = await buyer("new@example.com");
    expect((await verify(again.json.accessToken, t)).json.plus).toBe(true);
    await retryConfirmations(withResend);
    expect(sent).toHaveLength(1);
  });

  it("a purchase over 30 days old (a 'Not now' buyer signing in late) gets none", async () => {
    const me = await buyer();
    const old = Date.now() - 31 * 86_400_000;
    const t = transaction({ purchaseDate: old, originalPurchaseDate: old });
    await verify(me.json.accessToken, t);
    expect(await job(t)).toBeNull();
  });

  it("refunded before it went out: cancelled, never sent", async () => {
    const sent = resend();
    const me = await buyer();
    const t = transaction();
    await verify(me.json.accessToken, t);
    await stub(me.json.accountId).setRevoked("apple", t.originalTransactionId, Date.now());
    expect(await processConfirmation(withResend, "apple", t.originalTransactionId)).toBe("cancelled:refunded");
    expect(sent).toHaveLength(0);
    expect((await job(t))?.reason).toBe("refunded");
  });

  it("no address on the account: cancelled; account deleted first: cancelled", async () => {
    const sent = resend();
    const silent = await buyer(null);
    const t1 = transaction();
    await verify(silent.json.accessToken, t1);
    expect(await processConfirmation(withResend, "apple", t1.originalTransactionId)).toBe("cancelled:no_address");

    const gone = await buyer();
    const t2 = transaction();
    await verify(gone.json.accessToken, t2);
    await call("POST", "/v1/account/delete", {}, gone.json.accessToken);
    expect(await processConfirmation(withResend, "apple", t2.originalTransactionId)).toBe("cancelled:no_account");
    expect(sent).toHaveLength(0);
  });

  it("a provider failure is retried, and gives up after 5 tries", async () => {
    resend(false);
    const me = await buyer();
    const t = transaction();
    await verify(me.json.accessToken, t);
    for (let i = 0; i < 4; i++) expect(await processConfirmation(withResend, "apple", t.originalTransactionId)).toBe("retry");
    expect(await processConfirmation(withResend, "apple", t.originalTransactionId)).toBe("failed");
    expect(await job(t)).toMatchObject({ status: "failed", attempts: 5 });
  });

  it("pending jobs older than a week are given up by the daily run", async () => {
    const me = await buyer();
    const t = transaction();
    await verify(me.json.accessToken, t);
    await retryConfirmations(env, Date.now() + 8 * 86_400_000);
    expect(await job(t)).toMatchObject({ status: "failed", reason: "expired" });
  });
});

import { createExecutionContext, createScheduledController, waitOnExecutionContext } from "cloudflare:test";
import { env } from "cloudflare:workers";
import { afterEach, beforeAll, beforeEach, describe, expect, it, vi } from "vitest";
import { Accounts, DAY_MS } from "../src/accounts";
import { clearKeyCache } from "../src/identity";
import { clearPlayToken } from "../src/play";
import { SWEEP_MAX_HELD, SWEEP_OVERLAP_MS, sweepVoided } from "../src/refunds";
import worker from "../src/worker";
import {
  APPLE_KEYS, GOOGLE_KEYS, PUBSUB, bought, call, createAccount, joinFamily, mockGoogle, newKey, person, play, published, pubsubToken, pushNotification,
  rtdn, sha256Hex,
} from "./helpers";

/*
 * Google Play refunds end Plus within seconds: Real-time developer notifications pushed by Pub/Sub, the Voided Purchases
 * API every day as the backstop, and a void that is final (src/refunds.ts; README, "Refunds").
 */

const PLUS = "com.oftenenough.app.plus";
const FAMILY = "com.oftenenough.app.plusfamily";
const UPGRADE = "com.oftenenough.app.plusfamily.upgrade";

beforeAll(async () => {
  published[GOOGLE_KEYS] = [await newKey("google-1")];
  published[APPLE_KEYS] = [await newKey("apple-1")];
});
beforeEach(async () => {
  mockGoogle();
  clearKeyCache();
  clearPlayToken();
  play.mode = "ok";
  play.voided = [];
  play.voidedPageSize = 1000;
  play.voidedQueries = [];
  await env.DB.prepare("DELETE FROM worker_state").run();
});
afterEach(() => vi.restoreAllMocks());

/** [db], counting every call that reaches D1 (a statement run, or one batch): the Workers Free plan allows 1,000 a run. */
function counting(db: D1Database) {
  let calls = 0;
  const real = new WeakMap<object, D1PreparedStatement>();
  const wrap = (stmt: D1PreparedStatement): D1PreparedStatement => {
    const proxy = new Proxy(stmt, {
      get(target, prop) {
        const value = Reflect.get(target, prop);
        if (prop === "bind") return (...args: unknown[]) => wrap(target.bind(...args));
        if (prop === "first" || prop === "all" || prop === "run" || prop === "raw") {
          return (...args: unknown[]) => { calls++; return (value as (...a: unknown[]) => unknown).apply(target, args); };
        }
        return typeof value === "function" ? value.bind(target) : value;
      },
    });
    real.set(proxy, stmt);
    return proxy;
  };
  const counted = new Proxy(db, {
    get(target, prop) {
      if (prop === "prepare") return (query: string) => wrap(target.prepare(query));
      if (prop === "batch") return (statements: D1PreparedStatement[]) => { calls++; return target.batch(statements.map((s) => real.get(s) ?? s)); };
      const value = Reflect.get(target, prop);
      return typeof value === "function" ? value.bind(target) : value;
    },
  });
  return { db: counted, calls: () => calls };
}

const plusOf = async (session: string) => (await call("GET", "/v1/account", { session })).body.account.plus as string;

describe("a refund notification ends Plus at once", () => {
  it("a refunded Plus stops counting as soon as the notification arrives, with no waiting for a re-check", async () => {
    const p = bought(PLUS);
    const sam = await createAccount(person("Sam"), p);
    expect(sam.account.plus).toBe("PLUS");
    const requests = play.purchaseRequests;
    expect((await pushNotification(rtdn.voided(p.token))).status).toBe(204);
    expect(await plusOf(sam.session)).toBe("NONE");
    // The void is Google's own word: it needs no extra question to the Play Developer API.
    expect(play.purchaseRequests).toBe(requests);
  });

  it("a refunded Plus Family ends the family for everyone in it, exactly as any refund", async () => {
    const p = bought(FAMILY);
    const lee = await createAccount(person("Lee"), p);
    const { member, token } = await joinFamily(lee.session, "Priya");
    expect(member.account.plus).toBe("FAMILY_MEMBER");
    await pushNotification(rtdn.voided(p.token));
    expect(await plusOf(lee.session)).toBe("NONE");
    expect((await call("GET", "/v1/account", { session: member.session })).body.account).toMatchObject({ plus: "NONE", family: null });
    expect((await call("GET", `/v1/invites/${token}`)).body).toEqual({ state: "cancelled", owner: "Lee" });
  });

  it("a refunded upgrade keeps Plus and ends the family; a refunded Plus under the upgrade ends both (paidFor)", async () => {
    const plus = bought(PLUS);
    const upgrade = bought(UPGRADE);
    const ana = await createAccount(person("Ana"), plus);
    await call("POST", "/v1/account/purchases", { session: ana.session, body: upgrade });
    const { member } = await joinFamily(ana.session, "Priya");
    await pushNotification(rtdn.voided(upgrade.token));
    expect(await plusOf(ana.session)).toBe("PLUS");
    expect(await plusOf(member.session)).toBe("NONE");

    const plus2 = bought(PLUS);
    const upgrade2 = bought(UPGRADE);
    const bo = await createAccount(person("Bo"), plus2);
    await call("POST", "/v1/account/purchases", { session: bo.session, body: upgrade2 });
    expect(await plusOf(bo.session)).toBe("FAMILY_OWNER");
    await pushNotification(rtdn.voided(plus2.token));
    expect(await plusOf(bo.session)).toBe("NONE");
  });

  it("a cancelled one-time purchase is checked with Google, and ends Plus when Google says cancelled", async () => {
    const p = bought(PLUS);
    const sam = await createAccount(person("Sam"), p);
    // Purchased again (Pub/Sub may deliver one late): checked, nothing changes.
    expect((await pushNotification(rtdn.oneTime(p.token, 1))).status).toBe(204);
    expect(await plusOf(sam.session)).toBe("PLUS");
    play.purchases.get(p.token)!.purchaseState = 1; // revoked on Google Play
    const requests = play.purchaseRequests;
    expect((await pushNotification(rtdn.oneTime(p.token, 2))).status).toBe(204);
    expect(play.purchaseRequests).toBe(requests + 1);
    expect(await plusOf(sam.session)).toBe("NONE");
  });

  it("when Google can't be asked, answers 503 so Pub/Sub delivers it again, and the retry ends Plus", async () => {
    const p = bought(PLUS);
    const sam = await createAccount(person("Sam"), p);
    play.purchases.get(p.token)!.purchaseState = 1;
    play.mode = "down";
    const first = await pushNotification(rtdn.oneTime(p.token, 2));
    expect(first.status).toBe(503);
    expect(await plusOf(sam.session)).toBe("PLUS"); // never taken away on a guess
    play.mode = "ok";
    expect((await pushNotification(rtdn.oneTime(p.token, 2), { messageId: first.messageId })).status).toBe(204);
    expect(await plusOf(sam.session)).toBe("NONE");
  });

  it("a message delivered twice is handled once (Google: check messageId)", async () => {
    const p = bought(PLUS);
    await createAccount(person("Sam"), p);
    const first = await pushNotification(rtdn.oneTime(p.token, 1));
    const requests = play.purchaseRequests;
    expect((await pushNotification(rtdn.oneTime(p.token, 1), { messageId: first.messageId })).status).toBe(204);
    expect(play.purchaseRequests).toBe(requests);
  });

  it("acknowledges what changes nothing: the test message, another app, a subscription, a partial refund, unreadable data", async () => {
    const p = bought(PLUS);
    const sam = await createAccount(person("Sam"), p);
    const other = { ...rtdn.voided(p.token), packageName: "com.someone.else" };
    for (const n of [rtdn.test(), other, rtdn.voided(p.token, 1, 1), rtdn.voided(p.token, 2), { raw: "not base64 json!" }, { raw: btoa("[1,2]") }]) {
      expect((await pushNotification(n)).status, JSON.stringify(n)).toBe(204);
    }
    expect(await plusOf(sam.session)).toBe("PLUS");
    // A notification for a purchase no account holds yet changes no account.
    expect((await pushNotification(rtdn.oneTime(bought(PLUS).token, 2))).status).toBe(204);
  });

  it("never logs a purchase token or a message body (D11)", async () => {
    const lines: string[] = [];
    for (const level of ["log", "error", "warn", "info"] as const) vi.spyOn(console, level).mockImplementation((...a: unknown[]) => void lines.push(a.join(" ")));
    const p = bought(PLUS);
    await createAccount(person("Sam"), p);
    const push = await pushNotification(rtdn.voided(p.token));
    await pushNotification(rtdn.oneTime(p.token, 2));
    expect(lines.length).toBeGreaterThan(0);
    for (const line of lines) {
      expect(line).not.toContain(p.token);
      expect(line).not.toContain(btoa(JSON.stringify(rtdn.voided(p.token))).slice(0, 40));
      expect(line).not.toContain(push.messageId);
    }
  });
});

describe("only Pub/Sub, as our push service account, may push", () => {
  it("refuses a push without a token, or with one that isn't Pub/Sub's for this subscription", async () => {
    const p = bought(PLUS);
    const sam = await createAccount(person("Sam"), p);
    const stranger = await newKey("not-google");
    const wrong: Record<string, string | null> = {
      "no token": null,
      "made up": "x".repeat(40),
      "another audience": await pubsubToken({ audience: "https://api.oftenenough.com/v1/google/notifications" }),
      "another service account": await pubsubToken({ email: "someone@else.iam.gserviceaccount.com" }),
      "an unverified email": await pubsubToken({ emailVerified: false }),
      "another issuer": await pubsubToken({ issuer: "https://evil.example" }),
      "not signed by Google": await pubsubToken({ key: stranger }),
      "expired": await pubsubToken({ expiresIn: -120 }),
    };
    for (const [what, token] of Object.entries(wrong)) {
      const reply = await pushNotification(rtdn.voided(p.token), { token });
      expect(reply.status, what).toBe(401);
      expect(reply.body.error, what).toBe("unauthorized");
    }
    expect(await plusOf(sam.session)).toBe("PLUS");
    // The right one, and Plus ends.
    expect((await pushNotification(rtdn.voided(p.token))).status).toBe(204);
    expect(await plusOf(sam.session)).toBe("NONE");
    expect(PUBSUB.audience).toBe(env.GOOGLE_PUBSUB_AUDIENCE);
  });
});

describe("a void is final", () => {
  it("a token voided before any account sent it never gives Plus, even while Google's check still says purchased", async () => {
    const p = bought(PLUS);
    await pushNotification(rtdn.voided(p.token));
    const sam = await createAccount(person("Sam"), p); // play.purchases still answers purchased
    expect(sam.account.plus).toBe("NONE");
    const again = await call("POST", "/v1/account/purchases", { session: sam.session, body: p });
    expect(again.body).toMatchObject({ purchase: "not_bought", account: { plus: "NONE" } });
    const row = await env.DB.prepare("SELECT source FROM voided_purchases WHERE token_hash = ?").bind(await sha256Hex(p.token)).first();
    expect(row).toEqual({ source: "notification" });
  });

  it("a refunded purchase sent again by the app stays refunded", async () => {
    const p = bought(PLUS);
    const sam = await createAccount(person("Sam"), p);
    await pushNotification(rtdn.voided(p.token));
    expect((await call("POST", "/v1/account/purchases", { session: sam.session, body: p })).body).toMatchObject({ purchase: "not_bought", account: { plus: "NONE" } });
    // A new purchase is a new token: it counts.
    expect((await call("POST", "/v1/account/purchases", { session: sam.session, body: bought(PLUS) })).body.account.plus).toBe("PLUS");
  });

  it("a refund found by the daily re-check is final too", async () => {
    const p = bought(PLUS);
    const sam = await createAccount(person("Sam"), p);
    play.purchases.get(p.token)!.purchaseState = 1;
    await call("POST", "/v1/account/purchases", { session: sam.session, body: p });
    play.purchases.get(p.token)!.purchaseState = 0; // Google's answer flips back: the void still stands
    expect((await call("POST", "/v1/account/purchases", { session: sam.session, body: p })).body.account.plus).toBe("NONE");
  });
});

describe("the daily sweep of the Voided Purchases API (the backstop)", () => {
  const accounts = () => new Accounts(env.DB);

  it("ends Plus for a refund whose notification never came, and remembers voids no account holds", async () => {
    const p = bought(FAMILY);
    const lee = await createAccount(person("Lee"), p);
    const { member } = await joinFamily(lee.session, "Priya");
    const unheld = bought(PLUS);
    play.voided.push({ purchaseToken: p.token, seenAt: Date.now() - 1000 }, { purchaseToken: unheld.token, seenAt: Date.now() - 2000 });
    expect(await sweepVoided(env, accounts())).toEqual({ voided: 2, held: 1, done: true });
    expect(await plusOf(lee.session)).toBe("NONE");
    expect(await plusOf(member.session)).toBe("NONE");
    expect((await createAccount(person("Sam"), unheld)).account.plus).toBe("NONE");
  });

  it("starts 30 days back, then from the last sweep with an hour's overlap; a failed sweep is done again", async () => {
    const now = Date.now();
    await sweepVoided(env, accounts(), now);
    expect(play.voidedQueries.at(-1)!.startTime).toBeGreaterThanOrEqual(now - 30 * DAY_MS);
    expect(play.voidedQueries.at(-1)!.startTime).toBeLessThan(now - 29 * DAY_MS);
    expect(play.voidedQueries.at(-1)!.endTime).toBe(now);
    const later = now + 3600_000;
    await sweepVoided(env, accounts(), later);
    expect(play.voidedQueries.at(-1)).toMatchObject({ startTime: now - SWEEP_OVERLAP_MS, endTime: later });

    play.mode = "down";
    await expect(sweepVoided(env, accounts(), later + 3600_000)).rejects.toMatchObject({ status: 503 });
    play.mode = "ok";
    await sweepVoided(env, accounts(), later + 7200_000);
    expect(play.voidedQueries.at(-1)!.startTime).toBe(later - SWEEP_OVERLAP_MS); // the cursor didn't move on the failure
  });

  it("reads every page", async () => {
    play.voidedPageSize = 2;
    const people = await Promise.all([1, 2, 3, 4, 5].map(async (i) => {
      const p = bought(PLUS);
      const made = await createAccount(person(`P${i}`), p);
      play.voided.push({ purchaseToken: p.token, seenAt: Date.now() - i * 1000 });
      return made;
    }));
    expect(await sweepVoided(env, accounts())).toEqual({ voided: 5, held: 5, done: true });
    expect(play.voidedQueries.map((q) => q.token)).toEqual([null, "2", "4"]);
    for (const p of people) expect(await plusOf(p.session)).toBe("NONE");
  });

  it("stays within the Workers Free plan's 1,000 database calls a run; what doesn't fit is done the next day", async () => {
    // 3,000 voids in the window, 200 of them held by an account: more than one run may end (SWEEP_MAX_HELD).
    const owner = crypto.randomUUID();
    await env.DB.prepare("INSERT INTO accounts (id, provider, subject, name, created_at, seen_at) VALUES (?, 'google', ?, 'Big', 0, 0)").bind(owner, `big-${owner}`).run();
    const heldTokens = Array.from({ length: 200 }, (_, i) => `held-${i}-${crypto.randomUUID()}`);
    for (let i = 0; i < heldTokens.length; i += 20) {
      const chunk = heldTokens.slice(i, i + 20);
      const rows = await Promise.all(chunk.map(async (t) => [await sha256Hex(t), t, owner, PLUS, 0]));
      await env.DB.prepare(`INSERT INTO purchases (token_hash, token, account_id, store, product, active, checked_at) VALUES ${chunk.map(() => "(?, ?, ?, 'google', ?, 1, ?)").join(", ")}`)
        .bind(...rows.flat()).run();
    }
    const now = Date.now();
    play.voided = [
      ...heldTokens.map((purchaseToken, i) => ({ purchaseToken, seenAt: now - 1000 - i })),
      ...Array.from({ length: 2800 }, (_, i) => ({ purchaseToken: `other-${i}-${crypto.randomUUID()}`, seenAt: now - 5000 - i })),
    ];
    const first = counting(env.DB);
    expect(await sweepVoided(env, new Accounts(first.db), now)).toMatchObject({ held: SWEEP_MAX_HELD, done: false });
    expect(first.calls()).toBeGreaterThan(SWEEP_MAX_HELD); // the counter sees every call
    expect(first.calls()).toBeLessThan(1000);
    expect(await env.DB.prepare("SELECT value FROM worker_state WHERE key = 'voided_until'").first()).toBeNull(); // not moved on
    const second = counting(env.DB);
    expect(await sweepVoided(env, new Accounts(second.db), now + 3600_000)).toMatchObject({ held: 200 - SWEEP_MAX_HELD, done: true });
    expect(second.calls()).toBeLessThan(1000);
    const left = await env.DB.prepare("SELECT COUNT(*) AS n FROM purchases WHERE account_id = ? AND active = 1").bind(owner).first<{ n: number }>();
    expect(left?.n).toBe(0);
    expect((await env.DB.prepare("SELECT COUNT(*) AS n FROM voided_purchases WHERE source = 'voided_api'").first<{ n: number }>())!.n).toBeGreaterThanOrEqual(3000);
  });

  it("the one daily trigger tidies and sweeps", async () => {
    const p = bought(PLUS);
    const sam = await createAccount(person("Sam"), p);
    play.voided.push({ purchaseToken: p.token, seenAt: Date.now() - 1000 });
    const oldMessage = await pushNotification(rtdn.test());
    await env.DB.prepare("UPDATE play_notifications SET received_at = ? WHERE message_id = ?").bind(Date.now() - 31 * DAY_MS, oldMessage.messageId).run();
    expect(await plusOf(sam.session)).toBe("PLUS");
    const ctx = createExecutionContext();
    await worker.scheduled(createScheduledController({ cron: "0 5 * * *", scheduledTime: Date.now() }), env, ctx);
    await waitOnExecutionContext(ctx);
    expect(await plusOf(sam.session)).toBe("NONE"); // swept
    expect(await env.DB.prepare("SELECT 1 AS x FROM play_notifications WHERE message_id = ?").bind(oldMessage.messageId).first()).toBeNull(); // tidied
  });

  it("the daily tidy forgets handled message IDs after 30 days, never a void", async () => {
    const p = bought(PLUS);
    const push = await pushNotification(rtdn.voided(p.token));
    await env.DB.prepare("UPDATE play_notifications SET received_at = ? WHERE message_id = ?").bind(Date.now() - 31 * DAY_MS, push.messageId).run();
    await accounts().tidy();
    expect(await env.DB.prepare("SELECT 1 AS x FROM play_notifications WHERE message_id = ?").bind(push.messageId).first()).toBeNull();
    expect(await env.DB.prepare("SELECT 1 AS x FROM voided_purchases WHERE token_hash = ?").bind(await sha256Hex(p.token)).first()).not.toBeNull();
  });
});

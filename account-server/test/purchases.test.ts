import { env } from "cloudflare:workers";
import { beforeAll, beforeEach, describe, expect, it } from "vitest";
import { clearKeyCache } from "../src/identity";
import { checkPlayPurchase, clearPlayToken, googleAccess } from "../src/play";
import { APPLE_KEYS, GOOGLE_KEYS, bought, call, createAccount, eventually, joinFamily, mockGoogle, newKey, person, play, published, sha256Hex, signIn } from "./helpers";

beforeAll(async () => {
  published[GOOGLE_KEYS] = [await newKey("google-1")];
  published[APPLE_KEYS] = [await newKey("apple-1")];
});
beforeEach(() => {
  mockGoogle();
  clearKeyCache();
  clearPlayToken();
  play.mode = "ok";
});

const PLUS = "com.oftenenough.app.plus";
const FAMILY = "com.oftenenough.app.plusfamily";
const UPGRADE = "com.oftenenough.app.plusfamily.upgrade";

async function age(token: string, days: number) {
  await env.DB.prepare("UPDATE purchases SET checked_at = ? WHERE token_hash = ?").bind(Date.now() - days * 86_400_000, await sha256Hex(token)).run();
}

describe("purchases are checked with Google Play", () => {
  it("gives Plus for a purchase Google says was bought, signing in to Google keyless (Workload Identity Federation)", async () => {
    const made = await createAccount(person("Sam"), bought(PLUS));
    expect(made.account.plus).toBe("PLUS");
    expect(play.tokenRequests).toBe(1);
    // The access token is reused, not asked for per purchase.
    await createAccount(person("Ana"), bought(PLUS));
    expect(play.tokenRequests).toBe(1);
  });

  it("gives nothing for a purchase that isn't paid, was cancelled, or isn't ours", async () => {
    expect((await createAccount(person("A"), bought(PLUS, 2))).account.plus).toBe("NONE"); // pending
    expect((await createAccount(person("B"), bought(PLUS, 1))).account.plus).toBe("NONE"); // cancelled
    expect((await createAccount(person("C"), { product: PLUS, token: "made-up-token" })).account.plus).toBe("NONE");
    const wrongProduct = bought(PLUS);
    expect((await createAccount(person("D"), { product: FAMILY, token: wrongProduct.token })).account.plus).toBe("NONE");
    const notOurs = await call("POST", "/v1/accounts", { body: { provider: "google", idToken: "x", nonce: "y", purchase: { product: "com.other.app", token: "t" } } });
    expect(notOurs.status).toBe(401); // the sign-in is checked first; a product not ours is refused after it
  });

  it("makes the account even when Google Play can't be asked, and takes the purchase when it's sent again", async () => {
    play.mode = "down";
    const p = bought(PLUS);
    const made = await createAccount(person("Sam"), p);
    expect(made.account.plus).toBe("NONE");
    const again = await call("POST", "/v1/account/purchases", { session: made.session, body: p });
    expect(again.status).toBe(503); // the app keeps it and sends it again later
    play.mode = "ok";
    const later = await call("POST", "/v1/account/purchases", { session: made.session, body: p });
    expect(later.body).toMatchObject({ purchase: "added", account: { plus: "PLUS" } });
    // Sending it again changes nothing.
    expect((await call("POST", "/v1/account/purchases", { session: made.session, body: p })).body.account.plus).toBe("PLUS");
  });

  it("answers 503 when the service account has no access, never giving Plus", async () => {
    play.mode = "refused";
    const made = await createAccount(person("Sam"));
    const reply = await call("POST", "/v1/account/purchases", { session: made.session, body: bought(PLUS) });
    expect(reply.status).toBe(503);
    expect(reply.body.error).toBe("store_unavailable");
  });

  it("says purchases aren't set up when the signing key is missing or broken, or Google's side isn't set up yet", async () => {
    const google = googleAccess(env);
    await expect(checkPlayPurchase({ ...google, signingKey: undefined }, "com.oftenenough.app", PLUS, "t")).rejects.toMatchObject({ status: 503, code: "purchases_not_configured" });
    await expect(checkPlayPurchase({ ...google, signingKey: "not a key" }, "com.oftenenough.app", PLUS, "t")).rejects.toMatchObject({ status: 503, code: "purchases_not_configured" });
    await expect(checkPlayPurchase(google, "com.oftenenough.app", "com.other.thing", "t")).resolves.toMatchObject({ state: "unknown" });
    // Google refuses our token (the pool or provider isn't made, or the public key isn't uploaded) …
    play.mode = "sts-refused";
    await expect(checkPlayPurchase(google, "com.oftenenough.app", PLUS, bought(PLUS).token)).rejects.toMatchObject({ status: 503, code: "purchases_not_configured" });
    // … or the pool's subject may not act as the service account.
    play.mode = "iam-refused";
    clearPlayToken();
    await expect(checkPlayPurchase(google, "com.oftenenough.app", PLUS, bought(PLUS).token)).rejects.toMatchObject({ status: 503, code: "purchases_not_configured" });
  });

  it("says whether keyless Google sign-in works, without showing a token", async () => {
    clearPlayToken();
    expect((await call("GET", "/v1/health/play")).body).toEqual({ play: "ready" });
    clearPlayToken();
    play.mode = "sts-refused";
    const refused = await call("GET", "/v1/health/play");
    expect(refused.status).toBe(503);
    expect(refused.body).toEqual({ play: "not_set_up" });
    clearPlayToken();
    play.mode = "down";
    expect((await call("GET", "/v1/health/play")).body).toEqual({ play: "unavailable" });
  });

  it("signs a token Google accepts only for this provider: another subject, key ID or audience is refused", async () => {
    const google = googleAccess(env);
    for (const wrong of [{ subject: "someone-else" }, { keyId: "another-key" }, { pool: "another-pool" }, { issuer: "https://evil.example" }]) {
      clearPlayToken();
      await expect(checkPlayPurchase({ ...google, ...wrong }, "com.oftenenough.app", PLUS, bought(PLUS).token), JSON.stringify(wrong))
        .rejects.toMatchObject({ code: "purchases_not_configured" });
    }
    clearPlayToken();
    await expect(checkPlayPurchase(google, "com.oftenenough.app", PLUS, bought(PLUS).token)).resolves.toMatchObject({ state: "purchased" });
  });

  it("refuses a product that isn't ours", async () => {
    const made = await createAccount(person("Sam"));
    const reply = await call("POST", "/v1/account/purchases", { session: made.session, body: { product: "com.other.app", token: "t" } });
    expect(reply.status).toBe(400);
  });

  it("keeps a license tester's purchase, marked as a test", async () => {
    const p = bought(PLUS, 0, 0);
    const made = await createAccount(person("Tester"), p);
    expect(made.account.plus).toBe("PLUS");
    const row = await env.DB.prepare("SELECT test, order_id FROM purchases WHERE token_hash = ?").bind(await sha256Hex(p.token)).first();
    expect(row).toMatchObject({ test: 1 });
  });

  it("gives one purchase to one account; deleting that account frees it", async () => {
    const p = bought(PLUS);
    const first = person("Sam");
    const sam = await createAccount(first, p);
    const ana = await createAccount(person("Ana"));
    const taken = await call("POST", "/v1/account/purchases", { session: ana.session, body: p });
    expect(taken.body).toMatchObject({ purchase: "in_use", account: { plus: "NONE" } });
    // Sam deletes the account (signing in again to confirm): the purchase is free for whoever signs in next.
    const { idToken: t, nonce } = await (await import("./helpers")).idToken(first);
    expect((await call("POST", "/v1/account/delete", { session: sam.session, body: { provider: "google", idToken: t, nonce } })).body).toEqual({ deleted: true });
    expect((await call("POST", "/v1/account/purchases", { session: ana.session, body: p })).body).toMatchObject({ purchase: "added", account: { plus: "PLUS" } });
  });
});

describe("Plus Family", () => {
  it("makes the buyer a family owner, with the upgrade too", async () => {
    const owner = await createAccount(person("Lee"), bought(FAMILY));
    expect(owner.account.plus).toBe("FAMILY_OWNER");
    expect(owner.account.family).toEqual({ owner: "Lee", people: [{ id: owner.account.id, name: "Lee", owner: true, you: true, joinedDay: null }], invite: null });
    const upgrader = await createAccount(person("Sam"), bought(PLUS));
    const upgraded = await call("POST", "/v1/account/purchases", { session: upgrader.session, body: bought(UPGRADE) });
    expect(upgraded.body.account.plus).toBe("FAMILY_OWNER");
    // Buying it again makes no second family.
    await call("POST", "/v1/account/purchases", { session: upgrader.session, body: bought(FAMILY) });
    const families = await env.DB.prepare("SELECT COUNT(*) AS n FROM families WHERE owner_id = ?").bind(upgrader.account.id).first<{ n: number }>();
    expect(families?.n).toBe(1);
  });

  it("the upgrade alone gives nothing: it's only the difference, so it needs Plus beside it", async () => {
    const sneaky = await createAccount(person("Sam"), bought(UPGRADE));
    expect(sneaky.account).toMatchObject({ plus: "NONE", family: null });
    // Plus arriving after it (the app sends every purchase, in any order) completes the family.
    const both = await call("POST", "/v1/account/purchases", { session: sneaky.session, body: bought(PLUS) });
    expect(both.body.account.plus).toBe("FAMILY_OWNER");
  });

  it("refunding Plus under an upgrade ends the family; refunding the upgrade keeps Plus", async () => {
    const plus = bought(PLUS);
    const upgrade = bought(UPGRADE);
    const a = await createAccount(person("Ana"), plus);
    expect((await call("POST", "/v1/account/purchases", { session: a.session, body: upgrade })).body.account.plus).toBe("FAMILY_OWNER");
    const { member } = await joinFamily(a.session, "Priya");
    play.purchases.get(upgrade.token)!.purchaseState = 1; // the upgrade refunded
    await age(upgrade.token, 2);
    await call("GET", "/v1/account", { session: a.session });
    await eventually(async () => (await call("GET", "/v1/account", { session: a.session })).body.account.plus === "PLUS");
    expect((await call("GET", "/v1/account", { session: member.session })).body.account).toMatchObject({ plus: "NONE", family: null });

    const plus2 = bought(PLUS);
    const upgrade2 = bought(UPGRADE);
    const b = await createAccount(person("Bo"), plus2);
    await call("POST", "/v1/account/purchases", { session: b.session, body: upgrade2 });
    play.purchases.get(plus2.token)!.purchaseState = 1; // Plus refunded: the upgrade alone pays for nothing
    await age(plus2.token, 2);
    await call("GET", "/v1/account", { session: b.session });
    await eventually(async () => (await call("GET", "/v1/account", { session: b.session })).body.account.plus === "NONE");
  });

  it("someone in a family who buys Plus Family leaves it and owns their own", async () => {
    const lee = await createAccount(person("Lee"), bought(FAMILY));
    const { member } = await joinFamily(lee.session, "Priya");
    expect(member.account.plus).toBe("FAMILY_MEMBER");
    const own = await call("POST", "/v1/account/purchases", { session: member.session, body: bought(FAMILY) });
    expect(own.body.account.plus).toBe("FAMILY_OWNER");
    expect(own.body.account.family.people).toHaveLength(1);
    const leeNow = await call("GET", "/v1/account", { session: lee.session });
    expect(leeNow.body.account.family.people).toHaveLength(1);
  });
});

describe("refunds reach the account", () => {
  it("a purchase not checked for a day is checked again; refunded, Plus stops", async () => {
    const p = bought(PLUS);
    const sam = await createAccount(person("Sam"), p);
    play.purchases.get(p.token)!.purchaseState = 1; // refunded on Google Play
    // Checked less than a day ago: not asked again.
    const requests = play.purchaseRequests;
    await call("GET", "/v1/account", { session: sam.session });
    expect(play.purchaseRequests).toBe(requests);
    await age(p.token, 2);
    await call("GET", "/v1/account", { session: sam.session });
    await eventually(async () => (await call("GET", "/v1/account", { session: sam.session })).body.account.plus === "NONE");
  });

  it("a refunded Plus Family ends the family: everyone in it loses Plus, keeps their account", async () => {
    const p = bought(FAMILY);
    const lee = await createAccount(person("Lee"), p);
    const { member, token } = await joinFamily(lee.session, "Priya");
    expect(member.account.plus).toBe("FAMILY_MEMBER");
    play.purchases.get(p.token)!.purchaseState = 1;
    await age(p.token, 2);
    await call("GET", "/v1/account", { session: lee.session });
    await eventually(async () => (await call("GET", "/v1/account", { session: lee.session })).body.account.plus === "NONE");
    const priya = await call("GET", "/v1/account", { session: member.session });
    expect(priya.body.account).toMatchObject({ plus: "NONE", family: null });
    // An invite to a family that has ended reads "cancelled", as in the app's stand-in.
    expect((await call("GET", `/v1/invites/${token}`)).body).toEqual({ state: "cancelled", owner: "Lee" });
  });

  it("never takes Plus away because Google couldn't be asked or didn't know the token", async () => {
    const p = bought(PLUS);
    const sam = await createAccount(person("Sam"), p);
    await age(p.token, 2);
    play.mode = "down";
    await call("GET", "/v1/account", { session: sam.session });
    play.mode = "ok";
    play.purchases.delete(p.token); // Google answers "Invalid Value"
    await age(p.token, 2);
    await call("GET", "/v1/account", { session: sam.session });
    await eventually(async () => {
      const row = await env.DB.prepare("SELECT checked_at FROM purchases WHERE token_hash = ?").bind(await sha256Hex(p.token)).first<{ checked_at: number }>();
      return (row?.checked_at ?? 0) > Date.now() - 60_000;
    });
    expect((await call("GET", "/v1/account", { session: sam.session })).body.account.plus).toBe("PLUS");
  });

  it("a purchase bought again after a refund counts again", async () => {
    const p = bought(PLUS);
    const sam = await createAccount(person("Sam"), p);
    play.purchases.get(p.token)!.purchaseState = 1;
    await age(p.token, 2);
    await call("GET", "/v1/account", { session: sam.session });
    await eventually(async () => (await call("GET", "/v1/account", { session: sam.session })).body.account.plus === "NONE");
    const again = await call("POST", "/v1/account/purchases", { session: sam.session, body: bought(PLUS) });
    expect(again.body.account.plus).toBe("PLUS");
    // Signing in on another device shows the same.
    expect((await signIn({ provider: "google", subject: (await env.DB.prepare("SELECT subject FROM accounts WHERE id = ?").bind(sam.account.id).first<{ subject: string }>())!.subject })).body.account.plus).toBe("PLUS");
  });
});

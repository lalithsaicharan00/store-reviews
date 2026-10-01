import { CompactSign, importPKCS8 } from "jose";
import { describe, expect, it } from "vitest";
import { APPLE_ROOT_CA_G3 } from "../src/apple";
import intermediatePem from "./fixtures/test-intermediate.pem?raw";
import leafKeyPem from "./fixtures/test-leaf.pk8?raw";
import leafPem from "./fixtures/test-leaf.pem?raw";
import rootPem from "./fixtures/test-root.pem?raw";
import { call, freeSignIn } from "./helpers";

/** Signs like the App Store: an ES256 JWS with the certificate chain in its header. */
const der = (pem: string) => pem.replace(/-----[^-]+-----/g, "").replace(/\s/g, "");
async function appleSign(payload: Record<string, unknown>, chain = [leafPem, intermediatePem, rootPem]) {
  const key = await importPKCS8(leafKeyPem, "ES256");
  return new CompactSign(new TextEncoder().encode(JSON.stringify(payload)))
    .setProtectedHeader({ alg: "ES256", x5c: chain.map(der) })
    .sign(key);
}

function transaction(overrides: Record<string, unknown> = {}) {
  const now = Date.now();
  const id = String(2_000_000_000 + Math.floor(Math.random() * 1e9));
  return {
    transactionId: id, originalTransactionId: id, bundleId: "com.oftenenough.app", productId: "com.oftenenough.app.plus",
    purchaseDate: now, originalPurchaseDate: now, quantity: 1, type: "Non-Consumable", inAppOwnershipType: "PURCHASED",
    signedDate: now, environment: "Xcode", storefront: "IND", ...overrides,
  };
}

async function verify(accessToken: string, payload: Record<string, unknown>, chain?: string[]) {
  return call("POST", "/v1/purchases/verify", { jws: await appleSign(payload, chain) }, accessToken);
}

describe("verifying App Store purchases", () => {
  it("a genuine Plus purchase unlocks Plus on the account; repeating it changes nothing", async () => {
    const me = await freeSignIn();
    const t = transaction({ appAccountToken: me.json.accountId });
    const first = await verify(me.json.accessToken, t);
    expect(first.status).toBe(200);
    expect(first.json).toMatchObject({ plus: true, family: false });
    expect((await verify(me.json.accessToken, t)).json.purchases).toHaveLength(1);
    expect((await call("GET", "/v1/purchases", undefined, me.json.accessToken)).json.plus).toBe(true);
  });

  it("Plus Family unlocks Plus and the family plan", async () => {
    const me = await freeSignIn();
    const { json } = await verify(me.json.accessToken, transaction({ productId: "com.oftenenough.app.plusfamily" }));
    expect(json).toMatchObject({ plus: true, family: true });
  });

  it("a purchase made while signed out (no account token) can be linked at sign-in", async () => {
    const me = await freeSignIn();
    expect((await verify(me.json.accessToken, transaction())).json.plus).toBe(true);
  });

  it.each([
    ["signed by a chain that doesn't lead to a trusted root", () => transaction(), [leafPem, intermediatePem, APPLE_ROOT_CA_G3]],
    ["signed with the leaf alone", () => transaction(), [leafPem, leafPem, rootPem]],
    ["for another app", () => transaction({ bundleId: "com.someone.else" }), undefined],
    ["for a product we don't sell", () => transaction({ productId: "com.oftenenough.app.coins" }), undefined],
    ["signed in the future", () => transaction({ signedDate: Date.now() + 3_600_000 }), undefined],
  ])("refuses a purchase %s", async (_name, make, chain) => {
    const me = await freeSignIn();
    const { status, json } = await verify(me.json.accessToken, make(), chain);
    expect(status).toBe(400);
    expect(json.error).toBe("not_verified");
    expect((await call("GET", "/v1/purchases", undefined, me.json.accessToken)).json.plus).toBe(false);
  });

  it("refuses a transaction whose payload was altered after Apple signed it", async () => {
    const me = await freeSignIn();
    const [header, , signature] = (await appleSign(transaction())).split(".");
    const forged = btoa(JSON.stringify(transaction({ productId: "com.oftenenough.app.plusfamily" }))).replace(/=+$/, "").replace(/\+/g, "-").replace(/\//g, "_");
    const { status } = await call("POST", "/v1/purchases/verify", { jws: `${header}.${forged}.${signature}` }, me.json.accessToken);
    expect(status).toBe(400);
  });

  it("refuses a purchase bought for a different account", async () => {
    const me = await freeSignIn();
    const { status, json } = await verify(me.json.accessToken, transaction({ appAccountToken: crypto.randomUUID() }));
    expect(status).toBe(409);
    expect(json.error).toBe("purchase_for_another_account");
  });

  it("one purchase can't unlock two accounts, until the first is deleted", async () => {
    const a = await freeSignIn();
    const b = await freeSignIn();
    const t = transaction();
    expect((await verify(a.json.accessToken, t)).status).toBe(200);
    const second = await verify(b.json.accessToken, t);
    expect(second.status).toBe(409);
    expect(second.json.error).toBe("purchase_linked_elsewhere");
    await call("POST", "/v1/account/delete", {}, a.json.accessToken);
    expect((await verify(b.json.accessToken, t)).json.plus).toBe(true);
  });

  it("a transaction that's already refunded doesn't unlock Plus", async () => {
    const me = await freeSignIn();
    const { json } = await verify(me.json.accessToken, transaction({ revocationDate: Date.now(), revocationReason: 0 }));
    expect(json.plus).toBe(false);
  });
});

describe("App Store Server Notifications", () => {
  async function notify(type: string, t: Record<string, unknown>) {
    const signedTransactionInfo = await appleSign(t);
    const signedPayload = await appleSign({
      notificationType: type, notificationUUID: crypto.randomUUID(), version: "2.0", signedDate: Date.now(),
      data: { bundleId: "com.oftenenough.app", environment: "Xcode", signedTransactionInfo },
    });
    return call("POST", "/v1/hooks/apple", { signedPayload });
  }

  it("a refund removes Plus everywhere; a reversed refund gives it back; repeats are harmless", async () => {
    const me = await freeSignIn();
    const t = transaction();
    await verify(me.json.accessToken, t);
    expect((await notify("REFUND", { ...t, revocationDate: Date.now(), revocationReason: 0 })).status).toBe(200);
    expect((await notify("REFUND", { ...t, revocationDate: Date.now(), revocationReason: 0 })).status).toBe(200);
    const after = await call("GET", "/v1/purchases", undefined, me.json.accessToken);
    expect(after.json.plus).toBe(false);
    expect(after.json.purchases[0].revokedAt).toBeTypeOf("number");
    await notify("REFUND_REVERSED", t);
    expect((await call("GET", "/v1/purchases", undefined, me.json.accessToken)).json.plus).toBe(true);
  });

  it("a verify after a refund doesn't bring Plus back", async () => {
    const me = await freeSignIn();
    const t = transaction();
    await verify(me.json.accessToken, t);
    await notify("REVOKE", { ...t, revocationDate: Date.now(), revocationReason: 1 });
    expect((await verify(me.json.accessToken, t)).json.plus).toBe(false);
  });

  it("notifications for purchases we don't know, and other kinds, are acknowledged and ignored", async () => {
    expect((await notify("REFUND", transaction())).status).toBe(200);
    expect((await notify("CONSUMPTION_REQUEST", transaction())).status).toBe(200);
  });

  it("a notification Apple didn't sign is refused", async () => {
    const signedPayload = await appleSign({ notificationType: "REFUND", data: { bundleId: "com.oftenenough.app" } }, [leafPem, intermediatePem, APPLE_ROOT_CA_G3]);
    expect((await call("POST", "/v1/hooks/apple", { signedPayload })).status).toBe(400);
  });
});

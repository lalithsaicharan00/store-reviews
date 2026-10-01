import { env } from "cloudflare:workers";
import { SignJWT } from "jose";
import { afterEach, beforeAll, beforeEach, describe, expect, it, vi } from "vitest";
import type { Account } from "../src/account";
import { clearProviderKeyCache } from "../src/providers";
import { APPLE_AUDIENCE, APPLE_KEYS_URL, GOOGLE_AUDIENCE, GOOGLE_KEYS_URL, call, device, idToken, mockProviderKeys, newSigningKey, published, testSignIn } from "./helpers";

/** Sign in with Apple server-to-server notifications (Architecture 01 §3.9, 09 §7), signed with stand-in Apple keys. */

let apple: Awaited<ReturnType<typeof newSigningKey>>;
let google: Awaited<ReturnType<typeof newSigningKey>>;
let impostor: Awaited<ReturnType<typeof newSigningKey>>;

beforeAll(async () => {
  apple = await newSigningKey("apple-events");
  google = await newSigningKey("google-events");
  impostor = await newSigningKey("not-apple");
});
beforeEach(() => {
  published[APPLE_KEYS_URL] = [apple];
  published[GOOGLE_KEYS_URL] = [google];
  clearProviderKeyCache();
  mockProviderKeys();
});
afterEach(() => vi.restoreAllMocks());

async function appleSignIn(subject: string, dev = device(), email = "x@privaterelay.appleid.com") {
  const nonce = crypto.randomUUID();
  const token = await idToken({ key: apple, issuer: "https://appleid.apple.com", audience: APPLE_AUDIENCE, subject, nonce, email, emailVerified: "true", isPrivateEmail: "true" });
  return call("POST", "/v1/auth/apple", { idToken: token, nonce, create: true, device: dev });
}

/** An event as Apple sends it: a JWT whose `events` claim is a JSON string. */
async function appleEvent(type: string, subject: string, extra: Record<string, unknown> = {}, key = apple, audience = APPLE_AUDIENCE) {
  const now = Math.floor(Date.now() / 1000);
  const payload = await new SignJWT({ events: JSON.stringify({ type, sub: subject, event_time: Date.now(), ...extra }) })
    .setProtectedHeader({ alg: "RS256", kid: key.kid })
    .setIssuer("https://appleid.apple.com")
    .setAudience(audience)
    .setIssuedAt(now)
    .setJti(crypto.randomUUID())
    .sign(key.privateKey);
  return call("POST", "/v1/hooks/apple-signin", { payload });
}

const stub = (accountId: string) => env.ACCOUNT.get(env.ACCOUNT.idFromName(accountId)) as DurableObjectStub<Account>;
const refresh = (token: string) => call("POST", "/v1/auth/refresh", { refreshToken: token });

describe("Sign in with Apple notifications", () => {
  it("consent revoked: Apple's sessions end, other sign-ins' sessions and the data stay", async () => {
    const subject = `apple-${crypto.randomUUID()}`;
    const phone = await appleSignIn(subject);
    // The same account also opened on an iPad with Google.
    const nonce = crypto.randomUUID();
    await call("POST", "/v1/account/link", { provider: "google", idToken: await idToken({ key: google, issuer: "https://accounts.google.com", audience: GOOGLE_AUDIENCE, subject: `g-${subject}`, nonce }), nonce }, phone.json.accessToken);
    const gNonce = crypto.randomUUID();
    const ipad = await call("POST", "/v1/auth/google", { idToken: await idToken({ key: google, issuer: "https://accounts.google.com", audience: GOOGLE_AUDIENCE, subject: `g-${subject}`, nonce: gNonce }), nonce: gNonce, device: device() });
    expect(ipad.json.accountId).toBe(phone.json.accountId);

    expect((await appleEvent("consent-revoked", subject)).status).toBe(200);
    expect((await refresh(phone.json.refreshToken)).json.error).toBe("signed_out");
    expect((await refresh(ipad.json.refreshToken)).status).toBe(200);
    expect((await stub(phone.json.accountId).summary())?.keys.map((k) => k.provider).sort()).toEqual(["apple", "google"]);
  });

  it("Apple Account deleted, Apple the only sign-in: the whole account is deleted", async () => {
    const subject = `apple-${crypto.randomUUID()}`;
    const me = await appleSignIn(subject);
    await call("POST", "/v1/sync", { cursor: 0, ops: [] }, me.json.accessToken);
    expect((await appleEvent("account-delete", subject)).status).toBe(200);
    expect((await refresh(me.json.refreshToken)).json.error).toBe("account_deleted");
    expect(await stub(me.json.accountId).summary()).toBeNull();
    expect(await env.DIRECTORY.prepare("SELECT 1 FROM account WHERE id = ?").bind(me.json.accountId).first()).toBeNull();
    // Repeated by Apple: harmless.
    expect((await appleEvent("account-delete", subject)).status).toBe(200);
  });

  it("Apple Account deleted, with Google linked too: only the Apple sign-in goes", async () => {
    const subject = `apple-${crypto.randomUUID()}`;
    const me = await appleSignIn(subject);
    const nonce = crypto.randomUUID();
    await call("POST", "/v1/account/link", { provider: "google", idToken: await idToken({ key: google, issuer: "https://accounts.google.com", audience: GOOGLE_AUDIENCE, subject: `g-${subject}`, nonce }), nonce }, me.json.accessToken);
    await appleEvent("account-delete", subject);
    const summary = await stub(me.json.accountId).summary();
    expect(summary?.keys.map((k) => k.provider)).toEqual(["google"]);
    expect((await env.DIRECTORY.prepare("SELECT count(*) AS n FROM account_key WHERE account_id = ? AND provider = 'apple'").bind(me.json.accountId).first<{ n: number }>())?.n).toBe(0);
  });

  it("email forwarding off and back on", async () => {
    const subject = `apple-${crypto.randomUUID()}`;
    const me = await appleSignIn(subject, device(), "abc@privaterelay.appleid.com");
    await appleEvent("email-disabled", subject, { email: "abc@privaterelay.appleid.com", is_private_email: "true" });
    expect((await stub(me.json.accountId).summary())?.keys[0]?.email).toBeNull();
    await appleEvent("email-enabled", subject, { email: "abc@privaterelay.appleid.com", is_private_email: "true" });
    expect((await stub(me.json.accountId).summary())?.keys[0]).toMatchObject({ email: "abc@privaterelay.appleid.com", isPrivateEmail: true });
  });

  it("refuses events Apple didn't sign or that aren't for our app, and ignores sign-ins it doesn't know", async () => {
    const subject = `apple-${crypto.randomUUID()}`;
    const me = await appleSignIn(subject);
    expect((await appleEvent("account-delete", subject, {}, impostor)).status).toBe(401);
    expect((await appleEvent("account-delete", subject, {}, apple, "com.someone.else")).status).toBe(401);
    expect((await refresh(me.json.refreshToken)).status).toBe(200); // nothing happened
    expect((await appleEvent("account-delete", "nobody-we-know")).status).toBe(200);
    expect((await call("POST", "/v1/hooks/apple-signin", { payload: "not.a.jwt" })).status).toBe(401);
    // A test-provider account is never touched by an Apple event, even with the same subject text.
    const other = await testSignIn(subject);
    await appleEvent("consent-revoked", subject);
    expect((await refresh(other.json.refreshToken)).status).toBe(200);
  });
});

import { env } from "cloudflare:workers";
import { SignJWT, importSPKI, jwtVerify } from "jose";
import { afterEach, beforeAll, beforeEach, describe, expect, it, vi } from "vitest";
import type { Account } from "../src/account";
import { APPLE_REVOKE_URL, APPLE_TOKEN_URL, clearAppleClientSecret } from "../src/appleTokens";
import { clearProviderKeyCache } from "../src/providers";
import { APPLE_AUDIENCE, APPLE_KEYS_URL, GOOGLE_AUDIENCE, GOOGLE_KEYS_URL, call, device, idToken, newSigningKey, published } from "./helpers";

/**
 * Sign in with Apple token revocation (appleTokens.ts), against a stand-in Apple: it checks our client secret with the
 * test key's public half, swaps known codes for refresh tokens, and records every revoked token.
 */

let apple: Awaited<ReturnType<typeof newSigningKey>>;
let google: Awaited<ReturnType<typeof newSigningKey>>;

/** code → the Apple ID it was issued for. */
const codes = new Map<string, string>();
const revoked: string[] = [];
const secrets: string[] = [];
let appleDown = false;

beforeAll(async () => {
  apple = await newSigningKey("apple-revoke");
  google = await newSigningKey("google-revoke");
});

beforeEach(() => {
  published[APPLE_KEYS_URL] = [apple];
  published[GOOGLE_KEYS_URL] = [google];
  clearProviderKeyCache();
  clearAppleClientSecret();
  codes.clear();
  revoked.length = 0;
  secrets.length = 0;
  appleDown = false;
  const realFetch = globalThis.fetch;
  vi.spyOn(globalThis, "fetch").mockImplementation(async (input, init) => {
    const url = typeof input === "string" ? input : input instanceof URL ? input.href : input.url;
    if (url in published) return Response.json({ keys: published[url]!.map((k) => k.jwk) });
    if (url === APPLE_TOKEN_URL || url === APPLE_REVOKE_URL) return fakeApple(url, new URLSearchParams(String(init?.body)));
    return realFetch(input, init);
  });
});

afterEach(() => vi.restoreAllMocks());

async function fakeApple(url: string, form: URLSearchParams): Promise<Response> {
  if (appleDown) return new Response("unavailable", { status: 503 });
  const secret = form.get("client_secret") ?? "";
  try {
    const key = await importSPKI(env.APPLE_SIGNIN_TEST_PUBLIC_KEY, "ES256");
    const { payload, protectedHeader } = await jwtVerify(secret, key, { issuer: "MHTC4C9P8F", audience: "https://appleid.apple.com", subject: "com.oftenenough.app", algorithms: ["ES256"] });
    if (protectedHeader.kid !== "S2D594VDJH" || !payload.exp || !payload.iat) throw new Error("bad header");
  } catch {
    return Response.json({ error: "invalid_client" }, { status: 400 });
  }
  if (form.get("client_id") !== "com.oftenenough.app") return Response.json({ error: "invalid_client" }, { status: 400 });
  secrets.push(secret);
  if (url === APPLE_REVOKE_URL) {
    if (form.get("token_type_hint") !== "refresh_token") return Response.json({ error: "invalid_request" }, { status: 400 });
    revoked.push(form.get("token") ?? "");
    return new Response(null, { status: 200 });
  }
  const subject = codes.get(form.get("code") ?? "");
  if (form.get("grant_type") !== "authorization_code" || !subject) return Response.json({ error: "invalid_grant" }, { status: 400 });
  codes.delete(form.get("code")!); // one-time
  const now = Math.floor(Date.now() / 1000);
  const idTokenFromApple = await new SignJWT({}).setProtectedHeader({ alg: "RS256", kid: apple.kid }).setIssuer("https://appleid.apple.com").setAudience(APPLE_AUDIENCE).setSubject(subject).setIssuedAt(now).setExpirationTime(now + 600).sign(apple.privateKey);
  return Response.json({ access_token: "a", token_type: "Bearer", expires_in: 3600, refresh_token: `refresh-for-${subject}`, id_token: idTokenFromApple });
}

/** A code Apple issued to `codeFor` (default: the person signing in). */
/** One phone per Apple ID here: a free account's second device is asked first (Current Work 78), which isn't what these test. */
const phones = new Map<string, ReturnType<typeof device>>();

async function appleSignIn(subject: string, options: { code?: string | null; codeFor?: string; create?: boolean } = {}) {
  const nonce = crypto.randomUUID();
  const token = await idToken({ key: apple, issuer: "https://appleid.apple.com", audience: APPLE_AUDIENCE, subject, nonce });
  let code: string | undefined;
  if (options.code !== null) {
    code = options.code ?? `code-${crypto.randomUUID()}`;
    codes.set(code, options.codeFor ?? subject);
  }
  if (!phones.has(subject)) phones.set(subject, device());
  return call("POST", "/v1/auth/apple", { idToken: token, nonce, create: options.create ?? true, device: phones.get(subject), authorizationCode: code });
}

const stub = (accountId: string) => env.ACCOUNT.get(env.ACCOUNT.idFromName(accountId)) as DurableObjectStub<Account>;

/** The exchange runs after the reply; wait for it to land. */
async function keptTokens(accountId: string, expected: number) {
  await vi.waitFor(async () => expect(await stub(accountId).revokeTokens()).toHaveLength(expected), { timeout: 2000, interval: 20 });
  return stub(accountId).revokeTokens();
}

describe("Sign in with Apple token revocation", () => {
  it("keeps Apple's refresh token at sign-in, and revokes it when the account is deleted", async () => {
    const subject = `apple-${crypto.randomUUID()}`;
    const signedIn = await appleSignIn(subject);
    expect(signedIn.status).toBe(201);
    expect(await keptTokens(signedIn.json.accountId, 1)).toEqual([`refresh-for-${subject}`]);

    const deleted = await call("POST", "/v1/account/delete", {}, signedIn.json.accessToken);
    expect(deleted.status).toBe(200);
    expect(revoked).toEqual([`refresh-for-${subject}`]);
    // One client secret served both calls.
    expect(new Set(secrets).size).toBe(1);
  });

  it("never shows the token: not in the account summary, not in the export", async () => {
    const subject = `apple-${crypto.randomUUID()}`;
    const signedIn = await appleSignIn(subject);
    await keptTokens(signedIn.json.accountId, 1);
    const summary = await call("GET", "/v1/account", undefined, signedIn.json.accessToken);
    expect(JSON.stringify(summary.json)).not.toContain("refresh-for-");
    const { exports } = await import("cloudflare:workers");
    const exported = await exports.default.fetch("https://api-dev.oftenenough.com/v1/account/export", { headers: { authorization: `Bearer ${signedIn.json.accessToken}` } });
    expect(exported.status).toBe(200);
    expect(await exported.text()).not.toContain("refresh-for-");
  });

  it("a later sign-in replaces the token; the account still holds one per Apple ID", async () => {
    const subject = `apple-${crypto.randomUUID()}`;
    const first = await appleSignIn(subject);
    await keptTokens(first.json.accountId, 1);
    const again = await appleSignIn(subject, { create: false });
    expect(again.status).toBe(200);
    expect(await keptTokens(first.json.accountId, 1)).toEqual([`refresh-for-${subject}`]);
  });

  it("a code issued to someone else's Apple ID is never kept", async () => {
    const subject = `apple-${crypto.randomUUID()}`;
    const signedIn = await appleSignIn(subject, { codeFor: "someone-else" });
    expect(signedIn.status).toBe(201);
    await new Promise((r) => setTimeout(r, 100));
    expect(await stub(signedIn.json.accountId).revokeTokens()).toEqual([]);
  });

  it("Apple being down never stops a sign-in or a deletion", async () => {
    appleDown = true;
    const subject = `apple-${crypto.randomUUID()}`;
    const signedIn = await appleSignIn(subject);
    expect(signedIn.status).toBe(201);
    await new Promise((r) => setTimeout(r, 100));
    expect(await stub(signedIn.json.accountId).revokeTokens()).toEqual([]);

    appleDown = false;
    const later = await appleSignIn(subject, { create: false });
    await keptTokens(later.json.accountId, 1);
    appleDown = true;
    const deleted = await call("POST", "/v1/account/delete", {}, later.json.accessToken);
    expect(deleted.status).toBe(200);
    expect((await call("GET", "/v1/account", undefined, later.json.accessToken)).status).toBe(401);
  });

  it("an app that sends no code signs in as before, and deleting calls Apple for nothing", async () => {
    const subject = `apple-${crypto.randomUUID()}`;
    const signedIn = await appleSignIn(subject, { code: null });
    expect(signedIn.status).toBe(201);
    expect((await call("POST", "/v1/account/delete", {}, signedIn.json.accessToken)).status).toBe(200);
    expect(revoked).toEqual([]);
    expect(secrets).toEqual([]);
  });

  it("removing the Apple sign-in revokes it; the account stays", async () => {
    const subject = `apple-${crypto.randomUUID()}`;
    const signedIn = await appleSignIn(subject);
    await keptTokens(signedIn.json.accountId, 1);
    const nonce = crypto.randomUUID();
    const googleToken = await idToken({ key: google, issuer: "https://accounts.google.com", audience: GOOGLE_AUDIENCE, subject: `g-${subject}`, nonce });
    expect((await call("POST", "/v1/account/link", { provider: "google", idToken: googleToken, nonce }, signedIn.json.accessToken)).status).toBe(200);

    expect((await call("POST", "/v1/account/unlink", { provider: "apple" }, signedIn.json.accessToken)).status).toBe(200);
    expect(revoked).toEqual([`refresh-for-${subject}`]);
    expect(await stub(signedIn.json.accountId).revokeTokens()).toEqual([]);
    expect((await call("GET", "/v1/account", undefined, signedIn.json.accessToken)).status).toBe(200);
  });

  it("linking Apple to an existing account keeps its token too", async () => {
    const gSubject = `g-${crypto.randomUUID()}`;
    const gNonce = crypto.randomUUID();
    const googleToken = await idToken({ key: google, issuer: "https://accounts.google.com", audience: GOOGLE_AUDIENCE, subject: gSubject, nonce: gNonce });
    const signedIn = await call("POST", "/v1/auth/google", { idToken: googleToken, nonce: gNonce, create: true, device: device() });
    expect(signedIn.status).toBe(201);

    const subject = `apple-${crypto.randomUUID()}`;
    const nonce = crypto.randomUUID();
    const code = `code-${crypto.randomUUID()}`;
    codes.set(code, subject);
    const appleToken = await idToken({ key: apple, issuer: "https://appleid.apple.com", audience: APPLE_AUDIENCE, subject, nonce });
    expect((await call("POST", "/v1/account/link", { provider: "apple", idToken: appleToken, nonce, authorizationCode: code }, signedIn.json.accessToken)).status).toBe(200);
    expect(await keptTokens(signedIn.json.accountId, 1)).toEqual([`refresh-for-${subject}`]);
  });
});

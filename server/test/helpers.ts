import { type JWK, SignJWT, exportJWK, generateKeyPair } from "jose";
import { exports } from "cloudflare:workers";
import { vi } from "vitest";

/**
 * Stand-ins for Apple and Google: our own RSA keys, served at the providers' real key URLs through a mocked fetch,
 * and ID tokens signed with them. Everything else (the Worker, D1, the Durable Objects) is the real code.
 */

export const APPLE_KEYS_URL = "https://appleid.apple.com/auth/keys";
export const GOOGLE_KEYS_URL = "https://www.googleapis.com/oauth2/v3/certs";
export const GITHUB_KEYS_URL = "https://token.actions.githubusercontent.com/.well-known/jwks";
export const APPLE_AUDIENCE = "com.oftenenough.app";
export const GOOGLE_AUDIENCE = "test-google-client.apps.googleusercontent.com";
export const TEST_LOGIN_SECRET = "test-login-secret-0123456789abcdef01234";

interface SigningKey {
  kid: string;
  privateKey: Awaited<ReturnType<typeof generateKeyPair>>["privateKey"];
  jwk: JWK;
}

export async function newSigningKey(kid: string): Promise<SigningKey> {
  const { privateKey, publicKey } = await generateKeyPair("RS256", { extractable: true });
  return { kid, privateKey, jwk: { ...(await exportJWK(publicKey)), kid, alg: "RS256", use: "sig" } };
}

/** Which keys each provider currently publishes, and how many times its key URL was fetched. */
export const published: Record<string, SigningKey[]> = { [APPLE_KEYS_URL]: [], [GOOGLE_KEYS_URL]: [], [GITHUB_KEYS_URL]: [] };
export const keyFetches: Record<string, number> = { [APPLE_KEYS_URL]: 0, [GOOGLE_KEYS_URL]: 0, [GITHUB_KEYS_URL]: 0 };

export function mockProviderKeys() {
  const realFetch = globalThis.fetch;
  vi.spyOn(globalThis, "fetch").mockImplementation(async (input, init) => {
    const url = typeof input === "string" ? input : input instanceof URL ? input.href : input.url;
    if (url in published) {
      keyFetches[url] = (keyFetches[url] ?? 0) + 1;
      return Response.json({ keys: published[url]!.map((k) => k.jwk) });
    }
    return realFetch(input, init);
  });
}

export async function sha256Hex(text: string): Promise<string> {
  const digest = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text));
  return [...new Uint8Array(digest)].map((b) => b.toString(16).padStart(2, "0")).join("");
}

export interface IdTokenOptions {
  claims?: Record<string, unknown>;
  key: SigningKey;
  issuer: string;
  audience: string;
  subject: string;
  nonce: string;
  email?: string;
  emailVerified?: boolean | string;
  isPrivateEmail?: boolean | string;
  expiresInSeconds?: number;
}

/** An ID token as the provider would issue it, carrying SHA-256(nonce) as Apple and our apps do. */
export async function idToken(o: IdTokenOptions): Promise<string> {
  const now = Math.floor(Date.now() / 1000);
  const claims: Record<string, unknown> = { nonce: await sha256Hex(o.nonce) };
  if (o.email !== undefined) claims.email = o.email;
  if (o.emailVerified !== undefined) claims.email_verified = o.emailVerified;
  if (o.isPrivateEmail !== undefined) claims.is_private_email = o.isPrivateEmail;
  Object.assign(claims, o.claims ?? {});
  return new SignJWT(claims)
    .setProtectedHeader({ alg: "RS256", kid: o.key.kid })
    .setIssuer(o.issuer)
    .setAudience(o.audience)
    .setSubject(o.subject)
    .setIssuedAt(now)
    .setExpirationTime(now + (o.expiresInSeconds ?? 600))
    .sign(o.key.privateKey);
}

export function device(overrides: Partial<{ id: string; platform: string; name: string; appVersion: string }> = {}) {
  return { id: crypto.randomUUID(), platform: "ios", name: "iPhone", appVersion: "1.0", ...overrides };
}

export async function call(method: string, path: string, body?: unknown, accessToken?: string) {
  const headers: Record<string, string> = {};
  if (body !== undefined) headers["content-type"] = "application/json";
  if (accessToken) headers.authorization = `Bearer ${accessToken}`;
  const response = await exports.default.fetch(`https://api-dev.oftenenough.com${path}`, {
    method,
    headers,
    body: body === undefined ? undefined : JSON.stringify(body),
  });
  const json = (await response.json()) as Record<string, any>;
  return { status: response.status, json };
}

/** Signs in with the dev-only test provider, creating the account. */
export async function testSignIn(subject = crypto.randomUUID(), dev = device(), extra: Record<string, unknown> = {}) {
  return call("POST", "/v1/auth/test", { secret: TEST_LOGIN_SECRET, subject, create: true, device: dev, ...extra });
}

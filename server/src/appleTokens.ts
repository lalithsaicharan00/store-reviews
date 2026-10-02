import { SignJWT, decodeJwt, importPKCS8 } from "jose";

/**
 * Sign in with Apple token revocation (App Store Review Guideline 5.1.1(v)): an app that offers account deletion must
 * also revoke the person's Apple sign-in, so "Often Enough" disappears from their Apple Account's list of apps.
 *
 * At sign-in the app sends Apple's one-time `authorizationCode`; we exchange it at Apple for a refresh token and keep
 * it with the Apple sign-in key (account.ts). Deleting the account, or removing the Apple sign-in, sends that token to
 * Apple's revoke endpoint. We authenticate to Apple with a short-lived client secret: a JWT signed (ES256) with the
 * Sign in with Apple key from the developer account.
 *
 * Configured by the secret `APPLE_SIGNIN_KEY` (the key's .p8 file, PEM) and the vars `APPLE_TEAM_ID` and
 * `APPLE_SIGNIN_KEY_ID`; until the secret is set nothing is exchanged or revoked. Every call is best effort: Apple
 * being down never stops a sign-in or a deletion; it is logged.
 */

export const APPLE_TOKEN_URL = "https://appleid.apple.com/auth/token";
export const APPLE_REVOKE_URL = "https://appleid.apple.com/auth/revoke";

interface AppleTokenEnv {
  APPLE_SIGNIN_KEY?: string;
  APPLE_TEAM_ID?: string;
  APPLE_SIGNIN_KEY_ID?: string;
  APPLE_BUNDLE_ID: string;
}

/** The client secret, reused for a while (Apple allows up to 6 months; ours lives an hour). Isolate-wide, not request state. */
let cachedSecret: { value: string; keyId: string; expiresAt: number } | null = null;
const SECRET_LIFETIME_S = 60 * 60;

function config(env: Env) {
  const e = env as unknown as AppleTokenEnv;
  if (!e.APPLE_SIGNIN_KEY || !e.APPLE_TEAM_ID || !e.APPLE_SIGNIN_KEY_ID) return null;
  return { pem: e.APPLE_SIGNIN_KEY, teamId: e.APPLE_TEAM_ID, keyId: e.APPLE_SIGNIN_KEY_ID, clientId: e.APPLE_BUNDLE_ID };
}

export function appleTokensConfigured(env: Env): boolean {
  return config(env) !== null;
}

async function clientSecret(c: NonNullable<ReturnType<typeof config>>): Promise<string> {
  const now = Math.floor(Date.now() / 1000);
  if (cachedSecret && cachedSecret.keyId === c.keyId && cachedSecret.expiresAt - 300 > now) return cachedSecret.value;
  const key = await importPKCS8(c.pem.trim(), "ES256");
  const value = await new SignJWT({})
    .setProtectedHeader({ alg: "ES256", kid: c.keyId })
    .setIssuer(c.teamId)
    .setSubject(c.clientId)
    .setAudience("https://appleid.apple.com")
    .setIssuedAt(now)
    .setExpirationTime(now + SECRET_LIFETIME_S)
    .sign(key);
  cachedSecret = { value, keyId: c.keyId, expiresAt: now + SECRET_LIFETIME_S };
  return value;
}

/** For tests: forget the cached client secret. */
export function clearAppleClientSecret() {
  cachedSecret = null;
}

async function post(url: string, form: Record<string, string>): Promise<Response | null> {
  return fetch(url, {
    method: "POST",
    headers: { "content-type": "application/x-www-form-urlencoded", accept: "application/json" },
    body: new URLSearchParams(form),
  }).catch(() => null);
}

/**
 * Exchanges the app's one-time authorization code for a refresh token we can revoke later. Returns null when not
 * configured, when Apple refuses, or when the code belongs to a different Apple ID than the one that just signed in.
 */
export async function exchangeAppleCode(env: Env, code: string, subject: string): Promise<string | null> {
  const c = config(env);
  if (!c) return null;
  try {
    const response = await post(APPLE_TOKEN_URL, { client_id: c.clientId, client_secret: await clientSecret(c), code, grant_type: "authorization_code" });
    const body = response ? ((await response.json().catch(() => null)) as { refresh_token?: unknown; id_token?: unknown; error?: unknown } | null) : null;
    if (!response?.ok || typeof body?.refresh_token !== "string" || typeof body.id_token !== "string") {
      log("apple_code_exchange_failed", response?.status ?? 0, body?.error);
      return null;
    }
    // Straight from Apple over TLS, so reading it without checking the signature is safe.
    if (decodeJwt(body.id_token).sub !== subject) {
      log("apple_code_exchange_failed", response.status, "subject_mismatch");
      return null;
    }
    return body.refresh_token;
  } catch (error) {
    log("apple_code_exchange_failed", 0, error instanceof Error ? error.message : String(error));
    return null;
  }
}

/** Revokes a refresh token: the person's Apple sign-in for Often Enough ends. True if Apple accepted it. */
export async function revokeAppleToken(env: Env, token: string): Promise<boolean> {
  const c = config(env);
  if (!c) return false;
  try {
    const response = await post(APPLE_REVOKE_URL, { client_id: c.clientId, client_secret: await clientSecret(c), token, token_type_hint: "refresh_token" });
    if (!response?.ok) log("apple_revoke_failed", response?.status ?? 0, null);
    return response?.ok === true;
  } catch (error) {
    log("apple_revoke_failed", 0, error instanceof Error ? error.message : String(error));
    return false;
  }
}

// Never the code, token or client secret: only what went wrong.
function log(event: string, status: number, error: unknown) {
  console.error(JSON.stringify({ event, status, error: typeof error === "string" ? error.slice(0, 100) : null }));
}

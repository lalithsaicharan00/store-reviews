import { type JSONWebKeySet, createLocalJWKSet, errors, jwtVerify } from "jose";
import { HttpError } from "./http";
import { sha256Hex } from "./tokens";

/**
 * Checks an Apple or Google ID token (Architecture 01 §3.9): signature against the provider's published keys
 * (cached for an hour), issuer, audience, expiry and nonce. The app makes a random nonce, gives the provider its
 * SHA-256 (hex), and sends us the raw value; the token must carry the hash, so a token can't be replayed.
 */

export interface VerifiedKey {
  provider: "apple" | "google" | "test" | "ci";
  subject: string;
  email: string | null;
  /** Apple "Hide My Email" relay address. */
  isPrivateEmail: boolean;
}

interface ProviderConfig {
  provider: "apple" | "google" | "ci";
  jwksUrl: string;
  issuers: string[];
}

export const APPLE: ProviderConfig = {
  provider: "apple",
  jwksUrl: "https://appleid.apple.com/auth/keys",
  issuers: ["https://appleid.apple.com"],
};

export const GOOGLE: ProviderConfig = {
  provider: "google",
  jwksUrl: "https://www.googleapis.com/oauth2/v3/certs",
  issuers: ["https://accounts.google.com", "accounts.google.com"],
};

/** GitHub Actions' identity tokens: what the dev-only CI sign-in accepts (see `verifyCiToken`). */
export const GITHUB_ACTIONS: ProviderConfig = {
  provider: "ci",
  jwksUrl: "https://token.actions.githubusercontent.com/.well-known/jwks",
  issuers: ["https://token.actions.githubusercontent.com"],
};

// The providers' public keys, shared by every request in this isolate (not request state).
const keyCache = new Map<string, { keys: JSONWebKeySet; fetchedAt: number }>();
const KEYS_FRESH_MS = 60 * 60 * 1000;
// A token naming a key we don't have triggers a refetch (the provider rotated its keys), at most once a minute,
// so made-up key IDs can't make us hammer the provider.
const lastUnknownKeyRefetch = new Map<string, number>();
const UNKNOWN_KEY_REFETCH_MS = 60 * 1000;

async function providerKeys(url: string, forceRefresh: boolean): Promise<JSONWebKeySet> {
  const cached = keyCache.get(url);
  const now = Date.now();
  const stale = !cached || now - cached.fetchedAt > KEYS_FRESH_MS;
  const mayForce = forceRefresh && now - (lastUnknownKeyRefetch.get(url) ?? 0) > UNKNOWN_KEY_REFETCH_MS;
  if (cached && !stale && !mayForce) return cached.keys;
  if (mayForce) lastUnknownKeyRefetch.set(url, now);
  const response = await fetch(url, { headers: { accept: "application/json" } }).catch(() => null);
  const keys = response?.ok ? ((await response.json().catch(() => null)) as JSONWebKeySet | null) : null;
  if (!keys || !Array.isArray(keys.keys) || keys.keys.length === 0) {
    if (cached) return cached.keys; // the provider is having trouble; keys rotate slowly, so the old ones still work
    throw new HttpError(503, "provider_unavailable", "Couldn't reach the sign-in provider. Please try again.");
  }
  keyCache.set(url, { keys, fetchedAt: now });
  return keys;
}

/** For tests: forget cached provider keys. */
export function clearProviderKeyCache() {
  keyCache.clear();
  lastUnknownKeyRefetch.clear();
}

export async function verifyIdToken(config: ProviderConfig, idToken: string, rawNonce: string, audiences: string[]): Promise<VerifiedKey> {
  if (audiences.length === 0) {
    throw new HttpError(503, "provider_not_configured", `Sign in with ${config.provider === "apple" ? "Apple" : "Google"} isn't set up yet.`);
  }
  const payload = await verifySigned(config, idToken, audiences);
  if (typeof payload.sub !== "string" || payload.sub.length === 0) throw invalid();
  if (typeof payload.nonce !== "string" || payload.nonce !== (await sha256Hex(rawNonce))) throw invalid();
  const emailVerified = payload.email_verified === true || payload.email_verified === "true";
  const email = typeof payload.email === "string" && emailVerified ? payload.email.toLowerCase() : null;
  const isPrivateEmail = payload.is_private_email === true || payload.is_private_email === "true";
  return { provider: config.provider, subject: payload.sub, email, isPrivateEmail };
}

/**
 * Dev only: proves a request comes from a GitHub Actions run of our own repository (its OIDC token, minted for
 * [audience]), so the iPhone end-to-end tests can sign in without Apple, Google or any stored secret. A fork's
 * runs carry their own repository name and are refused. The test chooses `subject`, so several simulated devices
 * can share one account.
 */
export async function verifyCiToken(idToken: string, audience: string, repository: string, subject: string): Promise<VerifiedKey> {
  const payload = await verifySigned(GITHUB_ACTIONS, idToken, [audience]);
  if (payload.repository !== repository) throw invalid();
  return { provider: "ci", subject, email: null, isPrivateEmail: false };
}

async function verifySigned(config: ProviderConfig, token: string, audiences: string[]) {
  const verify = async (forceRefresh: boolean) =>
    jwtVerify(token, createLocalJWKSet(await providerKeys(config.jwksUrl, forceRefresh)), {
      issuer: config.issuers,
      audience: audiences,
      algorithms: ["RS256"],
      clockTolerance: 60,
    });
  try {
    return (await verify(false)).payload;
  } catch (error) {
    if (error instanceof HttpError) throw error;
    if (!(error instanceof errors.JWKSNoMatchingKey)) throw invalid();
  }
  // The provider may have rotated its keys since we cached them.
  try {
    return (await verify(true)).payload;
  } catch (error) {
    if (error instanceof HttpError) throw error;
    throw invalid();
  }
}

function invalid() {
  return new HttpError(401, "invalid_token", "The sign-in couldn't be checked. Please try again.");
}

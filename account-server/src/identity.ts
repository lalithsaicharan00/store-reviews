import { type JSONWebKeySet, createLocalJWKSet, errors, jwtVerify } from "jose";
import { HttpError, sha256Hex } from "./http";

/**
 * Who is signing in: an ID token from Google's or Apple's own sign-in, checked against the provider's published keys
 * (cached for an hour, fetched again when a token names a key we don't have), its issuer, its audience (our OAuth
 * clients) and expiry, and a nonce: the app makes a random value, gives the provider its SHA-256 (hex), and sends us
 * the raw value; the token must carry that hash, so a token can't be replayed by someone who copied it.
 */

export type Provider = "google" | "apple";

export interface Person {
  provider: Provider;
  /** The provider's fixed account ID: the same for this person whatever their email becomes. */
  subject: string;
  /** Verified email, only to make the masked hint; never stored whole (D16). */
  email: string | null;
  /** The first name the provider gave, if any (Google gives it; Apple only to the app, which sends it). */
  givenName: string | null;
}

interface ProviderConfig {
  jwksUrl: string;
  issuers: string[];
}

export const PROVIDERS: Record<Provider, ProviderConfig> = {
  google: { jwksUrl: "https://www.googleapis.com/oauth2/v3/certs", issuers: ["https://accounts.google.com", "accounts.google.com"] },
  apple: { jwksUrl: "https://appleid.apple.com/auth/keys", issuers: ["https://appleid.apple.com"] },
};

// The providers' public keys, shared by every request in this isolate.
const keyCache = new Map<string, { keys: JSONWebKeySet; fetchedAt: number }>();
const KEYS_FRESH_MS = 60 * 60 * 1000;
// A token naming a key we don't have refetches the keys (the provider rotated them), at most once a minute, so made-up
// key IDs can't make us hammer the provider.
const lastForcedFetch = new Map<string, number>();
const FORCED_FETCH_GAP_MS = 60 * 1000;

async function providerKeys(url: string, force: boolean): Promise<JSONWebKeySet> {
  const cached = keyCache.get(url);
  const now = Date.now();
  const stale = !cached || now - cached.fetchedAt > KEYS_FRESH_MS;
  const mayForce = force && now - (lastForcedFetch.get(url) ?? 0) > FORCED_FETCH_GAP_MS;
  if (cached && !stale && !mayForce) return cached.keys;
  if (mayForce) lastForcedFetch.set(url, now);
  const response = await fetch(url, { headers: { accept: "application/json" } }).catch(() => null);
  const keys = response?.ok ? ((await response.json().catch(() => null)) as JSONWebKeySet | null) : null;
  if (!keys || !Array.isArray(keys.keys) || keys.keys.length === 0) {
    if (cached) return cached.keys; // the provider is having trouble; keys rotate slowly, so the old ones still work
    throw new HttpError(503, "provider_unavailable", "Couldn't reach the sign-in provider. Please try again.");
  }
  keyCache.set(url, { keys, fetchedAt: now });
  return keys;
}

/** For tests: forget the cached keys. */
export function clearKeyCache() {
  keyCache.clear();
  lastForcedFetch.clear();
}

export function audiences(list: string | undefined): string[] {
  return (list ?? "").split(",").map((s) => s.trim()).filter(Boolean);
}

export async function verifyIdToken(provider: Provider, idToken: string, rawNonce: string, allowed: string[]): Promise<Person> {
  if (allowed.length === 0) {
    throw new HttpError(503, "provider_not_configured", `Sign in with ${provider === "apple" ? "Apple" : "Google"} isn't set up yet.`);
  }
  const config = PROVIDERS[provider];
  const verify = async (force: boolean) =>
    (await jwtVerify(idToken, createLocalJWKSet(await providerKeys(config.jwksUrl, force)), {
      issuer: config.issuers,
      audience: allowed,
      algorithms: ["RS256"],
      clockTolerance: 60,
    })).payload;
  let payload;
  try {
    payload = await verify(false);
  } catch (error) {
    if (error instanceof HttpError) throw error;
    if (!(error instanceof errors.JWKSNoMatchingKey)) throw invalid();
    try {
      payload = await verify(true); // the provider may have rotated its keys since we cached them
    } catch (again) {
      if (again instanceof HttpError) throw again;
      throw invalid();
    }
  }
  if (typeof payload.sub !== "string" || payload.sub.length === 0 || payload.sub.length > 255) throw invalid();
  if (typeof payload.nonce !== "string" || payload.nonce !== (await sha256Hex(rawNonce))) throw invalid();
  const emailVerified = payload.email_verified === true || payload.email_verified === "true";
  const email = typeof payload.email === "string" && emailVerified ? payload.email.toLowerCase() : null;
  const given = typeof payload.given_name === "string" ? payload.given_name : typeof payload.name === "string" ? payload.name : null;
  return { provider, subject: payload.sub, email, givenName: given };
}

function invalid() {
  return new HttpError(401, "invalid_token", "The sign-in couldn't be checked. Please try again.");
}

/** "lalith@gmail.com" → "l•••••@gmail.com" (D16: a hint to point someone back to the right account, never the address). */
export function emailHint(email: string | null): string | null {
  if (!email) return null;
  const at = email.lastIndexOf("@");
  if (at < 1) return null;
  return email[0] + "•••••" + email.slice(at);
}

/** The name the family sees: the first word, at most 40 characters, no control characters; "Someone" if there's none. */
export function cleanName(...candidates: (string | null | undefined)[]): string {
  for (const c of candidates) {
    const first = (c ?? "").replace(/[\p{C}]/gu, "").trim().split(/\s+/)[0] ?? "";
    if (first.length > 0) return [...first].slice(0, 40).join("");
  }
  return "Someone";
}

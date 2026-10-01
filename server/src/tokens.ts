import { SignJWT, errors, jwtVerify } from "jose";
import type { Jurisdiction } from "./directory";

/**
 * Our own tokens (Architecture 06 §5, 01 §3.5):
 * - an access token: a signed JWT for one hour, holding the account and device, checked without a database read;
 * - a refresh token: `rt1.<j>.<account>.<device>.<secret>` (j: `d` default, `e` EU storage), rotated on every use.
 *   Only a hash of the secret is stored, in the account's Durable Object; the rest only says where to look.
 */

export const ACCESS_TOKEN_SECONDS = 3600;
const ISSUER = "oftenenough";
const AUDIENCE = "api";

export interface AccessClaims {
  accountId: string;
  deviceId: string;
  jurisdiction: Jurisdiction;
}

function signingKey(secret: string): Uint8Array {
  if (secret.length < 32) throw new Error("TOKEN_KEY must be at least 32 characters");
  return new TextEncoder().encode(secret);
}

export async function issueAccessToken(claims: AccessClaims, secret: string, now = Date.now()) {
  const issuedAt = Math.floor(now / 1000);
  const expiresAt = issuedAt + ACCESS_TOKEN_SECONDS;
  const token = await new SignJWT({ did: claims.deviceId, jur: claims.jurisdiction })
    .setProtectedHeader({ alg: "HS256", typ: "JWT" })
    .setSubject(claims.accountId)
    .setIssuer(ISSUER)
    .setAudience(AUDIENCE)
    .setIssuedAt(issuedAt)
    .setExpirationTime(expiresAt)
    .sign(signingKey(secret));
  return { token, expiresAt: expiresAt * 1000 };
}

/** Returns the claims, or null for a missing, forged or expired token. `previous` lets a rotated key work for a day. */
export async function verifyAccessToken(token: string, secret: string, previous?: string): Promise<AccessClaims | null> {
  for (const key of [secret, previous]) {
    if (!key) continue;
    try {
      const { payload } = await jwtVerify(token, signingKey(key), { issuer: ISSUER, audience: AUDIENCE, algorithms: ["HS256"] });
      if (typeof payload.sub !== "string" || typeof payload.did !== "string") return null;
      return { accountId: payload.sub, deviceId: payload.did, jurisdiction: payload.jur === "eu" ? "eu" : "default" };
    } catch (error) {
      if (error instanceof errors.JWTExpired) return null; // expired with the right key: no point trying another
    }
  }
  return null;
}

export function bearer(request: Request): string | null {
  const header = request.headers.get("authorization") ?? "";
  return header.startsWith("Bearer ") ? header.slice(7) : null;
}

// Refresh tokens

export function newSecret(): string {
  const bytes = crypto.getRandomValues(new Uint8Array(32));
  return base64url(bytes);
}

export function composeRefreshToken(claims: AccessClaims, secret: string): string {
  return `rt1.${claims.jurisdiction === "eu" ? "e" : "d"}.${claims.accountId}.${claims.deviceId}.${secret}`;
}

export function parseRefreshToken(token: unknown): (AccessClaims & { secret: string }) | null {
  if (typeof token !== "string" || token.length > 256) return null;
  const parts = token.split(".");
  if (parts.length !== 5 || parts[0] !== "rt1" || (parts[1] !== "d" && parts[1] !== "e")) return null;
  const [, j, accountId, deviceId, secret] = parts;
  if (!accountId || !deviceId || !secret) return null;
  return { accountId, deviceId, jurisdiction: j === "e" ? "eu" : "default", secret };
}

// Hashing and comparing

export async function sha256Hex(text: string): Promise<string> {
  const digest = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text));
  return [...new Uint8Array(digest)].map((b) => b.toString(16).padStart(2, "0")).join("");
}

/** Constant-time comparison; both sides are hashed first so their lengths don't leak. */
export async function safeEqual(a: string, b: string): Promise<boolean> {
  const encoder = new TextEncoder();
  const [x, y] = await Promise.all([
    crypto.subtle.digest("SHA-256", encoder.encode(a)),
    crypto.subtle.digest("SHA-256", encoder.encode(b)),
  ]);
  return crypto.subtle.timingSafeEqual(x, y);
}

function base64url(bytes: Uint8Array): string {
  let binary = "";
  for (const byte of bytes) binary += String.fromCharCode(byte);
  return btoa(binary).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
}

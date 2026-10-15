import { SignJWT, importPKCS8 } from "jose";
import { HttpError } from "./http";

/**
 * Checking a Google Play purchase with Google (D16: "We verify it with Google or Apple"). The Worker signs in to Google
 * as the service account `play-purchases@often-enough.iam.gserviceaccount.com` (its JSON key is the secret
 * GOOGLE_PLAY_SERVICE_ACCOUNT, put in with `wrangler secret put`, never in the repository: D11) and asks the Play
 * Developer API about the purchase token the app sent. Nothing the app says about a purchase is trusted on its own.
 */

/** Our one-time products, and what each gives. The upgrade is sold only to someone who has Plus. */
export const PRODUCTS: Record<string, "plus" | "family"> = {
  "com.oftenenough.app.plus": "plus",
  "com.oftenenough.app.plusfamily": "family",
  "com.oftenenough.app.plusfamily.upgrade": "family",
};

export interface PlayCheck {
  /** Bought and paid; cancelled (refunded, revoked); pending (not paid yet); unknown (not a purchase of ours). */
  state: "purchased" | "cancelled" | "pending" | "unknown";
  orderId: string | null;
  /** A license tester's purchase (Play Console's test card). */
  test: boolean;
}

interface ServiceAccount {
  client_email: string;
  private_key: string;
  token_uri?: string;
}

const TOKEN_URL = "https://oauth2.googleapis.com/token";
const SCOPE = "https://www.googleapis.com/auth/androidpublisher";
let cachedAccess: { token: string; expiresAt: number; key: string } | null = null;

/** For tests: forget the cached access token. */
export function clearPlayToken() {
  cachedAccess = null;
}

function serviceAccount(secret: string | undefined): ServiceAccount {
  if (!secret) throw new HttpError(503, "purchases_not_configured", "Purchases can't be checked yet. Please try again later.");
  try {
    const parsed = JSON.parse(secret) as ServiceAccount;
    if (typeof parsed.client_email === "string" && typeof parsed.private_key === "string") return parsed;
  } catch {
    // fall through
  }
  throw new HttpError(503, "purchases_not_configured", "Purchases can't be checked yet. Please try again later.");
}

/** An access token for the Play Developer API (Google's OAuth 2.0 for service accounts), kept until a minute before it ends. */
async function accessToken(secret: string | undefined): Promise<string> {
  const sa = serviceAccount(secret);
  const now = Date.now();
  if (cachedAccess && cachedAccess.key === sa.client_email && cachedAccess.expiresAt - 60_000 > now) return cachedAccess.token;
  const key = await importPKCS8(sa.private_key, "RS256");
  const assertion = await new SignJWT({ scope: SCOPE })
    .setProtectedHeader({ alg: "RS256", typ: "JWT" })
    .setIssuer(sa.client_email)
    .setAudience(TOKEN_URL)
    .setIssuedAt(Math.floor(now / 1000))
    .setExpirationTime(Math.floor(now / 1000) + 3600)
    .sign(key);
  const response = await fetch(TOKEN_URL, {
    method: "POST",
    headers: { "content-type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({ grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer", assertion }),
  }).catch(() => null);
  const body = response?.ok ? ((await response.json().catch(() => null)) as { access_token?: string; expires_in?: number } | null) : null;
  if (!body?.access_token) {
    console.error(`play: no access token (${response?.status ?? "network"})`);
    throw new HttpError(503, "store_unavailable", "Couldn't reach Google Play. Please try again.");
  }
  cachedAccess = { token: body.access_token, expiresAt: now + (body.expires_in ?? 3600) * 1000, key: sa.client_email };
  return body.access_token;
}

/** Asks Google Play about one purchase of [product] with [purchaseToken] in the app [packageName]. */
export async function checkPlayPurchase(secret: string | undefined, packageName: string, product: string, purchaseToken: string): Promise<PlayCheck> {
  if (!(product in PRODUCTS)) return { state: "unknown", orderId: null, test: false };
  const access = await accessToken(secret);
  const url = `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/${encodeURIComponent(packageName)}`
    + `/purchases/products/${encodeURIComponent(product)}/tokens/${encodeURIComponent(purchaseToken)}`;
  const response = await fetch(url, { headers: { authorization: `Bearer ${access}`, accept: "application/json" } }).catch(() => null);
  if (!response) throw new HttpError(503, "store_unavailable", "Couldn't reach Google Play. Please try again.");
  // Google answers 400 or 404 (410 once expired) for a token that isn't a purchase of this product in this app.
  if (response.status === 400 || response.status === 404 || response.status === 410) return { state: "unknown", orderId: null, test: false };
  if (response.status === 401 || response.status === 403) {
    if (response.status === 401) cachedAccess = null;
    console.error(`play: refused (${response.status}); check the service account's access in Play Console`);
    throw new HttpError(503, "store_unavailable", "Couldn't reach Google Play. Please try again.");
  }
  if (!response.ok) throw new HttpError(503, "store_unavailable", "Couldn't reach Google Play. Please try again.");
  const body = (await response.json().catch(() => null)) as { purchaseState?: number; orderId?: string; purchaseType?: number } | null;
  if (!body) throw new HttpError(503, "store_unavailable", "Couldn't reach Google Play. Please try again.");
  const state = body.purchaseState === 0 ? "purchased" : body.purchaseState === 1 ? "cancelled" : body.purchaseState === 2 ? "pending" : "unknown";
  return { state, orderId: typeof body.orderId === "string" ? body.orderId : null, test: body.purchaseType === 0 };
}

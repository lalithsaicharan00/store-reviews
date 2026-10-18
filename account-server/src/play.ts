import { SignJWT, importPKCS8 } from "jose";
import { HttpError } from "./http";

/**
 * Checking a Google Play purchase with Google (D16: "We verify it with Google or Apple"). The Worker asks the Play
 * Developer API about the purchase token the app sent; nothing the app says about a purchase is trusted on its own.
 *
 * **Keyless** (the user, 16 Oct 2026, following Google's advice not to download service account keys): the Worker signs
 * in to Google through **Workload Identity Federation**, as its own small identity provider. It signs a 5-minute token
 * with its own key (GOOGLE_WIF_SIGNING_KEY, made straight into Cloudflare by `scripts/make-wif-key.mjs`, never on disk
 * or in the repository: D11; Google holds only its public half), trades it at Google's Security Token Service for a
 * federated token, and that for a one-hour token as the service account `play-purchases@…` (IAM Credentials
 * `generateAccessToken`), which Play Console lets read purchases. No Google key exists anywhere.
 */

/** Our one-time products. The upgrade is Plus → Plus Family for the difference, so it counts only beside Plus (`paidFor`). */
export const PLUS = "com.oftenenough.app.plus";
export const FAMILY = "com.oftenenough.app.plusfamily";
export const UPGRADE = "com.oftenenough.app.plusfamily.upgrade";
export const PRODUCTS: Record<string, "plus" | "family" | "upgrade"> = { [PLUS]: "plus", [FAMILY]: "family", [UPGRADE]: "upgrade" };

/**
 * What an account's active purchases pay for. Plus Family is paid by Plus Family itself, or by the upgrade **together
 * with** Plus (the upgrade is only the difference: bought alone, by a modified app, it gives nothing). Whichever of the
 * two reaches the Worker first, the family starts when both are there, and a refund of either ends it.
 */
export function paidFor(products: string[]): { plus: boolean; family: boolean } {
  const has = new Set(products);
  const family = has.has(FAMILY) || (has.has(UPGRADE) && has.has(PLUS));
  return { plus: family || has.has(PLUS), family };
}

export interface PlayCheck {
  /** Bought and paid; cancelled (refunded, revoked); pending (not paid yet); unknown (not a purchase of ours). */
  state: "purchased" | "cancelled" | "pending" | "unknown";
  orderId: string | null;
  /** A license tester's purchase (Play Console's test card). */
  test: boolean;
}

/** Where and as whom the Worker signs in to Google (wrangler.jsonc's GOOGLE_* vars, and the signing key's secret). */
export interface GoogleAccess {
  /** The Worker's own private key (PKCS #8 PEM), a Cloudflare secret. */
  signingKey: string | undefined;
  /** Its ID, as uploaded to the pool's provider ("account-production-1"). */
  keyId: string;
  /** The provider's issuer, and this Worker's subject in it ("often-enough-account", "…-dev"). */
  issuer: string;
  subject: string;
  /** The Google Cloud project's number, the pool and the provider. */
  projectNumber: string;
  pool: string;
  provider: string;
  /** The service account Play Console gives access to. */
  serviceAccount: string;
}

export function googleAccess(env: Env): GoogleAccess {
  return {
    signingKey: env.GOOGLE_WIF_SIGNING_KEY,
    keyId: env.GOOGLE_WIF_KEY_ID,
    issuer: env.GOOGLE_WIF_ISSUER,
    subject: env.GOOGLE_WIF_SUBJECT,
    projectNumber: env.GOOGLE_PROJECT_NUMBER,
    pool: env.GOOGLE_WIF_POOL,
    provider: env.GOOGLE_WIF_PROVIDER,
    serviceAccount: env.GOOGLE_PLAY_SERVICE_ACCOUNT_EMAIL,
  };
}

const STS_URL = "https://sts.googleapis.com/v1/token";
const PLAY_SCOPE = "https://www.googleapis.com/auth/androidpublisher";
let cachedAccess: { token: string; expiresAt: number; who: string } | null = null;

/** For tests: forget the cached access token. */
export function clearPlayToken() {
  cachedAccess = null;
}

const notSetUp = () => new HttpError(503, "purchases_not_configured", "Purchases can't be checked yet. Please try again later.");
const unavailable = () => new HttpError(503, "store_unavailable", "Couldn't reach Google Play. Please try again.");

/** The provider's address: "//iam.googleapis.com/projects/N/locations/global/workloadIdentityPools/P/providers/Q". */
export function providerName(g: GoogleAccess): string {
  return `//iam.googleapis.com/projects/${g.projectNumber}/locations/global/workloadIdentityPools/${g.pool}/providers/${g.provider}`;
}

/**
 * A one-hour access token as the Play service account, kept until a minute before it ends. Three steps, all keyless on
 * Google's side: our signed token → Google's federated token → the service account's token.
 */
async function accessToken(g: GoogleAccess): Promise<string> {
  if (!g.signingKey || !g.keyId || !g.issuer || !g.subject || !g.projectNumber || !g.pool || !g.provider || !g.serviceAccount) throw notSetUp();
  const now = Date.now();
  const who = `${g.serviceAccount}|${g.subject}|${g.keyId}`;
  if (cachedAccess && cachedAccess.who === who && cachedAccess.expiresAt - 60_000 > now) return cachedAccess.token;

  // 1. Our own token, for the pool's provider (its default audience is the provider's address over https).
  let key: CryptoKey;
  try {
    key = await importPKCS8(g.signingKey, "RS256");
  } catch {
    throw notSetUp();
  }
  const provider = providerName(g);
  const subjectToken = await new SignJWT({})
    .setProtectedHeader({ alg: "RS256", kid: g.keyId, typ: "JWT" })
    .setIssuer(g.issuer)
    .setSubject(g.subject)
    .setAudience("https:" + provider)
    .setIssuedAt(Math.floor(now / 1000))
    .setExpirationTime(Math.floor(now / 1000) + 300)
    .sign(key);

  // 2. Google's Security Token Service trades it for a federated token.
  const sts = await fetch(STS_URL, {
    method: "POST",
    headers: { "content-type": "application/json" },
    body: JSON.stringify({
      grantType: "urn:ietf:params:oauth:grant-type:token-exchange",
      audience: provider,
      scope: "https://www.googleapis.com/auth/cloud-platform",
      requestedTokenType: "urn:ietf:params:oauth:token-type:access_token",
      subjectToken,
      subjectTokenType: "urn:ietf:params:oauth:token-type:jwt",
    }),
  }).catch(() => null);
  const federated = sts?.ok ? ((await sts.json().catch(() => null)) as { access_token?: string } | null) : null;
  if (!federated?.access_token) {
    // 400: the pool, provider, key or subject isn't set up as Google expects (the README's console steps).
    console.error(`play: no federated token (${sts?.status ?? "network"})`);
    throw sts && sts.status >= 400 && sts.status < 500 ? notSetUp() : unavailable();
  }

  // 3. The service account's own token, for the Play Developer API.
  const iam = await fetch(`https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/${encodeURIComponent(g.serviceAccount)}:generateAccessToken`, {
    method: "POST",
    headers: { authorization: `Bearer ${federated.access_token}`, "content-type": "application/json" },
    body: JSON.stringify({ scope: [PLAY_SCOPE], lifetime: "3600s" }),
  }).catch(() => null);
  const access = iam?.ok ? ((await iam.json().catch(() => null)) as { accessToken?: string; expireTime?: string } | null) : null;
  if (!access?.accessToken) {
    // 403: the pool's subject hasn't been given "Workload Identity User" on the service account.
    console.error(`play: no service account token (${iam?.status ?? "network"})`);
    throw iam && iam.status >= 400 && iam.status < 500 ? notSetUp() : unavailable();
  }
  const ends = access.expireTime ? Date.parse(access.expireTime) : NaN;
  cachedAccess = { token: access.accessToken, expiresAt: Number.isFinite(ends) ? ends : now + 3600_000, who };
  return access.accessToken;
}

/**
 * Whether the Worker can sign in to Google as the Play service account right now (GET /v1/health/play): "ready", "not
 * set up" (the signing key, the pool, the provider or the service account's permission is missing), or "unavailable".
 */
export async function playReady(g: GoogleAccess): Promise<"ready" | "not_set_up" | "unavailable"> {
  try {
    await accessToken(g);
    return "ready";
  } catch (error) {
    return error instanceof HttpError && error.code === "purchases_not_configured" ? "not_set_up" : "unavailable";
  }
}

/** Asks Google Play about one purchase of [product] with [purchaseToken] in the app [packageName]. */
export async function checkPlayPurchase(google: GoogleAccess, packageName: string, product: string, purchaseToken: string): Promise<PlayCheck> {
  if (!(product in PRODUCTS)) return { state: "unknown", orderId: null, test: false };
  const access = await accessToken(google);
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

/** One voided purchase, as the Voided Purchases API lists it (only what the Worker uses). */
export interface VoidedPurchase {
  purchaseToken: string;
  /** Present only for a quantity-based partial refund; ours are bought one at a time, so it's never set for them. */
  voidedQuantity?: number;
}

/**
 * One page of the Voided Purchases API (`purchases.voidedpurchases.list`): one-time purchases Google voided (refunded,
 * revoked or charged back) that it first saw as voided between [startTime] and [endTime] (milliseconds; at most 30 days
 * back). Needs Play Console's "View financial data" for the service account. Quota: 6,000 a day, 30 per 30 seconds.
 */
export async function listVoidedPurchases(google: GoogleAccess, packageName: string, startTime: number, endTime: number, pageToken?: string):
  Promise<{ voided: VoidedPurchase[]; nextPageToken: string | null }> {
  const access = await accessToken(google);
  const query = new URLSearchParams({ startTime: String(startTime), endTime: String(endTime), maxResults: "1000", type: "0" });
  if (pageToken) query.set("token", pageToken);
  const url = `https://androidpublisher.googleapis.com/androidpublisher/v3/applications/${encodeURIComponent(packageName)}/purchases/voidedpurchases?${query}`;
  const response = await fetch(url, { headers: { authorization: `Bearer ${access}`, accept: "application/json" } }).catch(() => null);
  if (!response) throw unavailable();
  if (response.status === 401) cachedAccess = null;
  if (!response.ok) {
    // 403: the service account can't view financial data in Play Console (README, "Refunds").
    console.error(`play: voided purchases refused (${response.status})`);
    throw unavailable();
  }
  const body = (await response.json().catch(() => null)) as {
    voidedPurchases?: { purchaseToken?: unknown; voidedQuantity?: unknown }[];
    tokenPagination?: { nextPageToken?: unknown };
  } | null;
  if (!body) throw unavailable();
  const voided = (body.voidedPurchases ?? [])
    .filter((v) => typeof v.purchaseToken === "string" && v.purchaseToken.length > 0)
    .map((v) => ({ purchaseToken: v.purchaseToken as string, ...(typeof v.voidedQuantity === "number" ? { voidedQuantity: v.voidedQuantity } : {}) }));
  const next = body.tokenPagination?.nextPageToken;
  return { voided, nextPageToken: typeof next === "string" && next.length > 0 ? next : null };
}

import { type JWK, SignJWT, exportJWK, generateKeyPair, importSPKI, jwtVerify } from "jose";
import { env, exports } from "cloudflare:workers";
import { vi } from "vitest";

/**
 * Stand-ins for Google, Apple and Google Play: our own RSA keys served at the providers' real key URLs, ID tokens signed
 * with them, and a Play Developer API that knows the purchases a test sets up, all through a mocked fetch. The Worker,
 * D1 and every check in them are the real code.
 */

export const GOOGLE_KEYS = "https://www.googleapis.com/oauth2/v3/certs";
export const APPLE_KEYS = "https://appleid.apple.com/auth/keys";
export const GOOGLE_AUDIENCE = "test-google-client.apps.googleusercontent.com";
export const APPLE_AUDIENCE = "com.oftenenough.app";

export interface SigningKey { kid: string; privateKey: CryptoKey; jwk: JWK }

export async function newKey(kid: string): Promise<SigningKey> {
  const { privateKey, publicKey } = await generateKeyPair("RS256", { extractable: true });
  return { kid, privateKey: privateKey as CryptoKey, jwk: { ...(await exportJWK(publicKey)), kid, alg: "RS256", use: "sig" } };
}

/** The keys each provider publishes now, and how often its key URL was fetched. */
export const published: Record<string, SigningKey[]> = { [GOOGLE_KEYS]: [], [APPLE_KEYS]: [] };
export const keyFetches: Record<string, number> = { [GOOGLE_KEYS]: 0, [APPLE_KEYS]: 0 };

/** Google Play's purchases, by purchase token: what the Play Developer API answers. */
export interface PlayPurchase { product: string; purchaseState: number; orderId: string; purchaseType?: number }
export const play = {
  purchases: new Map<string, PlayPurchase>(),
  /**
   * "ok", or Google failing: "down" (500 everywhere), "refused" (Play answers 403: the service account lacks access),
   * "sts-refused" (the pool or provider isn't set up: 400), "iam-refused" (no Workload Identity User: 403).
   */
  mode: "ok" as "ok" | "down" | "refused" | "sts-refused" | "iam-refused",
  /** Federated sign-ins (one per access token, which is reused for its hour). */
  tokenRequests: 0,
  purchaseRequests: 0,
};

const PLAY_ACCESS = "play-access-token-for-tests";
const FEDERATED = "federated-token-for-tests";
/** What dev's wrangler.jsonc says (the tests run as dev). */
export const WIF = {
  provider: "//iam.googleapis.com/projects/367584981284/locations/global/workloadIdentityPools/cloudflare-workers/providers/often-enough-account",
  issuer: "https://api.oftenenough.com",
  subject: "often-enough-account-dev",
  keyId: "account-dev-1",
  serviceAccount: "play-purchases@often-enough.iam.gserviceaccount.com",
};

export function mockGoogle() {
  const realFetch = globalThis.fetch;
  vi.spyOn(globalThis, "fetch").mockImplementation(async (input, init) => {
    const request = new Request(input as RequestInfo, init);
    const url = request.url;
    if (url in published) {
      keyFetches[url] = (keyFetches[url] ?? 0) + 1;
      return Response.json({ keys: published[url]!.map((k) => k.jwk) });
    }
    if (url === "https://sts.googleapis.com/v1/token") {
      // Google's Security Token Service, as Workload Identity Federation's OIDC provider checks a token: our uploaded
      // public key (by key ID), the provider's issuer and default audience, and a lifetime of at most 24 hours.
      play.tokenRequests++;
      if (play.mode === "down") return new Response("unavailable", { status: 500 });
      if (play.mode === "sts-refused") return Response.json({ error: "invalid_target" }, { status: 400 });
      const body = JSON.parse(new TextDecoder().decode(await request.arrayBuffer())) as Record<string, string>;
      if (body.grantType !== "urn:ietf:params:oauth:grant-type:token-exchange" || body.audience !== WIF.provider
        || body.requestedTokenType !== "urn:ietf:params:oauth:token-type:access_token" || body.subjectTokenType !== "urn:ietf:params:oauth:token-type:jwt") {
        return Response.json({ error: "invalid_request" }, { status: 400 });
      }
      try {
        const key = await importSPKI(env.PLAY_TEST_PUBLIC_KEY, "RS256");
        const { payload, protectedHeader } = await jwtVerify(body.subjectToken ?? "", key, { issuer: WIF.issuer, audience: "https:" + WIF.provider });
        const lifetime = (payload.exp ?? 0) - (payload.iat ?? 0);
        if (protectedHeader.kid !== WIF.keyId || payload.sub !== WIF.subject || lifetime <= 0 || lifetime > 24 * 3600) throw new Error("claims");
      } catch {
        return Response.json({ error: "invalid_grant" }, { status: 400 });
      }
      return Response.json({ access_token: FEDERATED, issued_token_type: "urn:ietf:params:oauth:token-type:access_token", token_type: "Bearer", expires_in: 3600 });
    }
    if (url === `https://iamcredentials.googleapis.com/v1/projects/-/serviceAccounts/${encodeURIComponent(WIF.serviceAccount)}:generateAccessToken`) {
      // IAM Credentials: the federated identity, given "Workload Identity User" on the service account, gets its token.
      if (play.mode === "down") return new Response("unavailable", { status: 500 });
      if (play.mode === "iam-refused") return Response.json({ error: { code: 403, status: "PERMISSION_DENIED" } }, { status: 403 });
      if (request.headers.get("authorization") !== `Bearer ${FEDERATED}`) return Response.json({ error: { code: 401 } }, { status: 401 });
      const body = JSON.parse(new TextDecoder().decode(await request.arrayBuffer())) as { scope?: string[] };
      if (!body.scope?.includes("https://www.googleapis.com/auth/androidpublisher")) return Response.json({ error: { code: 400 } }, { status: 400 });
      return Response.json({ accessToken: PLAY_ACCESS, expireTime: new Date(Date.now() + 3600_000).toISOString() });
    }
    const match = /^https:\/\/androidpublisher\.googleapis\.com\/androidpublisher\/v3\/applications\/([^/]+)\/purchases\/products\/([^/]+)\/tokens\/([^/]+)$/.exec(url);
    if (match) {
      play.purchaseRequests++;
      if (play.mode === "down") return new Response("unavailable", { status: 500 });
      if (play.mode === "refused") return Response.json({ error: { code: 403 } }, { status: 403 });
      if (request.headers.get("authorization") !== `Bearer ${PLAY_ACCESS}`) return Response.json({ error: { code: 401 } }, { status: 401 });
      const [, pkg, product, token] = match;
      const p = play.purchases.get(decodeURIComponent(token!));
      if (decodeURIComponent(pkg!) !== "com.oftenenough.app" || !p || p.product !== decodeURIComponent(product!)) {
        return Response.json({ error: { code: 400, message: "Invalid Value" } }, { status: 400 });
      }
      return Response.json({ kind: "androidpublisher#productPurchase", purchaseState: p.purchaseState, orderId: p.orderId, purchaseType: p.purchaseType, consumptionState: 0, acknowledgementState: 1 });
    }
    return realFetch(input, init);
  });
}

export async function sha256Hex(text: string): Promise<string> {
  const digest = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text));
  return [...new Uint8Array(digest)].map((b) => b.toString(16).padStart(2, "0")).join("");
}

export interface Who {
  provider: "google" | "apple";
  subject: string;
  email?: string;
  givenName?: string;
}

export interface TokenOptions {
  key?: SigningKey;
  issuer?: string;
  audience?: string;
  nonce?: string;
  expiresIn?: number;
  claims?: Record<string, unknown>;
}

/** An ID token from Google or Apple for [who], and the raw nonce the app would send with it. */
export async function idToken(who: Who, o: TokenOptions = {}): Promise<{ idToken: string; nonce: string }> {
  const google = who.provider === "google";
  const nonce = crypto.randomUUID();
  const key = o.key ?? published[google ? GOOGLE_KEYS : APPLE_KEYS]![0]!;
  const now = Math.floor(Date.now() / 1000);
  const token = await new SignJWT({
    nonce: o.nonce ?? (await sha256Hex(nonce)),
    ...(who.email ? { email: who.email, email_verified: true } : {}),
    ...(who.givenName ? { given_name: who.givenName, name: who.givenName + " Surname" } : {}),
    ...o.claims,
  })
    .setProtectedHeader({ alg: "RS256", kid: key.kid })
    .setIssuer(o.issuer ?? (google ? "https://accounts.google.com" : "https://appleid.apple.com"))
    .setAudience(o.audience ?? (google ? GOOGLE_AUDIENCE : APPLE_AUDIENCE))
    .setSubject(who.subject)
    .setIssuedAt(now)
    .setExpirationTime(now + (o.expiresIn ?? 600))
    .sign(key.privateKey);
  return { idToken: token, nonce };
}

let ipCounter = 0;
/** A fresh caller IP, so one test's sign-ins don't use up another's rate limit. */
export function newIp() {
  return `test-ip-${++ipCounter}`;
}

export interface Reply { status: number; body: any; headers?: Headers }

/** One call to the Worker, as the app makes it. */
export async function call(method: string, path: string, opts: { session?: string; body?: unknown; ip?: string; raw?: string } = {}): Promise<Reply> {
  const headers: Record<string, string> = { "cf-connecting-ip": opts.ip ?? newIp() };
  if (opts.session) headers.authorization = `Bearer ${opts.session}`;
  if (opts.body !== undefined || opts.raw !== undefined) headers["content-type"] = "application/json";
  const response = await exports.default.fetch(new Request(`https://api.test${path}`, {
    method,
    headers,
    body: opts.raw ?? (opts.body === undefined ? undefined : JSON.stringify(opts.body)),
  }));
  const text = await response.text();
  return { status: response.status, body: text ? JSON.parse(text) : null, headers: response.headers };
}

export async function signIn(who: Who, o: TokenOptions = {}) {
  return call("POST", "/v1/sign-in", { body: { provider: who.provider, ...(await idToken(who, o)) } });
}

/** Makes [who]'s account (with a Play purchase if given) and returns its session and account. */
export async function createAccount(who: Who, purchase?: { product: string; token: string }, name?: string) {
  const reply = await call("POST", "/v1/accounts", { body: { provider: who.provider, ...(await idToken(who)), name, purchase } });
  if (reply.status !== 200) throw new Error(`create ${reply.status} ${JSON.stringify(reply.body)}`);
  return reply.body as { session: string; account: any };
}

let purchaseCounter = 0;
/** A purchase bought on Google Play: its token, now known to the Play stand-in. */
export function bought(product = "com.oftenenough.app.plus", purchaseState = 0, purchaseType?: number) {
  purchaseCounter++;
  const token = `play-token-${purchaseCounter}-${crypto.randomUUID()}`;
  play.purchases.set(token, { product, purchaseState, orderId: `GPA.0000-${purchaseCounter}`, purchaseType });
  return { product, token };
}

let personCounter = 0;
export function person(name = "Sam", provider: "google" | "apple" = "google"): Who {
  personCounter++;
  return { provider, subject: `${provider}-subject-${personCounter}-${crypto.randomUUID()}`, email: `${name.toLowerCase()}${personCounter}@gmail.com`, givenName: name };
}

/** A family owner (Plus Family bought on Google Play) and their session. */
export async function familyOwner(name = "Lee") {
  return createAccount(person(name), bought("com.oftenenough.app.plusfamily"));
}

/** [owner] invites; [who] (a new account) joins with the link. */
export async function joinFamily(ownerSession: string, name = "Priya") {
  const invited = await call("POST", "/v1/family/invite", { session: ownerSession });
  const token = invited.body.account.family.invite.token as string;
  const member = await createAccount(person(name));
  const joined = await call("POST", `/v1/invites/${token}/join`, { session: member.session });
  return { token, member: { session: member.session, account: joined.body.account } };
}

/** Lets work the Worker handed to waitUntil finish: polls [check] for up to two seconds. */
export async function eventually(check: () => Promise<boolean>) {
  for (let i = 0; i < 40; i++) {
    if (await check()) return;
    await new Promise((r) => setTimeout(r, 50));
  }
  throw new Error("never happened");
}

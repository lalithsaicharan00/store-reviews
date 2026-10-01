import { type Account, type DeviceInfo, MAX_PUSH, type PurchaseRecord } from "./account";
import { APPLE_ROOT_CA_G3, verifyAppleSigned } from "./apple";
import { deleteBackups, listBackups, readBackup, storeBackup } from "./backup";
import { adminRoute } from "./admin";
import { accountStub } from "./stubs";
import { dailyReport, recordRequest } from "./report";
import { deleteSnapshots } from "./snapshots";
import {
  type Jurisdiction,
  createAccount,
  deleteAccount,
  findAccount,
  jurisdictionFor,
  jurisdictionOf,
  linkKey,
  linkPurchase,
  purchaseOwner,
  unlinkKey,
  wasDeleted,
} from "./directory";
import { HttpError, errorResponse, isUuid, json, readJson, requireString } from "./http";
import { APPLE, GOOGLE, type VerifiedKey, verifyCiToken, verifyIdToken } from "./providers";
import {
  type AccessClaims,
  bearer,
  composeRefreshToken,
  issueAccessToken,
  parseRefreshToken,
  safeEqual,
  verifyAccessToken,
} from "./tokens";

export { Account } from "./account";

/** The Often Enough API (Architecture 06). Every route is under /v1 and answers JSON. */
export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const started = Date.now();
    const url = new URL(request.url);
    let response: Response;
    const origin = webOrigin(request, url, env);
    if (request.method === "OPTIONS" && origin) return preflight(origin);
    try {
      response = await route(request, url, env);
    } catch (error) {
      if (error instanceof HttpError) {
        response = errorResponse(error);
      } else {
        // Never log request bodies or tokens: they can hold habit names and credentials (Architecture 06 §11).
        console.error(JSON.stringify({ message: "unhandled error", path: url.pathname, error: error instanceof Error ? error.message : String(error) }));
        response = json({ error: "server_error", message: "Our server is having trouble. Your data is safe on your phone." }, 500);
      }
    }
    if (origin) {
      response = new Response(response.body, response);
      response.headers.set("access-control-allow-origin", origin);
      response.headers.append("vary", "Origin");
    }
    const ms = Date.now() - started;
    console.log(JSON.stringify({ route: `${request.method} ${url.pathname}`, status: response.status, ms }));
    recordRequest(env, request.method, url.pathname, response.status, ms);
    return response;
  },

  /** The daily report (cron `0 6 * * *`, Architecture 06 §10). */
  async scheduled(controller, env, ctx): Promise<void> {
    ctx.waitUntil(dailyReport(env, controller.scheduledTime));
  },
} satisfies ExportedHandler<Env>;

async function route(request: Request, url: URL, env: Env): Promise<Response> {
  const key = `${request.method} ${url.pathname}`;
  if (url.pathname.startsWith("/v1/auth/")) await limitByIp(request, env);
  if (url.pathname.startsWith("/v1/admin/")) return adminRoute(request, url, env);
  const copy = /^\/v1\/backup\/([^/]+)\/([^/]+)$/.exec(url.pathname);
  if (copy && request.method === "GET") return backupFile(request, env, copy[1]!, copy[2]!);
  switch (key) {
    case "GET /v1/status":
      return json({ ok: true, environment: env.ENVIRONMENT, time: Date.now() }, 200, { "cache-control": "public, max-age=30" });
    case "POST /v1/auth/apple":
      return signIn(request, env, (body) => verifyIdToken(APPLE, requireString(body.idToken, "idToken", 8192), requireString(body.nonce, "nonce", 256), audiences(env.APPLE_AUDIENCES)));
    case "POST /v1/auth/google":
      return signIn(request, env, (body) => verifyIdToken(GOOGLE, requireString(body.idToken, "idToken", 8192), requireString(body.nonce, "nonce", 256), audiences(env.GOOGLE_AUDIENCES)));
    case "POST /v1/auth/test":
      return signIn(request, env, (body) => verifyTestKey(body, env));
    case "POST /v1/auth/ci":
      return signIn(request, env, (body) => verifyCiKey(body, env));
    case "POST /v1/auth/refresh":
      return refresh(request, env);
    case "GET /v1/account":
      return accountSummary(request, env);
    case "POST /v1/account/link":
      return link(request, env);
    case "POST /v1/account/unlink":
      return unlink(request, env);
    case "POST /v1/account/signout":
      return signOut(request, env);
    case "POST /v1/account/delete":
      return remove(request, env);
    case "POST /v1/sync":
      return sync(request, env);
    case "PUT /v1/backup":
      return backupUpload(request, env);
    case "GET /v1/backup":
      return backupList(request, env);
    case "DELETE /v1/backup":
      return backupDelete(request, env);
    case "POST /v1/purchases/verify":
      return verifyPurchase(request, env);
    case "GET /v1/purchases":
      return purchases(request, env);
    case "POST /v1/hooks/apple":
      return appleNotification(request, env);
  }
  throw new HttpError(404, "not_found", "There's nothing here.");
}

// MARK: Sign-in

interface SignInBody {
  idToken?: unknown;
  nonce?: unknown;
  /** True only after the person chose "Create account": an unknown key never creates one silently (01 §3.3). */
  create?: unknown;
  device?: unknown;
  /** The store country, which decides where a new account's data is kept. */
  country?: unknown;
  // Test sign-in only:
  secret?: unknown;
  subject?: unknown;
  /** Test and CI sign-ins only: false makes a free account (default: Plus, so end-to-end tests can sync). */
  plus?: unknown;
}

async function signIn(request: Request, env: Env, verify: (body: SignInBody) => Promise<VerifiedKey>): Promise<Response> {
  const body = await readJson<SignInBody>(request);
  const device = parseDevice(body.device);
  const key = await verify(body);
  let account = await findAccount(env.DIRECTORY, key.provider, key.subject);
  let created = false;
  if (!account) {
    if (body.create !== true) {
      throw new HttpError(404, "unknown_key", "There's no account for this sign-in yet.");
    }
    account = await createAccount(env.DIRECTORY, key, jurisdictionFor(body.country));
    created = true;
  }
  const claims: AccessClaims = { accountId: account.accountId, deviceId: device.id, jurisdiction: account.jurisdiction };
  const testPlus = key.provider === "test" || key.provider === "ci" ? body.plus !== false : null;
  const session = await accountStub(env, claims).openSession(account.accountId, key, device, testPlus);
  if (!session.ok) throw new HttpError(409, "account_unavailable", "This account can't be opened right now. Please try again.");
  return json({ accountId: account.accountId, created, ...(await tokens(env, { ...claims, plus: session.plus }, session.secret)) }, created ? 201 : 200);
}

/** Dev only: a sign-in that needs no Apple or Google account, for end-to-end tests. It doesn't exist anywhere else. */
async function verifyTestKey(body: SignInBody, env: Env): Promise<VerifiedKey> {
  const expected = env.TEST_LOGIN_SECRET;
  if (env.ENVIRONMENT !== "dev" || typeof expected !== "string" || expected.length < 32) throw new HttpError(404, "not_found", "There's nothing here.");
  const secret = typeof body.secret === "string" ? body.secret : "";
  if (!(await safeEqual(secret, expected))) throw new HttpError(401, "invalid_token", "The sign-in couldn't be checked.");
  return { provider: "test", subject: requireString(body.subject, "subject", 200), email: null, isPrivateEmail: false };
}

/** Dev only: a sign-in for our GitHub Actions runs (end-to-end tests on the iPhone Simulator). */
async function verifyCiKey(body: SignInBody, env: Env): Promise<VerifiedKey> {
  const repository: string = env.CI_REPOSITORY;
  if (env.ENVIRONMENT !== "dev" || !repository) throw new HttpError(404, "not_found", "There's nothing here.");
  const subject = requireString(body.subject, "subject", 200);
  return verifyCiToken(requireString(body.idToken, "idToken", 8192), CI_AUDIENCE, repository, `${repository}:${subject}`);
}

/** The audience our workflow asks GitHub to mint its identity token for. */
export const CI_AUDIENCE = "oftenenough-api-dev";

const PLATFORMS = new Set(["ios", "ipados", "watchos", "android", "wearos", "web", "mac", "windows"]);

function parseDevice(value: unknown): DeviceInfo {
  const device = (value ?? {}) as Record<string, unknown>;
  if (!isUuid(device.id)) throw new HttpError(400, "bad_request", '"device.id" must be a UUID.');
  if (typeof device.platform !== "string" || !PLATFORMS.has(device.platform)) throw new HttpError(400, "bad_request", '"device.platform" is invalid.');
  return {
    id: device.id.toLowerCase(),
    platform: device.platform,
    name: requireString(device.name, "device.name", 100),
    appVersion: requireString(device.appVersion, "device.appVersion", 32),
  };
}

/** `plus` tells the app whether this account syncs; it's also inside the access token, where the server checks it. */
async function tokens(env: Env, claims: AccessClaims, secret: string) {
  const access = await issueAccessToken(claims, env.TOKEN_KEY);
  return { accessToken: access.token, accessTokenExpiresAt: access.expiresAt, refreshToken: composeRefreshToken(claims, secret), plus: claims.plus === true };
}

// MARK: Sessions

async function refresh(request: Request, env: Env): Promise<Response> {
  const body = await readJson<{ refreshToken?: unknown }>(request);
  const parsed = parseRefreshToken(body.refreshToken);
  if (!parsed || !isUuid(parsed.accountId) || !isUuid(parsed.deviceId)) throw signedOut();
  const result = await accountStub(env, parsed).refresh(parsed.deviceId, parsed.secret);
  // A deleted account says so, so its other devices don't ask the person to sign in again (09 §7).
  if (!result.ok && result.reason === "gone" && (await wasDeleted(env.DIRECTORY, parsed.accountId))) {
    throw new HttpError(401, "account_deleted", "This account was deleted. Everything on this device is kept.");
  }
  if (!result.ok) throw signedOut();
  return json(await tokens(env, { ...parsed, plus: result.plus }, result.secret));
}

/** The app keeps all its data and shows "Sign in again to keep syncing" (01 §3.5). */
function signedOut() {
  return new HttpError(401, "signed_out", "Sign in again to keep syncing. Everything on this device is kept.");
}

async function authenticate(request: Request, env: Env): Promise<AccessClaims> {
  const token = bearer(request);
  const claims = token ? await verifyAccessToken(token, env.TOKEN_KEY) : null;
  if (!claims) throw new HttpError(401, "token_expired", "The access token is missing or expired; refresh it.");
  return claims;
}

// MARK: Account

async function accountSummary(request: Request, env: Env): Promise<Response> {
  const claims = await authenticate(request, env);
  const summary = await accountStub(env, claims).summary();
  if (!summary) throw signedOut();
  return json(summary);
}

async function link(request: Request, env: Env): Promise<Response> {
  const claims = await authenticate(request, env);
  const body = await readJson<SignInBody & { provider?: unknown }>(request);
  const key =
    body.provider === "apple"
      ? await verifyIdToken(APPLE, requireString(body.idToken, "idToken", 8192), requireString(body.nonce, "nonce", 256), audiences(env.APPLE_AUDIENCES))
      : body.provider === "google"
        ? await verifyIdToken(GOOGLE, requireString(body.idToken, "idToken", 8192), requireString(body.nonce, "nonce", 256), audiences(env.GOOGLE_AUDIENCES))
        : body.provider === "test"
          ? await verifyTestKey(body, env)
          : null;
  if (!key) throw new HttpError(400, "bad_request", '"provider" must be "apple" or "google".');
  const stub = accountStub(env, claims);
  if (!(await stub.summary())) throw signedOut();
  const result = await linkKey(env.DIRECTORY, claims.accountId, key);
  if (result === "used_by_another_account") {
    throw new HttpError(409, "used_by_another_account", "This sign-in already opens a different account. Sign in with it to merge the two.");
  }
  if (result === "provider_already_linked") {
    throw new HttpError(409, "provider_already_linked", "This account already has a sign-in from that provider.");
  }
  await stub.addKey(key);
  return json({ linked: true });
}

async function unlink(request: Request, env: Env): Promise<Response> {
  const claims = await authenticate(request, env);
  const body = await readJson<{ provider?: unknown }>(request);
  const provider = requireString(body.provider, "provider", 20);
  const result = await unlinkKey(env.DIRECTORY, claims.accountId, provider);
  if (!result.removed) {
    if (result.reason === "last_key") throw new HttpError(409, "last_key", "This is the only way to sign in, so it can't be removed.");
    throw new HttpError(404, "not_linked", "That sign-in isn't linked to this account.");
  }
  await accountStub(env, claims).removeKey(provider, result.subject);
  return json({ removed: true });
}

async function signOut(request: Request, env: Env): Promise<Response> {
  const claims = await authenticate(request, env);
  await accountStub(env, claims).endSession(claims.deviceId);
  return json({ signedOut: true });
}

/** Deletes the account (01 §3.7): first from the directory, so nothing can open it, then its data. Safe to retry. */
async function remove(request: Request, env: Env): Promise<Response> {
  const claims = await authenticate(request, env);
  await deleteAccount(env.DIRECTORY, claims.accountId);
  await accountStub(env, claims).wipe();
  await deleteBackups(env, claims);
  await deleteSnapshots(env, claims);
  return json({ deleted: true, at: Date.now() });
}

// MARK: Sync

/**
 * `{cursor, ops}` → `{applied, rejected, ops, cursor, more}` (Architecture 05, 06 §4). Only Plus syncs: a free
 * account is answered here, before any Durable Object is called (Server Cost and Capacity §4.2).
 */
async function sync(request: Request, env: Env): Promise<Response> {
  const claims = await authenticate(request, env);
  if (!claims.plus) throw new HttpError(403, "plus_required", "Sync is part of Plus. Your habits stay on this device and in your backup.");
  await limit(env.SYNC_LIMIT, claims.accountId);
  const body = await readJson<{ cursor?: unknown; ops?: unknown }>(request, 2 * 1024 * 1024);
  const ops = body.ops ?? [];
  if (!Array.isArray(ops)) throw new HttpError(400, "bad_request", '"ops" must be a list.');
  if (ops.length > MAX_PUSH) throw new HttpError(413, "too_many_ops", `Send at most ${MAX_PUSH} ops at a time.`);
  const cursor = typeof body.cursor === "number" ? body.cursor : 0;
  const result = await accountStub(env, claims).sync(claims.deviceId, { cursor, ops, jurisdiction: claims.jurisdiction });
  if (!result.ok) {
    if (result.reason === "too_many_ops") throw new HttpError(413, "too_many_ops", `Send at most ${MAX_PUSH} ops at a time.`);
    throw signedOut();
  }
  const { ok: _ok, ...reply } = result;
  return json(reply);
}

// MARK: Backup (accounts that don't sync; see backup.ts)

/** Checks the account still exists, so nothing is stored for an account deleted in the last hour. */
async function liveAccount(env: Env, claims: AccessClaims): Promise<AccessClaims> {
  if ((await jurisdictionOf(env.DIRECTORY, claims.accountId)) === null) throw signedOut();
  return claims;
}

async function backupUpload(request: Request, env: Env): Promise<Response> {
  const claims = await authenticate(request, env);
  await limit(env.BACKUP_LIMIT, `${claims.accountId}/${claims.deviceId}`);
  return storeBackup(request, env, await liveAccount(env, claims));
}

async function backupList(request: Request, env: Env): Promise<Response> {
  const claims = await authenticate(request, env);
  await limit(env.SYNC_LIMIT, claims.accountId);
  return listBackups(env, claims);
}

async function backupFile(request: Request, env: Env, device: string, slot: string): Promise<Response> {
  const claims = await authenticate(request, env);
  await limit(env.SYNC_LIMIT, claims.accountId);
  return readBackup(env, claims, device, slot);
}

/** "Keep my backup only in my iCloud" (Backup, Sync and Accounts §4.3): every copy on the server goes. */
async function backupDelete(request: Request, env: Env): Promise<Response> {
  const claims = await authenticate(request, env);
  return json({ deleted: await deleteBackups(env, claims) });
}

// MARK: Purchases (Architecture 02 §3.11)

/** What each App Store product unlocks. Plus Family includes Plus. */
const APPLE_PRODUCTS: Record<string, "plus" | "family"> = {
  "com.oftenenough.app.plus": "plus",
  "com.oftenenough.app.plusfamily": "family",
  "com.oftenenough.app.plusfamily.upgrade": "family",
};

function appleRoots(env: Env): string[] {
  // Dev may also trust a test root (unit tests, Xcode's StoreKit testing certificate). Production: Apple's alone.
  const extra = env.ENVIRONMENT === "dev" ? (env.APPLE_EXTRA_ROOTS ?? "").split(/(?=-----BEGIN CERTIFICATE-----)/).filter((p) => p.includes("BEGIN")) : [];
  return [APPLE_ROOT_CA_G3, ...extra];
}

/** Checks a signed StoreKit 2 transaction and turns it into a purchase record. */
async function applePurchase(jws: string, env: Env): Promise<PurchaseRecord & { appAccountToken: string | null }> {
  const t = await verifyAppleSigned(jws, appleRoots(env));
  const grants = typeof t.productId === "string" ? APPLE_PRODUCTS[t.productId] : undefined;
  const environments = env.APPLE_ENVIRONMENTS.split(",").map((e) => e.trim());
  if (t.bundleId !== env.APPLE_BUNDLE_ID || !grants || typeof t.originalTransactionId !== "string" || typeof t.environment !== "string") {
    throw new HttpError(400, "not_verified", "This purchase isn't one of ours.");
  }
  if (!environments.includes(t.environment)) throw new HttpError(400, "not_verified", "This purchase is from a test store this server doesn't accept.");
  return {
    store: "apple",
    originalId: t.originalTransactionId,
    productId: t.productId as string,
    grants,
    environment: t.environment,
    purchasedAt: typeof t.originalPurchaseDate === "number" ? t.originalPurchaseDate : typeof t.purchaseDate === "number" ? t.purchaseDate : Date.now(),
    revokedAt: typeof t.revocationDate === "number" ? t.revocationDate : null,
    appAccountToken: typeof t.appAccountToken === "string" ? t.appAccountToken.toLowerCase() : null,
  };
}

/** `{jws}` (Transaction.jwsRepresentation) → the account's entitlements. Safe to repeat. */
async function verifyPurchase(request: Request, env: Env): Promise<Response> {
  const claims = await authenticate(request, env);
  const body = await readJson<{ jws?: unknown }>(request, 64 * 1024);
  const purchase = await applePurchase(requireString(body.jws, "jws", 32 * 1024), env);
  if (purchase.appAccountToken && purchase.appAccountToken !== claims.accountId.toLowerCase()) {
    throw new HttpError(409, "purchase_for_another_account", "This purchase was made for a different account.");
  }
  if ((await linkPurchase(env.DIRECTORY, purchase.store, purchase.originalId, claims.accountId)) === "linked_elsewhere") {
    throw new HttpError(409, "purchase_linked_elsewhere", "This purchase already unlocks another account. Contact us and we'll move it.");
  }
  const { appAccountToken: _token, ...record } = purchase;
  const entitlements = await accountStub(env, claims).recordPurchase(record);
  if (!entitlements) throw signedOut();
  // A new access token that says Plus, so sync can start at once without waiting for the next refresh.
  const access = await issueAccessToken({ ...claims, plus: entitlements.plus }, env.TOKEN_KEY);
  return json({ ...entitlements, accessToken: access.token, accessTokenExpiresAt: access.expiresAt });
}

async function purchases(request: Request, env: Env): Promise<Response> {
  const claims = await authenticate(request, env);
  const entitlements = await accountStub(env, claims).entitlements();
  if (!entitlements) throw signedOut();
  return json(entitlements);
}

/**
 * App Store Server Notifications V2: Apple tells us about refunds and revocations. Only those change an account,
 * and only for a purchase we know; everything else is acknowledged and ignored. Repeats are harmless.
 */
async function appleNotification(request: Request, env: Env): Promise<Response> {
  const body = await readJson<{ signedPayload?: unknown }>(request, 64 * 1024);
  const notification = await verifyAppleSigned(requireString(body.signedPayload, "signedPayload", 60 * 1024), appleRoots(env));
  const type = notification.notificationType;
  const data = (notification.data ?? {}) as { bundleId?: unknown; signedTransactionInfo?: unknown };
  if (data.bundleId !== env.APPLE_BUNDLE_ID) throw new HttpError(400, "not_verified", "Not our app.");
  if ((type === "REFUND" || type === "REVOKE" || type === "REFUND_REVERSED") && typeof data.signedTransactionInfo === "string") {
    const purchase = await applePurchase(data.signedTransactionInfo, env);
    const owner = await purchaseOwner(env.DIRECTORY, purchase.store, purchase.originalId);
    if (owner) {
      const revokedAt = type === "REFUND_REVERSED" ? null : (purchase.revokedAt ?? Date.now());
      await accountStub(env, owner).setRevoked(purchase.store, purchase.originalId, revokedAt);
    }
  }
  return json({ received: true });
}

// MARK: Helpers

/**
 * The website (oftenenough.com) deletes accounts without the app (09 §7): it may call only these routes, and only from
 * the origins in `WEB_ORIGINS` (`*.` allows that host's subdomains, for Cloudflare Pages previews on dev).
 */
const WEB_ROUTES = new Set(["/v1/auth/google", "/v1/account/delete", "/v1/account/signout"]);

function webOrigin(request: Request, url: URL, env: Env): string | null {
  const origin = request.headers.get("origin");
  if (!origin || !WEB_ROUTES.has(url.pathname)) return null;
  const allowed = (env.WEB_ORIGINS ?? "").split(",").map((s) => s.trim()).filter(Boolean);
  const ok = allowed.some((a) => a === origin || (a.startsWith("https://*.") && origin.startsWith("https://") && origin.endsWith(a.slice("https://*".length))));
  return ok ? origin : null;
}

function preflight(origin: string): Response {
  return new Response(null, {
    status: 204,
    headers: {
      "access-control-allow-origin": origin,
      "access-control-allow-methods": "POST",
      "access-control-allow-headers": "content-type, authorization",
      "access-control-max-age": "86400",
      vary: "Origin",
    },
  });
}

/**
 * Rate limits (Architecture 06 §6): Cloudflare's rate-limit binding, approximate and per location, so it stops loops
 * and floods rather than counting exactly. The app backs off on 429 and retries after `Retry-After`.
 */
async function limit(limiter: RateLimit, key: string): Promise<void> {
  const { success } = await limiter.limit({ key });
  if (!success) throw new HttpError(429, "slow_down", "Too many requests. Your data is safe; we'll try again shortly.");
}

/** Sign-in and refresh, per IP. Cloudflare always sets the header; a request without one (tests) isn't limited. */
async function limitByIp(request: Request, env: Env): Promise<void> {
  const ip = request.headers.get("cf-connecting-ip");
  if (ip) await limit(env.AUTH_LIMIT, ip);
}


function audiences(list: string): string[] {
  return list.split(",").map((s) => s.trim()).filter(Boolean);
}

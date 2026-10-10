import { type Account, type DeviceInfo, type EndedReason, MAX_PUSH, type OtherDevice, type PurchaseRecord, type SyncResult } from "./account";
import { APPLE_ROOT_CA_G3, verifyAppleSigned } from "./apple";
import { exchangeAppleCode, revokeAppleToken } from "./appleTokens";
import { deleteBackups, listBackups, readBackup, storeBackup } from "./backup";
import { adminRoute } from "./admin";
import { accountStub } from "./stubs";
import { countUsage, dailyReport, recordRequest, recordSync } from "./report";
import { processConfirmation, retryConfirmations, scheduleConfirmation } from "./email";
import { deleteSnapshots } from "./snapshots";
import { listSnapshots, snapshotBackupFile } from "./snapshotFile";
import { cancelTransfer, getTransfer, pruneTransfers, putTransfer, receivedTransfer, transferStatus } from "./transfer";
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
import { APPLE, GOOGLE, type VerifiedKey, verifyAppleEvent, verifyCiToken, verifyIdToken } from "./providers";
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
  async fetch(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
    const started = Date.now();
    const url = new URL(request.url);
    let response: Response;
    const origin = webOrigin(request, url, env);
    if (request.method === "OPTIONS" && origin) return preflight(origin);
    try {
      response = await route(request, url, env, ctx);
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
      response.headers.set("access-control-expose-headers", "content-disposition");
      response.headers.append("vary", "Origin");
    }
    const ms = Date.now() - started;
    console.log(JSON.stringify({ route: `${request.method} ${url.pathname}`, status: response.status, ms }));
    recordRequest(env, request.method, url.pathname, response.status, ms);
    return response;
  },

  /** The daily report (cron `0 6 * * *`, Architecture 06 §10). */
  async scheduled(controller, env, ctx): Promise<void> {
    // Independent: a failing email retry must never cost the day's report.
    const failed = (job: string) => (error: unknown) => console.error(JSON.stringify({ event: "cron_failed", job, error: String(error) }));
    ctx.waitUntil(
      retryConfirmations(env, controller.scheduledTime)
        .catch(failed("purchase_emails"))
        .then(() => dailyReport(env, controller.scheduledTime))
        .catch(failed("daily_report")),
    );
    ctx.waitUntil(pruneTransfers(env, controller.scheduledTime).catch(failed("transfers")));
  },
} satisfies ExportedHandler<Env>;

async function route(request: Request, url: URL, env: Env, ctx: ExecutionContext): Promise<Response> {
  const key = `${request.method} ${url.pathname}`;
  if (url.pathname.startsWith("/v1/auth/")) await limitByIp(request, env);
  if (url.pathname.startsWith("/v1/admin/")) return adminRoute(request, url, env);
  const copy = /^\/v1\/backup\/([^/]+)\/([^/]+)$/.exec(url.pathname);
  if (copy && request.method === "GET") return backupFile(request, env, copy[1]!, copy[2]!);
  const snapshotDay = /^\/v1\/snapshots\/([^/]+)$/.exec(url.pathname);
  if (snapshotDay && request.method === "GET") return snapshotDownload(request, env, snapshotDay[1]!);
  const move = /^\/v1\/transfer\/([^/]+)(\/received|\/status)?$/.exec(url.pathname);
  if (move) return transfer(request, env, move[1]!, move[2] ?? "");
  switch (key) {
    case "GET /v1/status":
      return json({ ok: true, environment: env.ENVIRONMENT, time: Date.now() }, 200, { "cache-control": "public, max-age=30" });
    case "POST /v1/auth/apple":
      return signIn(request, env, (body) => verifyIdToken(APPLE, requireString(body.idToken, "idToken", 8192), requireString(body.nonce, "nonce", 256), audiences(env.APPLE_AUDIENCES)), ctx);
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
    case "GET /v1/account/export":
      return exportAccount(request, env);
    case "POST /v1/account/link":
      return link(request, env, ctx);
    case "POST /v1/account/unlink":
      return unlink(request, env);
    case "POST /v1/account/signout":
      return signOut(request, env);
    case "POST /v1/account/delete":
      return remove(request, env);
    case "POST /v1/sync":
      return sync(request, env, ctx);
    case "PUT /v1/backup":
      return backupUpload(request, env);
    case "GET /v1/backup":
      return backupList(request, env);
    case "DELETE /v1/backup":
      return backupDelete(request, env);
    case "GET /v1/snapshots":
      return snapshotList(request, env);
    case "POST /v1/purchases/verify":
      return verifyPurchase(request, env, ctx);
    case "GET /v1/purchases":
      return purchases(request, env);
    case "POST /v1/hooks/apple":
      return appleNotification(request, env);
    case "POST /v1/hooks/apple-signin":
      return appleSignInEvent(request, env);
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
  /** Apple only: the credential's one-time code, exchanged for a token we can revoke on deletion (appleTokens.ts). */
  authorizationCode?: unknown;
  /**
   * The person chose Continue on "Use on This iPad?": a free account signed in on another device moves here, and that
   * device is signed out, keeping its habits (Current Work 78). Without it, such a sign-in answers 409
   * `other_device_signed_in`.
   */
  replace?: unknown;
}

async function signIn(request: Request, env: Env, verify: (body: SignInBody) => Promise<VerifiedKey>, ctx?: ExecutionContext): Promise<Response> {
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
  const session = await accountStub(env, claims).openSession(account.accountId, key, device, testPlus, Date.now(), body.replace === true);
  if (!session.ok && session.reason === "other_device") {
    // Free accounts sync one device: the app asks "Use on This iPad?" and signs in again with `replace` (screen 7).
    throw new HttpError(409, "other_device_signed_in", `This account is signed in on ${session.device.name}. A free account syncs one device.`, { device: session.device });
  }
  if (!session.ok) throw new HttpError(409, "account_unavailable", "This account can't be opened right now. Please try again.");
  if (session.replaced) countUsage(env, ctx, "replaced_device");
  if (ctx) keepAppleToken(env, ctx, account, key, body.authorizationCode);
  return json({ accountId: account.accountId, created, ...(await tokens(env, { ...claims, plus: session.plus }, session.secret)) }, created ? 201 : 200);
}

/**
 * After an Apple sign-in or link: exchanges the one-time code for a revocable token, after the reply, so signing in
 * never waits on it. A code that's missing or fails leaves the key without one; the next sign-in tries again.
 */
function keepAppleToken(env: Env, ctx: ExecutionContext, account: { accountId: string; jurisdiction: Jurisdiction }, key: VerifiedKey, code: unknown) {
  if (key.provider !== "apple" || typeof code !== "string" || code.length === 0 || code.length > 1024) return;
  ctx.waitUntil(
    exchangeAppleCode(env, code, key.subject).then(async (token) => {
      if (token) await accountStub(env, account).setRevokeToken("apple", key.subject, token);
    }),
  );
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
  if (!result.ok && result.reason === "ended") throw sessionEnded(result.ended, result.by);
  if (!result.ok) throw signedOut();
  return json(await tokens(env, { ...parsed, plus: result.plus }, result.secret));
}

/** The app keeps all its data and shows "Sign in again to keep syncing" (01 §3.5). */
function signedOut() {
  return new HttpError(401, "signed_out", "Sign in again to keep syncing. Everything on this device is kept.");
}

/**
 * Another device signed in to this free account (or Plus ended and another device was kept): the app signs out here
 * keeping every habit, goes back to iCloud / Google Drive, and says so once (screen 8, Current Work 78).
 */
function sessionEnded(reason: EndedReason, by: OtherDevice | null) {
  const message = by ? `Your account is now used on ${by.name}. Everything on this device is kept.` : "Signed out on this device. Everything on it is kept.";
  return new HttpError(401, "session_ended", message, { reason, deviceName: by?.name ?? null, device: by });
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

/**
 * A copy of everything the server holds for this account (09 §8, the right of access and portability): sign-ins,
 * devices, purchases, every synced record, and the account's backup copies (each downloadable from
 * `/v1/backup/{device}/{slot}`). Returned as a file to save.
 */
async function exportAccount(request: Request, env: Env): Promise<Response> {
  const claims = await authenticate(request, env);
  await limit(env.SYNC_LIMIT, claims.accountId);
  const data = await accountStub(env, claims).exportData();
  if (!data) throw signedOut();
  const backups = (await (await listBackups(env, claims)).json()) as { copies: unknown[] };
  const body = { format: 1, exportedAt: new Date().toISOString(), account: data.summary, purchases: data.entitlements, records: data.records, backups: backups.copies };
  return new Response(JSON.stringify(body, null, 2), {
    headers: {
      "content-type": "application/json; charset=utf-8",
      "content-disposition": `attachment; filename="often-enough-account-${new Date().toISOString().slice(0, 10)}.json"`,
      "cache-control": "no-store",
    },
  });
}

async function link(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
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
  keepAppleToken(env, ctx, claims, key, body.authorizationCode);
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
  const token = await accountStub(env, claims).removeKey(provider, result.subject);
  if (provider === "apple" && token) await revokeAppleToken(env, token);
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
  await deleteEverything(env, claims);
  return json({ deleted: true, at: Date.now() });
}

/**
 * Everything of an account, in the order that keeps it safe: the directory, its data, backups, snapshots (09 §7).
 * Then its Apple sign-in is revoked at Apple (appleTokens.ts); the tokens are read first, as the wipe removes them.
 */
async function deleteEverything(env: Env, account: { accountId: string; jurisdiction: Jurisdiction }) {
  const stub = accountStub(env, account);
  const appleTokens = await stub.revokeTokens();
  await deleteAccount(env.DIRECTORY, account.accountId);
  await stub.wipe();
  await deleteBackups(env, account);
  await deleteSnapshots(env, account);
  for (const token of appleTokens) await revokeAppleToken(env, token);
}

/**
 * Sign in with Apple server-to-server notifications (01 §3.9, 09 §7), `{payload: <JWT Apple signed>}`:
 * - `consent-revoked`: the person stopped using Apple sign-in with us; sessions it opened end, data stays;
 * - `account-delete`: they deleted their Apple Account; the Apple sign-in goes, and if it was the account's only way
 *   in, the whole account is deleted (it could never be opened again);
 * - `email-disabled` / `email-enabled`: whether their relay address still reaches them.
 * Events for sign-ins we don't know are acknowledged and ignored; repeats are harmless.
 */
async function appleSignInEvent(request: Request, env: Env): Promise<Response> {
  const body = await readJson<{ payload?: unknown }>(request, 16 * 1024);
  const event = await verifyAppleEvent(requireString(body.payload, "payload", 8192), audiences(env.APPLE_AUDIENCES));
  const account = await findAccount(env.DIRECTORY, "apple", event.subject);
  if (!account) return json({ received: true });
  const stub = accountStub(env, account);
  if (event.type === "consent-revoked") {
    await stub.endSessionsOpenedWith("apple");
  } else if (event.type === "account-delete") {
    const result = await unlinkKey(env.DIRECTORY, account.accountId, "apple");
    if (!result.removed && result.reason === "last_key") {
      await deleteEverything(env, account);
    } else {
      await stub.removeKey("apple", event.subject);
      await stub.endSessionsOpenedWith("apple");
    }
  } else if (event.type === "email-disabled") {
    await stub.setKeyEmail("apple", event.subject, null, event.isPrivateEmail);
  } else if (event.type === "email-enabled") {
    await stub.setKeyEmail("apple", event.subject, event.email, event.isPrivateEmail);
  }
  console.log(JSON.stringify({ event: "apple_signin_event", type: event.type }));
  return json({ received: true });
}

// MARK: Sync

/**
 * `{cursor, ops}` → `{applied, rejected, ops, cursor, more}` (Architecture 05, 06 §4). Every account syncs: Plus across
 * its devices, a free account from its one signed-in device (Current Work 78; the Durable Object knows which).
 */
async function sync(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
  const claims = await authenticate(request, env);
  await limit(env.SYNC_LIMIT, claims.accountId);
  const body = await readJson<{ cursor?: unknown; ops?: unknown; full?: unknown }>(request, 2 * 1024 * 1024);
  const ops = body.ops ?? [];
  if (!Array.isArray(ops)) throw new HttpError(400, "bad_request", '"ops" must be a list.');
  if (ops.length > MAX_PUSH) throw new HttpError(413, "too_many_ops", `Send at most ${MAX_PUSH} ops at a time.`);
  const cursor = typeof body.cursor === "number" ? body.cursor : 0;
  const measure = env.ENVIRONMENT === "dev";
  const result = await accountStub(env, claims).sync(claims.deviceId, { cursor, ops, jurisdiction: claims.jurisdiction, full: body.full === true, measure });
  if (!result.ok) {
    if (result.reason === "too_many_ops") throw new HttpError(413, "too_many_ops", `Send at most ${MAX_PUSH} ops at a time.`);
    if (result.reason === "ended") throw sessionEnded(result.ended, result.by);
    throw signedOut();
  }
  // The RPC stub's types lose the success case (its `unknown[]` ops), so name it.
  const { ok: _ok, usage, ...reply } = result as unknown as Extract<SyncResult, { ok: true }>;
  recordSync(env, usage);
  if (usage.firstToday) countUsage(env, ctx, usage.plus ? "syncing_plus" : "syncing_free");
  // Dev only: what this sync cost, so the cost model's estimates can be measured (Free Sync §2.1).
  return json(measure ? { ...reply, usage } : reply);
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

// MARK: Restore From a Backup (snapshotFile.ts)

/** Every account's daily copies are its snapshots: the last 7 days on free, 90 on Plus (Current Work 78). */
async function snapshotClaims(request: Request, env: Env): Promise<AccessClaims> {
  const claims = await authenticate(request, env);
  await limit(env.SYNC_LIMIT, claims.accountId);
  return liveAccount(env, claims);
}

async function snapshotList(request: Request, env: Env): Promise<Response> {
  return listSnapshots(env, await snapshotClaims(request, env));
}

async function snapshotDownload(request: Request, env: Env, day: string): Promise<Response> {
  return snapshotBackupFile(env, await snapshotClaims(request, env), day);
}

// MARK: Move to Another Device (transfer.ts)

/** No account: the code is the only key, and every route is limited per IP so codes can't be guessed. */
async function transfer(request: Request, env: Env, id: string, action: string): Promise<Response> {
  const ip = request.headers.get("cf-connecting-ip");
  if (ip) await limit(env.TRANSFER_LIMIT, ip);
  const route = `${request.method} ${action}`;
  if (route === "PUT ") return putTransfer(request, env, id);
  if (route === "GET ") return getTransfer(env, id);
  if (route === "DELETE ") return cancelTransfer(env, id);
  if (route === "POST /received") return receivedTransfer(env, id);
  if (route === "GET /status") return transferStatus(env, id);
  throw new HttpError(404, "not_found", "There's nothing here.");
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
async function verifyPurchase(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
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
  // The one email (Email Delivery Decision): once per purchase, ever, after the answer; it never holds Plus up.
  if (await scheduleConfirmation(env, record)) {
    ctx.waitUntil(processConfirmation(env, record.store, record.originalId).catch((error) => console.error(JSON.stringify({ event: "purchase_email_error", error: String(error) }))));
  }
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
const WEB_ROUTES = new Set(["/v1/auth/google", "/v1/account/delete", "/v1/account/signout", "/v1/account/export"]);

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
      "access-control-allow-methods": "GET, POST",
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

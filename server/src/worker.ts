import { type Account, type DeviceInfo, MAX_PUSH } from "./account";
import {
  type Jurisdiction,
  createAccount,
  deleteAccount,
  findAccount,
  jurisdictionFor,
  linkKey,
  unlinkKey,
} from "./directory";
import { HttpError, errorResponse, isUuid, json, readJson, requireString } from "./http";
import { APPLE, GOOGLE, type VerifiedKey, verifyIdToken } from "./providers";
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
    console.log(JSON.stringify({ route: `${request.method} ${url.pathname}`, status: response.status, ms: Date.now() - started }));
    return response;
  },
} satisfies ExportedHandler<Env>;

async function route(request: Request, url: URL, env: Env): Promise<Response> {
  const key = `${request.method} ${url.pathname}`;
  switch (key) {
    case "GET /v1/status":
      return json({ ok: true, environment: env.ENVIRONMENT, time: Date.now() }, 200, { "cache-control": "public, max-age=30" });
    case "POST /v1/auth/apple":
      return signIn(request, env, (body) => verifyIdToken(APPLE, requireString(body.idToken, "idToken", 8192), requireString(body.nonce, "nonce", 256), audiences(env.APPLE_AUDIENCES)));
    case "POST /v1/auth/google":
      return signIn(request, env, (body) => verifyIdToken(GOOGLE, requireString(body.idToken, "idToken", 8192), requireString(body.nonce, "nonce", 256), audiences(env.GOOGLE_AUDIENCES)));
    case "POST /v1/auth/test":
      return signIn(request, env, (body) => verifyTestKey(body, env));
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
  const session = await accountStub(env, claims).openSession(account.accountId, key, device);
  if (!session.ok) throw new HttpError(409, "account_unavailable", "This account can't be opened right now. Please try again.");
  return json({ accountId: account.accountId, created, ...(await tokens(env, claims, session.secret)) }, created ? 201 : 200);
}

/** Dev only: a sign-in that needs no Apple or Google account, for end-to-end tests. It doesn't exist anywhere else. */
async function verifyTestKey(body: SignInBody, env: Env): Promise<VerifiedKey> {
  const enabled = env.ENVIRONMENT === "dev" && typeof env.TEST_LOGIN_SECRET === "string" && env.TEST_LOGIN_SECRET.length >= 32;
  if (!enabled) throw new HttpError(404, "not_found", "There's nothing here.");
  const secret = typeof body.secret === "string" ? body.secret : "";
  if (!(await safeEqual(secret, env.TEST_LOGIN_SECRET))) throw new HttpError(401, "invalid_token", "The sign-in couldn't be checked.");
  return { provider: "test", subject: requireString(body.subject, "subject", 200), email: null, isPrivateEmail: false };
}

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

async function tokens(env: Env, claims: AccessClaims, secret: string) {
  const access = await issueAccessToken(claims, env.TOKEN_KEY);
  return { accessToken: access.token, accessTokenExpiresAt: access.expiresAt, refreshToken: composeRefreshToken(claims, secret) };
}

// MARK: Sessions

async function refresh(request: Request, env: Env): Promise<Response> {
  const body = await readJson<{ refreshToken?: unknown }>(request);
  const parsed = parseRefreshToken(body.refreshToken);
  if (!parsed || !isUuid(parsed.accountId) || !isUuid(parsed.deviceId)) throw signedOut();
  const result = await accountStub(env, parsed).refresh(parsed.deviceId, parsed.secret);
  if (!result.ok) throw signedOut();
  return json(await tokens(env, parsed, result.secret));
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
  return json({ deleted: true, at: Date.now() });
}

// MARK: Sync

/** `{cursor, ops}` → `{applied, rejected, ops, cursor, more}` (Architecture 05, 06 §4). */
async function sync(request: Request, env: Env): Promise<Response> {
  const claims = await authenticate(request, env);
  const body = await readJson<{ cursor?: unknown; ops?: unknown }>(request, 2 * 1024 * 1024);
  const ops = body.ops ?? [];
  if (!Array.isArray(ops)) throw new HttpError(400, "bad_request", '"ops" must be a list.');
  if (ops.length > MAX_PUSH) throw new HttpError(413, "too_many_ops", `Send at most ${MAX_PUSH} ops at a time.`);
  const cursor = typeof body.cursor === "number" ? body.cursor : 0;
  const result = await accountStub(env, claims).sync(claims.deviceId, { cursor, ops });
  if (!result.ok) {
    if (result.reason === "too_many_ops") throw new HttpError(413, "too_many_ops", `Send at most ${MAX_PUSH} ops at a time.`);
    throw signedOut();
  }
  const { ok: _ok, ...reply } = result;
  return json(reply);
}

// MARK: Helpers

function accountStub(env: Env, account: { accountId: string; jurisdiction: Jurisdiction }): DurableObjectStub<Account> {
  const namespace = account.jurisdiction === "eu" ? env.ACCOUNT.jurisdiction("eu") : env.ACCOUNT;
  return namespace.get(namespace.idFromName(account.accountId)) as DurableObjectStub<Account>;
}

function audiences(list: string): string[] {
  return list.split(",").map((s) => s.trim()).filter(Boolean);
}

import { Accounts } from "./accounts";
import { HttpError, errorResponse, json, optionalString, readJson, requireString } from "./http";
import { type Person, type Provider, audiences, verifyIdToken } from "./identity";
import { PRODUCTS, type PlayCheck, checkPlayPurchase } from "./play";

/*
 * The Plus account's Worker (Rulebook D15, D16; Android A15; Current Work 110). It holds only who someone is (Google's
 * or Apple's fixed ID, a first name and a masked email hint), their purchases as checked with the store, and their
 * family. Never a habit. Every call but sign-in and opening an invite needs the session token sign-in gave the device.
 *
 *   POST /v1/sign-in                 { provider, idToken, nonce }                  → { found, session?, account? }
 *   POST /v1/accounts                { provider, idToken, nonce, name?, purchase? } → { session, account }
 *   GET  /v1/account                                                               → { account }
 *   POST /v1/account/purchases       { product, token }                            → { account, purchase }
 *   POST /v1/account/delete          { provider, idToken, nonce }                  → { deleted }
 *   POST /v1/sign-out                                                              → 204
 *   POST /v1/family/invite | /v1/family/invite/cancel | /v1/family/leave           → { account }
 *   POST /v1/family/remove           { person }                                    → { account }
 *   GET  /v1/invites/<token>                                                       → { state, owner }
 *   POST /v1/invites/<token>/join                                                  → { account }
 *   GET  /v1/health                                                                → { ok, environment }
 */

const INVITE_TOKEN = /^[A-Za-z0-9_-]{8,64}$/;

export default {
  async fetch(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
    try {
      return await route(request, env, ctx);
    } catch (error) {
      if (error instanceof HttpError) return errorResponse(error);
      // Never the request's body or tokens in a log (D11).
      console.error(`unexpected: ${error instanceof Error ? error.message : String(error)}`);
      return errorResponse(new HttpError(500, "server_error", "Something went wrong. Please try again."));
    }
  },

  /** Daily at 05:00 UTC: tidying (Accounts.tidy). */
  async scheduled(_controller: ScheduledController, env: Env, ctx: ExecutionContext) {
    ctx.waitUntil((async () => {
      const gone = await new Accounts(env.DB).tidy();
      console.log(`tidy: ${gone.invites} invites, ${gone.sessions} sessions`);
    })());
  },
} satisfies ExportedHandler<Env>;

async function route(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
  const url = new URL(request.url);
  const path = url.pathname.replace(/\/+$/, "");
  const method = request.method;
  const accounts = new Accounts(env.DB);
  const ip = request.headers.get("cf-connecting-ip") ?? "unknown";

  if (path === "/v1/health" && method === "GET") return json({ ok: true, environment: env.ENVIRONMENT });

  // ---------------------------------------------------------------- Signing in (no session yet)
  if (path === "/v1/sign-in" && method === "POST") {
    await limit(env.AUTH_LIMIT, ip);
    const body = await readJson(request);
    const person = await identify(body, env);
    const found = await accounts.find(person);
    if (!found) return json({ found: false });
    await accounts.touch(found.id, person);
    return json({ found: true, session: await accounts.newSession(found.id), account: await accounts.view(found.id) });
  }

  if (path === "/v1/accounts" && method === "POST") {
    await limit(env.AUTH_LIMIT, ip);
    const body = await readJson(request);
    const person = await identify(body, env);
    const row = await accounts.create(person, optionalString(body.name, "name", 200));
    await accounts.touch(row.id, person);
    const purchase = readPurchase(body.purchase, true);
    if (purchase) {
      // The account is made even if Google Play can't be asked right now: the app sends the purchase again later.
      try {
        await accounts.recordPurchase(row.id, purchase.product, purchase.token, await check(env, purchase.product, purchase.token));
      } catch (error) {
        if (!(error instanceof HttpError) || error.status !== 503) throw error;
      }
    }
    return json({ session: await accounts.newSession(row.id), account: await accounts.view(row.id) });
  }

  // ---------------------------------------------------------------- Opening an invite (anyone with the link)
  const inviteMatch = /^\/v1\/invites\/([^/]+)(\/join)?$/.exec(path);
  if (inviteMatch && method === "GET" && !inviteMatch[2]) {
    await limit(env.INVITE_LIMIT, ip);
    const token = inviteMatch[1]!;
    if (!INVITE_TOKEN.test(token)) throw new HttpError(404, "no_invite", "This invite doesn't work.");
    const look = await accounts.lookInvite(token);
    if (!look) throw new HttpError(404, "no_invite", "This invite doesn't work.");
    return json(look);
  }

  // ---------------------------------------------------------------- Everything else: a signed-in device
  const session = bearer(request);
  const accountId = session ? await accounts.sessionAccount(session) : null;
  if (!session || !accountId) throw new HttpError(401, "signed_out", "Please sign in again.");
  await limit(env.CALL_LIMIT, accountId);
  const reply = async () => {
    const view = await accounts.view(accountId);
    if (!view) throw new HttpError(401, "signed_out", "Please sign in again.");
    return json({ account: view });
  };

  if (inviteMatch && inviteMatch[2] && method === "POST") {
    await limit(env.INVITE_LIMIT, ip);
    const token = inviteMatch[1]!;
    if (INVITE_TOKEN.test(token)) await accounts.join(accountId, token);
    return reply();
  }

  if (method === "GET" && path === "/v1/account") {
    // Purchases not checked for a day are checked again after the answer, so a refund reaches the account.
    const stale = await accounts.stalePurchases(accountId);
    if (stale.length > 0) {
      ctx.waitUntil((async () => {
        for (const p of stale) {
          try {
            await accounts.recheck(accountId, p.token, await check(env, p.product, p.token));
          } catch {
            // Google can't be asked now: the purchase stays as it was and is checked again next time.
          }
        }
      })());
    }
    return reply();
  }

  if (method !== "POST") throw new HttpError(404, "not_found", "Not found.");
  switch (path) {
    case "/v1/account/purchases": {
      const purchase = readPurchase((await readJson(request)) as unknown, false)!;
      const answer = await check(env, purchase.product, purchase.token);
      const result = await accounts.recordPurchase(accountId, purchase.product, purchase.token, answer);
      const view = await accounts.view(accountId);
      if (!view) throw new HttpError(401, "signed_out", "Please sign in again.");
      return json({ account: view, purchase: result });
    }
    case "/v1/account/delete": {
      await limit(env.AUTH_LIMIT, ip);
      // Deleting needs Google's or Apple's own sign-in again, as the same person (Figma 7.2.1).
      const person = await identify(await readJson(request), env);
      const row = await accounts.byId(accountId);
      if (!row || row.provider !== person.provider || row.subject !== person.subject) {
        throw new HttpError(403, "wrong_account", "That's a different account. Choose the one you're signed in with.");
      }
      await accounts.delete(accountId);
      return json({ deleted: true });
    }
    case "/v1/sign-out":
      await accounts.endSession(session);
      return new Response(null, { status: 204, headers: { "cache-control": "no-store" } });
    case "/v1/family/invite":
      await accounts.invite(accountId);
      return reply();
    case "/v1/family/invite/cancel":
      await accounts.cancelInvite(accountId);
      return reply();
    case "/v1/family/remove": {
      const body = await readJson(request);
      await accounts.remove(accountId, requireString(body.person, "person", 64));
      return reply();
    }
    case "/v1/family/leave":
      await accounts.leave(accountId);
      return reply();
  }
  throw new HttpError(404, "not_found", "Not found.");
}

function bearer(request: Request): string | null {
  const header = request.headers.get("authorization") ?? "";
  const match = /^Bearer ([A-Za-z0-9_-]{20,100})$/.exec(header);
  return match ? match[1]! : null;
}

async function identify(body: Record<string, unknown>, env: Env): Promise<Person> {
  const provider = body.provider;
  if (provider === "test") return testPerson(body, env);
  if (provider !== "google" && provider !== "apple") throw new HttpError(400, "bad_request", "\"provider\" is missing or invalid.");
  const idToken = requireString(body.idToken, "idToken", 8192);
  const nonce = requireString(body.nonce, "nonce", 200);
  const allowed = audiences(provider === "google" ? env.GOOGLE_AUDIENCES : env.APPLE_AUDIENCES);
  return verifyIdToken(provider as Provider, idToken, nonce, allowed);
}

/**
 * Dev only: the app's end-to-end tests on an emulator can't tap through Google's own account sheet, so on dev a sign-in
 * may instead carry the test secret (TEST_SIGN_IN_SECRET, set only on dev, kept only on the developer's PC) and choose
 * its own subject. Production refuses it whatever is sent: its ENVIRONMENT isn't "dev" and it has no such secret.
 */
async function testPerson(body: Record<string, unknown>, env: Env): Promise<Person> {
  const secret = env.TEST_SIGN_IN_SECRET;
  const sent = typeof body.secret === "string" ? body.secret : "";
  if (env.ENVIRONMENT !== "dev" || !secret || secret.length < 32 || !(await sameText(sent, secret))) {
    throw new HttpError(400, "bad_request", "\"provider\" is missing or invalid.");
  }
  const subject = requireString(body.subject, "subject", 100);
  return { provider: "google", subject: "test:" + subject, email: null, givenName: optionalString(body.name, "name", 100) };
}

/** Compares two strings in time that doesn't depend on where they differ. */
async function sameText(a: string, b: string): Promise<boolean> {
  const [ha, hb] = await Promise.all([a, b].map(async (s) => new Uint8Array(await crypto.subtle.digest("SHA-256", new TextEncoder().encode(s)))));
  let diff = 0;
  for (let i = 0; i < ha!.length; i++) diff |= ha![i]! ^ hb![i]!;
  return diff === 0;
}

/**
 * Asks Google Play about a purchase. Dev only: the debug app's stand-in store (no real Play) sends the token
 * "stand-in", which dev counts as bought so families can be tested end to end; production never does.
 */
async function check(env: Env, product: string, token: string): Promise<PlayCheck> {
  if (env.ENVIRONMENT === "dev" && env.ACCEPT_STAND_IN_PURCHASES === "true" && token.startsWith("stand-in")) {
    return { state: "purchased", orderId: null, test: true };
  }
  return checkPlayPurchase(env.GOOGLE_PLAY_SERVICE_ACCOUNT, env.PLAY_PACKAGE, product, token);
}

function readPurchase(value: unknown, optional: boolean): { product: string; token: string } | null {
  if (optional && (value === undefined || value === null)) return null;
  const p = (value ?? {}) as Record<string, unknown>;
  const product = requireString(p.product, "product", 100);
  if (!(product in PRODUCTS)) throw new HttpError(400, "bad_request", "\"product\" isn't one of ours.");
  return { product, token: requireString(p.token, "token", 2048) };
}

async function limit(binding: RateLimit | undefined, key: string) {
  if (!binding) return;
  const { success } = await binding.limit({ key });
  if (!success) throw new HttpError(429, "too_many", "Too many tries. Please wait a minute.");
}

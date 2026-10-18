import { env } from "cloudflare:workers";
import { beforeAll, beforeEach, describe, expect, it } from "vitest";
import { clearKeyCache } from "../src/identity";
import {
  APPLE_KEYS, GOOGLE_KEYS, call, createAccount, idToken, keyFetches, mockGoogle, newIp, newKey, person, published, sha256Hex, signIn,
} from "./helpers";

beforeAll(async () => {
  published[GOOGLE_KEYS] = [await newKey("google-1")];
  published[APPLE_KEYS] = [await newKey("apple-1")];
});
beforeEach(() => {
  mockGoogle();
  clearKeyCache();
});

describe("signing in and making an account", () => {
  it("finds no account, makes one, and finds it on the next sign-in (another device, its own session)", async () => {
    const sam = person("Sam");
    expect((await signIn(sam)).body).toEqual({ found: false });
    const made = await createAccount(sam);
    expect(made.session).toMatch(/^[A-Za-z0-9_-]{43}$/);
    expect(made.account).toEqual({ id: made.account.id, plus: "NONE", family: null });
    const again = await signIn(sam);
    expect(again.status).toBe(200);
    expect(again.body.found).toBe(true);
    expect(again.body.account.id).toBe(made.account.id);
    expect(again.body.session).not.toBe(made.session);
    // Both devices stay signed in.
    expect((await call("GET", "/v1/account", { session: made.session })).status).toBe(200);
    expect((await call("GET", "/v1/account", { session: again.body.session })).status).toBe(200);
  });

  it("makes one account however often it's asked, even at once", async () => {
    const sam = person("Sam");
    const replies = await Promise.all([createAccount(sam), createAccount(sam), createAccount(sam)]);
    expect(new Set(replies.map((r) => r.account.id)).size).toBe(1);
    const rows = await env.DB.prepare("SELECT COUNT(*) AS n FROM accounts WHERE subject = ?").bind(sam.subject).first<{ n: number }>();
    expect(rows?.n).toBe(1);
  });

  it("works with Sign in with Apple too, and keeps Google and Apple accounts apart", async () => {
    const apple = { ...person("Ana", "apple"), email: undefined, givenName: undefined };
    const made = await createAccount(apple, undefined, "Ana Lopez");
    const google = await createAccount({ ...apple, provider: "google" });
    expect(made.account.id).not.toBe(google.account.id);
    const row = await env.DB.prepare("SELECT name, email_hint FROM accounts WHERE id = ?").bind(made.account.id).first<{ name: string; email_hint: string | null }>();
    expect(row).toEqual({ name: "Ana", email_hint: null }); // Apple gives the name only to the app, which sends it
  });

  it("keeps only a masked email hint and a first name, never the email (D16)", async () => {
    const lalith = { ...person("Lalith"), email: "lalith.example@gmail.com" };
    const made = await createAccount(lalith);
    const row = await env.DB.prepare("SELECT * FROM accounts WHERE id = ?").bind(made.account.id).first<Record<string, unknown>>();
    expect(row?.email_hint).toBe("l•••••@gmail.com");
    expect(row?.name).toBe("Lalith");
    const everything = JSON.stringify(await Promise.all(["accounts", "sessions", "purchases", "families", "members", "invites"].map((t) =>
      env.DB.prepare(`SELECT * FROM ${t}`).all())));
    expect(everything).not.toContain("lalith.example");
    // Sessions are kept only as hashes.
    expect(everything).not.toContain(made.session);
  });

  it("refuses tokens that aren't Google's or Apple's for us", async () => {
    const sam = person("Sam");
    const stranger = await newKey("google-1"); // same key ID, different key: a forged signature
    const cases: [string, Parameters<typeof idToken>[1]][] = [
      ["another app's audience", { audience: "someone-else.apps.googleusercontent.com" }],
      ["another issuer", { issuer: "https://evil.example" }],
      ["expired", { expiresIn: -3600 }],
      ["forged signature", { key: stranger }],
      ["wrong nonce", { nonce: "not-the-hash" }],
      ["Apple's audience for a Google token", { audience: "com.oftenenough.app" }],
    ];
    for (const [what, options] of cases) {
      const reply = await signIn(sam, options);
      expect(reply.status, what).toBe(401);
      expect(reply.body.error, what).toBe("invalid_token");
    }
    // A nonce that isn't the hash of the one sent, and a token sent twice with a different nonce: both refused.
    const { idToken: token } = await idToken(sam);
    expect((await call("POST", "/v1/sign-in", { body: { provider: "google", idToken: token, nonce: "something-else" } })).status).toBe(401);
    // Missing fields.
    expect((await call("POST", "/v1/sign-in", { body: { provider: "google", idToken: token } })).status).toBe(400);
    expect((await call("POST", "/v1/sign-in", { body: { provider: "facebook", idToken: token, nonce: "x" } })).status).toBe(400);
  });

  it("follows Google's key rotation, at most one extra fetch a minute for unknown keys", async () => {
    const sam = person("Sam");
    await createAccount(sam);
    const before = keyFetches[GOOGLE_KEYS]!;
    const rotated = await newKey("google-2");
    published[GOOGLE_KEYS] = [rotated, ...published[GOOGLE_KEYS]!];
    expect((await signIn(sam, { key: rotated })).body.found).toBe(true);
    expect(keyFetches[GOOGLE_KEYS]).toBe(before + 1);
    // Made-up key IDs don't make it fetch again within the minute.
    const madeUp = await newKey("made-up");
    for (let i = 0; i < 3; i++) expect((await signIn(sam, { key: madeUp })).status).toBe(401);
    expect(keyFetches[GOOGLE_KEYS]).toBe(before + 1);
  });

  it("uses Google's first name, or the app's, cleaned", async () => {
    const noName = { ...person("x"), givenName: undefined };
    const made = await createAccount(noName, undefined, "  \u0007Priya   Sharma ");
    const row = await env.DB.prepare("SELECT name FROM accounts WHERE id = ?").bind(made.account.id).first<{ name: string }>();
    expect(row?.name).toBe("Priya");
    const nobody = await createAccount({ ...person("x"), givenName: undefined });
    const row2 = await env.DB.prepare("SELECT name FROM accounts WHERE id = ?").bind(nobody.account.id).first<{ name: string }>();
    expect(row2?.name).toBe("Someone");
  });
});

describe("sessions", () => {
  it("needs a session for everything but signing in and opening an invite", async () => {
    for (const [method, path] of [["GET", "/v1/account"], ["POST", "/v1/family/invite"], ["POST", "/v1/family/leave"], ["POST", "/v1/sign-out"], ["POST", "/v1/account/delete"]] as const) {
      const none = await call(method, path);
      expect(none.status, path).toBe(401);
      expect(none.body.error, path).toBe("signed_out");
      expect(none.headers?.get("www-authenticate"), path).toBe('Bearer realm="oftenenough"');
      expect((await call(method, path, { session: "a".repeat(43) })).status, path).toBe(401);
    }
  });

  it("signing out ends only that device's session", async () => {
    const sam = person("Sam");
    const phone = await createAccount(sam);
    const tablet = (await signIn(sam)).body.session as string;
    expect((await call("POST", "/v1/sign-out", { session: phone.session })).status).toBe(204);
    expect((await call("GET", "/v1/account", { session: phone.session })).status).toBe(401);
    expect((await call("GET", "/v1/account", { session: tablet })).status).toBe(200);
    // Signing out twice changes nothing.
    expect((await call("POST", "/v1/sign-out", { session: phone.session })).status).toBe(401);
  });

  it("forgets a session unused for 400 days", async () => {
    const made = await createAccount(person("Sam"));
    await env.DB.prepare("UPDATE sessions SET used_at = ? WHERE token_hash = ?").bind(Date.now() - 401 * 86_400_000, await sha256Hex(made.session)).run();
    expect((await call("GET", "/v1/account", { session: made.session })).status).toBe(401);
    expect(await env.DB.prepare("SELECT 1 FROM sessions WHERE token_hash = ?").bind(await sha256Hex(made.session)).first()).toBeNull();
  });
});

describe("the edges", () => {
  it("answers health, unknown routes, bad JSON and big bodies plainly", async () => {
    expect((await call("GET", "/v1/health")).body).toEqual({ ok: true, environment: "dev" });
    expect((await call("GET", "/v1/nothing")).status).toBe(401); // unknown routes need a session first, and say nothing
    const made = await createAccount(person("Sam"));
    expect((await call("GET", "/v1/nothing", { session: made.session })).status).toBe(404);
    expect((await call("POST", "/v1/sign-in", { raw: "{not json" })).status).toBe(400);
    expect((await call("POST", "/v1/sign-in", { raw: "[]" })).status).toBe(400);
    expect((await call("POST", "/v1/sign-in", { raw: JSON.stringify({ provider: "google", idToken: "x".repeat(20_000), nonce: "n" }) })).status).toBe(413);
  });

  it("slows down sign-in tries from one place (30 a minute)", async () => {
    const ip = newIp();
    const sam = person("Sam");
    let limited = 0;
    for (let i = 0; i < 35; i++) {
      const reply = await call("POST", "/v1/sign-in", { ip, body: { provider: "google", ...(await idToken(sam)) } });
      if (reply.status === 429) limited++;
    }
    expect(limited).toBeGreaterThan(0);
    // Someone else, somewhere else, isn't held up.
    expect((await signIn(person("Ana"))).status).toBe(200);
  });
});

import { runInDurableObject } from "cloudflare:test";
import { env } from "cloudflare:workers";
import { afterEach, beforeAll, beforeEach, describe, expect, it, vi } from "vitest";
import type { Account } from "../src/account";
import { clearProviderKeyCache } from "../src/providers";
import { issueAccessToken } from "../src/tokens";
import {
  APPLE_AUDIENCE,
  APPLE_KEYS_URL,
  GOOGLE_AUDIENCE,
  GITHUB_KEYS_URL,
  GOOGLE_KEYS_URL,
  TEST_LOGIN_SECRET,
  call,
  device,
  idToken,
  keyFetches,
  mockProviderKeys,
  newSigningKey,
  published,
  testSignIn,
} from "./helpers";

let apple: Awaited<ReturnType<typeof newSigningKey>>;
let google: Awaited<ReturnType<typeof newSigningKey>>;

beforeAll(async () => {
  apple = await newSigningKey("apple-1");
  google = await newSigningKey("google-1");
});

beforeEach(() => {
  published[APPLE_KEYS_URL] = [apple];
  published[GOOGLE_KEYS_URL] = [google];
  published[GITHUB_KEYS_URL] = [];
  clearProviderKeyCache();
  mockProviderKeys();
});

afterEach(() => {
  vi.restoreAllMocks();
});

function appleToken(subject: string, nonce: string, extra: Partial<Parameters<typeof idToken>[0]> = {}) {
  return idToken({ key: apple, issuer: "https://appleid.apple.com", audience: APPLE_AUDIENCE, subject, nonce, ...extra });
}

function googleToken(subject: string, nonce: string, extra: Partial<Parameters<typeof idToken>[0]> = {}) {
  return idToken({ key: google, issuer: "https://accounts.google.com", audience: GOOGLE_AUDIENCE, subject, nonce, ...extra });
}

async function appleSignIn(subject: string, options: { create?: boolean; dev?: ReturnType<typeof device>; country?: string; email?: string; isPrivateEmail?: boolean } = {}) {
  const nonce = crypto.randomUUID();
  const token = await appleToken(subject, nonce, { email: options.email, emailVerified: options.email ? "true" : undefined, isPrivateEmail: options.isPrivateEmail });
  return call("POST", "/v1/auth/apple", { idToken: token, nonce, create: options.create ?? true, device: options.dev ?? device(), country: options.country });
}

function stubFor(accountId: string) {
  return env.ACCOUNT.get(env.ACCOUNT.idFromName(accountId)) as DurableObjectStub<Account>;
}

describe("status", () => {
  it("answers without signing in", async () => {
    const { status, json } = await call("GET", "/v1/status");
    expect(status).toBe(200);
    expect(json.ok).toBe(true);
  });

  it("unknown paths are 404 JSON", async () => {
    const { status, json } = await call("GET", "/v1/nope");
    expect(status).toBe(404);
    expect(json.error).toBe("not_found");
  });
});

describe("signing in with Apple", () => {
  it("never creates an account without being asked", async () => {
    const { status, json } = await appleSignIn("apple-unknown", { create: false });
    expect(status).toBe(404);
    expect(json.error).toBe("unknown_key");
    const rows = await env.DIRECTORY.prepare("SELECT count(*) AS n FROM account_key WHERE subject = ?").bind("apple-unknown").first<{ n: number }>();
    expect(rows?.n).toBe(0);
  });

  it("creates an account once, and the same Apple ID opens it again", async () => {
    const first = await appleSignIn("apple-a", { email: "abc@privaterelay.appleid.com", isPrivateEmail: true });
    expect(first.status).toBe(201);
    expect(first.json.created).toBe(true);
    expect(first.json.refreshToken).toMatch(/^rt1\.d\./);
    const again = await appleSignIn("apple-a");
    expect(again.status).toBe(200);
    expect(again.json.created).toBe(false);
    expect(again.json.accountId).toBe(first.json.accountId);

    const summary = await call("GET", "/v1/account", undefined, again.json.accessToken);
    expect(summary.status).toBe(200);
    expect(summary.json.keys).toEqual([
      expect.objectContaining({ provider: "apple", email: "abc@privaterelay.appleid.com", isPrivateEmail: true }),
    ]);
    expect(summary.json.devices).toHaveLength(2);
  });

  it("two creates at the same moment make one account", async () => {
    const results = await Promise.all([appleSignIn("apple-race"), appleSignIn("apple-race"), appleSignIn("apple-race")]);
    expect(new Set(results.map((r) => r.json.accountId)).size).toBe(1);
    const accounts = await env.DIRECTORY.prepare("SELECT count(*) AS n FROM account_key WHERE subject = 'apple-race'").first<{ n: number }>();
    expect(accounts?.n).toBe(1);
  });

  it.each([
    ["a token signed by someone else", async (nonce: string) => idToken({ key: await newSigningKey("apple-1"), issuer: "https://appleid.apple.com", audience: APPLE_AUDIENCE, subject: "x", nonce })],
    ["a token for another app", (nonce: string) => appleToken("x", nonce, { audience: "com.someone.else" })],
    ["a token from another issuer", (nonce: string) => appleToken("x", nonce, { issuer: "https://evil.example" })],
    ["an expired token", (nonce: string) => appleToken("x", nonce, { expiresInSeconds: -3600 })],
    ["a replayed token (wrong nonce)", (_nonce: string) => appleToken("x", "some-other-nonce")],
  ])("refuses %s", async (_name, make) => {
    const nonce = crypto.randomUUID();
    const { status, json } = await call("POST", "/v1/auth/apple", { idToken: await make(nonce), nonce, create: true, device: device() });
    expect(status).toBe(401);
    expect(json.error).toBe("invalid_token");
  });

  it("refuses a malformed request", async () => {
    expect((await call("POST", "/v1/auth/apple", { nonce: "n", device: device() })).status).toBe(400);
    expect((await call("POST", "/v1/auth/apple", { idToken: "x", nonce: "n", device: { id: "not-a-uuid", platform: "ios", name: "x", appVersion: "1" } })).status).toBe(400);
    expect((await call("POST", "/v1/auth/apple", { idToken: "x", nonce: "n", device: device({ platform: "toaster" }) })).status).toBe(400);
  });

  it("refuses an oversized body before reading it", async () => {
    const { status } = await call("POST", "/v1/auth/apple", { idToken: "x".repeat(20_000), nonce: "n", device: device() });
    expect(status).toBe(413);
  });

  it("picks up Apple's new signing key when Apple rotates it", async () => {
    await appleSignIn("apple-rotate"); // caches the current keys
    const rotated = await newSigningKey("apple-2");
    published[APPLE_KEYS_URL] = [apple, rotated];
    const fetchesBefore = keyFetches[APPLE_KEYS_URL]!;
    const nonce = crypto.randomUUID();
    const token = await idToken({ key: rotated, issuer: "https://appleid.apple.com", audience: APPLE_AUDIENCE, subject: "apple-rotate", nonce });
    const { status } = await call("POST", "/v1/auth/apple", { idToken: token, nonce, device: device() });
    expect(status).toBe(200);
    expect(keyFetches[APPLE_KEYS_URL]).toBe(fetchesBefore + 1);
  });

  it("keeps using cached keys when Apple's key server is down", async () => {
    await appleSignIn("apple-outage");
    published[APPLE_KEYS_URL] = []; // the server now returns nothing useful
    expect((await appleSignIn("apple-outage")).status).toBe(200);
  });
});

describe("signing in with Google", () => {
  it("works, and only stores a verified email", async () => {
    const nonce = crypto.randomUUID();
    const token = await googleToken("google-a", nonce, { email: "Person@Gmail.com", emailVerified: true });
    const { status, json } = await call("POST", "/v1/auth/google", { idToken: token, nonce, create: true, device: device({ platform: "android" }) });
    expect(status).toBe(201);
    const summary = await call("GET", "/v1/account", undefined, json.accessToken);
    expect(summary.json.keys[0]).toMatchObject({ provider: "google", email: "person@gmail.com" });

    const nonce2 = crypto.randomUUID();
    const unverified = await googleToken("google-b", nonce2, { email: "x@example.com", emailVerified: false });
    const second = await call("POST", "/v1/auth/google", { idToken: unverified, nonce: nonce2, create: true, device: device() });
    const summary2 = await call("GET", "/v1/account", undefined, second.json.accessToken);
    expect(summary2.json.keys[0].email).toBeNull();
  });

  it("accepts both of Google's issuer spellings", async () => {
    const nonce = crypto.randomUUID();
    const token = await googleToken("google-iss", nonce, { issuer: "accounts.google.com" });
    expect((await call("POST", "/v1/auth/google", { idToken: token, nonce, create: true, device: device() })).status).toBe(201);
  });
});

describe("the test sign-in (dev only)", () => {
  it("needs the secret", async () => {
    const { status } = await call("POST", "/v1/auth/test", { secret: "wrong", subject: "t", create: true, device: device() });
    expect(status).toBe(401);
  });

  it("works with it", async () => {
    const { status, json } = await call("POST", "/v1/auth/test", { secret: TEST_LOGIN_SECRET, subject: "t-ok", create: true, device: device() });
    expect(status).toBe(201);
    expect(json.accessToken).toBeTruthy();
  });
});

describe("the CI sign-in (dev only, for GitHub Actions end-to-end tests)", () => {
  async function ciToken(repository: string, audience = "oftenenough-api-dev") {
    const key = await newSigningKey("github-1");
    published[GITHUB_KEYS_URL] = [key];
    return idToken({ key, issuer: "https://token.actions.githubusercontent.com", audience, subject: "repo:x:ref:refs/heads/main", nonce: "unused", claims: { repository } });
  }

  it("accepts our repository's runs, and two devices with one subject share an account", async () => {
    const token = await ciToken("lalithsaicharan00/store-reviews");
    const a = await call("POST", "/v1/auth/ci", { idToken: token, subject: "run-1", create: true, device: device() });
    const b = await call("POST", "/v1/auth/ci", { idToken: token, subject: "run-1", device: device() });
    expect(a.status).toBe(201);
    expect(b.status).toBe(200);
    expect(b.json.accountId).toBe(a.json.accountId);
  });

  it("refuses a fork's runs and tokens minted for something else", async () => {
    const fork = await call("POST", "/v1/auth/ci", { idToken: await ciToken("someone/store-reviews"), subject: "s", create: true, device: device() });
    expect(fork.status).toBe(401);
    const other = await call("POST", "/v1/auth/ci", { idToken: await ciToken("lalithsaicharan00/store-reviews", "sts.amazonaws.com"), subject: "s", create: true, device: device() });
    expect(other.status).toBe(401);
  });
});

describe("sessions", () => {
  it("a refresh token works once and is replaced", async () => {
    const signedIn = await testSignIn();
    const first = await call("POST", "/v1/auth/refresh", { refreshToken: signedIn.json.refreshToken });
    expect(first.status).toBe(200);
    expect(first.json.refreshToken).not.toBe(signedIn.json.refreshToken);
    const second = await call("POST", "/v1/auth/refresh", { refreshToken: first.json.refreshToken });
    expect(second.status).toBe(200);
    expect((await call("GET", "/v1/account", undefined, second.json.accessToken)).status).toBe(200);
  });

  it("a lost reply doesn't sign anyone out: the same token can be retried right away", async () => {
    const signedIn = await testSignIn();
    const lost = await call("POST", "/v1/auth/refresh", { refreshToken: signedIn.json.refreshToken });
    expect(lost.status).toBe(200);
    // The app never got `lost`, so it tries again with the token it has.
    const retry = await call("POST", "/v1/auth/refresh", { refreshToken: signedIn.json.refreshToken });
    expect(retry.status).toBe(200);
    expect((await call("POST", "/v1/auth/refresh", { refreshToken: retry.json.refreshToken })).status).toBe(200);
  });

  it("an old token used later signs only that device out", async () => {
    const subject = crypto.randomUUID();
    const phone = device();
    const tablet = device({ platform: "ipados" });
    const onPhone = await testSignIn(subject, phone);
    const onTablet = await testSignIn(subject, tablet);
    const accountId = onPhone.json.accountId as string;
    const stolen = (onPhone.json.refreshToken as string).split(".")[4]!;
    const rotated = await call("POST", "/v1/auth/refresh", { refreshToken: onPhone.json.refreshToken });
    expect(rotated.status).toBe(200);

    // Ten minutes later, someone uses the copied token.
    const later = Date.now() + 10 * 60 * 1000;
    const result = await runInDurableObject(stubFor(accountId), (instance: Account) => instance.refresh(phone.id, stolen, later));
    expect(result).toEqual({ ok: false, reason: "reused" });
    // The phone is signed out (its newest token no longer works)...
    expect((await call("POST", "/v1/auth/refresh", { refreshToken: rotated.json.refreshToken })).status).toBe(401);
    // ...and the tablet isn't.
    expect((await call("POST", "/v1/auth/refresh", { refreshToken: onTablet.json.refreshToken })).status).toBe(200);
  });

  it("never expires for inactivity: a device back after 300 days refreshes", async () => {
    const dev = device();
    const signedIn = await testSignIn(undefined, dev);
    const secret = (signedIn.json.refreshToken as string).split(".")[4]!;
    const result = await runInDurableObject(stubFor(signedIn.json.accountId), (instance: Account) =>
      instance.refresh(dev.id, secret, Date.now() + 300 * 24 * 3600 * 1000),
    );
    expect(result.ok).toBe(true);
  });

  it.each([
    ["no token", undefined],
    ["a forged token", "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ4In0.c2lnbmF0dXJl"],
  ])("refuses requests with %s", async (_name, token) => {
    const { status, json } = await call("GET", "/v1/account", undefined, token);
    expect(status).toBe(401);
    expect(json.error).toBe("token_expired");
  });

  it("refuses an expired access token", async () => {
    const signedIn = await testSignIn();
    const old = await issueAccessToken({ accountId: signedIn.json.accountId, deviceId: crypto.randomUUID(), jurisdiction: "default" }, env.TOKEN_KEY, Date.now() - 2 * 3600 * 1000);
    expect((await call("GET", "/v1/account", undefined, old.token)).status).toBe(401);
  });

  it("refuses garbage refresh tokens", async () => {
    for (const refreshToken of [undefined, "", "rt1.d.x.y.z", "rt1.x.a.b.c", "nonsense", `rt1.d.${crypto.randomUUID()}.${crypto.randomUUID()}.abc`]) {
      const { status, json } = await call("POST", "/v1/auth/refresh", { refreshToken });
      expect(status).toBe(401);
      expect(json.error).toBe("signed_out");
    }
  });

  it("signing out ends only this device's session", async () => {
    const subject = crypto.randomUUID();
    const a = await testSignIn(subject);
    const b = await testSignIn(subject);
    expect((await call("POST", "/v1/account/signout", {}, a.json.accessToken)).status).toBe(200);
    expect((await call("POST", "/v1/auth/refresh", { refreshToken: a.json.refreshToken })).status).toBe(401);
    expect((await call("POST", "/v1/auth/refresh", { refreshToken: b.json.refreshToken })).status).toBe(200);
  });
});

describe("linking and unlinking sign-in methods", () => {
  it("adds Google to an Apple account; both open it", async () => {
    const created = await appleSignIn("apple-link");
    const nonce = crypto.randomUUID();
    const linked = await call("POST", "/v1/account/link", { provider: "google", idToken: await googleToken("google-link", nonce), nonce }, created.json.accessToken);
    expect(linked.status).toBe(200);
    const nonce2 = crypto.randomUUID();
    const viaGoogle = await call("POST", "/v1/auth/google", { idToken: await googleToken("google-link", nonce2), nonce: nonce2, device: device() });
    expect(viaGoogle.status).toBe(200);
    expect(viaGoogle.json.accountId).toBe(created.json.accountId);
    const summary = await call("GET", "/v1/account", undefined, viaGoogle.json.accessToken);
    expect(summary.json.keys.map((k: { provider: string }) => k.provider).sort()).toEqual(["apple", "google"]);
  });

  it("a key that opens another account can't be linked", async () => {
    const mine = await appleSignIn("apple-mine");
    const nonce = crypto.randomUUID();
    await call("POST", "/v1/auth/google", { idToken: await googleToken("google-theirs", nonce), nonce, create: true, device: device() });
    const nonce2 = crypto.randomUUID();
    const { status, json } = await call("POST", "/v1/account/link", { provider: "google", idToken: await googleToken("google-theirs", nonce2), nonce: nonce2 }, mine.json.accessToken);
    expect(status).toBe(409);
    expect(json.error).toBe("used_by_another_account");
  });

  it("one key per provider", async () => {
    const mine = await appleSignIn("apple-one");
    const nonce = crypto.randomUUID();
    const { status, json } = await call("POST", "/v1/account/link", { provider: "apple", idToken: await appleToken("apple-two", nonce), nonce }, mine.json.accessToken);
    expect(status).toBe(409);
    expect(json.error).toBe("provider_already_linked");
  });

  it("the last way to sign in can't be removed; one of two can", async () => {
    const created = await appleSignIn("apple-unlink");
    const last = await call("POST", "/v1/account/unlink", { provider: "apple" }, created.json.accessToken);
    expect(last.status).toBe(409);
    expect(last.json.error).toBe("last_key");

    const nonce = crypto.randomUUID();
    await call("POST", "/v1/account/link", { provider: "google", idToken: await googleToken("google-unlink", nonce), nonce }, created.json.accessToken);
    expect((await call("POST", "/v1/account/unlink", { provider: "apple" }, created.json.accessToken)).status).toBe(200);
    expect((await appleSignIn("apple-unlink", { create: false })).json.error).toBe("unknown_key");
    const summary = await call("GET", "/v1/account", undefined, created.json.accessToken);
    expect(summary.json.keys.map((k: { provider: string }) => k.provider)).toEqual(["google"]);
  });

  it("removing two keys at once still leaves one", async () => {
    const created = await appleSignIn("apple-both");
    const nonce = crypto.randomUUID();
    await call("POST", "/v1/account/link", { provider: "google", idToken: await googleToken("google-both", nonce), nonce }, created.json.accessToken);
    const results = await Promise.all([
      call("POST", "/v1/account/unlink", { provider: "apple" }, created.json.accessToken),
      call("POST", "/v1/account/unlink", { provider: "google" }, created.json.accessToken),
    ]);
    expect(results.filter((r) => r.status === 200)).toHaveLength(1);
    const left = await env.DIRECTORY.prepare("SELECT count(*) AS n FROM account_key WHERE account_id = ?").bind(created.json.accountId).first<{ n: number }>();
    expect(left?.n).toBe(1);
  });
});

describe("deleting an account", () => {
  it("removes everything, can be repeated, and the key no longer opens anything", async () => {
    const dev = device();
    const created = await appleSignIn("apple-delete", { dev, email: "me@icloud.com" });
    const accountId = created.json.accountId as string;
    expect((await call("POST", "/v1/account/delete", {}, created.json.accessToken)).status).toBe(200);
    expect((await call("POST", "/v1/account/delete", {}, created.json.accessToken)).status).toBe(200);

    expect((await call("GET", "/v1/account", undefined, created.json.accessToken)).json.error).toBe("signed_out");
    expect((await call("POST", "/v1/auth/refresh", { refreshToken: created.json.refreshToken })).status).toBe(401);
    expect((await appleSignIn("apple-delete", { create: false })).json.error).toBe("unknown_key");
    const rows = await env.DIRECTORY.prepare("SELECT (SELECT count(*) FROM account WHERE id = ?1) + (SELECT count(*) FROM account_key WHERE account_id = ?1) AS n").bind(accountId).first<{ n: number }>();
    expect(rows?.n).toBe(0);
    // Nothing of the account is left in its Durable Object, the email included.
    const left = await runInDurableObject(stubFor(accountId), (_instance: Account, state) =>
      state.storage.sql.exec("SELECT (SELECT count(*) FROM sign_in_key) + (SELECT count(*) FROM device) + (SELECT count(*) FROM session) AS n").one().n,
    );
    expect(left).toBe(0);
  });

  it("a deleted person can start a fresh account with the same Apple ID", async () => {
    const first = await appleSignIn("apple-again");
    await call("POST", "/v1/account/delete", {}, first.json.accessToken);
    const second = await appleSignIn("apple-again");
    expect(second.status).toBe(201);
    expect(second.json.accountId).not.toBe(first.json.accountId);
  });
});

describe("where data is kept", () => {
  // The local runtime can't place objects in a jurisdiction (only Cloudflare's network can), so here the EU
  // namespace stands in for itself, and the test checks the Worker asks for it. Checked for real on api-dev.
  it("an account from an EU storefront is stored in the EU and works normally", async () => {
    const asked = vi.spyOn(env.ACCOUNT, "jurisdiction").mockImplementation(() => env.ACCOUNT);
    const created = await appleSignIn("apple-eu", { country: "DEU" });
    expect(asked).toHaveBeenCalledWith("eu");
    expect(created.status).toBe(201);
    expect(created.json.refreshToken).toMatch(/^rt1\.e\./);
    const row = await env.DIRECTORY.prepare("SELECT jurisdiction FROM account WHERE id = ?").bind(created.json.accountId).first<{ jurisdiction: string }>();
    expect(row?.jurisdiction).toBe("eu");
    expect((await call("GET", "/v1/account", undefined, created.json.accessToken)).status).toBe(200);
    const refreshed = await call("POST", "/v1/auth/refresh", { refreshToken: created.json.refreshToken });
    expect(refreshed.status).toBe(200);
    // Signing in again later (any country) finds the same EU account.
    const again = await appleSignIn("apple-eu", { country: "USA" });
    expect(again.json.accountId).toBe(created.json.accountId);
    expect(again.json.refreshToken).toMatch(/^rt1\.e\./);
    expect(asked.mock.calls.every(([where]) => where === "eu")).toBe(true);
  });

  it("other storefronts use the default location", async () => {
    const asked = vi.spyOn(env.ACCOUNT, "jurisdiction");
    const created = await appleSignIn("apple-us", { country: "USA" });
    expect(created.json.refreshToken).toMatch(/^rt1\.d\./);
    expect(asked).not.toHaveBeenCalled();
  });
});

import { createExecutionContext, waitOnExecutionContext } from "cloudflare:test";
import { env } from "cloudflare:workers";
import { beforeAll, beforeEach, describe, expect, it } from "vitest";
import worker from "../src/worker";
import { clearKeyCache } from "../src/identity";
import { APPLE_KEYS, GOOGLE_KEYS, call, mockGoogle, newKey, published } from "./helpers";

const SECRET = "test-sign-in-secret-0123456789abcdef0123";

beforeAll(async () => {
  published[GOOGLE_KEYS] = [await newKey("google-1")];
  published[APPLE_KEYS] = [await newKey("apple-1")];
});
beforeEach(() => {
  mockGoogle();
  clearKeyCache();
});

/** The Worker as production runs it: the same code with production's settings. */
async function asProduction(path: string, body: unknown, extra: Partial<Env> = {}) {
  const production = { ...env, ENVIRONMENT: "production", ACCEPT_STAND_IN_PURCHASES: undefined, TEST_SIGN_IN_SECRET: undefined, ...extra } as unknown as Env;
  const ctx = createExecutionContext();
  const response = await worker.fetch(new Request(`https://api.test${path}`, {
    method: "POST", headers: { "content-type": "application/json", "cf-connecting-ip": crypto.randomUUID() }, body: JSON.stringify(body),
  }), production, ctx);
  await waitOnExecutionContext(ctx);
  return { status: response.status, body: await response.json() as any };
}

describe("dev's test doors", () => {
  it("dev takes the end-to-end tests' sign-in with the secret, and only with it", async () => {
    const made = await call("POST", "/v1/accounts", { body: { provider: "test", secret: SECRET, subject: "e2e-1", name: "Tess" } });
    expect(made.status).toBe(200);
    expect(made.body.account.plus).toBe("NONE");
    const again = await call("POST", "/v1/sign-in", { body: { provider: "test", secret: SECRET, subject: "e2e-1" } });
    expect(again.body.account.id).toBe(made.body.account.id);
    for (const secret of ["wrong", SECRET.slice(0, -1), "", undefined]) {
      expect((await call("POST", "/v1/sign-in", { body: { provider: "test", secret, subject: "e2e-1" } })).status).toBe(400);
    }
  });

  it("dev counts the debug app's stand-in purchases, so a family can be tested end to end", async () => {
    const made = await call("POST", "/v1/accounts", {
      body: { provider: "test", secret: SECRET, subject: "e2e-owner", name: "Lee", purchase: { product: "com.oftenenough.app.plusfamily", token: "stand-in-abc" } },
    });
    expect(made.body.account.plus).toBe("FAMILY_OWNER");
  });

  it("production refuses both, even with the right secret", async () => {
    const signIn = await asProduction("/v1/accounts", { provider: "test", secret: SECRET, subject: "e2e-2" }, { TEST_SIGN_IN_SECRET: SECRET } as Partial<Env>);
    expect(signIn.status).toBe(400);
    expect(signIn.body.error).toBe("bad_request");
  });

  it("production's settings have neither door, and their own database and address", () => {
    const text = env.WRANGLER_CONFIG.replace(/^\s*\/\/.*$/gm, "");
    const config = JSON.parse(text);
    const production = config.env.production;
    expect(production.vars.ENVIRONMENT).toBe("production");
    expect(production.vars).not.toHaveProperty("ACCEPT_STAND_IN_PURCHASES");
    expect(production.vars).not.toHaveProperty("TEST_SIGN_IN_SECRET");
    expect(production.routes).toEqual([{ pattern: "api.oftenenough.com", custom_domain: true }]);
    expect(production.d1_databases[0].database_name).toBe("often-enough-accounts");
    expect(production.d1_databases[0].database_id).not.toBe(config.d1_databases[0].database_id);
    expect(production.vars.GOOGLE_AUDIENCES).toBe(config.vars.GOOGLE_AUDIENCES);
    expect(production.ratelimits.map((r: { name: string }) => r.name).sort()).toEqual(["AUTH_LIMIT", "CALL_LIMIT", "INVITE_LIMIT"]);
    // Keyless Google sign-in: production signs in as its own subject with its own key, in the same pool and provider.
    expect(production.vars.GOOGLE_WIF_SUBJECT).toBe("often-enough-account");
    expect(config.vars.GOOGLE_WIF_SUBJECT).toBe("often-enough-account-dev");
    expect(production.vars.GOOGLE_WIF_KEY_ID).not.toBe(config.vars.GOOGLE_WIF_KEY_ID);
    for (const name of ["GOOGLE_PROJECT_NUMBER", "GOOGLE_WIF_POOL", "GOOGLE_WIF_PROVIDER", "GOOGLE_WIF_ISSUER", "GOOGLE_PLAY_SERVICE_ACCOUNT_EMAIL", "GOOGLE_PUBSUB_SERVICE_ACCOUNT"]) {
      expect(production.vars[name], name).toBe(config.vars[name]);
    }
    // Google Play's notifications: each environment's Pub/Sub subscription pushes to its own address, with that as the
    // token's audience, so a token for one is refused by the other. Both sweep voided purchases once a day, in their one daily job.
    expect(production.vars.GOOGLE_PUBSUB_AUDIENCE).toBe("https://api.oftenenough.com/v1/google/notifications");
    expect(config.vars.GOOGLE_PUBSUB_AUDIENCE).toBe("https://api-dev.oftenenough.com/v1/google/notifications");
    expect(production.triggers.crons).toEqual(config.triggers.crons);
    expect(production.triggers.crons).toEqual(["0 5 * * *"]);
  });
});

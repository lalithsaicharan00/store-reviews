import { createExecutionContext } from "cloudflare:test";
import { env } from "cloudflare:workers";
import { CompactSign, importPKCS8 } from "jose";
import { describe, expect, it } from "vitest";
import worker from "../src/worker";
import intermediatePem from "./fixtures/test-intermediate.pem?raw";
import leafKeyPem from "./fixtures/test-leaf.pk8?raw";
import leafPem from "./fixtures/test-leaf.pem?raw";
import rootPem from "./fixtures/test-root.pem?raw";
import { TEST_LOGIN_SECRET, call as devCall, device, freeSignIn } from "./helpers";

/**
 * Production's settings (wrangler.jsonc `env.production`) on the real Worker: nothing that exists for testing works
 * there. The bindings are the test runtime's; only the vars differ, as they do on Cloudflare.
 */
const production = {
  ...env,
  ENVIRONMENT: "production",
  APPLE_ENVIRONMENTS: "Production,Sandbox",
  APPLE_EXTRA_ROOTS: "",
  CI_REPOSITORY: "",
  TEST_LOGIN_SECRET: "",
} as unknown as Env;

async function call(path: string, body: unknown, token?: string) {
  const headers: Record<string, string> = { "content-type": "application/json" };
  if (token) headers.authorization = `Bearer ${token}`;
  const response = await worker.fetch(
    new Request(`https://api.oftenenough.com${path}`, { method: "POST", headers, body: JSON.stringify(body) }),
    production,
    createExecutionContext(),
  );
  return { status: response.status, json: (await response.json()) as Record<string, unknown> };
}

describe("production", () => {
  it("has no test sign-in, even with the dev secret", async () => {
    const r = await call("/v1/auth/test", { secret: TEST_LOGIN_SECRET, subject: "x", create: true, device: device() });
    expect(r.status).toBe(404);
  });

  it("has no CI sign-in", async () => {
    const r = await call("/v1/auth/ci", { idToken: "a.b.c", subject: "x", device: device() });
    expect(r.status).toBe(404);
  });

  it("answers its status as production", async () => {
    const response = await worker.fetch(new Request("https://api.oftenenough.com/v1/status"), production, createExecutionContext());
    expect(((await response.json()) as { environment: string }).environment).toBe("production");
  });

  it("trusts only Apple's root: a purchase signed by the test chain works on dev and is refused here", async () => {
    const me = await freeSignIn(); // on dev; production shares the test TOKEN_KEY here, so the token works on both
    const id = String(2_000_000_000 + Math.floor(Math.random() * 1e9));
    const now = Date.now();
    const der = (pem: string) => pem.replace(/-----[^-]+-----/g, "").replace(/\s/g, "");
    const jws = await new CompactSign(new TextEncoder().encode(JSON.stringify({
      transactionId: id, originalTransactionId: id, bundleId: "com.oftenenough.app", productId: "com.oftenenough.app.plus",
      purchaseDate: now, originalPurchaseDate: now, signedDate: now, environment: "Production",
    })))
      .setProtectedHeader({ alg: "ES256", x5c: [leafPem, intermediatePem, rootPem].map(der) })
      .sign(await importPKCS8(leafKeyPem, "ES256"));
    const here = await call("/v1/purchases/verify", { jws }, me.json.accessToken);
    expect(here.status).toBe(400);
    expect(here.json.error).toBe("not_verified");
    expect((await devCall("POST", "/v1/purchases/verify", { jws }, me.json.accessToken)).json.plus).toBe(true);
  });
});

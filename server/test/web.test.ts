import { createExecutionContext } from "cloudflare:test";
import { env, exports } from "cloudflare:workers";
import { describe, expect, it } from "vitest";
import worker from "../src/worker";
import { call, device, testSignIn } from "./helpers";

/** The website deletes accounts without the app (09 §7): only its origins, and only three routes. */

const fetchFrom = (origin: string, method: string, path: string, init: RequestInit = {}) =>
  exports.default.fetch(`https://api-dev.oftenenough.com${path}`, { ...init, method, headers: { origin, ...(init.headers ?? {}) } });

describe("the website's calls", () => {
  it("a preflight from the website is allowed for delete, sign-out and Google sign-in", async () => {
    for (const path of ["/v1/account/delete", "/v1/account/signout", "/v1/auth/google"]) {
      const response = await fetchFrom("https://oftenenough.com", "OPTIONS", path, { headers: { "access-control-request-method": "POST" } });
      expect(response.status).toBe(204);
      expect(response.headers.get("access-control-allow-origin")).toBe("https://oftenenough.com");
      expect(response.headers.get("access-control-allow-headers")).toContain("authorization");
    }
  });

  it("nothing else is open to the website, and no other site gets in", async () => {
    const sync = await fetchFrom("https://oftenenough.com", "OPTIONS", "/v1/sync");
    expect(sync.headers.get("access-control-allow-origin")).toBeNull();
    for (const origin of ["https://evil.example", "https://oftenenough.com.evil.example", "https://eviloftenenough.pages.dev", "http://oftenenough.com"]) {
      const response = await fetchFrom(origin, "OPTIONS", "/v1/account/delete");
      expect(response.headers.get("access-control-allow-origin"), origin).toBeNull();
    }
    // Pages previews of the site, on dev only.
    expect((await fetchFrom("https://3f2a1b.oftenenough.pages.dev", "OPTIONS", "/v1/account/delete")).headers.get("access-control-allow-origin")).toBe("https://3f2a1b.oftenenough.pages.dev");
  });

  it("deleting from the website works and the answer is readable by the page", async () => {
    const me = await testSignIn(undefined, device({ platform: "web", name: "Website" }));
    const response = await fetchFrom("https://www.oftenenough.com", "POST", "/v1/account/delete", {
      headers: { authorization: `Bearer ${me.json.accessToken}`, "content-type": "application/json" },
      body: "{}",
    });
    expect(response.status).toBe(200);
    expect(response.headers.get("access-control-allow-origin")).toBe("https://www.oftenenough.com");
    expect(response.headers.get("vary")).toContain("Origin");
    // An answer to anyone else carries no permission.
    const sync = await fetchFrom("https://www.oftenenough.com", "POST", "/v1/sync", { headers: { "content-type": "application/json" }, body: "{}" });
    expect(sync.headers.get("access-control-allow-origin")).toBeNull();
  });

  it("production allows only oftenenough.com, never a preview", async () => {
    const production = { ...env, ENVIRONMENT: "production", WEB_ORIGINS: "https://oftenenough.com,https://www.oftenenough.com" } as unknown as Env;
    const preview = await worker.fetch(new Request("https://api.oftenenough.com/v1/account/delete", { method: "OPTIONS", headers: { origin: "https://3f2a1b.oftenenough.pages.dev" } }), production, createExecutionContext());
    expect(preview.headers.get("access-control-allow-origin")).toBeNull();
    const site = await worker.fetch(new Request("https://api.oftenenough.com/v1/account/delete", { method: "OPTIONS", headers: { origin: "https://oftenenough.com" } }), production, createExecutionContext());
    expect(site.status).toBe(204);
  });

  it("export: everything the server holds, as a file the website can download", async () => {
    const me = await testSignIn(undefined, device({ name: "Lalith's iPhone" }));
    const row = crypto.randomUUID();
    await call("POST", "/v1/sync", { cursor: 0, ops: [{ id: crypto.randomUUID(), table: "habit", row, fields: { name: "Read ☕", deleted_at: null }, hlc: `${String(Date.now()).padStart(18, "0")}-00000-x`, schema: 6 }] }, me.json.accessToken);
    const response = await fetchFrom("https://oftenenough.com", "GET", "/v1/account/export", { headers: { authorization: `Bearer ${me.json.accessToken}` } });
    expect(response.status).toBe(200);
    expect(response.headers.get("access-control-allow-origin")).toBe("https://oftenenough.com");
    expect(response.headers.get("content-disposition")).toMatch(/^attachment; filename="often-enough-account-\d{4}-\d{2}-\d{2}\.json"$/);
    const body = (await response.json()) as any;
    expect(body.account.accountId).toBe(me.json.accountId);
    expect(body.account.devices[0].name).toBe("Lalith's iPhone");
    expect(body.purchases.plus).toBe(true);
    expect(body.records).toEqual([{ table: "habit", row, fields: { name: "Read ☕", deleted_at: null } }]);
    expect(body.backups).toEqual([]);
    expect((await fetchFrom("https://oftenenough.com", "GET", "/v1/account/export")).status).toBe(401);
  });
});

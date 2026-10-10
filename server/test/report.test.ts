import { createExecutionContext, createScheduledController, waitOnExecutionContext } from "cloudflare:test";
import { env, exports } from "cloudflare:workers";
import { afterEach, describe, expect, it, vi } from "vitest";
import { buildReport, dailyReport, reportText, routeName } from "../src/report";
import worker from "../src/worker";
import { call, testSignIn } from "./helpers";

/** Monitoring (Architecture 06 §10): request data points without IDs, and the daily report. */

afterEach(() => vi.restoreAllMocks());

function withVars(vars: Record<string, string>): Env {
  return { ...env, ...vars } as unknown as Env;
}

describe("request metrics", () => {
  it("name routes without any IDs in them", () => {
    expect(routeName("GET", `/v1/backup/${crypto.randomUUID()}/mon`)).toBe("GET /v1/backup/:device/:slot");
    expect(routeName("POST", "/v1/sync")).toBe("POST /v1/sync");
    expect(routeName("GET", `/v1/transfer/${"ab".repeat(32)}/status`)).toBe("GET /v1/transfer/:id/status");
    expect(routeName("PUT", `/v1/transfer/${"ab".repeat(32)}`)).toBe("PUT /v1/transfer/:id");
    expect(routeName("GET", "/v1/snapshots/2026-10-05")).toBe("GET /v1/snapshots/:day");
    expect(routeName("POST", "/v1/auth/google")).toBe("POST /v1/auth/google");
    expect(routeName("GET", "/wp-admin/../../etc/passwd")).toBe("other");
    expect(routeName("GET", `/v1/${crypto.randomUUID()}`)).toBe("other");
  });

  it("are written for every request, and a broken metrics binding never fails one", async () => {
    const write = vi.fn(() => { throw new Error("dataset down"); });
    const response = await worker.fetch(new Request("https://api-dev.oftenenough.com/v1/status"), { ...env, METRICS: { writeDataPoint: write } } as unknown as Env, createExecutionContext());
    expect(response.status).toBe(200);
    expect(write).toHaveBeenCalledWith({ blobs: ["GET /v1/status", "200"], doubles: [expect.any(Number)], indexes: ["dev"] });
  });
});

describe("the daily report", () => {
  it("counts accounts syncing, free and Plus, and free sign-ins that signed another device out (Current Work 78)", async () => {
    const now = Date.now() + 2 * 86_400_000; // a day of its own
    const day = new Date(now - 86_400_000).toISOString().slice(0, 10);
    for (const [metric, n] of [["syncing_free", 7], ["syncing_plus", 2], ["replaced_device", 3]] as const) {
      await env.DIRECTORY.prepare("INSERT INTO usage_day (day, metric, n) VALUES (?, ?, ?)").bind(day, metric, n).run();
    }
    const report = await buildReport(env, now);
    expect(report.sync).toEqual({ freeAccounts: 7, plusAccounts: 2, replacedDevice: 3, rowsPerChange: null, bytesPerRecord: null });
    expect(reportText(report)).toContain("Syncing: 7 free, 2 Plus; free sign-ins that signed another device out: 3");
  });

  it("counts new and deleted accounts, purchases and failed snapshots in the last 24 hours", async () => {
    const before = await buildReport(env);
    const a = await testSignIn();
    await testSignIn();
    await call("POST", "/v1/account/delete", {}, a.json.accessToken);
    await env.DIRECTORY.prepare("INSERT INTO job_failure (at, kind, account_id, message) VALUES (?, 'snapshot', 'x', 'R2 down')").bind(Date.now()).run();
    const after = await buildReport(env);
    expect(after.accounts.new - before.accounts.new).toBe(1); // made yesterday and still open
    expect(after.accounts.deleted - before.accounts.deleted).toBe(1);
    expect(after.accounts.total - before.accounts.total).toBe(1);
    expect(after.jobs.snapshotFailures).toBeGreaterThan(0);
    expect(after.warnings.join(" ")).toContain("snapshot");
    expect(after.requests).toBeNull();
    expect(after.notes.join(" ")).toContain("ANALYTICS_TOKEN");
    expect(reportText(after)).toContain("Needs a look:");
  });

  it("includes requests from Analytics Engine when it's set up, and warns at 1% errors and half the free plan", async () => {
    const realFetch = globalThis.fetch;
    const asked: string[] = [];
    vi.spyOn(globalThis, "fetch").mockImplementation(async (input, init) => {
      const url = typeof input === "string" ? input : input instanceof URL ? input.href : input.url;
      if (!url.includes("/analytics_engine/sql")) return realFetch(input, init);
      asked.push(String(init?.body));
      return Response.json({ data: [{ route: "POST /v1/sync", total: "60000", errors: "900" }, { route: "GET /v1/status", total: "1000", errors: "0" }] });
    });
    const report = await buildReport(withVars({ ANALYTICS_TOKEN: "t", ACCOUNT_ID: "a" }));
    expect(asked[0]).toContain("FROM often_enough_dev");
    expect(report.requests).toMatchObject({ total: 61_000, errors: 900 });
    expect(report.warnings.join(" ")).toContain("Server errors: 1.5%");
    expect(report.warnings.join(" ")).toContain("61% of the free plan");
  });

  it("is emailed through Resend only when it's set up", async () => {
    const sent: { url: string; body: any; auth: string | null }[] = [];
    const realFetch = globalThis.fetch;
    vi.spyOn(globalThis, "fetch").mockImplementation(async (input, init) => {
      const url = typeof input === "string" ? input : input instanceof URL ? input.href : input.url;
      if (!url.startsWith("https://api.resend.com/")) return realFetch(input, init);
      sent.push({ url, body: JSON.parse(String(init?.body)), auth: new Headers(init?.headers).get("authorization") });
      return Response.json({ id: "email" });
    });
    await dailyReport(env);
    expect(sent).toHaveLength(0);
    await dailyReport(withVars({ RESEND_API_KEY: "re_test", REPORT_TO: "me@example.com, you@example.com" }));
    expect(sent).toHaveLength(1);
    expect(sent[0]!.auth).toBe("Bearer re_test");
    expect(sent[0]!.body.to).toEqual(["me@example.com", "you@example.com"]);
    expect(sent[0]!.body.text).toContain("Accounts:");
  });

  it("runs from the cron trigger", async () => {
    const logs: string[] = [];
    vi.spyOn(console, "log").mockImplementation((line: string) => { logs.push(line); });
    const ctx = createExecutionContext();
    await worker.scheduled!(createScheduledController({ scheduledTime: Date.now(), cron: "0 6 * * *" }), env, ctx);
    await waitOnExecutionContext(ctx);
    expect(logs.some((l) => l.includes('"event":"daily_report"'))).toBe(true);
  });

  it("a failing email retry never costs the day's report", async () => {
    const logs: string[] = [];
    vi.spyOn(console, "log").mockImplementation((line: string) => { logs.push(line); });
    vi.spyOn(console, "error").mockImplementation(() => {});
    const broken = { ...env, DIRECTORY: new Proxy(env.DIRECTORY, { get(target, prop) {
      if (prop === "prepare") return (sql: string) => { if (sql.includes("purchase_email SET status = 'failed', reason = 'expired'")) throw new Error("D1 down"); return target.prepare(sql); };
      return Reflect.get(target, prop);
    } }) } as unknown as Env;
    const ctx = createExecutionContext();
    await worker.scheduled!(createScheduledController({ scheduledTime: Date.now(), cron: "0 6 * * *" }), broken, ctx);
    await waitOnExecutionContext(ctx);
    expect(logs.some((l) => l.includes('"event":"daily_report"'))).toBe(true);
  });

  it("support can read it now, as text", async () => {
    const response = await exports.default.fetch("https://api-dev.oftenenough.com/v1/admin/report?format=text", {
      headers: { authorization: "Bearer test-admin-secret-0123456789abcdef012345" },
    });
    expect(response.status).toBe(200);
    expect(await response.text()).toContain("Often Enough (dev)");
  });
});

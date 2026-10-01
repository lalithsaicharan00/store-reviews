/**
 * Monitoring (Architecture 06 §10): one data point per request into Workers Analytics Engine, and a daily report
 * built at 06:00 UTC by the cron trigger. The report is always logged; it's emailed through Resend when
 * `RESEND_API_KEY` and `REPORT_TO` are set, and request numbers are included when `ANALYTICS_TOKEN` (a Cloudflare API
 * token with "Account Analytics: Read" only) is set. Nothing here ever holds habit content, tokens or account IDs.
 */

const DAY_MS = 86_400_000;
/** Workers Free allows 100,000 requests a day; the report warns from half of it (06 §10, Server Cost §1). */
const FREE_DAILY_REQUESTS = 100_000;

/** Optional secrets and vars: set where monitoring is wanted. */
interface MonitoringEnv extends Env {
  /** Absent until Analytics Engine is switched on for the account (wrangler.jsonc). */
  METRICS?: AnalyticsEngineDataset;
  ANALYTICS_TOKEN?: string;
  RESEND_API_KEY?: string;
  REPORT_TO?: string;
  REPORT_FROM?: string;
}

/** A route as a short name with no IDs in it: `GET /v1/backup/:device/:slot`, `other` for unknown paths. */
export function routeName(method: string, path: string): string {
  if (/^\/v1\/backup\/[^/]+\/[^/]+$/.test(path)) return `${method} /v1/backup/:device/:slot`;
  if (/^\/v1\/(status|auth\/[a-z]+|account(\/[a-z]+)?|sync|backup|purchases(\/verify)?|hooks\/apple|admin\/[a-z]+)$/.test(path)) return `${method} ${path}`;
  return "other";
}

export function recordRequest(env: Env, method: string, path: string, status: number, ms: number) {
  try {
    (env as MonitoringEnv).METRICS?.writeDataPoint({ blobs: [routeName(method, path), String(status)], doubles: [ms], indexes: [env.ENVIRONMENT] });
  } catch {
    // Metrics must never fail a request.
  }
}

export interface DailyReport {
  environment: string;
  day: string;
  accounts: { total: number; new: number; deleted: number };
  purchases: { linked: number; new: number };
  jobs: { snapshotFailures: number };
  requests: null | { total: number; errors: number; errorRate: number; freePlanShare: number; byRoute: { route: string; total: number; errors: number }[] };
  /** Things to look at (snapshot failures, errors above 1%, half the free plan used). */
  warnings: string[];
  /** Setup that's missing, not a problem. */
  notes: string[];
}

/** The report for the 24 hours before `now`. */
export async function buildReport(env: Env, now = Date.now()): Promise<DailyReport> {
  const since = now - DAY_MS;
  const db = env.DIRECTORY;
  const one = async (sql: string, ...values: unknown[]) => (await db.prepare(sql).bind(...values).first<{ n: number }>())?.n ?? 0;
  const report: DailyReport = {
    environment: env.ENVIRONMENT,
    day: new Date(since).toISOString().slice(0, 10),
    accounts: {
      total: await one("SELECT count(*) AS n FROM account WHERE id NOT IN (SELECT id FROM deleted_account)"),
      new: await one("SELECT count(*) AS n FROM account WHERE created_at >= ?", since),
      deleted: await one("SELECT count(*) AS n FROM deleted_account WHERE deleted_at >= ?", since),
    },
    purchases: {
      linked: await one("SELECT count(*) AS n FROM purchase"),
      new: await one("SELECT count(*) AS n FROM purchase WHERE created_at >= ?", since),
    },
    jobs: { snapshotFailures: await one("SELECT count(*) AS n FROM job_failure WHERE kind = 'snapshot' AND at >= ?", since) },
    requests: await requestCounts(env as MonitoringEnv),
    warnings: [],
    notes: [],
  };
  if (report.jobs.snapshotFailures > 0) report.warnings.push(`${report.jobs.snapshotFailures} nightly snapshot attempts failed (retried automatically; check the logs).`);
  if (report.requests && report.requests.errorRate > 0.01) report.warnings.push(`Server errors: ${(report.requests.errorRate * 100).toFixed(1)}% of requests (alert level 1%).`);
  if (report.requests && report.requests.freePlanShare >= 0.5) report.warnings.push(`${Math.round(report.requests.freePlanShare * 100)}% of the free plan's daily requests: time for Workers Paid.`);
  if (!report.requests) report.notes.push("Request numbers are off: set ANALYTICS_TOKEN (Account Analytics: Read) to include them.");
  // Failures older than 30 days are of no more use.
  await db.prepare("DELETE FROM job_failure WHERE at < ?").bind(now - 30 * DAY_MS).run();
  return report;
}

/** Yesterday's requests from Analytics Engine's SQL API, or null when it isn't set up. */
async function requestCounts(env: MonitoringEnv): Promise<DailyReport["requests"]> {
  if (!env.ANALYTICS_TOKEN || !env.ACCOUNT_ID) return null;
  const dataset = env.ENVIRONMENT === "production" ? "often_enough" : "often_enough_dev";
  const sql = `SELECT blob1 AS route, sum(_sample_interval) AS total, sum(if(toUInt32(blob2) >= 500, _sample_interval, 0)) AS errors
    FROM ${dataset} WHERE timestamp > NOW() - INTERVAL '1' DAY GROUP BY route ORDER BY total DESC FORMAT JSON`;
  try {
    const response = await fetch(`https://api.cloudflare.com/client/v4/accounts/${env.ACCOUNT_ID}/analytics_engine/sql`, {
      method: "POST",
      headers: { authorization: `Bearer ${env.ANALYTICS_TOKEN}` },
      body: sql,
    });
    if (!response.ok) return null;
    const rows = ((await response.json()) as { data: { route: string; total: number | string; errors: number | string }[] }).data;
    const byRoute = rows.map((r) => ({ route: r.route, total: Number(r.total), errors: Number(r.errors) }));
    const total = byRoute.reduce((sum, r) => sum + r.total, 0);
    const errors = byRoute.reduce((sum, r) => sum + r.errors, 0);
    return { total, errors, errorRate: total ? errors / total : 0, freePlanShare: total / FREE_DAILY_REQUESTS, byRoute };
  } catch {
    return null;
  }
}

export function reportText(r: DailyReport): string {
  const lines = [
    `Often Enough (${r.environment}), ${r.day}`,
    "",
    ...(r.warnings.length ? ["Needs a look:", ...r.warnings.map((w) => `- ${w}`), ""] : ["All fine.", ""]),
    `Accounts: ${r.accounts.total} (new and still open ${r.accounts.new}, deleted ${r.accounts.deleted})`,
    `Purchases linked: ${r.purchases.linked} (new ${r.purchases.new})`,
    `Nightly snapshot failures: ${r.jobs.snapshotFailures}`,
  ];
  if (r.notes.length) lines.push("", ...r.notes);
  if (r.requests) {
    lines.push(`Requests: ${r.requests.total} (${(r.requests.freePlanShare * 100).toFixed(1)}% of the free daily limit), server errors ${r.requests.errors}`);
    for (const route of r.requests.byRoute.slice(0, 12)) lines.push(`  ${route.route}: ${route.total}${route.errors ? `, ${route.errors} errors` : ""}`);
  }
  return lines.join("\n");
}

/** The cron trigger: build, log, and email if Resend is set up. */
export async function dailyReport(env: Env, now = Date.now()): Promise<DailyReport> {
  const report = await buildReport(env, now);
  console.log(JSON.stringify({ event: "daily_report", ...report, requests: report.requests ? { total: report.requests.total, errors: report.requests.errors } : null }));
  const m = env as MonitoringEnv;
  if (m.RESEND_API_KEY && m.REPORT_TO) {
    const response = await fetch("https://api.resend.com/emails", {
      method: "POST",
      headers: { authorization: `Bearer ${m.RESEND_API_KEY}`, "content-type": "application/json" },
      body: JSON.stringify({
        from: m.REPORT_FROM || "Often Enough <reports@oftenenough.com>",
        to: m.REPORT_TO.split(",").map((s) => s.trim()),
        subject: `${report.warnings.length ? "⚠️ " : ""}Often Enough ${env.ENVIRONMENT} report, ${report.day}`,
        text: reportText(report),
      }),
    });
    if (!response.ok) console.error(JSON.stringify({ event: "report_email_failed", status: response.status }));
  }
  return report;
}

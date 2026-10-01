import { jurisdictionOf } from "./directory";
import { HttpError, isUuid, json, readJson } from "./http";
import { buildReport, reportText } from "./report";
import { type Snapshot, gunzip, snapshotBucket, snapshotPrefix } from "./snapshots";
import { accountStub } from "./stubs";
import { bearer, safeEqual } from "./tokens";

/**
 * Support tools (Architecture 06 §9), for us, never for apps. They exist only where the `ADMIN_SECRET` secret is set
 * (at least 32 characters); everywhere else every `/v1/admin/*` path is a plain 404. Driven by
 * `scripts/restore-account.mjs`.
 *
 * - `GET  /v1/admin/report[?format=text]`: the daily report for the last 24 hours, now.
 * - `POST /v1/admin/snapshot {accountId}`: take a snapshot now.
 * - `GET  /v1/admin/snapshots?account=<id>`: the account's snapshots, newest first.
 * - `POST /v1/admin/restore {from, day, into?, apply?}`: compare snapshot `from`/`day` with account `into` (default:
 *   the same account) and, with `apply: true`, merge back what's missing or older there. Never removes anything.
 */
export async function adminRoute(request: Request, url: URL, env: Env): Promise<Response> {
  const secret = (env as { ADMIN_SECRET?: string }).ADMIN_SECRET;
  if (!secret || secret.length < 32 || !(await safeEqual(bearer(request) ?? "", secret))) {
    throw new HttpError(404, "not_found", "There's nothing here.");
  }
  const key = `${request.method} ${url.pathname}`;
  if (key === "POST /v1/admin/snapshot") {
    const body = await readJson<{ accountId?: unknown }>(request);
    const account = await existing(env, body.accountId);
    const taken = await accountStub(env, account).snapshotNow(account.jurisdiction);
    if (!taken) throw new HttpError(404, "no_account", "That account's data is gone.");
    return json(taken);
  }
  if (key === "GET /v1/admin/report") {
    const report = await buildReport(env);
    return url.searchParams.get("format") === "text" ? new Response(reportText(report), { headers: { "content-type": "text/plain; charset=utf-8" } }) : json(report);
  }
  if (key === "GET /v1/admin/snapshots") {
    const account = await existing(env, url.searchParams.get("account"));
    const page = await snapshotBucket(env, account.jurisdiction).list({ prefix: snapshotPrefix(account.accountId), include: ["customMetadata"] });
    const snapshots = page.objects
      .map((o) => ({ day: o.key.slice(-18, -8), size: o.size, records: Number(o.customMetadata?.records ?? 0), takenAt: Number(o.customMetadata?.takenAt ?? 0) }))
      .sort((a, b) => b.takenAt - a.takenAt);
    return json({ snapshots });
  }
  if (key === "POST /v1/admin/restore") {
    const body = await readJson<{ from?: unknown; day?: unknown; into?: unknown; apply?: unknown }>(request);
    const from = await existing(env, body.from);
    const into = await existing(env, body.into ?? body.from);
    if (typeof body.day !== "string" || !/^\d{4}-\d{2}-\d{2}$/.test(body.day)) throw new HttpError(400, "bad_request", '"day" must be YYYY-MM-DD.');
    const object = await snapshotBucket(env, from.jurisdiction).get(`${snapshotPrefix(from.accountId)}${body.day}.json.gz`);
    if (!object) throw new HttpError(404, "no_snapshot", "There's no snapshot for that day.");
    const snapshot = JSON.parse(await gunzip(object.body)) as Snapshot;
    if (snapshot.accountId !== from.accountId) throw new HttpError(409, "wrong_snapshot", "That snapshot belongs to another account.");
    const report = await accountStub(env, into).restoreRecords(snapshot.records, body.apply === true);
    if (!report) throw new HttpError(404, "no_account", "The account to restore into has no data object; sign in to it once first.");
    console.log(JSON.stringify({ event: "admin_restore", applied: report.applied, ops: report.ops }));
    return json({ snapshot: { day: body.day, takenAt: snapshot.takenAt, records: snapshot.records.length, cursor: snapshot.cursor }, ...report });
  }
  throw new HttpError(404, "not_found", "There's nothing here.");
}

/** An account in the directory. A deleted account has no snapshots either (they're deleted with it). */
async function existing(env: Env, accountId: unknown) {
  if (!isUuid(accountId)) throw new HttpError(400, "bad_request", "An account ID is needed.");
  const jurisdiction = await jurisdictionOf(env.DIRECTORY, accountId);
  if (!jurisdiction) throw new HttpError(404, "no_account", "There's no such account.");
  return { accountId, jurisdiction };
}

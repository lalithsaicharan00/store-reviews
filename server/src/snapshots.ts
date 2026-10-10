import type { Jurisdiction } from "./directory";

/**
 * Nightly R2 snapshots of synced accounts (Architecture 06 §9). Durable Objects keep 30 days of point-in-time
 * recovery; these cover longer, and our own bugs.
 *
 * - The first change of a day sets the account's alarm for the next 02:00 UTC; the alarm writes the whole account
 *   (every record with its field stamps, and the op-log cursor) to `snapshots/<account>/<YYYY-MM-DD>.json.gz` in the
 *   account's backup bucket (EU accounts: the EU bucket). An account that didn't change writes nothing.
 * - Kept: on Plus, 90 nightlies, then the 1st of each month; on free, the last 7 nightlies (Current Work 78). The
 *   bucket's lifecycle rule removes everything after 365 days.
 * - A failed alarm is retried by Cloudflare (with back-off), so a bad night is caught up the same night.
 * - Deleting the account deletes its snapshots.
 *
 * Restoring is a support tool (`POST /v1/admin/restore`, `scripts/restore-account.mjs`): it compares a snapshot with an
 * account and merges back only what's missing or older, as ops, so phones receive it through ordinary sync and newer
 * edits by the user are never overwritten.
 */

export const SNAPSHOT_FORMAT = 1;
const DAY_MS = 86_400_000;
const NIGHT_HOUR_UTC = 2;
/** Restore From a Backup offers "any day in the last 90 days" on Plus and the last 7 days on free (Free Sync §1). */
export const PLUS_SNAPSHOT_DAYS = 90;
export const FREE_SNAPSHOT_DAYS = 7;

export interface SnapshotRecord {
  table: string;
  row: string;
  /** The record as sync stores it: `{fields, clocks}` JSON (Core/sync `SyncRules.encodeRecord`). */
  data: string;
}

export interface Snapshot {
  format: number;
  accountId: string;
  takenAt: number;
  /** The last op-log sequence number included. */
  cursor: number;
  records: SnapshotRecord[];
}

export function snapshotBucket(env: Env, jurisdiction: Jurisdiction): R2Bucket {
  return jurisdiction === "eu" ? env.BACKUPS_EU : env.BACKUPS;
}

export function snapshotPrefix(accountId: string): string {
  return `snapshots/${accountId}/`;
}

export function snapshotKey(accountId: string, at: number): string {
  return `${snapshotPrefix(accountId)}${day(at)}.json.gz`;
}

export function day(at: number): string {
  return new Date(at).toISOString().slice(0, 10);
}

/** The next 02:00 UTC strictly after `now`. */
export function nextNight(now: number): number {
  const today = Math.floor(now / DAY_MS) * DAY_MS + NIGHT_HOUR_UTC * 3_600_000;
  return today > now ? today : today + DAY_MS;
}

/** The first day a plan keeps: Plus 90 days back, free the last 7 days (today and the 6 before). */
export function firstKeptDay(now: number, plus: boolean): string {
  return plus ? day(now - PLUS_SNAPSHOT_DAYS * DAY_MS) : day(now - (FREE_SNAPSHOT_DAYS - 1) * DAY_MS);
}

/**
 * Snapshot keys to delete. Plus: nightlies older than 90 days, except each month's 1st (kept until the 365-day rule).
 * Free: everything older than the last 7 days.
 */
export function prunable(keys: string[], now: number, plus = true): string[] {
  const cutoff = firstKeptDay(now, plus);
  return keys.filter((key) => {
    const name = key.slice(key.lastIndexOf("/") + 1, key.lastIndexOf("/") + 11);
    return /^\d{4}-\d{2}-\d{2}$/.test(name) && name < cutoff && (!plus || !name.endsWith("-01"));
  });
}

export async function gzip(text: string): Promise<ArrayBuffer> {
  const stream = new Blob([text]).stream().pipeThrough(new CompressionStream("gzip"));
  return new Response(stream).arrayBuffer();
}

export async function gunzip(body: ReadableStream | ArrayBuffer): Promise<string> {
  const stream = (body instanceof ArrayBuffer ? new Blob([body]).stream() : body).pipeThrough(new DecompressionStream("gzip"));
  return new Response(stream).text();
}

/** Deletes every snapshot of an account (account deletion). Safe to repeat. */
export async function deleteSnapshots(env: Env, account: { accountId: string; jurisdiction: Jurisdiction }): Promise<number> {
  const bucket = snapshotBucket(env, account.jurisdiction);
  let deleted = 0;
  let cursor: string | undefined;
  do {
    const page = await bucket.list({ prefix: snapshotPrefix(account.accountId), cursor });
    if (page.objects.length > 0) await bucket.delete(page.objects.map((o) => o.key));
    deleted += page.objects.length;
    cursor = page.truncated ? page.cursor : undefined;
  } while (cursor);
  return deleted;
}

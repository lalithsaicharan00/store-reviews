import { DurableObject } from "cloudflare:workers";
import { syncMerge, syncProblem } from "../core/Core-sync.mjs";
import type { Jurisdiction } from "./directory";
import type { VerifiedKey } from "./providers";
import { SNAPSHOT_FORMAT, type Snapshot, type SnapshotRecord, gzip, nextNight, prunable, snapshotBucket, snapshotKey, snapshotPrefix } from "./snapshots";
import { newSecret, sha256Hex } from "./tokens";

/**
 * One Durable Object per account, named by account ID (Architecture 06 §4). Its own SQLite database holds the
 * account's devices, sessions and sign-in keys, and its synced data: every record, and the log of every op applied.
 *
 * Every method returns a result instead of throwing, because errors lose their type crossing the RPC boundary.
 * An object with no `account_id` in `meta` is not an account (never set up, or deleted): every call says "gone".
 */

const SCHEMA_VERSION = 3;

/** Sync limits (Architecture 06 §4): a push is at most 500 ops (bigger outboxes come in chunks); a pull at most 1,000. */
export const MAX_PUSH = 500;
export const MAX_PULL = 1000;
const SESSION_LIFETIME_MS = 365 * 24 * 60 * 60 * 1000; // slides on every refresh, so active devices never expire
const RETRY_GRACE_MS = 2 * 60 * 1000;
/** `device.last_seen` only needs hour precision; writing it on every sync would be a quarter of all rows written. */
const LAST_SEEN_PRECISION_MS = 60 * 60 * 1000;

/** Compares two SHA-256 hex digests in constant time, without awaiting (see `refresh`). */
function sameHash(a: string, b: string): boolean {
  if (a.length !== b.length) return false; // digests are always 64 characters; this only rejects corrupt rows
  let difference = 0;
  for (let i = 0; i < a.length; i++) difference |= a.charCodeAt(i) ^ b.charCodeAt(i);
  return difference === 0;
}

export interface DeviceInfo {
  id: string;
  platform: string;
  name: string;
  appVersion: string;
}

/** `plus` goes into the new access token: only Plus accounts may sync (Server Cost and Capacity §4.2). */
export type SessionResult = { ok: true; secret: string; plus: boolean } | { ok: false; reason: "gone" | "invalid" | "reused" | "expired" };

export interface SyncRequest {
  /** The last `cursor` this device received; 0 the first time. */
  cursor: number;
  ops: unknown[];
  /** Where this account's data lives (from the access token): which bucket its nightly snapshots go to. */
  jurisdiction?: Jurisdiction;
}

/** What restoring a snapshot into an account found, per table, and whether it was applied. */
export interface RestoreReport {
  applied: boolean;
  tables: Record<string, { inSnapshot: number; missing: number; older: number; same: number }>;
  /** Ops written to the op log (phones receive them through ordinary sync). 0 when not applied. */
  ops: number;
}

export type SyncResult =
  | {
      ok: true;
      /** Every op ID this device can now forget: applied now, or already applied before (a retry). */
      applied: string[];
      /** Ops that can never be applied, with why. The device should keep them aside, not retry them forever. */
      rejected: { id: string | null; problem: string }[];
      /** Other devices' ops since `cursor`, in the order they were applied here. */
      ops: unknown[];
      cursor: number;
      /** More ops are waiting: sync again straight away with the new cursor. */
      more: boolean;
    }
  | { ok: false; reason: "gone" | "signed_out" | "too_many_ops" };

/** A verified store purchase (Architecture 02 §3.3). */
export interface PurchaseRecord {
  /** "test": dev only, the Plus that test and CI sign-ins get so end-to-end tests can sync. */
  store: "apple" | "google" | "test";
  originalId: string;
  productId: string;
  /** What it unlocks: "plus" or "family" (Plus Family, which includes Plus). */
  grants: "plus" | "family";
  environment: string;
  purchasedAt: number;
  revokedAt: number | null;
}

export interface Entitlements {
  plus: boolean;
  family: boolean;
  purchases: PurchaseRecord[];
}

export interface AccountSummary {
  accountId: string;
  createdAt: number;
  keys: { provider: string; email: string | null; isPrivateEmail: boolean; addedAt: number }[];
  devices: { id: string; platform: string; name: string; appVersion: string; lastSeen: number; signedIn: boolean }[];
}

export class Account extends DurableObject<Env> {
  private readonly sql: SqlStorage;

  constructor(ctx: DurableObjectState, env: Env) {
    super(ctx, env);
    this.sql = ctx.storage.sql;
    ctx.blockConcurrencyWhile(async () => this.migrate());
  }

  /** Schema changes only add (Architecture 08 §3); each object upgrades itself on its first request after a deploy. */
  private migrate() {
    this.sql.exec("CREATE TABLE IF NOT EXISTS meta (key TEXT PRIMARY KEY, value TEXT NOT NULL)");
    const current = Number(this.meta("schema") ?? "0");
    if (current >= SCHEMA_VERSION) return;
    this.ctx.storage.transactionSync(() => {
      if (current < 1) {
        this.sql.exec(`CREATE TABLE device (
          id TEXT PRIMARY KEY, platform TEXT NOT NULL, name TEXT NOT NULL, app_version TEXT NOT NULL,
          created_at INTEGER NOT NULL, last_seen INTEGER NOT NULL)`);
        // One session per device. `previous_hash` is the secret it replaced: seeing it again means a copied token.
        this.sql.exec(`CREATE TABLE session (
          device_id TEXT PRIMARY KEY, secret_hash TEXT NOT NULL, previous_hash TEXT,
          created_at INTEGER NOT NULL, rotated_at INTEGER NOT NULL, expires_at INTEGER NOT NULL)`);
        this.sql.exec(`CREATE TABLE sign_in_key (
          provider TEXT NOT NULL, subject TEXT NOT NULL, email TEXT, is_private_email INTEGER NOT NULL,
          added_at INTEGER NOT NULL, PRIMARY KEY (provider, subject))`);
      }
      if (current < 2) {
        // Every synced record, stored as sync sees it (fields + a stamp per field), whatever its table: the server
        // never needs to know the apps' schema, so it can store fields from app versions newer than itself (05 §12).
        this.sql.exec(`CREATE TABLE record (
          table_name TEXT NOT NULL, row_id TEXT NOT NULL, data TEXT NOT NULL, PRIMARY KEY (table_name, row_id))`);
        // Every op applied, in order. `seq` is the cursor devices pull from; `op_id` makes a retried op a no-op.
        this.sql.exec(`CREATE TABLE op_log (
          seq INTEGER PRIMARY KEY AUTOINCREMENT, op_id TEXT NOT NULL UNIQUE, device_id TEXT NOT NULL,
          op TEXT NOT NULL, received_at INTEGER NOT NULL)`);
      }
      if (current < 3) {
        // Verified store purchases. A refund or revocation sets revoked_at; nothing else removes Plus (02 §3.3).
        this.sql.exec(`CREATE TABLE purchase (
          store TEXT NOT NULL, original_id TEXT NOT NULL, product_id TEXT NOT NULL, grants TEXT NOT NULL,
          environment TEXT NOT NULL, purchased_at INTEGER NOT NULL, revoked_at INTEGER, recorded_at INTEGER NOT NULL,
          PRIMARY KEY (store, original_id))`);
      }
      this.setMeta("schema", String(SCHEMA_VERSION));
    });
  }

  /** Records a verified purchase. Recording it again changes nothing; a refund already recorded stays recorded. */
  async recordPurchase(purchase: PurchaseRecord, now = Date.now()): Promise<Entitlements | null> {
    if (this.accountId === undefined) return null;
    this.sql.exec(
      `INSERT INTO purchase (store, original_id, product_id, grants, environment, purchased_at, revoked_at, recorded_at)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)
       ON CONFLICT(store, original_id) DO UPDATE SET revoked_at = COALESCE(purchase.revoked_at, excluded.revoked_at)`,
      purchase.store, purchase.originalId, purchase.productId, purchase.grants, purchase.environment,
      purchase.purchasedAt, purchase.revokedAt, now,
    );
    return this.entitlements();
  }

  /** A refund or revocation confirmed by the store (02 §3.11). `revokedAt: null` undoes it (Apple REFUND_REVERSED). */
  async setRevoked(store: string, originalId: string, revokedAt: number | null): Promise<void> {
    this.sql.exec("UPDATE purchase SET revoked_at = ? WHERE store = ? AND original_id = ?", revokedAt, store, originalId);
  }

  /** Dev only (test and CI sign-ins): gives or takes away a test Plus, so end-to-end tests can be free or Plus. */
  private setTestPlus(on: boolean, now: number) {
    if (!on) {
      this.sql.exec("DELETE FROM purchase WHERE store = 'test'");
      return;
    }
    this.sql.exec(
      `INSERT INTO purchase (store, original_id, product_id, grants, environment, purchased_at, revoked_at, recorded_at)
       VALUES ('test', 'test', 'test.plus', 'plus', 'Test', ?, NULL, ?) ON CONFLICT(store, original_id) DO NOTHING`,
      now, now,
    );
  }

  private hasPlus(): boolean {
    return this.sql.exec("SELECT 1 FROM purchase WHERE revoked_at IS NULL LIMIT 1").toArray().length > 0;
  }

  async entitlements(): Promise<Entitlements | null> {
    if (this.accountId === undefined) return null;
    const purchases = this.sql
      .exec<{ store: PurchaseRecord["store"]; original_id: string; product_id: string; grants: "plus" | "family"; environment: string; purchased_at: number; revoked_at: number | null }>(
        "SELECT store, original_id, product_id, grants, environment, purchased_at, revoked_at FROM purchase ORDER BY purchased_at",
      )
      .toArray()
      .map((p) => ({ store: p.store, originalId: p.original_id, productId: p.product_id, grants: p.grants, environment: p.environment, purchasedAt: p.purchased_at, revokedAt: p.revoked_at }));
    const live = purchases.filter((p) => p.revokedAt === null);
    return { plus: live.length > 0, family: live.some((p) => p.grants === "family"), purchases };
  }

  /**
   * One sync round (Architecture 06 §4): apply this device's ops in one transaction (skipping any already applied),
   * then return other devices' ops after `cursor`. A crash before the reply is harmless: the device sends the same
   * ops again, and they're recognised by ID.
   */
  async sync(deviceId: string, request: SyncRequest, now = Date.now()): Promise<SyncResult> {
    if (this.accountId === undefined) return { ok: false, reason: "gone" };
    if (this.sql.exec("SELECT 1 FROM session WHERE device_id = ?", deviceId).toArray().length === 0) {
      return { ok: false, reason: "signed_out" };
    }
    if (request.ops.length > MAX_PUSH) return { ok: false, reason: "too_many_ops" };

    const applied: string[] = [];
    const rejected: { id: string | null; problem: string }[] = [];
    const valid: { id: string; table: string; row: string; json: string }[] = [];
    for (const op of request.ops) {
      const json = JSON.stringify(op);
      const problem = typeof op === "object" && op !== null ? syncProblem(json) : "not an op";
      const id = typeof (op as { id?: unknown })?.id === "string" ? (op as { id: string }).id : null;
      if (problem || id === null) {
        rejected.push({ id, problem: problem ?? "not an op" });
      } else {
        const { table, row } = op as { table: string; row: string };
        valid.push({ id, table, row, json });
      }
    }

    let changed = false;
    this.ctx.storage.transactionSync(() => {
      for (const op of valid) {
        applied.push(op.id);
        if (this.sql.exec("SELECT 1 FROM op_log WHERE op_id = ?", op.id).toArray().length > 0) continue;
        changed = true;
        const current = this.sql
          .exec<{ data: string }>("SELECT data FROM record WHERE table_name = ? AND row_id = ?", op.table, op.row)
          .toArray()[0]?.data;
        const merged = syncMerge(current ?? null, op.json);
        this.sql.exec(
          "INSERT INTO record (table_name, row_id, data) VALUES (?, ?, ?) ON CONFLICT(table_name, row_id) DO UPDATE SET data = excluded.data",
          op.table, op.row, merged,
        );
        this.sql.exec("INSERT INTO op_log (op_id, device_id, op, received_at) VALUES (?, ?, ?, ?)", op.id, deviceId, op.json, now);
      }
      // At most once an hour: an UPDATE that matches no row writes nothing.
      this.sql.exec("UPDATE device SET last_seen = ? WHERE id = ? AND last_seen <= ?", now, deviceId, now - LAST_SEEN_PRECISION_MS);
    });
    if (changed) await this.scheduleSnapshot(now, request.jurisdiction);

    // Pull: scan forward from the cursor, skipping this device's own ops (it has them), and move the cursor past
    // everything scanned so its own ops are never scanned again.
    const cursor = Number.isSafeInteger(request.cursor) && request.cursor > 0 ? request.cursor : 0;
    const rows = this.sql
      .exec<{ seq: number; device_id: string; op: string }>("SELECT seq, device_id, op FROM op_log WHERE seq > ? ORDER BY seq LIMIT ?", cursor, MAX_PULL)
      .toArray();
    const ops = rows.filter((r) => r.device_id !== deviceId).map((r) => JSON.parse(r.op) as unknown);
    const last = rows.at(-1);
    return { ok: true, applied, rejected, ops, cursor: last ? last.seq : cursor, more: rows.length === MAX_PULL };
  }

  /** For support and tests: the merged record, as the server holds it. */
  async record(table: string, row: string): Promise<unknown> {
    const data = this.sql.exec<{ data: string }>("SELECT data FROM record WHERE table_name = ? AND row_id = ?", table, row).toArray()[0]?.data;
    return data ? (JSON.parse(data) as unknown) : null;
  }

  private meta(key: string): string | undefined {
    return this.sql.exec<{ value: string }>("SELECT value FROM meta WHERE key = ?", key).toArray()[0]?.value;
  }

  private setMeta(key: string, value: string) {
    this.sql.exec("INSERT INTO meta (key, value) VALUES (?, ?) ON CONFLICT(key) DO UPDATE SET value = excluded.value", key, value);
  }

  private get accountId(): string | undefined {
    return this.meta("account_id");
  }

  /**
   * Signs a device in: sets the account up if it's new, records the key and device, and starts a fresh session.
   * `testPlus` (dev-only test and CI sign-ins, else null) gives or takes away a test Plus first.
   */
  async openSession(accountId: string, key: VerifiedKey, device: DeviceInfo, testPlus: boolean | null = null, now = Date.now()): Promise<SessionResult> {
    const secret = newSecret();
    const hash = await sha256Hex(secret);
    // From here on nothing awaits, so no other request can run in between (the read and the writes are one step).
    const existing = this.accountId;
    if (existing !== undefined && existing !== accountId) return { ok: false, reason: "gone" };
    this.ctx.storage.transactionSync(() => {
      if (existing === undefined) {
        this.setMeta("account_id", accountId);
        this.setMeta("created_at", String(now));
      }
      this.recordKey(key, now);
      this.sql.exec(
        `INSERT INTO device (id, platform, name, app_version, created_at, last_seen) VALUES (?, ?, ?, ?, ?, ?)
         ON CONFLICT(id) DO UPDATE SET platform = excluded.platform, name = excluded.name,
           app_version = excluded.app_version, last_seen = excluded.last_seen`,
        device.id, device.platform, device.name, device.appVersion, now, now,
      );
      // A new sign-in replaces whatever session this device had.
      this.sql.exec(
        `INSERT INTO session (device_id, secret_hash, previous_hash, created_at, rotated_at, expires_at) VALUES (?, ?, NULL, ?, ?, ?)
         ON CONFLICT(device_id) DO UPDATE SET secret_hash = excluded.secret_hash, previous_hash = NULL,
           created_at = excluded.created_at, rotated_at = excluded.rotated_at, expires_at = excluded.expires_at`,
        device.id, hash, now, now, now + SESSION_LIFETIME_MS,
      );
      if (testPlus !== null) this.setTestPlus(testPlus, now);
    });
    return { ok: true, secret, plus: this.hasPlus() };
  }

  /**
   * Rotates a device's refresh token. A token that was already used signs that device out (someone else has a copy);
   * other devices are unaffected (Architecture 06 §5).
   *
   * One exception: the app may send the same token twice when the first reply was lost (a timeout, a dropped
   * connection). Within [RETRY_GRACE_MS] of a rotation, the token it replaced still works once more and rotates again,
   * so a bad network never signs anyone out (Architecture 01 rule 6).
   */
  async refresh(deviceId: string, secret: string, now = Date.now()): Promise<SessionResult> {
    const hash = await sha256Hex(secret);
    const next = newSecret();
    const nextHash = await sha256Hex(next);
    // Nothing below awaits: two refreshes for one device can't interleave between the check and the update.
    if (this.accountId === undefined) return { ok: false, reason: "gone" };
    const session = this.sql
      .exec<{ secret_hash: string; previous_hash: string | null; rotated_at: number; expires_at: number }>(
        "SELECT secret_hash, previous_hash, rotated_at, expires_at FROM session WHERE device_id = ?",
        deviceId,
      )
      .toArray()[0];
    if (!session) return { ok: false, reason: "invalid" };
    const isCurrent = sameHash(hash, session.secret_hash);
    const isRetry = !isCurrent && session.previous_hash !== null && sameHash(hash, session.previous_hash);
    if (isRetry && now - session.rotated_at > RETRY_GRACE_MS) {
      this.sql.exec("DELETE FROM session WHERE device_id = ?", deviceId);
      return { ok: false, reason: "reused" };
    }
    if (!isCurrent && !isRetry) return { ok: false, reason: "invalid" };
    if (session.expires_at < now) return { ok: false, reason: "expired" };
    this.ctx.storage.transactionSync(() => {
      // A retry keeps the original "previous" token, so a second lost reply is covered too; the secret it
      // replaces (from the lost reply) was never received, so it simply stops working.
      this.sql.exec(
        `UPDATE session SET previous_hash = ${isCurrent ? "secret_hash" : "previous_hash"}, secret_hash = ?,
           rotated_at = ?, expires_at = ? WHERE device_id = ?`,
        nextHash, isCurrent ? now : session.rotated_at, now + SESSION_LIFETIME_MS, deviceId,
      );
      this.sql.exec("UPDATE device SET last_seen = ? WHERE id = ?", now, deviceId);
    });
    return { ok: true, secret: next, plus: this.hasPlus() };
  }

  /** True if this device still has a session: a signed-out or stolen-token device can't keep using old access tokens for long. */
  async isSignedIn(deviceId: string): Promise<boolean> {
    if (this.accountId === undefined) return false;
    return this.sql.exec("SELECT 1 FROM session WHERE device_id = ?", deviceId).toArray().length > 0;
  }

  async endSession(deviceId: string): Promise<void> {
    this.sql.exec("DELETE FROM session WHERE device_id = ?", deviceId);
  }

  async addKey(key: VerifiedKey, now = Date.now()): Promise<boolean> {
    if (this.accountId === undefined) return false;
    this.recordKey(key, now);
    return true;
  }

  async removeKey(provider: string, subject: string): Promise<void> {
    this.sql.exec("DELETE FROM sign_in_key WHERE provider = ? AND subject = ?", provider, subject);
  }

  async summary(): Promise<AccountSummary | null> {
    const accountId = this.accountId;
    if (accountId === undefined) return null;
    const keys = this.sql
      .exec<{ provider: string; email: string | null; is_private_email: number; added_at: number }>(
        "SELECT provider, email, is_private_email, added_at FROM sign_in_key ORDER BY added_at",
      )
      .toArray()
      .map((k) => ({ provider: k.provider, email: k.email, isPrivateEmail: k.is_private_email === 1, addedAt: k.added_at }));
    const devices = this.sql
      .exec<{ id: string; platform: string; name: string; app_version: string; last_seen: number; signed_in: number }>(
        `SELECT d.id, d.platform, d.name, d.app_version, d.last_seen, (s.device_id IS NOT NULL) AS signed_in
         FROM device d LEFT JOIN session s ON s.device_id = d.id ORDER BY d.last_seen DESC`,
      )
      .toArray()
      .map((d) => ({ id: d.id, platform: d.platform, name: d.name, appVersion: d.app_version, lastSeen: d.last_seen, signedIn: d.signed_in === 1 }));
    return { accountId, createdAt: Number(this.meta("created_at")), keys, devices };
  }

  /** Account deletion: everything this object holds is removed. The empty object then reports "gone". */
  async wipe(): Promise<void> {
    await this.ctx.storage.deleteAlarm();
    await this.ctx.storage.deleteAll();
    this.migrate();
  }

  // MARK: Nightly snapshots (Architecture 06 §9, snapshots.ts)

  private get jurisdiction(): Jurisdiction {
    return this.meta("jurisdiction") === "eu" ? "eu" : "default";
  }

  /** The day's first change sets the alarm for the coming night; later changes find it already set. */
  private async scheduleSnapshot(now: number, jurisdiction?: Jurisdiction) {
    if (jurisdiction && this.meta("jurisdiction") !== jurisdiction) this.setMeta("jurisdiction", jurisdiction);
    if ((await this.ctx.storage.getAlarm()) === null) await this.ctx.storage.setAlarm(nextNight(now));
  }

  /** The nightly alarm. Throwing makes Cloudflare retry it with back-off. */
  async alarm(): Promise<void> {
    if (this.accountId === undefined) return;
    await this.writeSnapshot(Date.now());
  }

  /** Support and the restore drill: a snapshot now, outside the nightly schedule. */
  async snapshotNow(now = Date.now()): Promise<{ key: string; records: number; cursor: number } | null> {
    if (this.accountId === undefined) return null;
    return this.writeSnapshot(now);
  }

  private async writeSnapshot(now: number): Promise<{ key: string; records: number; cursor: number }> {
    const accountId = this.accountId!;
    const records: SnapshotRecord[] = this.sql
      .exec<{ table_name: string; row_id: string; data: string }>("SELECT table_name, row_id, data FROM record ORDER BY table_name, row_id")
      .toArray()
      .map((r) => ({ table: r.table_name, row: r.row_id, data: r.data }));
    const cursor = Number(this.sql.exec<{ seq: number | null }>("SELECT max(seq) AS seq FROM op_log").one().seq ?? 0);
    const snapshot: Snapshot = { format: SNAPSHOT_FORMAT, accountId, takenAt: now, cursor, records };
    const bucket = snapshotBucket(this.env, this.jurisdiction);
    const key = snapshotKey(accountId, now);
    await bucket.put(key, await gzip(JSON.stringify(snapshot)), {
      httpMetadata: { contentType: "application/gzip" },
      customMetadata: { records: String(records.length), cursor: String(cursor), takenAt: String(now) },
    });
    const old = prunable((await bucket.list({ prefix: snapshotPrefix(accountId) })).objects.map((o) => o.key), now);
    if (old.length > 0) await bucket.delete(old);
    this.setMeta("last_snapshot", String(now));
    console.log(JSON.stringify({ event: "snapshot", records: records.length, pruned: old.length }));
    return { key, records: records.length, cursor };
  }

  /**
   * Support: merges a snapshot's records into this account (06 §9 "Restoring one account"). Only what's missing here,
   * or older here field by field, changes; everything newer here is kept, because the same merge rules decide. Each
   * change is written as ops from the device "restore", so phones receive them through ordinary sync. With
   * `apply: false` it only reports.
   */
  async restoreRecords(records: SnapshotRecord[], apply: boolean, now = Date.now()): Promise<RestoreReport | null> {
    if (this.accountId === undefined) return null;
    const tables: RestoreReport["tables"] = {};
    let written = 0;
    const work = () => {
      for (const record of records) {
        const stats = (tables[record.table] ??= { inSnapshot: 0, missing: 0, older: 0, same: 0 });
        stats.inSnapshot++;
        const current = this.sql
          .exec<{ data: string }>("SELECT data FROM record WHERE table_name = ? AND row_id = ?", record.table, record.row)
          .toArray()[0]?.data ?? null;
        // One op per stamp, so every field keeps the stamp it really has (as a phone does when it binds).
        const { fields, clocks } = JSON.parse(record.data) as { fields: Record<string, unknown>; clocks: Record<string, string> };
        const byStamp = new Map<string, Record<string, unknown>>();
        for (const [name, value] of Object.entries(fields)) {
          const stamp = clocks[name];
          if (stamp) byStamp.set(stamp, { ...(byStamp.get(stamp) ?? {}), [name]: value });
        }
        const ops = [...byStamp].map(([hlc, f]) => JSON.stringify({ id: crypto.randomUUID(), table: record.table, row: record.row, fields: f, hlc, schema: 0 }));
        let merged = current;
        for (const op of ops) merged = syncMerge(merged, op);
        if (merged === current) { stats.same++; continue; }
        if (current === null) stats.missing++; else stats.older++;
        if (!apply) continue;
        this.sql.exec(
          "INSERT INTO record (table_name, row_id, data) VALUES (?, ?, ?) ON CONFLICT(table_name, row_id) DO UPDATE SET data = excluded.data",
          record.table, record.row, merged,
        );
        for (const op of ops) {
          this.sql.exec("INSERT INTO op_log (op_id, device_id, op, received_at) VALUES (?, 'restore', ?, ?)", JSON.parse(op).id, op, now);
          written++;
        }
      }
    };
    if (apply) this.ctx.storage.transactionSync(work);
    else work();
    return { applied: apply, tables, ops: written };
  }

  private recordKey(key: VerifiedKey, now: number) {
    // The email can change (a relay turned off, a new Google address); keep the latest one the provider vouched for.
    this.sql.exec(
      `INSERT INTO sign_in_key (provider, subject, email, is_private_email, added_at) VALUES (?, ?, ?, ?, ?)
       ON CONFLICT(provider, subject) DO UPDATE SET email = COALESCE(excluded.email, sign_in_key.email),
         is_private_email = CASE WHEN excluded.email IS NULL THEN sign_in_key.is_private_email ELSE excluded.is_private_email END`,
      key.provider, key.subject, key.email, key.isPrivateEmail ? 1 : 0, now,
    );
  }
}

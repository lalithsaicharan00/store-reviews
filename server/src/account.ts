import { DurableObject } from "cloudflare:workers";
import type { VerifiedKey } from "./providers";
import { newSecret, sha256Hex } from "./tokens";

/**
 * One Durable Object per account, named by account ID (Architecture 06 §4). Its own SQLite database holds the
 * account's devices, sessions and sign-in keys; habit data and the sync log are added with sync (topic 5).
 *
 * Every method returns a result instead of throwing, because errors lose their type crossing the RPC boundary.
 * An object with no `account_id` in `meta` is not an account (never set up, or deleted): every call says "gone".
 */

const SCHEMA_VERSION = 1;
const SESSION_LIFETIME_MS = 365 * 24 * 60 * 60 * 1000; // slides on every refresh, so active devices never expire
const RETRY_GRACE_MS = 2 * 60 * 1000;

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

export type SessionResult = { ok: true; secret: string } | { ok: false; reason: "gone" | "invalid" | "reused" | "expired" };

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
      this.setMeta("schema", String(SCHEMA_VERSION));
    });
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

  /** Signs a device in: sets the account up if it's new, records the key and device, and starts a fresh session. */
  async openSession(accountId: string, key: VerifiedKey, device: DeviceInfo, now = Date.now()): Promise<SessionResult> {
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
    });
    return { ok: true, secret };
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
    return { ok: true, secret: next };
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
    await this.ctx.storage.deleteAll();
    this.migrate();
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

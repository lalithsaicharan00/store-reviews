import type { Jurisdiction } from "./directory";
import { HttpError, isUuid, json } from "./http";
import type { AccessClaims } from "./tokens";

/**
 * Backups on our server for accounts that don't sync (Backup, Sync and Accounts §4.2: "a free account backs up
 * nightly to our server"). The phone uploads its checked backup file (Architecture 03 §3.2); the server only stores
 * it. Worker + R2 only: no Durable Object, no database write (Server Cost and Capacity §4.1).
 *
 * - Each device keeps 7 copies, one per weekday (UTC), overwritten in turn: a bad night never destroys the other 6.
 * - Shrink guard: before a copy with far fewer records than the newest one is stored, the newest is kept aside
 *   (`before-shrink`), so a bug that empties the phone can't push the last good copy out.
 * - Checked: the phone sends the file's SHA-256, R2 refuses the write if the bytes don't match, and the reply carries
 *   the checksum R2 stored. The phone shows "Backed up" only when it matches (Architecture 03 §3.4).
 * - EU accounts' copies go to an EU-jurisdiction bucket. Every bucket has a lifecycle rule deleting copies 365 days
 *   after their upload, so a device that stops backing up leaves nothing behind for long.
 *
 * Keys: `<account>/<device>/<slot>`, slot = `sun` … `sat` or `before-shrink`.
 */

export const MAX_BACKUP_BYTES = 5 * 1024 * 1024;
const WEEKDAYS = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"] as const;
const KEPT_SLOT = "before-shrink";
/** A copy smaller than this share of the newest one's records triggers the shrink guard... */
const SHRINK_RATIO = 0.5;
/** ...once the newest one is big enough for a drop to mean something. */
const SHRINK_MIN_RECORDS = 20;

export interface BackupCopy {
  device: string;
  slot: string;
  deviceName: string;
  platform: string;
  appVersion: string;
  /** Backup file format version (Architecture 03 §3.2). */
  format: number;
  /** When the phone made the file (epoch ms). */
  createdAt: number;
  /** When it reached the server. */
  uploadedAt: number;
  size: number;
  sha256: string;
  habits: number;
  entries: number;
  /** Every record in the file, all tables: what the shrink guard compares. */
  records: number;
  /** True for the copy kept aside by the shrink guard. */
  kept: boolean;
}

function bucket(env: Env, jurisdiction: Jurisdiction): R2Bucket {
  return jurisdiction === "eu" ? env.BACKUPS_EU : env.BACKUPS;
}

function count(value: string | null, field: string): number {
  const n = Number(value);
  if (!value || !Number.isSafeInteger(n) || n < 0) throw new HttpError(400, "bad_request", `"${field}" is missing or invalid.`);
  return n;
}

function text(value: string | null, field: string, maxLength: number): string {
  let decoded: string;
  try {
    decoded = decodeURIComponent(value ?? "");
  } catch {
    throw new HttpError(400, "bad_request", `"${field}" is missing or invalid.`);
  }
  if (!decoded || decoded.length > maxLength) throw new HttpError(400, "bad_request", `"${field}" is missing or invalid.`);
  return decoded;
}

/** R2 custom metadata holds strings only. */
function toMetadata(copy: Omit<BackupCopy, "device" | "slot" | "size" | "sha256" | "kept">): Record<string, string> {
  return {
    deviceName: encodeURIComponent(copy.deviceName),
    platform: copy.platform,
    appVersion: copy.appVersion,
    format: String(copy.format),
    createdAt: String(copy.createdAt),
    uploadedAt: String(copy.uploadedAt),
    habits: String(copy.habits),
    entries: String(copy.entries),
    records: String(copy.records),
  };
}

function fromObject(object: R2Object): BackupCopy {
  const [, device = "", slot = ""] = object.key.split("/");
  const m = object.customMetadata ?? {};
  const n = (k: string) => Number(m[k] ?? "0") || 0;
  let deviceName = m.deviceName ?? "";
  try {
    deviceName = decodeURIComponent(deviceName);
  } catch {
    // Written by us, so this can't happen; keep the raw text rather than fail the whole listing.
  }
  return {
    device,
    slot,
    deviceName,
    platform: m.platform ?? "",
    appVersion: m.appVersion ?? "",
    format: n("format"),
    createdAt: n("createdAt"),
    uploadedAt: n("uploadedAt") || object.uploaded.getTime(),
    size: object.size,
    sha256: hex(object.checksums.sha256),
    habits: n("habits"),
    entries: n("entries"),
    records: n("records"),
    kept: slot === KEPT_SLOT,
  };
}

function hex(buffer: ArrayBuffer | undefined): string {
  return buffer ? [...new Uint8Array(buffer)].map((b) => b.toString(16).padStart(2, "0")).join("") : "";
}

async function listObjects(store: R2Bucket, prefix: string): Promise<R2Object[]> {
  const objects: R2Object[] = [];
  let cursor: string | undefined;
  do {
    const page = await store.list({ prefix, cursor, include: ["customMetadata"] });
    objects.push(...page.objects);
    cursor = page.truncated ? page.cursor : undefined;
  } while (cursor);
  return objects;
}

/** `PUT /v1/backup`: the body is the backup file; its details come in `x-backup-*` headers (see server/README.md). */
export async function storeBackup(request: Request, env: Env, claims: AccessClaims, now = Date.now()): Promise<Response> {
  const h = request.headers;
  const sha256 = (h.get("x-backup-sha256") ?? "").toLowerCase();
  if (!/^[0-9a-f]{64}$/.test(sha256)) throw new HttpError(400, "bad_request", '"x-backup-sha256" must be the file\'s SHA-256 in hex.');
  const details = {
    deviceName: text(h.get("x-backup-device-name"), "x-backup-device-name", 100),
    platform: text(h.get("x-backup-platform"), "x-backup-platform", 20),
    appVersion: text(h.get("x-backup-app-version"), "x-backup-app-version", 32),
    format: count(h.get("x-backup-format"), "x-backup-format"),
    createdAt: count(h.get("x-backup-created-at"), "x-backup-created-at"),
    uploadedAt: now,
    habits: count(h.get("x-backup-habits"), "x-backup-habits"),
    entries: count(h.get("x-backup-entries"), "x-backup-entries"),
    records: count(h.get("x-backup-records"), "x-backup-records"),
  };

  if (Number(h.get("content-length") ?? "0") > MAX_BACKUP_BYTES) throw tooLarge();
  const body = await request.arrayBuffer();
  if (body.byteLength > MAX_BACKUP_BYTES) throw tooLarge();
  if (body.byteLength === 0) throw new HttpError(400, "bad_request", "The backup file is empty.");
  const actual = hex(await crypto.subtle.digest("SHA-256", body));
  if (actual !== sha256) throw new HttpError(400, "checksum_mismatch", "The backup was damaged on the way. Nothing was replaced; please try again.");

  const store = bucket(env, claims.jurisdiction);
  const prefix = `${claims.accountId}/${claims.deviceId}/`;

  // Shrink guard: keep the newest copy aside before a much smaller one arrives.
  let kept = false;
  const newest = (await listObjects(store, prefix))
    .map((o) => ({ object: o, copy: fromObject(o) }))
    .filter((c) => !c.copy.kept)
    .sort((a, b) => b.copy.uploadedAt - a.copy.uploadedAt)[0];
  if (newest && newest.copy.records >= SHRINK_MIN_RECORDS && details.records < newest.copy.records * SHRINK_RATIO) {
    const previous = await store.get(newest.object.key);
    if (previous) {
      await store.put(`${prefix}${KEPT_SLOT}`, await previous.arrayBuffer(), {
        sha256: previous.checksums.sha256,
        httpMetadata: { contentType: "application/zip" },
        customMetadata: previous.customMetadata,
      });
      kept = true;
    }
  }

  const slot = WEEKDAYS[new Date(now).getUTCDay()]!;
  // R2 checks the bytes against `sha256` and refuses the write if they differ.
  const written = await store.put(`${prefix}${slot}`, body, {
    sha256,
    httpMetadata: { contentType: "application/zip" },
    customMetadata: toMetadata(details),
  });
  const copy = fromObject(written);
  console.log(JSON.stringify({ event: "backup_stored", size: copy.size, kept }));
  return json({ ...copy, keptPrevious: kept }, 201);
}

function tooLarge() {
  return new HttpError(413, "too_large", `A backup can be at most ${MAX_BACKUP_BYTES / 1024 / 1024} MB.`);
}

/** `GET /v1/backup`: every copy this account has on the server, newest first. */
export async function listBackups(env: Env, claims: AccessClaims): Promise<Response> {
  const copies = (await listObjects(bucket(env, claims.jurisdiction), `${claims.accountId}/`)).map(fromObject);
  copies.sort((a, b) => b.createdAt - a.createdAt || b.uploadedAt - a.uploadedAt);
  return json({ copies });
}

/** `GET /v1/backup/<device>/<slot>`: one copy's file, any device of this account. */
export async function readBackup(env: Env, claims: AccessClaims, device: string, slot: string): Promise<Response> {
  if (!isUuid(device) || !(WEEKDAYS.includes(slot as never) || slot === KEPT_SLOT)) {
    throw new HttpError(404, "not_found", "There's nothing here.");
  }
  const object = await bucket(env, claims.jurisdiction).get(`${claims.accountId}/${device.toLowerCase()}/${slot}`);
  if (!object) throw new HttpError(404, "no_backup", "This backup isn't on the server.");
  const copy = fromObject(object);
  return new Response(object.body, {
    headers: {
      "content-type": "application/zip",
      "content-length": String(object.size),
      "cache-control": "no-store",
      "x-backup-sha256": copy.sha256,
      "x-backup-created-at": String(copy.createdAt),
      "x-backup-device-name": encodeURIComponent(copy.deviceName),
    },
  });
}

/**
 * Removes every copy of an account: when it's deleted, or when its owner chooses "iCloud only" (§4.3).
 * Safe to repeat.
 */
export async function deleteBackups(env: Env, account: { accountId: string; jurisdiction: Jurisdiction }): Promise<number> {
  const store = bucket(env, account.jurisdiction);
  const keys = (await listObjects(store, `${account.accountId}/`)).map((o) => o.key);
  for (let i = 0; i < keys.length; i += 1000) await store.delete(keys.slice(i, i + 1000));
  return keys.length;
}

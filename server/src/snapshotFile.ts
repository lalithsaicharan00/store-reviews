import { HttpError, json } from "./http";
import { type Snapshot, gunzip, snapshotBucket, snapshotPrefix } from "./snapshots";
import type { AccessClaims } from "./tokens";

/**
 * Restore From a Backup for Plus (Account and Backup Redesign, screen 6c; Current Work 76): "any day in the last 90
 * days". Sync copies a mistake to every device within seconds, so the account's nightly snapshots (snapshots.ts) are the
 * only way back. The app lists them and gets one day as an ordinary backup file (`Core/Backup File Format.md`, format
 * 1), which it checks, previews and restores like any other, with its 30-day undo (D5); the restore syncs to every
 * device like any edit. The snapshot itself is never changed.
 *
 * - `GET /v1/snapshots`: `{ snapshots: [{ day, takenAt, records }] }`, newest first.
 * - `GET /v1/snapshots/<YYYY-MM-DD>`: that day's backup file (`application/zip`), its SHA-256 in `x-backup-sha256`.
 */

const TABLES = ["habit", "step", "reminder", "entry", "setting"] as const;
/** Settings that only make sense on one device (Core `SyncCodec.isLocalSetting`): never in a backup file. */
const LOCAL_SETTINGS = new Set(["placement_v1", "placement_v2"]);
/** Core's database schema when this was written (`HabitRepository.SCHEMA_VERSION`); for support only, readers ignore it. */
const SCHEMA = 8;

export async function listSnapshots(env: Env, claims: AccessClaims): Promise<Response> {
  const bucket = snapshotBucket(env, claims.jurisdiction);
  const snapshots: { day: string; takenAt: number; records: number }[] = [];
  let cursor: string | undefined;
  do {
    const page = await bucket.list({ prefix: snapshotPrefix(claims.accountId), cursor, include: ["customMetadata"] });
    for (const o of page.objects) {
      const day = o.key.slice(-18, -8);
      if (!/^\d{4}-\d{2}-\d{2}$/.test(day)) continue;
      snapshots.push({ day, takenAt: Number(o.customMetadata?.takenAt ?? 0) || o.uploaded.getTime(), records: Number(o.customMetadata?.records ?? 0) });
    }
    cursor = page.truncated ? page.cursor : undefined;
  } while (cursor);
  snapshots.sort((a, b) => b.takenAt - a.takenAt);
  return json({ snapshots });
}

export async function snapshotBackupFile(env: Env, claims: AccessClaims, day: string): Promise<Response> {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(day)) throw new HttpError(404, "not_found", "There's nothing here.");
  const object = await snapshotBucket(env, claims.jurisdiction).get(`${snapshotPrefix(claims.accountId)}${day}.json.gz`);
  if (!object) throw new HttpError(404, "no_snapshot", "There's no copy for that day.");
  const snapshot = JSON.parse(await gunzip(object.body)) as Snapshot;
  if (snapshot.accountId !== claims.accountId) throw new HttpError(404, "no_snapshot", "There's no copy for that day.");
  const file = await backupFileFrom(snapshot);
  return new Response(file.bytes, {
    headers: {
      "content-type": "application/zip",
      "content-length": String(file.bytes.byteLength),
      "cache-control": "no-store",
      "x-backup-sha256": file.sha256,
      "x-backup-created-at": String(snapshot.takenAt),
      "x-backup-habits": String(file.habits),
      "x-backup-entries": String(file.entries),
    },
  });
}

/**
 * A snapshot as a backup file: each record's sync fields become a row (`id` plus the fields, as `BackupFile.write`
 * makes them), per table. A step, time or log whose habit isn't in the snapshot is left out (a file with one is refused
 * as damaged), and counted in the result.
 */
export async function backupFileFrom(snapshot: Snapshot): Promise<{ bytes: Uint8Array; sha256: string; habits: number; entries: number; orphans: number }> {
  const rows: Record<(typeof TABLES)[number], Record<string, unknown>[]> = { habit: [], step: [], reminder: [], entry: [], setting: [] };
  for (const record of snapshot.records) {
    if (!(TABLES as readonly string[]).includes(record.table)) continue;
    if (record.table === "setting" && LOCAL_SETTINGS.has(record.row)) continue;
    const { fields } = JSON.parse(record.data) as { fields: Record<string, unknown> };
    rows[record.table as (typeof TABLES)[number]].push({ id: record.row, ...fields });
  }
  const habits = new Set(rows.habit.map((h) => h.id));
  let orphans = 0;
  for (const table of ["step", "reminder", "entry"] as const) {
    const kept = rows[table].filter((r) => habits.has(r.habit_id));
    orphans += rows[table].length - kept.length;
    rows[table] = kept;
  }
  const data = new TextEncoder().encode(JSON.stringify(rows));
  const live = (list: Record<string, unknown>[]) => list.filter((r) => r.deleted_at === null || r.deleted_at === undefined).length;
  const liveHabits = live(rows.habit);
  const liveEntries = live(rows.entry);
  const manifest = new TextEncoder().encode(JSON.stringify({
    format: 1,
    app: "Often Enough",
    appVersion: "account",
    platform: "server",
    deviceName: "Your account",
    createdAt: snapshot.takenAt,
    schema: SCHEMA,
    data: { file: "data.json", sha256: await sha256Hex(data), bytes: data.byteLength },
    counts: Object.fromEntries(TABLES.map((t) => [t, rows[t].length])),
    live: { habits: liveHabits, entries: liveEntries },
  }));
  const bytes = zip([{ name: "manifest.json", data: manifest }, { name: "data.json", data }], snapshot.takenAt);
  return { bytes, sha256: await sha256Hex(bytes), habits: liveHabits, entries: liveEntries, orphans };
}

async function sha256Hex(bytes: Uint8Array): Promise<string> {
  return [...new Uint8Array(await crypto.subtle.digest("SHA-256", bytes))].map((b) => b.toString(16).padStart(2, "0")).join("");
}

// MARK: A stored zip, as Core's `Zip.write` makes it

const CRC_TABLE = (() => {
  const table = new Uint32Array(256);
  for (let n = 0; n < 256; n++) {
    let c = n;
    for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
    table[n] = c >>> 0;
  }
  return table;
})();

export function crc32(data: Uint8Array): number {
  let c = 0xffffffff;
  for (const b of data) c = CRC_TABLE[(c ^ b) & 0xff]! ^ (c >>> 8);
  return (c ^ 0xffffffff) >>> 0;
}

function dosTime(epochMillis: number): [number, number] {
  const d = new Date(epochMillis);
  const year = d.getUTCFullYear();
  if (year < 1980) return [0, (1 << 5) | 1];
  const time = (d.getUTCHours() << 11) | (d.getUTCMinutes() << 5) | Math.floor(d.getUTCSeconds() / 2);
  const date = ((year - 1980) << 9) | ((d.getUTCMonth() + 1) << 5) | d.getUTCDate();
  return [time, date];
}

export function zip(entries: { name: string; data: Uint8Array }[], modifiedAt: number): Uint8Array {
  const [time, date] = dosTime(modifiedAt);
  const central: number[] = [];
  const u16 = (out: number[], v: number) => out.push(v & 0xff, (v >>> 8) & 0xff);
  const u32 = (out: number[], v: number) => { u16(out, v & 0xffff); u16(out, (v >>> 16) & 0xffff); };
  const parts: Uint8Array[] = [];
  let offset = 0;
  for (const entry of entries) {
    const name = new TextEncoder().encode(entry.name);
    const crc = crc32(entry.data);
    const header: number[] = [];
    u32(header, 0x04034b50); u16(header, 20); u16(header, 0x0800); u16(header, 0); u16(header, time); u16(header, date);
    u32(header, crc); u32(header, entry.data.byteLength); u32(header, entry.data.byteLength); u16(header, name.byteLength); u16(header, 0);
    const headerBytes = Uint8Array.from([...header, ...name]);
    parts.push(headerBytes, entry.data);
    u32(central, 0x02014b50); u16(central, 20); u16(central, 20); u16(central, 0x0800); u16(central, 0);
    u16(central, time); u16(central, date); u32(central, crc); u32(central, entry.data.byteLength); u32(central, entry.data.byteLength);
    u16(central, name.byteLength); u16(central, 0); u16(central, 0); u16(central, 0); u16(central, 0); u32(central, 0); u32(central, offset);
    central.push(...name);
    offset += headerBytes.byteLength + entry.data.byteLength;
  }
  const end: number[] = [];
  u32(end, 0x06054b50); u16(end, 0); u16(end, 0); u16(end, entries.length); u16(end, entries.length);
  u32(end, central.length); u32(end, offset); u16(end, 0);
  parts.push(Uint8Array.from(central), Uint8Array.from(end));
  const out = new Uint8Array(parts.reduce((n, p) => n + p.byteLength, 0));
  let at = 0;
  for (const p of parts) { out.set(p, at); at += p.byteLength; }
  return out;
}

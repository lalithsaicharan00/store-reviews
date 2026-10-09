import { runDurableObjectAlarm, runInDurableObject } from "cloudflare:test";
import { env, exports } from "cloudflare:workers";
import { describe, expect, it, vi } from "vitest";
import type { Account } from "../src/account";
import { type Snapshot, gunzip, nextNight, prunable } from "../src/snapshots";
import { call, device, testSignIn } from "./helpers";

/** Nightly R2 snapshots of synced accounts, and restoring one account from them (Architecture 06 §9). */

const ADMIN = "test-admin-secret-0123456789abcdef012345";
const hlc = (ms: number, node = "phone") => `${String(ms).padStart(18, "0")}-00000-${node}`;
const habit = (row: string, name: string, ms = Date.now()) => ({
  id: crypto.randomUUID(), table: "habit", row, fields: { name, deleted_at: null }, hlc: hlc(ms), schema: 6,
});
const entry = (row: string, habitId: string, ms = Date.now()) => ({
  id: crypto.randomUUID(), table: "entry", row, fields: { habit_id: habitId, day: "2026-10-01", value: 1, deleted_at: null }, hlc: hlc(ms), schema: 6,
});

function stub(accountId: string) {
  return env.ACCOUNT.get(env.ACCOUNT.idFromName(accountId)) as DurableObjectStub<Account>;
}

const alarmOf = (accountId: string) => runInDurableObject(stub(accountId), (_instance, state) => state.storage.getAlarm());

async function admin(method: string, path: string, body?: unknown, secret = ADMIN) {
  const response = await exports.default.fetch(`https://api-dev.oftenenough.com${path}`, {
    method,
    headers: { authorization: `Bearer ${secret}`, "content-type": "application/json" },
    body: body === undefined ? undefined : JSON.stringify(body),
  });
  return { status: response.status, json: (await response.json()) as Record<string, any> };
}

async function readSnapshot(bucket: R2Bucket, key: string): Promise<Snapshot> {
  const object = await bucket.get(key);
  return JSON.parse(await gunzip(object!.body)) as Snapshot;
}

describe("when snapshots run", () => {
  it("the next 02:00 UTC, strictly after now", () => {
    expect(new Date(nextNight(Date.UTC(2026, 9, 1, 1, 59))).toISOString()).toBe("2026-10-01T02:00:00.000Z");
    expect(new Date(nextNight(Date.UTC(2026, 9, 1, 2, 0))).toISOString()).toBe("2026-10-02T02:00:00.000Z");
    expect(new Date(nextNight(Date.UTC(2026, 9, 1, 23, 0))).toISOString()).toBe("2026-10-02T02:00:00.000Z");
  });

  it("keeps 90 nightlies, then each month's 1st", () => {
    const now = Date.UTC(2026, 9, 1);
    const keys = ["2026-09-30", "2026-07-04", "2026-07-01", "2026-06-15", "2026-06-01", "2025-11-01"].map((d) => `snapshots/a/${d}.json.gz`);
    expect(prunable(keys, now)).toEqual(["snapshots/a/2026-06-15.json.gz"]);
  });

  it("a sync that changes something sets the night's alarm; a pull with nothing new doesn't", async () => {
    const quiet = await testSignIn();
    await call("POST", "/v1/sync", { cursor: 0, ops: [] }, quiet.json.accessToken);
    expect(await alarmOf(quiet.json.accountId)).toBeNull();

    const busy = await testSignIn();
    await call("POST", "/v1/sync", { cursor: 0, ops: [habit(crypto.randomUUID(), "Read")] }, busy.json.accessToken);
    const alarm = await alarmOf(busy.json.accountId);
    expect(alarm).toBe(nextNight(Date.now()));
  });
});

describe("the nightly snapshot", () => {
  it("writes every record to R2, gzipped; with nothing new since, no alarm is left", async () => {
    const me = await testSignIn();
    const h = crypto.randomUUID();
    await call("POST", "/v1/sync", { cursor: 0, ops: [habit(h, "Read ☕"), entry(crypto.randomUUID(), h), entry(crypto.randomUUID(), h)] }, me.json.accessToken);
    expect(await runDurableObjectAlarm(stub(me.json.accountId))).toBe(true);
    const listed = await env.BACKUPS.list({ prefix: `snapshots/${me.json.accountId}/` });
    expect(listed.objects).toHaveLength(1);
    const snapshot = await readSnapshot(env.BACKUPS, listed.objects[0]!.key);
    expect(snapshot).toMatchObject({ format: 1, accountId: me.json.accountId, cursor: 3 });
    expect(snapshot.records).toHaveLength(3);
    expect(JSON.parse(snapshot.records.find((r) => r.row === h)!.data).fields.name).toBe("Read ☕");
    // Nothing changed since: no alarm left, so tomorrow writes nothing.
    expect(await alarmOf(me.json.accountId)).toBeNull();
  });

  it("prunes old nightlies as it writes", async () => {
    const me = await testSignIn();
    await call("POST", "/v1/sync", { cursor: 0, ops: [habit(crypto.randomUUID(), "Read")] }, me.json.accessToken);
    const old = `snapshots/${me.json.accountId}/2020-03-15.json.gz`;
    const monthly = `snapshots/${me.json.accountId}/2026-07-01.json.gz`;
    await env.BACKUPS.put(old, "x");
    await env.BACKUPS.put(monthly, "x");
    await runDurableObjectAlarm(stub(me.json.accountId));
    expect(await env.BACKUPS.head(old)).toBeNull();
    expect(await env.BACKUPS.head(monthly)).not.toBeNull();
  });

  it("an EU account's snapshots stay in the EU bucket", async () => {
    const asked = vi.spyOn(env.ACCOUNT, "jurisdiction").mockImplementation(() => env.ACCOUNT);
    try {
      const me = await testSignIn(undefined, device(), { country: "FRA" });
      await call("POST", "/v1/sync", { cursor: 0, ops: [habit(crypto.randomUUID(), "Lire")] }, me.json.accessToken);
      await runDurableObjectAlarm(stub(me.json.accountId));
      expect((await env.BACKUPS_EU.list({ prefix: `snapshots/${me.json.accountId}/` })).objects).toHaveLength(1);
      expect((await env.BACKUPS.list({ prefix: `snapshots/${me.json.accountId}/` })).objects).toHaveLength(0);
    } finally {
      asked.mockRestore();
    }
  });

  it("support's snapshot of an EU account that never synced a change still goes to the EU bucket", async () => {
    const asked = vi.spyOn(env.ACCOUNT, "jurisdiction").mockImplementation(() => env.ACCOUNT);
    try {
      const me = await testSignIn(undefined, device(), { country: "ITA", plus: false });
      expect((await admin("POST", "/v1/admin/snapshot", { accountId: me.json.accountId })).status).toBe(200);
      expect((await env.BACKUPS_EU.list({ prefix: `snapshots/${me.json.accountId}/` })).objects).toHaveLength(1);
      expect((await env.BACKUPS.list({ prefix: `snapshots/${me.json.accountId}/` })).objects).toHaveLength(0);
      await call("POST", "/v1/account/delete", {}, me.json.accessToken);
      expect((await env.BACKUPS_EU.list({ prefix: `snapshots/${me.json.accountId}/` })).objects).toHaveLength(0);
    } finally {
      asked.mockRestore();
    }
  });

  it("deleting the account deletes its snapshots and its alarm", async () => {
    const me = await testSignIn();
    await call("POST", "/v1/sync", { cursor: 0, ops: [habit(crypto.randomUUID(), "Read")] }, me.json.accessToken);
    await runDurableObjectAlarm(stub(me.json.accountId));
    await call("POST", "/v1/sync", { cursor: 0, ops: [habit(crypto.randomUUID(), "Walk")] }, me.json.accessToken);
    await call("POST", "/v1/account/delete", {}, me.json.accessToken);
    expect((await env.BACKUPS.list({ prefix: `snapshots/${me.json.accountId}/` })).objects).toHaveLength(0);
    expect(await alarmOf(me.json.accountId)).toBeNull();
  });
});

describe("restoring one account (support)", () => {
  it("doesn't exist without the admin secret", async () => {
    expect((await admin("GET", "/v1/admin/snapshots?account=x", undefined, "wrong")).status).toBe(404);
    expect((await admin("GET", "/v1/admin/snapshots?account=x", undefined, "")).status).toBe(404);
  });

  it("the drill: a snapshot restored into a fresh account reaches a phone signed in there, record for record", async () => {
    // The original account, with a habit, two logs and an undone log.
    const original = await testSignIn();
    const h = crypto.randomUUID(), e1 = crypto.randomUUID(), e2 = crypto.randomUUID();
    const undone = { ...entry(e2, h, Date.now() + 5), fields: { deleted_at: Date.now() } };
    await call("POST", "/v1/sync", { cursor: 0, ops: [habit(h, "Stretch"), entry(e1, h), entry(e2, h), undone] }, original.json.accessToken);
    const taken = await admin("POST", "/v1/admin/snapshot", { accountId: original.json.accountId });
    expect(taken.json.records).toBe(3);
    const day = new Date().toISOString().slice(0, 10);
    expect((await admin("GET", `/v1/admin/snapshots?account=${original.json.accountId}`)).json.snapshots[0]).toMatchObject({ day, records: 3 });

    // Into the same account: everything is already there.
    const same = await admin("POST", "/v1/admin/restore", { from: original.json.accountId, day });
    expect(same.json.tables.habit).toEqual({ inSnapshot: 1, missing: 0, older: 0, same: 1 });
    expect(same.json.applied).toBe(false);

    // Into a fresh account: a dry run changes nothing, then apply.
    const fresh = await testSignIn();
    const dry = await admin("POST", "/v1/admin/restore", { from: original.json.accountId, day, into: fresh.json.accountId });
    expect(dry.json.tables.entry).toEqual({ inSnapshot: 2, missing: 2, older: 0, same: 0 });
    expect(await stub(fresh.json.accountId).record("habit", h)).toBeNull();
    const applied = await admin("POST", "/v1/admin/restore", { from: original.json.accountId, day, into: fresh.json.accountId, apply: true });
    expect(applied.json.applied).toBe(true);
    for (const [table, row] of [["habit", h], ["entry", e1], ["entry", e2]] as const) {
      expect(await stub(fresh.json.accountId).record(table, row)).toEqual(await stub(original.json.accountId).record(table, row));
    }

    // The fresh account's phone receives it through ordinary sync, the undone log still undone.
    const pulled = await call("POST", "/v1/sync", { cursor: 0, ops: [] }, fresh.json.accessToken);
    const ops = pulled.json.ops as { row: string; fields: Record<string, unknown> }[];
    expect(new Set(ops.map((o) => o.row))).toEqual(new Set([h, e1, e2]));
    expect(ops.some((o) => o.row === e2 && typeof o.fields.deleted_at === "number")).toBe(true);

    // Applying again changes nothing.
    const again = await admin("POST", "/v1/admin/restore", { from: original.json.accountId, day, into: fresh.json.accountId, apply: true });
    expect(again.json.ops).toBe(0);
  });

  it("never overwrites a newer edit: only what's missing or older comes back", async () => {
    const me = await testSignIn();
    const kept = crypto.randomUUID(), lost = crypto.randomUUID();
    const t = Date.now();
    await call("POST", "/v1/sync", { cursor: 0, ops: [habit(kept, "Read", t), habit(lost, "Walk", t)] }, me.json.accessToken);
    await admin("POST", "/v1/admin/snapshot", { accountId: me.json.accountId });
    // After the snapshot the person renames one habit (newer) ... and a server bug loses the other's name.
    await call("POST", "/v1/sync", { cursor: 0, ops: [habit(kept, "Read more", t + 1000)] }, me.json.accessToken);
    await runInDurableObject(stub(me.json.accountId), (_instance, state) => {
      state.storage.sql.exec("DELETE FROM record WHERE table_name = 'habit' AND row_id = ?", lost);
    });
    const day = new Date().toISOString().slice(0, 10);
    const report = await admin("POST", "/v1/admin/restore", { from: me.json.accountId, day, apply: true });
    expect(report.json.tables.habit).toMatchObject({ missing: 1, same: 1 });
    expect(((await stub(me.json.accountId).record("habit", kept)) as any).fields.name).toBe("Read more");
    expect(((await stub(me.json.accountId).record("habit", lost)) as any).fields.name).toBe("Walk");
  });
});

describe("Restore From a Backup for Plus: the account's daily copies (Current Work 76)", () => {
  /** A stored zip's entries (stored only, as BackupFile and snapshotFile.ts write them), with every CRC checked. */
  async function unzip(bytes: Uint8Array): Promise<Record<string, string>> {
    const { crc32 } = await import("../src/snapshotFile");
    const view = new DataView(bytes.buffer, bytes.byteOffset, bytes.byteLength);
    const out: Record<string, string> = {};
    let at = 0;
    while (view.getUint32(at, true) === 0x04034b50) {
      const crc = view.getUint32(at + 14, true);
      const size = view.getUint32(at + 18, true);
      const nameLength = view.getUint16(at + 26, true);
      const name = new TextDecoder().decode(bytes.subarray(at + 30, at + 30 + nameLength));
      const data = bytes.subarray(at + 30 + nameLength, at + 30 + nameLength + size);
      expect(crc32(data)).toBe(crc);
      out[name] = new TextDecoder().decode(data);
      at += 30 + nameLength + size;
    }
    return out;
  }

  it("lists a Plus account's days and hands one back as an ordinary, checked backup file", async () => {
    const me = await testSignIn();
    const habitId = crypto.randomUUID();
    const orphanHabit = crypto.randomUUID();
    await call("POST", "/v1/sync", {
      cursor: 0,
      ops: [habit(habitId, "Read"), entry(crypto.randomUUID(), habitId), entry(crypto.randomUUID(), orphanHabit),
        { id: crypto.randomUUID(), table: "setting", row: "placement_v2", fields: { value: "done" }, hlc: hlc(Date.now()), schema: 6 },
        { id: crypto.randomUUID(), table: "setting", row: "week_start", fields: { value: "2" }, hlc: hlc(Date.now()), schema: 6 }],
    }, me.json.accessToken);
    const takenAt = Date.UTC(2026, 9, 3, 2, 0);
    await stub(me.json.accountId).snapshotNow("default", takenAt);

    const list = await call("GET", "/v1/snapshots", undefined, me.json.accessToken);
    expect(list.status).toBe(200);
    expect(list.json.snapshots).toEqual([{ day: "2026-10-03", takenAt, records: 5 }]);

    const response = await exports.default.fetch("https://api-dev.oftenenough.com/v1/snapshots/2026-10-03", { headers: { authorization: `Bearer ${me.json.accessToken}` } });
    expect(response.status).toBe(200);
    expect(response.headers.get("content-type")).toBe("application/zip");
    const bytes = new Uint8Array(await response.arrayBuffer());
    const digest = [...new Uint8Array(await crypto.subtle.digest("SHA-256", bytes))].map((b) => b.toString(16).padStart(2, "0")).join("");
    expect(response.headers.get("x-backup-sha256")).toBe(digest);
    expect(response.headers.get("x-backup-habits")).toBe("1");
    const files = await unzip(bytes);
    const manifest = JSON.parse(files["manifest.json"]!);
    const data = JSON.parse(files["data.json"]!);
    expect(manifest).toMatchObject({ format: 1, createdAt: takenAt, deviceName: "Your account", counts: { habit: 1, step: 0, reminder: 0, entry: 1, setting: 1 }, live: { habits: 1, entries: 1 } });
    expect(manifest.data.sha256).toBe([...new Uint8Array(await crypto.subtle.digest("SHA-256", new TextEncoder().encode(files["data.json"]!)))].map((b) => b.toString(16).padStart(2, "0")).join(""));
    expect(data.habit[0]).toMatchObject({ id: habitId, name: "Read", deleted_at: null });
    expect(data.entry).toHaveLength(1); // the log whose habit isn't there is left out
    expect(data.setting).toEqual([{ id: "week_start", value: "2" }]); // never this device's own settings

    expect((await call("GET", "/v1/snapshots/2026-10-04", undefined, me.json.accessToken)).status).toBe(404);
    expect((await call("GET", "/v1/snapshots/../x", undefined, me.json.accessToken)).status).toBe(404);
  });

  it("is part of Plus, and nobody sees another account's days", async () => {
    const { freeSignIn } = await import("./helpers");
    const free = await freeSignIn();
    expect((await call("GET", "/v1/snapshots", undefined, free.json.accessToken)).status).toBe(403);
    const owner = await testSignIn();
    await call("POST", "/v1/sync", { cursor: 0, ops: [habit(crypto.randomUUID(), "Private")] }, owner.json.accessToken);
    await stub(owner.json.accountId).snapshotNow("default", Date.UTC(2026, 9, 5, 2, 0));
    const other = await testSignIn();
    expect((await call("GET", "/v1/snapshots", undefined, other.json.accessToken)).json.snapshots).toEqual([]);
    expect((await call("GET", "/v1/snapshots/2026-10-05", undefined, other.json.accessToken)).status).toBe(404);
  });
});

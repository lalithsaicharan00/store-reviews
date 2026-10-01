import { runInDurableObject } from "cloudflare:test";
import { env } from "cloudflare:workers";
import { describe, expect, it } from "vitest";
import { syncMerge } from "../core/Core-sync.mjs";
import type { Account } from "../src/account";
import { call, device, testSignIn } from "./helpers";

/**
 * Sync through the real Worker and Durable Object. Each simulated device keeps its own copy of every record and
 * applies what it pulls with the same shared Kotlin rules the apps use, as a phone would.
 */

interface Op {
  id: string;
  table: string;
  row: string;
  fields: Record<string, string | number | boolean | null>;
  hlc: string;
  schema: number;
}

class Device {
  readonly records = new Map<string, string>(); // "table/row" -> record JSON
  outbox: Op[] = [];
  cursor = 0;
  private counter = 0;
  readonly id = crypto.randomUUID();

  private constructor(
    public accessToken: string,
    readonly name: string,
  ) {}

  static async signIn(subject: string, name: string) {
    const dev = device({ name });
    const result = await testSignIn(subject, dev);
    const d = new Device(result.json.accessToken, name);
    (d as { id: string }).id = dev.id;
    return d;
  }

  /** A local change: applied here at once, and queued to send. `millis` stands in for this device's clock. */
  change(table: string, row: string, fields: Op["fields"], millis: number) {
    const hlc = `${String(millis).padStart(18, "0")}-${String(this.counter++ % 100000).padStart(5, "0")}-${this.name}`;
    const op: Op = { id: crypto.randomUUID(), table, row, fields, hlc, schema: 6 };
    this.apply(op);
    this.outbox.push(op);
    return op;
  }

  apply(op: Op) {
    const key = `${op.table}/${op.row}`;
    this.records.set(key, syncMerge(this.records.get(key) ?? null, JSON.stringify(op)));
  }

  /** One full sync, as the app does it: push the outbox in chunks, pull until there's no more. */
  async sync() {
    do {
      const chunk = this.outbox.slice(0, 500);
      const { status, json } = await call("POST", "/v1/sync", { cursor: this.cursor, ops: chunk }, this.accessToken);
      if (status !== 200) throw new Error(`sync failed: ${status} ${JSON.stringify(json)}`);
      const done = new Set<string>(json.applied);
      this.outbox = this.outbox.filter((op) => !done.has(op.id));
      for (const op of json.ops as Op[]) this.apply(op);
      this.cursor = json.cursor;
      if (!json.more && this.outbox.length === 0) return;
    } while (true);
  }

  fields(table: string, row: string): Record<string, unknown> | undefined {
    const record = this.records.get(`${table}/${row}`);
    return record ? JSON.parse(record).fields : undefined;
  }
}

async function serverRecord(accountId: string, table: string, row: string) {
  const stub = env.ACCOUNT.get(env.ACCOUNT.idFromName(accountId)) as DurableObjectStub<Account>;
  return (await stub.record(table, row)) as { fields: Record<string, unknown> } | null;
}

async function accountOf(d: Device) {
  return (await call("GET", "/v1/account", undefined, d.accessToken)).json.accountId as string;
}

describe("sync", () => {
  it("a habit made on the phone appears on the iPad", async () => {
    const subject = crypto.randomUUID();
    const phone = await Device.signIn(subject, "phone");
    const ipad = await Device.signIn(subject, "ipad");
    phone.change("habit", "h1", { name: "Water", color: "blue", deleted_at: null }, 1000);
    phone.change("entry", "e1", { habit_id: "h1", day: "2026-10-01", value: 1 }, 1001);
    await phone.sync();
    await ipad.sync();
    expect(ipad.fields("habit", "h1")).toEqual({ name: "Water", color: "blue", deleted_at: null });
    expect(ipad.fields("entry", "e1")).toMatchObject({ habit_id: "h1", value: 1 });
  });

  it("edits to different fields on two offline devices are both kept, everywhere", async () => {
    const subject = crypto.randomUUID();
    const phone = await Device.signIn(subject, "phone");
    const ipad = await Device.signIn(subject, "ipad");
    phone.change("habit", "h1", { name: "Water", color: "blue" }, 1000);
    await phone.sync();
    await ipad.sync();
    // Both offline: the phone renames, the iPad recolours.
    phone.change("habit", "h1", { name: "Drink water" }, 2000);
    ipad.change("habit", "h1", { color: "green" }, 2000);
    await phone.sync();
    await ipad.sync();
    await phone.sync();
    const expected = { name: "Drink water", color: "green" };
    expect(phone.fields("habit", "h1")).toEqual(expected);
    expect(ipad.fields("habit", "h1")).toEqual(expected);
    expect((await serverRecord(await accountOf(phone), "habit", "h1"))?.fields).toEqual(expected);
  });

  it("two devices logging a glass at the same second count twice; the same log sent five times counts once", async () => {
    const subject = crypto.randomUUID();
    const phone = await Device.signIn(subject, "phone");
    const watch = await Device.signIn(subject, "watch");
    const a = phone.change("entry", "e-phone", { habit_id: "h1", day: "2026-10-01", value: 1 }, 5000);
    watch.change("entry", "e-watch", { habit_id: "h1", day: "2026-10-01", value: 1 }, 5000);
    for (let i = 0; i < 5; i++) {
      const { status } = await call("POST", "/v1/sync", { cursor: 0, ops: [a] }, phone.accessToken);
      expect(status).toBe(200);
    }
    await watch.sync();
    await phone.sync();
    const entries = [...phone.records.keys()].filter((k) => k.startsWith("entry/"));
    expect(entries.sort()).toEqual(["entry/e-phone", "entry/e-watch"]);
    const stub = env.ACCOUNT.get(env.ACCOUNT.idFromName(await accountOf(phone))) as DurableObjectStub<Account>;
    const logged = await runInDurableObject(stub, (_i: Account, state) =>
      state.storage.sql.exec("SELECT count(*) AS n FROM op_log").one().n,
    );
    expect(logged).toBe(2);
  });

  it("the app killed after the server applied, before the reply: the retry changes nothing", async () => {
    const phone = await Device.signIn(crypto.randomUUID(), "phone");
    phone.change("habit", "h1", { name: "Read" }, 1000);
    // The request reaches the server, but the reply is lost: the outbox still holds the op.
    await call("POST", "/v1/sync", { cursor: 0, ops: phone.outbox }, phone.accessToken);
    expect(phone.outbox).toHaveLength(1);
    const retry = await call("POST", "/v1/sync", { cursor: 0, ops: phone.outbox }, phone.accessToken);
    expect(retry.json.applied).toEqual([phone.outbox[0]!.id]);
    expect((await serverRecord(await accountOf(phone), "habit", "h1"))?.fields).toEqual({ name: "Read" });
  });

  it("a habit deleted on the phone stays deleted when an iPad offline for 400 days edits it", async () => {
    const subject = crypto.randomUUID();
    const phone = await Device.signIn(subject, "phone");
    const ipad = await Device.signIn(subject, "ipad");
    phone.change("habit", "h1", { name: "Run", deleted_at: null }, 1000);
    await phone.sync();
    await ipad.sync();
    phone.change("habit", "h1", { deleted_at: 2000 }, 2000);
    await phone.sync();
    // 400 days later, with a clock that's ahead, the iPad edits and "undeletes" it.
    ipad.change("habit", "h1", { name: "Run daily", deleted_at: null }, 2000 + 400 * 86_400_000);
    await ipad.sync();
    await phone.sync();
    for (const d of [phone, ipad]) expect(d.fields("habit", "h1")?.deleted_at).toBe(2000);
    expect((await serverRecord(await accountOf(phone), "habit", "h1"))?.fields.deleted_at).toBe(2000);
  });

  it("a big outbox goes in chunks, and a new device pulls everything in pages", async () => {
    const subject = crypto.randomUUID();
    const phone = await Device.signIn(subject, "phone");
    for (let i = 0; i < 1234; i++) phone.change("entry", `e${i}`, { habit_id: "h1", day: "2026-10-01", value: 1 }, 1000 + i);
    await phone.sync();
    expect(phone.outbox).toHaveLength(0);

    const tablet = await Device.signIn(subject, "tablet");
    const first = await call("POST", "/v1/sync", { cursor: 0, ops: [] }, tablet.accessToken);
    expect(first.json.ops).toHaveLength(1000);
    expect(first.json.more).toBe(true);
    await tablet.sync();
    expect([...tablet.records.keys()].filter((k) => k.startsWith("entry/"))).toHaveLength(1234);
  });

  it("a device never gets its own ops back, and its cursor moves past them", async () => {
    const phone = await Device.signIn(crypto.randomUUID(), "phone");
    phone.change("habit", "h1", { name: "A" }, 1);
    const reply = await call("POST", "/v1/sync", { cursor: 0, ops: phone.outbox }, phone.accessToken);
    expect(reply.json.ops).toEqual([]);
    expect(reply.json.cursor).toBe(1);
  });

  it("bad ops are reported, and the good ones in the same batch still apply", async () => {
    const phone = await Device.signIn(crypto.randomUUID(), "phone");
    const good = phone.change("habit", "h1", { name: "A" }, 1);
    const bad = [{ ...good, id: "x1", table: "DROP TABLE" }, { ...good, id: "x2", hlc: "yesterday" }, "not an op", { ...good, id: "x3", fields: { id: "x" } }];
    const { status, json } = await call("POST", "/v1/sync", { cursor: 0, ops: [...bad, good] }, phone.accessToken);
    expect(status).toBe(200);
    expect(json.applied).toEqual([good.id]);
    expect(json.rejected.map((r: { id: string | null }) => r.id)).toEqual(["x1", "x2", null, "x3"]);
  });

  it("refuses more than 500 ops at once", async () => {
    const phone = await Device.signIn(crypto.randomUUID(), "phone");
    for (let i = 0; i < 501; i++) phone.change("entry", `e${i}`, { value: 1 }, i);
    const { status } = await call("POST", "/v1/sync", { cursor: 0, ops: phone.outbox }, phone.accessToken);
    expect(status).toBe(413);
  });

  it("a signed-out device can't sync, even with an unexpired access token", async () => {
    const phone = await Device.signIn(crypto.randomUUID(), "phone");
    await call("POST", "/v1/account/signout", {}, phone.accessToken);
    const { status, json } = await call("POST", "/v1/sync", { cursor: 0, ops: [] }, phone.accessToken);
    expect(status).toBe(401);
    expect(json.error).toBe("signed_out");
  });

  it("a deleted account's data is gone and it can't sync", async () => {
    const phone = await Device.signIn(crypto.randomUUID(), "phone");
    phone.change("habit", "h1", { name: "Private" }, 1);
    await phone.sync();
    const accountId = await accountOf(phone);
    await call("POST", "/v1/account/delete", {}, phone.accessToken);
    expect((await call("POST", "/v1/sync", { cursor: 0, ops: [] }, phone.accessToken)).status).toBe(401);
    expect(await serverRecord(accountId, "habit", "h1")).toBeNull();
  });

  /** Three devices edit at random while offline and sync in random orders; all end identical to the server. */
  it("converges: random edits on three devices, synced in any order", async () => {
    let seed = 7;
    const random = () => ((seed = (seed * 1103515245 + 12345) % 2147483648) / 2147483648);
    const subject = crypto.randomUUID();
    const devices = [await Device.signIn(subject, "phone"), await Device.signIn(subject, "ipad"), await Device.signIn(subject, "watch")];
    const rows = ["h1", "h2", "h3"];
    const fieldNames = ["name", "color", "position", "archived_at", "deleted_at"];
    let clock = 1000;
    for (let round = 0; round < 8; round++) {
      for (const d of devices) {
        const edits = Math.floor(random() * 6);
        for (let i = 0; i < edits; i++) {
          const field = fieldNames[Math.floor(random() * fieldNames.length)]!;
          const value = field === "deleted_at" ? (random() < 0.3 ? clock : null) : random() < 0.2 ? null : `${d.name}-${round}-${i}`;
          // Each device's clock is a little off from the others.
          d.change("habit", rows[Math.floor(random() * rows.length)]!, { [field]: value }, clock + Math.floor(random() * 50) - 25);
        }
      }
      clock += 100;
      const order = [...devices].sort(() => random() - 0.5);
      for (const d of order) if (random() < 0.7) await d.sync();
    }
    for (const d of devices) await d.sync();
    for (const d of devices) await d.sync();
    const accountId = await accountOf(devices[0]!);
    for (const row of rows) {
      const server = (await serverRecord(accountId, "habit", row))?.fields;
      for (const d of devices) expect(d.fields("habit", row), `${d.name} ${row}`).toEqual(server);
    }
  });
});

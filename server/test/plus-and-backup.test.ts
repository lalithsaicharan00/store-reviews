import { runInDurableObject } from "cloudflare:test";
import { env, exports } from "cloudflare:workers";
import { CompactSign, importPKCS8 } from "jose";
import { describe, expect, it, vi } from "vitest";
import type { Account } from "../src/account";
import { storeBackup } from "../src/backup";
import { everyonePlus } from "../src/account";
import { verifyAccessToken } from "../src/tokens";
import intermediatePem from "./fixtures/test-intermediate.pem?raw";
import leafKeyPem from "./fixtures/test-leaf.pk8?raw";
import leafPem from "./fixtures/test-leaf.pem?raw";
import rootPem from "./fixtures/test-root.pem?raw";
import { call, device, freeSignIn, testSignIn } from "./helpers";

/**
 * Every account syncs (free on one device, Plus on all: Current Work 78), and the older builds' backup files on R2
 * (Backup, Sync and Accounts — One Seamless Experience; Server Cost and Capacity §4–5) keep working.
 */

const BASE = "https://api-dev.oftenenough.com";
const habitOp = () => ({
  id: crypto.randomUUID(), table: "habit", row: crypto.randomUUID(), fields: { name: "Read", deleted_at: null },
  hlc: `${String(Date.now()).padStart(18, "0")}-00000-phone`, schema: 6,
});
const sync = (token: string, ops: unknown[] = []) => call("POST", "/v1/sync", { cursor: 0, ops }, token);

function stub(accountId: string, jurisdiction: "default" | "eu" = "default") {
  const namespace = jurisdiction === "eu" ? env.ACCOUNT.jurisdiction("eu") : env.ACCOUNT;
  return namespace.get(namespace.idFromName(accountId)) as DurableObjectStub<Account>;
}

async function sha256(bytes: Uint8Array): Promise<string> {
  return [...new Uint8Array(await crypto.subtle.digest("SHA-256", bytes))].map((b) => b.toString(16).padStart(2, "0")).join("");
}

function backupFile(text = `backup ${crypto.randomUUID()}`): Uint8Array {
  return new TextEncoder().encode(text);
}

async function backupHeaders(bytes: Uint8Array, overrides: Record<string, string> = {}, records = 12) {
  return {
    "x-backup-sha256": await sha256(bytes),
    "x-backup-device-name": encodeURIComponent("Lalith’s iPhone"),
    "x-backup-platform": "ios",
    "x-backup-app-version": "1.0",
    "x-backup-format": "1",
    "x-backup-created-at": String(Date.now()),
    "x-backup-habits": "3",
    "x-backup-entries": String(records - 3),
    "x-backup-records": String(records),
    ...overrides,
  };
}

async function upload(token: string, bytes: Uint8Array, overrides: Record<string, string> = {}, records = 12) {
  const response = await exports.default.fetch(`${BASE}/v1/backup`, {
    method: "PUT",
    headers: { authorization: `Bearer ${token}`, "content-type": "application/zip", ...(await backupHeaders(bytes, overrides, records)) },
    body: bytes,
  });
  return { status: response.status, json: (await response.json()) as Record<string, any> };
}

async function download(token: string, deviceId: string, slot: string) {
  const response = await exports.default.fetch(`${BASE}/v1/backup/${deviceId}/${slot}`, { headers: { authorization: `Bearer ${token}` } });
  return { status: response.status, headers: response.headers, bytes: new Uint8Array(await response.arrayBuffer()) };
}

/** Signs like the App Store (test chain, see test/fixtures/README.md). */
async function sign(payload: Record<string, unknown>) {
  const der = (pem: string) => pem.replace(/-----[^-]+-----/g, "").replace(/\s/g, "");
  return new CompactSign(new TextEncoder().encode(JSON.stringify(payload)))
    .setProtectedHeader({ alg: "ES256", x5c: [leafPem, intermediatePem, rootPem].map(der) })
    .sign(await importPKCS8(leafKeyPem, "ES256"));
}

/** A Plus purchase, bought for `accountId`. */
async function plusTransaction(accountId: string) {
  const id = String(2_000_000_000 + Math.floor(Math.random() * 1e9));
  const now = Date.now();
  const payload = {
    transactionId: id, originalTransactionId: id, bundleId: "com.oftenenough.app", productId: "com.oftenenough.app.plus",
    purchaseDate: now, originalPurchaseDate: now, signedDate: now, environment: "Xcode", appAccountToken: accountId,
  };
  return sign(payload);
}

describe("every account syncs: free on one device, Plus on all (Current Work 78)", () => {
  const refresh = (refreshToken: string) => call("POST", "/v1/auth/refresh", { refreshToken });

  it("a free account syncs from its one signed-in device, and the change is stored", async () => {
    const me = await freeSignIn();
    expect(me.json.plus).toBe(false);
    const op = habitOp();
    const { status, json } = await sync(me.json.accessToken, [op]);
    expect(status).toBe(200);
    expect(json.applied).toEqual([op.id]);
    expect(await stub(me.json.accountId).record("habit", op.row)).not.toBeNull();
  });

  it("a second device of a free account is asked first, with the first device's name; nothing changes", async () => {
    const subject = crypto.randomUUID();
    const phone = await freeSignIn(subject, device({ name: "Lalith's iPhone" }));
    const ipad = await freeSignIn(subject, device({ name: "Lalith's iPad", platform: "ipados" }));
    expect(ipad.status).toBe(409);
    expect(ipad.json.error).toBe("other_device_signed_in");
    expect(ipad.json.device).toMatchObject({ name: "Lalith's iPhone", platform: "ios" });
    expect(ipad.json.accessToken).toBeUndefined();
    expect((await sync(phone.json.accessToken, [habitOp()])).status).toBe(200);
    expect((await refresh(phone.json.refreshToken)).status).toBe(200);
  });

  it("Continue signs the first device out: its next sync and refresh say where the account went", async () => {
    const subject = crypto.randomUUID();
    const phone = await freeSignIn(subject, device({ name: "Lalith's iPhone" }));
    const op = habitOp();
    await sync(phone.json.accessToken, [op]);
    const ipad = await freeSignIn(subject, device({ name: "Lalith's iPad", platform: "ipados" }), { replace: true });
    expect(ipad.status).toBe(200);
    const ended = await sync(phone.json.accessToken, [habitOp()]);
    expect(ended.status).toBe(401);
    expect(ended.json).toMatchObject({ error: "session_ended", reason: "signed_in_elsewhere", deviceName: "Lalith's iPad" });
    const refreshed = await refresh(phone.json.refreshToken);
    expect(refreshed.status).toBe(401);
    expect(refreshed.json).toMatchObject({ error: "session_ended", reason: "signed_in_elsewhere", deviceName: "Lalith's iPad" });
    // The iPad's first download brings everything the phone sent (D14).
    const first = await call("POST", "/v1/sync", { cursor: 0, ops: [], full: true }, ipad.json.accessToken);
    expect(first.json.ops.map((o: { id: string }) => o.id)).toContain(op.id);
    const summary = await call("GET", "/v1/account", undefined, ipad.json.accessToken);
    expect(summary.json.devices).toHaveLength(2); // the phone's device row is kept
    expect(summary.json.devices.filter((d: { signedIn: boolean }) => d.signedIn)).toHaveLength(1);
  });

  it("only the device whose session it was learns who took over", async () => {
    const subject = crypto.randomUUID();
    const phone = await freeSignIn(subject, device({ name: "Lalith's iPhone" }));
    await freeSignIn(subject, device({ name: "Lalith's iPad" }), { replace: true });
    const [prefix, secret] = [phone.json.refreshToken.slice(0, phone.json.refreshToken.lastIndexOf(".") + 1), "x".repeat(43)];
    const forged = await refresh(prefix + secret);
    expect(forged.status).toBe(401);
    expect(forged.json.error).toBe("signed_out");
    expect(forged.json.deviceName).toBeUndefined();
  });

  it("signing back in on the first device merges both devices' changes; nothing is lost (D3)", async () => {
    const subject = crypto.randomUUID();
    const phoneDevice = device({ name: "Lalith's iPhone" });
    const phone = await freeSignIn(subject, phoneDevice);
    const ipad = await freeSignIn(subject, device({ name: "Lalith's iPad" }), { replace: true });
    const onIpad = habitOp();
    expect((await sync(ipad.json.accessToken, [onIpad])).status).toBe(200);
    // A change the phone made while signed out (it kept its habits), sent once it signs in again.
    const onPhone = habitOp();
    expect((await sync(phone.json.accessToken, [onPhone])).status).toBe(401);
    const again = await freeSignIn(subject, phoneDevice, { replace: true });
    expect(again.status).toBe(200);
    const merged = await call("POST", "/v1/sync", { cursor: 0, ops: [onPhone], full: true }, again.json.accessToken);
    expect(merged.status).toBe(200);
    expect(merged.json.applied).toEqual([onPhone.id]);
    expect(merged.json.ops.map((o: { id: string }) => o.id)).toContain(onIpad.id);
    expect(await stub(again.json.accountId).record("habit", onIpad.row)).not.toBeNull();
    expect(await stub(again.json.accountId).record("habit", onPhone.row)).not.toBeNull();
    // And now the iPad is the one told.
    expect((await sync(ipad.json.accessToken)).json).toMatchObject({ error: "session_ended", deviceName: "Lalith's iPhone" });
  });

  it("the same device signing in again is never asked", async () => {
    const subject = crypto.randomUUID();
    const phoneDevice = device();
    await freeSignIn(subject, phoneDevice);
    expect((await freeSignIn(subject, phoneDevice)).status).toBe(200);
  });

  it("the website's sign-in (deleting or exporting the account) neither counts nor signs the phone out", async () => {
    const subject = crypto.randomUUID();
    const phone = await freeSignIn(subject);
    const web = await freeSignIn(subject, device({ platform: "web", name: "Website" }));
    expect(web.status).toBe(200);
    expect((await sync(phone.json.accessToken)).status).toBe(200);
  });

  it("Plus is never limited: every device signs in and syncs", async () => {
    const subject = crypto.randomUUID();
    const phone = await testSignIn(subject, device({ name: "iPhone" }));
    const ipad = await testSignIn(subject, device({ name: "iPad", platform: "ipados" }));
    expect(ipad.status).toBe(200);
    expect((await sync(phone.json.accessToken, [habitOp()])).status).toBe(200);
    expect((await sync(ipad.json.accessToken, [habitOp()])).status).toBe(200);
  });

  it("buying Plus hands back a token that syncs at once, and every refresh keeps it", async () => {
    const me = await freeSignIn();
    const bought = await call("POST", "/v1/purchases/verify", { jws: await plusTransaction(me.json.accountId) }, me.json.accessToken);
    expect(bought.json.plus).toBe(true);
    expect((await sync(bought.json.accessToken, [habitOp()])).status).toBe(200);
    const refreshed = await call("POST", "/v1/auth/refresh", { refreshToken: me.json.refreshToken });
    expect(refreshed.json.plus).toBe(true);
    expect((await sync(refreshed.json.accessToken)).status).toBe(200);
  });

  it("after a refund, the most recently synced device keeps syncing; the others are signed out at their next contact", async () => {
    const subject = crypto.randomUUID();
    const phoneDevice = device({ name: "Lalith's iPhone" });
    const me = await freeSignIn(subject, phoneDevice);
    const jws = await plusTransaction(me.json.accountId);
    const bought = await call("POST", "/v1/purchases/verify", { jws }, me.json.accessToken);
    expect(bought.json.plus).toBe(true);
    const ipad = await freeSignIn(subject, device({ name: "Lalith's iPad", platform: "ipados" }));
    expect(ipad.status).toBe(200); // Plus: no question
    // The phone was last seen a day ago; the iPad just now.
    await runInDurableObject(stub(me.json.accountId), (instance: Account, state) => {
      state.storage.sql.exec("UPDATE device SET last_seen = ? WHERE id = ?", Date.now() - 86_400_000, phoneDevice.id);
    });
    const transaction = JSON.parse(atob(jws.split(".")[1]!.replace(/-/g, "+").replace(/_/g, "/")));
    const signedTransactionInfo = await sign({ ...transaction, revocationDate: Date.now(), revocationReason: 0 });
    const signedPayload = await sign({ notificationType: "REFUND", data: { bundleId: "com.oftenenough.app", signedTransactionInfo } });
    expect((await call("POST", "/v1/hooks/apple", { signedPayload })).status).toBe(200);
    const phoneRefresh = await call("POST", "/v1/auth/refresh", { refreshToken: me.json.refreshToken });
    expect(phoneRefresh.status).toBe(401);
    expect(phoneRefresh.json).toMatchObject({ error: "session_ended", reason: "plus_ended", deviceName: "Lalith's iPad" });
    const ipadRefresh = await call("POST", "/v1/auth/refresh", { refreshToken: ipad.json.refreshToken });
    expect(ipadRefresh.json.plus).toBe(false);
    expect((await sync(ipadRefresh.json.accessToken, [habitOp()])).status).toBe(200);
  });

  it("an access token from before the Plus check (no claim) syncs like any account's", async () => {
    const me = await testSignIn();
    const claims = (await verifyAccessToken(me.json.accessToken, "test-token-key-0123456789abcdef0123456789"))!;
    const { issueAccessToken } = await import("../src/tokens");
    const old = await issueAccessToken({ accountId: claims.accountId, deviceId: claims.deviceId, jurisdiction: claims.jurisdiction }, "test-token-key-0123456789abcdef0123456789");
    expect((await sync(old.token)).status).toBe(200);
  });

  it("on dev, a sync says what it cost: rows written, records and the database's size (Free Sync §2.1)", async () => {
    const me = await freeSignIn();
    const { json } = await sync(me.json.accessToken, [habitOp(), habitOp()]);
    expect(json.usage).toMatchObject({ changes: 2, plus: false });
    expect(json.usage.rowsWritten).toBeGreaterThanOrEqual(4);
    expect(json.usage.records).toBe(2);
    expect(json.usage.databaseBytes).toBeGreaterThan(0);
    const day = new Date().toISOString().slice(0, 10);
    await new Promise((r) => setTimeout(r, 50));
    const counted = await env.DIRECTORY.prepare("SELECT n FROM usage_day WHERE day = ? AND metric = 'syncing_free'").bind(day).first<{ n: number }>();
    expect(counted?.n).toBeGreaterThanOrEqual(1);
  });
});

describe("device.last_seen", () => {
  it("is written at most once an hour by sync", async () => {
    const dev = device();
    const me = await testSignIn(undefined, dev);
    const account = stub(me.json.accountId);
    const seen = async () => (await account.summary())!.devices[0]!.lastSeen;
    const signedInAt = await seen();
    await account.sync(dev.id, { cursor: 0, ops: [] }, signedInAt + 10 * 60_000);
    expect(await seen()).toBe(signedInAt);
    await account.sync(dev.id, { cursor: 0, ops: [] }, signedInAt + 61 * 60_000);
    expect(await seen()).toBe(signedInAt + 61 * 60_000);
    await runInDurableObject(account, async (_instance, state) => {
      expect(state.storage.sql.exec("SELECT count(*) AS n FROM device").one().n).toBe(1);
    });
  });
});

describe("rate limits", () => {
  it("sign-in and refresh are limited per IP and answer 429 with Retry-After", async () => {
    const ip = `203.0.113.${Math.floor(Math.random() * 250)}`;
    let last: Response | undefined;
    for (let i = 0; i < 40; i++) {
      last = await exports.default.fetch(`${BASE}/v1/auth/refresh`, {
        method: "POST", headers: { "content-type": "application/json", "cf-connecting-ip": ip }, body: JSON.stringify({ refreshToken: "x" }),
      });
      if (last.status === 429) break;
    }
    expect(last!.status).toBe(429);
    expect(last!.headers.get("retry-after")).toBe("60");
    // Another address is unaffected.
    const other = await exports.default.fetch(`${BASE}/v1/auth/refresh`, {
      method: "POST", headers: { "content-type": "application/json", "cf-connecting-ip": "198.51.100.7" }, body: JSON.stringify({ refreshToken: "x" }),
    });
    expect(other.status).toBe(401);
  });

  it("backup uploads are limited per device: a loop can't run up the bill", async () => {
    const me = await freeSignIn();
    const statuses = [];
    for (let i = 0; i < 3; i++) statuses.push((await upload(me.json.accessToken, backupFile())).status);
    expect(statuses).toEqual([201, 201, 429]);
  });
});

describe("backup on our server (accounts that don't sync)", () => {
  it("a free account uploads its file; it's checked, listed and comes back byte for byte", async () => {
    const dev = device();
    const me = await freeSignIn(undefined, dev);
    const bytes = backupFile();
    const stored = await upload(me.json.accessToken, bytes);
    expect(stored.status).toBe(201);
    expect(stored.json.sha256).toBe(await sha256(bytes));
    expect(stored.json).toMatchObject({ device: dev.id, deviceName: "Lalith’s iPhone", habits: 3, records: 12, size: bytes.length, kept: false });

    const list = await call("GET", "/v1/backup", undefined, me.json.accessToken);
    expect(list.json.copies).toHaveLength(1);
    expect(list.json.copies[0]).toMatchObject({ device: dev.id, slot: stored.json.slot, sha256: stored.json.sha256 });

    const file = await download(me.json.accessToken, dev.id, stored.json.slot);
    expect(file.status).toBe(200);
    expect(file.bytes).toEqual(bytes);
    expect(file.headers.get("x-backup-sha256")).toBe(stored.json.sha256);
  });

  it("refuses a file damaged on the way, and keeps the copy it already had", async () => {
    const dev = device();
    const me = await freeSignIn(undefined, dev);
    const good = backupFile("good");
    const first = await upload(me.json.accessToken, good);
    const bad = await upload(me.json.accessToken, backupFile("bad"), { "x-backup-sha256": await sha256(backupFile("something else")) });
    expect(bad.status).toBe(400);
    expect(bad.json.error).toBe("checksum_mismatch");
    expect((await download(me.json.accessToken, dev.id, first.json.slot)).bytes).toEqual(good);
  });

  it.each([
    ["a missing checksum", { "x-backup-sha256": "" }],
    ["a missing count", { "x-backup-records": "" }],
    ["a negative count", { "x-backup-habits": "-1" }],
    ["a missing device name", { "x-backup-device-name": "" }],
  ])("refuses %s", async (_name, overrides) => {
    const me = await freeSignIn();
    expect((await upload(me.json.accessToken, backupFile(), overrides)).status).toBe(400);
  });

  it("refuses a file over 5 MB before storing anything", async () => {
    const me = await freeSignIn();
    const big = new Uint8Array(5 * 1024 * 1024 + 1);
    expect((await upload(me.json.accessToken, big)).status).toBe(413);
    expect((await call("GET", "/v1/backup", undefined, me.json.accessToken)).json.copies).toHaveLength(0);
  });

  it("keeps one copy per weekday: ten nights leave seven copies, the newest in each slot", async () => {
    const dev = device();
    const me = await freeSignIn(undefined, dev);
    const claims = (await verifyAccessToken(me.json.accessToken, "test-token-key-0123456789abcdef0123456789"))!;
    const day0 = Date.UTC(2026, 9, 1, 2, 0);
    for (let night = 0; night < 10; night++) {
      const bytes = backupFile(`night ${night}`);
      const request = new Request(`${BASE}/v1/backup`, { method: "PUT", headers: await backupHeaders(bytes, { "x-backup-created-at": String(day0 + night * 86_400_000) }), body: bytes });
      expect((await storeBackup(request, env, claims, day0 + night * 86_400_000)).status).toBe(201);
    }
    const copies = (await call("GET", "/v1/backup", undefined, me.json.accessToken)).json.copies as { slot: string; createdAt: number }[];
    expect(copies).toHaveLength(7);
    expect(new Set(copies.map((c) => c.slot)).size).toBe(7);
    expect(copies[0]!.createdAt).toBe(day0 + 9 * 86_400_000); // newest first
    expect(Math.min(...copies.map((c) => c.createdAt))).toBe(day0 + 3 * 86_400_000);
  });

  it("backed up as you go: at most 12 uploads an hour per device, and the next hour takes them again", async () => {
    const dev = device();
    const me = await freeSignIn(undefined, dev);
    const claims = (await verifyAccessToken(me.json.accessToken, "test-token-key-0123456789abcdef0123456789"))!;
    const start = Date.UTC(2026, 9, 1, 9, 0);
    const put = async (at: number) => {
      const bytes = backupFile(`at ${at}`);
      const request = new Request(`${BASE}/v1/backup`, { method: "PUT", headers: await backupHeaders(bytes, { "x-backup-created-at": String(at) }), body: bytes });
      try {
        return (await storeBackup(request, env, claims, at)).status;
      } catch (error) {
        return (error as { status: number }).status;
      }
    };
    // Every 5 minutes for an hour: 12 are taken, the 13th within the hour isn't.
    const statuses: number[] = [];
    for (let i = 0; i < 13; i++) statuses.push(await put(start + i * 4 * 60_000));
    expect(statuses.slice(0, 12).every((s) => s === 201)).toBe(true);
    expect(statuses[12]).toBe(429);
    // An hour after the first, there's room again; another device of the account is never held back.
    expect(await put(start + 61 * 60_000)).toBe(201);
    const other = await freeSignIn(undefined, device({ name: "iPad", platform: "ipados" }));
    expect((await upload(other.json.accessToken, backupFile())).status).toBe(201);
  });

  it("shrink guard: a copy with far fewer records never pushes out the last good one", async () => {
    const dev = device();
    const me = await freeSignIn(undefined, dev);
    const full = backupFile("400 records");
    await upload(me.json.accessToken, full, {}, 400);
    const shrunk = await upload(me.json.accessToken, backupFile("12 records"), {}, 12);
    expect(shrunk.json.keptPrevious).toBe(true);
    const copies = (await call("GET", "/v1/backup", undefined, me.json.accessToken)).json.copies as { slot: string; records: number; kept: boolean }[];
    const kept = copies.find((c) => c.kept)!;
    expect(kept).toMatchObject({ slot: "before-shrink", records: 400, sha256: await sha256(full) });
    expect((await download(me.json.accessToken, dev.id, "before-shrink")).bytes).toEqual(full);
  });

  it("a second device of a free account sees the first device's copy and can copy it once", async () => {
    const subject = crypto.randomUUID();
    const phoneDevice = device({ name: "iPhone" });
    const phone = await freeSignIn(subject, phoneDevice);
    const bytes = backupFile("the phone's habits");
    const stored = await upload(phone.json.accessToken, bytes);
    const ipad = await freeSignIn(subject, device({ name: "iPad", platform: "ipados" }), { replace: true });
    const copies = (await call("GET", "/v1/backup", undefined, ipad.json.accessToken)).json.copies;
    expect(copies[0]).toMatchObject({ device: phoneDevice.id, deviceName: "Lalith’s iPhone" });
    expect((await download(ipad.json.accessToken, phoneDevice.id, stored.json.slot)).bytes).toEqual(bytes);
  });

  it("nobody can read another account's copies", async () => {
    const dev = device();
    const owner = await freeSignIn(undefined, dev);
    const stored = await upload(owner.json.accessToken, backupFile());
    const stranger = await freeSignIn();
    expect((await download(stranger.json.accessToken, dev.id, stored.json.slot)).status).toBe(404);
    expect((await call("GET", "/v1/backup", undefined, stranger.json.accessToken)).json.copies).toHaveLength(0);
    expect((await download(owner.json.accessToken, dev.id, "../etc")).status).toBe(404);
  });

  it("an EU account's copies are kept in the EU bucket", async () => {
    // The local runtime can't place Durable Objects in a jurisdiction (see auth.test.ts); R2 buckets are separate here.
    const asked = vi.spyOn(env.ACCOUNT, "jurisdiction").mockImplementation(() => env.ACCOUNT);
    try {
      const dev = device();
      const me = await freeSignIn(undefined, dev, { country: "DEU" });
      const stored = await upload(me.json.accessToken, backupFile());
      const key = `${me.json.accountId}/${dev.id}/${stored.json.slot}`;
      expect(await env.BACKUPS_EU.head(key)).not.toBeNull();
      expect(await env.BACKUPS.head(key)).toBeNull();
      expect((await call("GET", "/v1/backup", undefined, me.json.accessToken)).json.copies).toHaveLength(1);
    } finally {
      asked.mockRestore();
    }
  });

  it("choosing 'iCloud only' removes every copy from the server", async () => {
    const me = await freeSignIn();
    await upload(me.json.accessToken, backupFile());
    expect((await call("DELETE", "/v1/backup", undefined, me.json.accessToken)).json.deleted).toBe(1);
    expect((await call("GET", "/v1/backup", undefined, me.json.accessToken)).json.copies).toHaveLength(0);
  });

  it("deleting the account deletes its copies, and a still-valid token can't upload afterwards", async () => {
    const me = await freeSignIn();
    await upload(me.json.accessToken, backupFile());
    expect((await call("POST", "/v1/account/delete", {}, me.json.accessToken)).status).toBe(200);
    expect((await env.BACKUPS.list({ prefix: `${me.json.accountId}/` })).objects).toHaveLength(0);
    const late = await upload(me.json.accessToken, backupFile());
    expect(late.status).toBe(401);
    expect((await env.BACKUPS.list({ prefix: `${me.json.accountId}/` })).objects).toHaveLength(0);
  });

  it("Plus accounts may back up too (a second copy beside sync)", async () => {
    const me = await testSignIn();
    expect((await upload(me.json.accessToken, backupFile())).status).toBe(201);
  });
});

// TEMPORARY (the user, 8 Oct 2026; Current Work item 68): every person's dev account is Plus while sync is tested.
describe("Every account is Plus (dev only, temporary)", () => {
  it("is on for dev only while EVERYONE_PLUS is \"true\"", () => {
    expect(everyonePlus({ ENVIRONMENT: "dev", EVERYONE_PLUS: "true" })).toBe(true);
    expect(everyonePlus({ ENVIRONMENT: "dev", EVERYONE_PLUS: "false" })).toBe(false);
    expect(everyonePlus({ ENVIRONMENT: "production", EVERYONE_PLUS: "true" } as never)).toBe(false);
  });
});

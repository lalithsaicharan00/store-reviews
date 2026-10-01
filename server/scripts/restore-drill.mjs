// The restore drill (Architecture 06 §9: "a backup nobody has restored is only a hope"), against dev:
// a Plus test account syncs data, a snapshot is taken, it's restored into a fresh account, and a device on that account
// must pull back exactly the same records. Then both accounts are deleted.
//   TEST_LOGIN_SECRET=… ADMIN_SECRET=… node scripts/restore-drill.mjs
const base = process.env.API_BASE ?? "https://api-dev.oftenenough.com";
const { TEST_LOGIN_SECRET, ADMIN_SECRET } = process.env;
const call = async (method, path, body, token) => {
  const r = await fetch(base + path, { method, headers: { "content-type": "application/json", ...(token ? { authorization: `Bearer ${token}` } : {}) }, body: body ? JSON.stringify(body) : undefined });
  return { status: r.status, json: await r.json().catch(() => ({})) };
};
const check = (name, ok, detail = "") => { console.log(`${ok ? "PASS" : "FAIL"} ${name}${detail ? " — " + detail : ""}`); if (!ok) process.exitCode = 1; };
const dev = () => ({ id: crypto.randomUUID(), platform: "ios", name: "Restore drill", appVersion: "0.0" });
const signIn = (subject) => call("POST", "/v1/auth/test", { secret: TEST_LOGIN_SECRET, subject, create: true, device: dev() });
const hlc = (ms, n) => `${String(ms).padStart(18, "0")}-${String(n).padStart(5, "0")}-drill`;

const original = await signIn(`drill-a-${crypto.randomUUID()}`);
const fresh = await signIn(`drill-b-${crypto.randomUUID()}`);
const now = Date.now();
const ops = [];
for (let h = 0; h < 5; h++) {
  const habit = crypto.randomUUID();
  ops.push({ id: crypto.randomUUID(), table: "habit", row: habit, fields: { name: `Drill habit ${h} ✓`, deleted_at: null }, hlc: hlc(now, ops.length), schema: 6 });
  for (let e = 0; e < 40; e++) ops.push({ id: crypto.randomUUID(), table: "entry", row: crypto.randomUUID(), fields: { habit_id: habit, day: `2026-09-${String(1 + (e % 30)).padStart(2, "0")}`, value: 1, deleted_at: e === 0 ? now : null }, hlc: hlc(now, ops.length), schema: 6 });
}
const pushed = await call("POST", "/v1/sync", { cursor: 0, ops }, original.json.accessToken);
check("original account synced 205 records", pushed.status === 200 && pushed.json.applied.length === 205);
const admin = (method, path, body) => call(method, path, body, ADMIN_SECRET);
const taken = await admin("POST", "/v1/admin/snapshot", { accountId: original.json.accountId });
check("snapshot taken", taken.status === 200 && taken.json.records === 205, JSON.stringify(taken.json));
const day = new Date().toISOString().slice(0, 10);
const dry = await admin("POST", "/v1/admin/restore", { from: original.json.accountId, day, into: fresh.json.accountId });
check("check: all 205 missing in the fresh account, nothing changed", dry.json.applied === false && dry.json.tables.entry.missing === 200 && dry.json.tables.habit.missing === 5);
const applied = await admin("POST", "/v1/admin/restore", { from: original.json.accountId, day, into: fresh.json.accountId, apply: true });
check("restore applied", applied.status === 200 && applied.json.applied === true, `${applied.json.ops} ops`);

const pull = async (token) => {
  const records = new Map();
  let cursor = 0, more = true;
  while (more) {
    const r = await call("POST", "/v1/sync", { cursor, ops: [] }, token);
    for (const op of r.json.ops) records.set(`${op.table}/${op.row}`, { ...(records.get(`${op.table}/${op.row}`) ?? {}), ...op.fields });
    cursor = r.json.cursor; more = r.json.more;
  }
  return records;
};
const restored = await pull(fresh.json.accessToken);
check("a device on the restored account pulls all 205 records", restored.size === 205, String(restored.size));
const sample = [...restored.values()];
check("names, logs and the undone logs came back as they were",
  sample.filter((f) => typeof f.name === "string" && f.name.startsWith("Drill habit")).length === 5 &&
  sample.filter((f) => f.habit_id && f.deleted_at === null).length === 195 &&
  sample.filter((f) => f.habit_id && typeof f.deleted_at === "number").length === 5);
const again = await admin("POST", "/v1/admin/restore", { from: original.json.accountId, day, into: fresh.json.accountId, apply: true });
check("restoring again changes nothing", again.json.ops === 0);

for (const account of [original, fresh]) await call("POST", "/v1/account/delete", {}, account.json.accessToken);
const gone = await admin("GET", `/v1/admin/snapshots?account=${original.json.accountId}`);
check("deleting the account removed it and its snapshots", gone.status === 404);

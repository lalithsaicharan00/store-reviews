// Live checks of api-dev for Current Work 78 (free accounts sync one device at a time) and the server transfer
// (Move to Another Device), with this GitHub Actions run's identity (POST /v1/auth/ci; no secret needed). Also measures
// the cost model's two estimates (Free Sync — One Device at a Time §2.1): SQLite rows written per change and stored
// bytes per record, from the `usage` that dev's sync replies carry.
//
// Run by .github/workflows/server-dev-checks.yml. Locally: ACTIONS_ID_TOKEN_REQUEST_URL/TOKEN must be set (Actions only).

const base = process.env.API_BASE ?? "https://api-dev.oftenenough.com";
const results = [];
const check = (name, ok, detail = "") => {
  results.push({ name, ok, detail });
  console.log(`${ok ? "PASS" : "FAIL"} ${name}${detail ? ` — ${detail}` : ""}`);
  if (!ok) process.exitCode = 1;
};
const call = async (method, path, body, token) => {
  const r = await fetch(base + path, {
    method,
    headers: { "content-type": "application/json", ...(token ? { authorization: `Bearer ${token}` } : {}) },
    body: body === undefined ? undefined : JSON.stringify(body),
  });
  return { status: r.status, json: await r.json().catch(() => ({})) };
};

async function githubToken() {
  const url = `${process.env.ACTIONS_ID_TOKEN_REQUEST_URL}&audience=oftenenough-api-dev`;
  const r = await fetch(url, { headers: { authorization: `bearer ${process.env.ACTIONS_ID_TOKEN_REQUEST_TOKEN}` } });
  if (!r.ok) throw new Error(`no GitHub identity token: ${r.status}`);
  return (await r.json()).value;
}

const device = (name, platform = "ios") => ({ id: crypto.randomUUID(), platform, name, appVersion: "live-check" });
const signIn = async (subject, dev, extra = {}) => call("POST", "/v1/auth/ci", { idToken: await githubToken(), subject, device: dev, create: true, ...extra });

let clock = Date.now();
const hlc = (node) => `${String(clock++).padStart(18, "0")}-00000-${node}`;
const habitFields = (name) => ({
  name, symbol: "drop.fill", color: "blue", kind: "amount", unit: "glasses", increment: 1, part: "anytime", goal: 8,
  period: "day", schedule_days: "1,2,3,4,5,6,7", frequency: null, due_day: null, due_minute: null, at_most: false,
  quit_since: null, position: 1, created_at: Date.now(), updated_at: Date.now(), archived_at: null, deleted_at: null,
  remind: false, alert: null, follow_up_minutes: null, starts_on: "2026-10-01", ends_on: null, reminder_text: null,
});
const entryFields = (habitId, day) => ({
  habit_id: habitId, step_id: null, day, value: 1, created_at: Date.now(), time_zone: "Asia/Kolkata", deleted_at: null, slot: null, source: "app",
});
const op = (table, row, fields, node) => ({ id: crypto.randomUUID(), table, row, fields, hlc: hlc(node), schema: 8 });
const sync = (token, ops = [], cursor = 0, full = false) => call("POST", "/v1/sync", { cursor, ops, full }, token);

// 1. Two devices on one free account.
{
  const subject = `live-free-${crypto.randomUUID()}`;
  const phoneDevice = device("Live check iPhone");
  const phone = await signIn(subject, phoneDevice, { plus: false });
  check("free: first sign-in creates a free account", phone.status === 201 && phone.json.plus === false, `status ${phone.status}`);
  const first = op("habit", crypto.randomUUID(), habitFields("Water"), "phone");
  const pushed = await sync(phone.json.accessToken, [first]);
  check("free: the one device syncs", pushed.status === 200 && pushed.json.applied?.[0] === first.id, `status ${pushed.status}`);

  const asked = await signIn(subject, device("Live check iPad", "ipados"), { plus: false });
  check("free: a second device is asked first, with the first device's name", asked.status === 409 && asked.json.error === "other_device_signed_in" && asked.json.device?.name === "Live check iPhone", JSON.stringify(asked.json));

  const ipadDevice = device("Live check iPad", "ipados");
  const ipad = await signIn(subject, ipadDevice, { plus: false, replace: true });
  check("free: Continue moves the account to the second device", ipad.status === 200, `status ${ipad.status}`);
  const ended = await sync(phone.json.accessToken, []);
  check("free: the first device's next sync says it was signed out, and where to", ended.status === 401 && ended.json.error === "session_ended" && ended.json.reason === "signed_in_elsewhere" && ended.json.deviceName === "Live check iPad", JSON.stringify(ended.json));
  const refreshed = await call("POST", "/v1/auth/refresh", { refreshToken: phone.json.refreshToken });
  check("free: so does its token refresh", refreshed.status === 401 && refreshed.json.error === "session_ended", JSON.stringify(refreshed.json));
  const download = await sync(ipad.json.accessToken, [], 0, true);
  check("free: the second device's first download has the first device's habit (D14)", download.status === 200 && download.json.ops.some((o) => o.id === first.id));

  const onIpad = op("habit", crypto.randomUUID(), habitFields("Read"), "ipad");
  await sync(ipad.json.accessToken, [onIpad], download.json.cursor);
  const offline = op("habit", crypto.randomUUID(), habitFields("Walk"), "phone"); // made on the phone while signed out
  const back = await signIn(subject, phoneDevice, { plus: false, replace: true });
  const merged = await sync(back.json.accessToken, [offline], 0, true);
  const ids = new Set(merged.json.ops?.map((o) => o.id));
  check("free: signing back in on the first device merges both devices' changes (D3)", back.status === 200 && merged.status === 200 && merged.json.applied?.includes(offline.id) && ids.has(onIpad.id) && ids.has(first.id));
  const ipadEnded = await sync(ipad.json.accessToken, []);
  check("free: and now the second device is the one told", ipadEnded.status === 401 && ipadEnded.json.deviceName === "Live check iPhone", JSON.stringify(ipadEnded.json));
  const days = await call("GET", "/v1/snapshots", undefined, back.json.accessToken);
  check("free: the account's daily copies can be listed", days.status === 200 && Array.isArray(days.json.snapshots), `status ${days.status}`);
  await call("POST", "/v1/account/delete", {}, back.json.accessToken);
}

// 2. Plus is never limited.
{
  const subject = `live-plus-${crypto.randomUUID()}`;
  const phone = await signIn(subject, device("Live check iPhone"));
  const ipad = await signIn(subject, device("Live check iPad", "ipados"));
  const a = await sync(phone.json.accessToken, [op("habit", crypto.randomUUID(), habitFields("A"), "phone")]);
  const b = await sync(ipad.json.accessToken, [op("habit", crypto.randomUUID(), habitFields("B"), "ipad")]);
  check("Plus: two devices sign in and both sync", phone.json.plus === true && ipad.status === 200 && a.status === 200 && b.status === 200);
  await call("POST", "/v1/account/delete", {}, phone.json.accessToken);
}

// 3. Measurements: rows written per change, stored bytes per record (a free account used as the app uses it).
const measured = {};
{
  const subject = `live-measure-${crypto.randomUUID()}`;
  const me = await signIn(subject, device("Live check iPhone"), { plus: false });
  const token = me.json.accessToken;
  let cursor = 0;
  // At most 60 syncs a minute per account (SYNC_LIMIT): paced, and a 429 waits and tries again.
  const run = async (ops) => {
    for (;;) {
      await new Promise((r) => setTimeout(r, 1100));
      const r = await sync(token, ops, cursor);
      if (r.status === 429) { await new Promise((w) => setTimeout(w, 15_000)); continue; }
      if (r.status !== 200) throw new Error(`measure sync failed: ${r.status} ${JSON.stringify(r.json)}`);
      cursor = r.json.cursor;
      return r.json.usage;
    }
  };
  const habits = [];
  let habitRows = 0;
  for (let i = 0; i < 5; i++) {
    const row = crypto.randomUUID();
    habits.push(row);
    habitRows += (await run([op("habit", row, habitFields(`Habit ${i}`), "phone")])).rowsWritten;
  }
  const empty = await run([]);
  const before = { records: empty.records, bytes: empty.databaseBytes };
  let entryRows = 0;
  const entries = [];
  const N = 100;
  for (let i = 0; i < N; i++) {
    const row = crypto.randomUUID();
    entries.push(row);
    const day = new Date(Date.UTC(2026, 6, 1) + i * 86_400_000).toISOString().slice(0, 10);
    entryRows += (await run([op("entry", row, entryFields(habits[i % 5], day), "phone")])).rowsWritten;
  }
  const after = await run([]);
  let updateRows = 0;
  for (let i = 0; i < 20; i++) updateRows += (await run([op("entry", entries[i], { value: 2 }, "phone")])).rowsWritten;
  measured.rowsPerNewHabit = habitRows / 5;
  measured.rowsPerNewLog = entryRows / N;
  measured.rowsPerEdit = updateRows / 20;
  measured.bytesPerRecordMarginal = (after.databaseBytes - before.bytes) / (after.records - before.records);
  measured.bytesPerRecordOverall = after.databaseBytes / after.records;
  measured.records = after.records;
  measured.databaseBytes = after.databaseBytes;
  check("measure: rows written and sizes are reported", Number.isFinite(measured.rowsPerNewLog) && measured.records === 5 + N, JSON.stringify(measured));
  await call("POST", "/v1/account/delete", {}, token);
}

// 4. Move to Another Device through the server (anonymous; the content is opaque bytes here).
{
  const id = [...crypto.getRandomValues(new Uint8Array(32))].map((b) => b.toString(16).padStart(2, "0")).join("");
  const bytes = crypto.getRandomValues(new Uint8Array(75_000)); // about a realistic backup file
  const put = await fetch(`${base}/v1/transfer/${id}`, { method: "PUT", body: bytes });
  const waiting = await (await fetch(`${base}/v1/transfer/${id}/status`)).json();
  const got = new Uint8Array(await (await fetch(`${base}/v1/transfer/${id}`)).arrayBuffer());
  const same = got.length === bytes.length && got.every((b, i) => b === bytes[i]);
  await fetch(`${base}/v1/transfer/${id}/received`, { method: "POST" });
  const received = await (await fetch(`${base}/v1/transfer/${id}/status`)).json();
  const gone = await fetch(`${base}/v1/transfer/${id}`);
  check("transfer: up, down byte for byte, then gone", put.status === 201 && waiting.state === "waiting" && same && received.state === "received" && gone.status === 404);
}

const summary = [
  "## Server dev checks (Current Work 78, transfer)",
  "",
  ...results.map((r) => `- ${r.ok ? "✅" : "❌"} ${r.name}`),
  "",
  "### Measured on dev",
  "",
  `- Rows written per change: new habit ${measured.rowsPerNewHabit?.toFixed(1)}, new log ${measured.rowsPerNewLog?.toFixed(1)}, edit ${measured.rowsPerEdit?.toFixed(1)}`,
  `- Stored bytes per record: ${Math.round(measured.bytesPerRecordMarginal)} for each new log; ${Math.round(measured.bytesPerRecordOverall)} overall (${measured.records} records, ${measured.databaseBytes} bytes, op log and indexes included)`,
].join("\n");
console.log(`\n${summary}`);
if (process.env.GITHUB_STEP_SUMMARY) (await import("node:fs")).appendFileSync(process.env.GITHUB_STEP_SUMMARY, `${summary}\n`);

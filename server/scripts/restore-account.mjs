// Support: restore one account from a nightly snapshot (Architecture 06 §9). Never overwrites newer edits: only what's
// missing or older in the account comes back, as ops that phones receive through ordinary sync.
//
//   ADMIN_SECRET=… node scripts/restore-account.mjs list    <account>
//   ADMIN_SECRET=… node scripts/restore-account.mjs check   <account> <YYYY-MM-DD> [into-account]
//   ADMIN_SECRET=… node scripts/restore-account.mjs restore <account> <YYYY-MM-DD> [into-account]
//   ADMIN_SECRET=… node scripts/restore-account.mjs snapshot <account>
//
// API_BASE defaults to production (https://api.oftenenough.com); set it to https://api-dev.oftenenough.com for dev.
// Always run `check` first and read the counts.
const base = process.env.API_BASE ?? "https://api.oftenenough.com";
const secret = process.env.ADMIN_SECRET;
if (!secret) { console.error("Set ADMIN_SECRET (the environment's own; `wrangler secret put ADMIN_SECRET [--env production]`)."); process.exit(2); }
const [command, account, day, into] = process.argv.slice(2);
const call = async (method, path, body) => {
  const r = await fetch(base + path, { method, headers: { authorization: `Bearer ${secret}`, "content-type": "application/json" }, body: body ? JSON.stringify(body) : undefined });
  const json = await r.json().catch(() => ({}));
  if (!r.ok) { console.error(`${r.status} ${json.error ?? ""} ${json.message ?? ""}`); process.exit(1); }
  return json;
};
if (command === "list") console.log(JSON.stringify(await call("GET", `/v1/admin/snapshots?account=${account}`), null, 2));
else if (command === "snapshot") console.log(JSON.stringify(await call("POST", "/v1/admin/snapshot", { accountId: account }), null, 2));
else if (command === "check" || command === "restore") {
  const report = await call("POST", "/v1/admin/restore", { from: account, day, into: into ?? account, apply: command === "restore" });
  console.log(`Snapshot ${report.snapshot.day}: ${report.snapshot.records} records (taken ${new Date(report.snapshot.takenAt).toISOString()})`);
  for (const [table, t] of Object.entries(report.tables)) console.log(`  ${table.padEnd(9)} in snapshot ${t.inSnapshot}, missing ${t.missing}, older ${t.older}, same ${t.same}`);
  console.log(report.applied ? `Applied: ${report.ops} ops written; phones receive them on their next sync.` : "Nothing changed (check). Run `restore` to apply.");
} else { console.error("Commands: list, snapshot, check, restore"); process.exit(2); }

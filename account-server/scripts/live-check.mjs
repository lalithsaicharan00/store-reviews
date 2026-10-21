// Checks a deployed move-relay Worker from outside, as the app talks to it (Rulebook T6).
//
//   node scripts/live-check.mjs https://api-dev.oftenenough.com
//
// Prints one line per check, "ok …" or "FAIL …", and exits 1 if any failed.
const base = process.argv[2];
if (!base) throw new Error("Usage: node scripts/live-check.mjs <base url>");
let failed = 0;
const say = (ok, what, detail = "") => {
  if (!ok) failed++;
  console.log(`${ok ? "ok  " : "FAIL"} ${what}${detail ? ` (${detail})` : ""}`);
};

async function call(method, path) {
  const response = await fetch(base + path, { method, headers: { "content-type": "application/json" } });
  const text = await response.text();
  let json = null;
  try { json = text ? JSON.parse(text) : null; } catch { /* not JSON */ }
  return { status: response.status, body: json, headers: response.headers };
}

const health = await call("GET", "/v1/health");
say(health.status === 200 && health.body?.ok === true, "health", JSON.stringify(health.body));
say(health.headers.get("cache-control") === "no-store", "answers aren't cached");
// The accounts are gone (21 Oct 2026): their routes answer 404. Reported, not counted: during a gradual release the
// previous version still answers some requests (scripts/release-production.mjs).
for (const [method, path] of [["GET", "/v1/account"], ["POST", "/v1/sign-in"], ["POST", "/v1/google/notifications"]]) {
  console.log(`info ${method} ${path}: ${(await call(method, path)).status} (404 once the release is whole)`);
}
// Moving to a new phone: a code is made (nothing more: the relay itself is covered by test/move.test.ts).
const code = await call("POST", "/v1/move/codes");
say(code.status === 200 && typeof code.body?.channel === "string" && typeof code.body?.token === "string", "a move code is made", String(code.status));
say((await call("GET", "/v1/move/receive?channel=00")).status !== 500, "the relay answers without an error");

console.log(failed ? `${failed} failed` : "all passed");
process.exit(failed ? 1 : 0);

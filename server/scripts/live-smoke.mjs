// Live check of api-dev: sign in (test provider), account, refresh (incl. retry), EU account, sign out, delete.
import { readFileSync } from "node:fs";
const base = process.env.API_BASE ?? "https://api-dev.oftenenough.com";
const TEST_LOGIN_SECRET = process.env.TEST_LOGIN_SECRET ?? JSON.parse(readFileSync(process.argv[2], "utf8")).TEST_LOGIN_SECRET;
const call = async (method, path, body, token) => {
  const r = await fetch(base + path, { method, headers: { "content-type": "application/json", ...(token ? { authorization: `Bearer ${token}` } : {}) }, body: body ? JSON.stringify(body) : undefined });
  return { status: r.status, json: await r.json().catch(() => ({})) };
};
const dev = () => ({ id: crypto.randomUUID(), platform: "ios", name: "Smoke test", appVersion: "0.0" });
const check = (name, ok, detail = "") => { console.log(`${ok ? "PASS" : "FAIL"} ${name}${detail ? " — " + detail : ""}`); if (!ok) process.exitCode = 1; };

const status = await call("GET", "/v1/status");
check("status", status.status === 200 && status.json.ok, JSON.stringify(status.json));
for (const country of ["USA", "DEU"]) {
  const subject = `smoke-${country}-${crypto.randomUUID()}`;
  const unknown = await call("POST", "/v1/auth/test", { secret: TEST_LOGIN_SECRET, subject, device: dev() });
  check(`${country}: unknown key is not created silently`, unknown.status === 404, unknown.json.error);
  const t0 = Date.now();
  const s = await call("POST", "/v1/auth/test", { secret: TEST_LOGIN_SECRET, subject, create: true, device: dev(), country });
  check(`${country}: create account`, s.status === 201, `${Date.now() - t0} ms, token ${s.json.refreshToken?.slice(0, 6)}…`);
  const a = await call("GET", "/v1/account", undefined, s.json.accessToken);
  check(`${country}: read account`, a.status === 200 && a.json.accountId === s.json.accountId);
  const r1 = await call("POST", "/v1/auth/refresh", { refreshToken: s.json.refreshToken });
  const retry = await call("POST", "/v1/auth/refresh", { refreshToken: s.json.refreshToken });
  check(`${country}: refresh, and a retried refresh`, r1.status === 200 && retry.status === 200);
  const out = await call("POST", "/v1/account/signout", {}, retry.json.accessToken);
  const afterOut = await call("POST", "/v1/auth/refresh", { refreshToken: retry.json.refreshToken });
  check(`${country}: sign out ends the session`, out.status === 200 && afterOut.status === 401);
  const del = await call("POST", "/v1/account/delete", {}, retry.json.accessToken);
  const gone = await call("POST", "/v1/auth/test", { secret: TEST_LOGIN_SECRET, subject, device: dev() });
  check(`${country}: delete`, del.status === 200 && gone.status === 404);
}
const wrong = await call("POST", "/v1/auth/test", { secret: "nope", subject: "x", create: true, device: dev() });
check("test sign-in refuses a wrong secret", wrong.status === 401);
const apple = await call("POST", "/v1/auth/apple", { idToken: "not.a.token", nonce: "n", device: dev() });
check("Apple sign-in refuses a fake token", apple.status === 401, apple.json.error);

// Sync: two devices on one account, through the live server.
{
  const subject = `smoke-sync-${crypto.randomUUID()}`;
  const phone = await call("POST", "/v1/auth/test", { secret: TEST_LOGIN_SECRET, subject, create: true, device: dev() });
  const ipad = await call("POST", "/v1/auth/test", { secret: TEST_LOGIN_SECRET, subject, device: dev() });
  const hlc = (ms, node) => `${String(ms).padStart(18, "0")}-00000-${node}`;
  const op = { id: crypto.randomUUID(), table: "habit", row: crypto.randomUUID(), fields: { name: "Live sync ☕", deleted_at: null }, hlc: hlc(Date.now(), "phone"), schema: 6 };
  const push = await call("POST", "/v1/sync", { cursor: 0, ops: [op] }, phone.json.accessToken);
  const retry = await call("POST", "/v1/sync", { cursor: 0, ops: [op] }, phone.json.accessToken);
  check("sync: push, and the same push again", push.status === 200 && push.json.applied[0] === op.id && retry.json.applied[0] === op.id);
  const pull = await call("POST", "/v1/sync", { cursor: 0, ops: [] }, ipad.json.accessToken);
  check("sync: the other device receives it exactly once", pull.status === 200 && pull.json.ops.length === 1 && pull.json.ops[0].fields.name === "Live sync ☕");
  await call("POST", "/v1/account/delete", {}, phone.json.accessToken);
}

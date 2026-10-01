// Live check of production (api.oftenenough.com) without any secret: it's up, and nothing meant for testing works there.
// Real sign-ins need a real Apple or Google account, so they're tried by hand on a phone (Status note).
const base = process.env.API_BASE ?? "https://api.oftenenough.com";
const call = async (method, path, body, headers = {}) => {
  const r = await fetch(base + path, { method, headers: { "content-type": "application/json", ...headers }, body: body ? JSON.stringify(body) : undefined });
  return { status: r.status, json: await r.json().catch(() => ({})) };
};
const dev = () => ({ id: crypto.randomUUID(), platform: "ios", name: "Production check", appVersion: "0.0" });
const check = (name, ok, detail = "") => { console.log(`${ok ? "PASS" : "FAIL"} ${name}${detail ? " — " + detail : ""}`); if (!ok) process.exitCode = 1; };

const status = await call("GET", "/v1/status");
check("status says production", status.status === 200 && status.json.environment === "production", JSON.stringify(status.json));
const test = await call("POST", "/v1/auth/test", { secret: "anything", subject: "x", create: true, device: dev() });
check("no test sign-in", test.status === 404, test.json.error);
const ci = await call("POST", "/v1/auth/ci", { idToken: "a.b.c", subject: "x", device: dev() });
check("no CI sign-in", ci.status === 404, ci.json.error);
const apple = await call("POST", "/v1/auth/apple", { idToken: "not.a.token", nonce: "n", device: dev() });
check("Apple sign-in refuses a fake token", apple.status === 401, apple.json.error);
const google = await call("POST", "/v1/auth/google", { idToken: "not.a.token", nonce: "n", device: dev() });
check("Google sign-in refuses a fake token", google.status === 401, google.json.error);
const sync = await call("POST", "/v1/sync", { cursor: 0, ops: [] });
check("sync needs a sign-in", sync.status === 401, sync.json.error);
const backup = await call("GET", "/v1/backup");
check("backups need a sign-in", backup.status === 401, backup.json.error);
const forged = await call("GET", "/v1/backup", undefined, { authorization: "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ4In0.x" });
check("a forged token is refused", forged.status === 401, forged.json.error);
const support = await call("GET", "/v1/admin/snapshots?account=x", undefined, { authorization: "Bearer guess" });
check("support routes are closed", support.status === 404, support.json.error);

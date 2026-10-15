// Checks a deployed account Worker from outside, as the app talks to it.
//
//   node scripts/live-check.mjs https://api-dev.oftenenough.com          the basics (any environment, no secret)
//   ACCOUNT_TEST_SECRET=... node scripts/live-check.mjs <dev url>        also a whole family, end to end (dev only)
//
// Prints one line per check, "ok …" or "FAIL …", and exits 1 if any failed. The end-to-end part makes test accounts
// (subjects "live-…") and deletes every one it made, whatever happens.
const base = process.argv[2];
if (!base) throw new Error("Usage: node scripts/live-check.mjs <base url>");
const secret = process.env.ACCOUNT_TEST_SECRET ?? "";
let failed = 0;
const say = (ok, what, detail = "") => {
  if (!ok) failed++;
  console.log(`${ok ? "ok  " : "FAIL"} ${what}${detail ? ` (${detail})` : ""}`);
};

async function call(method, path, { session, body } = {}) {
  const headers = { "content-type": "application/json" };
  if (session) headers.authorization = `Bearer ${session}`;
  const response = await fetch(base + path, { method, headers, body: body === undefined ? undefined : JSON.stringify(body) });
  const text = await response.text();
  let json = null;
  try { json = text ? JSON.parse(text) : null; } catch { /* not JSON */ }
  return { status: response.status, body: json, headers: response.headers };
}

// ---------------------------------------------------------------- The basics
const health = await call("GET", "/v1/health");
say(health.status === 200 && health.body?.ok === true, "health", JSON.stringify(health.body));
say(health.headers.get("cache-control") === "no-store", "answers aren't cached");
say((await call("GET", "/v1/account")).status === 401, "the account needs a session");
say((await call("GET", "/v1/account", { session: "x".repeat(43) })).status === 401, "a made-up session is refused");
say((await call("GET", "/v1/invites/AAAAAAAAAAAAAAAAAAAAAA")).status === 404, "an unknown invite doesn't work");
const forged = await call("POST", "/v1/sign-in", { body: { provider: "google", idToken: "eyJhbGciOiJSUzI1NiJ9.e30.x", nonce: "n" } });
say(forged.status === 401 && forged.body?.error === "invalid_token", "a forged Google token is refused", String(forged.status));
const apple = await call("POST", "/v1/sign-in", { body: { provider: "apple", idToken: "eyJhbGciOiJSUzI1NiJ9.e30.x", nonce: "n" } });
say(apple.status === 401, "a forged Apple token is refused", String(apple.status));
const test = await call("POST", "/v1/sign-in", { body: { provider: "test", secret: "guess", subject: "x" } });
say(test.status === 400, "the test sign-in refuses a wrong secret", String(test.status));

// ---------------------------------------------------------------- A whole family (dev, with the test secret)
if (secret && health.body?.environment === "dev") {
  const run = `live-${Date.now()}`;
  const made = [];
  const account = async (name, purchase) => {
    const r = await call("POST", "/v1/accounts", { body: { provider: "test", secret, subject: `${run}-${name}`, name, purchase } });
    if (r.status !== 200) throw new Error(`create ${name}: ${r.status} ${JSON.stringify(r.body)}`);
    made.push({ name, session: r.body.session });
    return r.body;
  };
  try {
    const lee = await account("Lee", { product: "com.oftenenough.app.plusfamily", token: `stand-in-${run}-lee` });
    say(lee.account.plus === "FAMILY_OWNER", "a Plus Family owner", lee.account.plus);
    const invited = await call("POST", "/v1/family/invite", { session: lee.session });
    const invite = invited.body?.account?.family?.invite;
    say(!!invite && invite.link === `https://oftenenough.com/join/${invite.token}`, "an invite link", invite?.link);
    const endsIn = invite ? invite.endsDay - Math.floor(Date.now() / 86_400_000) : -1;
    say(endsIn === 7, "it ends in 7 days", String(endsIn));
    say((await call("GET", `/v1/invites/${invite.token}`)).body?.state === "open", "it reads open");
    const priya = await account("Priya");
    const joined = await call("POST", `/v1/invites/${invite.token}/join`, { session: priya.session });
    say(joined.body?.account?.plus === "FAMILY_MEMBER" && joined.body.account.family.owner === "Lee", "Priya joins Lee's family");
    say((await call("GET", `/v1/invites/${invite.token}`)).body?.state === "used", "the invite is used once");
    const ana = await account("Ana");
    const second = await call("POST", `/v1/invites/${invite.token}/join`, { session: ana.session });
    say(second.body?.account?.plus === "NONE", "a used invite gives nothing");
    const leeNow = await call("GET", "/v1/account", { session: lee.session });
    say(leeNow.body?.account?.family?.people?.length === 2, "Lee sees Priya", String(leeNow.body?.account?.family?.people?.length));
    const again = await call("POST", "/v1/family/invite", { session: lee.session });
    const token2 = again.body?.account?.family?.invite?.token;
    await call("POST", "/v1/family/invite/cancel", { session: lee.session });
    say((await call("GET", `/v1/invites/${token2}`)).body?.state === "cancelled", "a cancelled invite reads cancelled");
    const priyaId = joined.body.account.id;
    const removed = await call("POST", "/v1/family/remove", { session: lee.session, body: { person: priyaId } });
    say(removed.body?.account?.family?.people?.length === 1, "Lee removes Priya");
    say((await call("GET", "/v1/account", { session: priya.session })).body?.account?.plus === "NONE", "Priya's Plus from the family stops");
    const out = await call("POST", "/v1/sign-out", { session: ana.session });
    say(out.status === 204 && (await call("GET", "/v1/account", { session: ana.session })).status === 401, "signing out ends the session");
    made.find((m) => m.name === "Ana").session = (await call("POST", "/v1/sign-in", { body: { provider: "test", secret, subject: `${run}-Ana` } })).body.session;
  } catch (error) {
    say(false, "end to end", error.message);
  } finally {
    for (const m of made) {
      const r = await call("POST", "/v1/account/delete", { session: m.session, body: { provider: "test", secret, subject: `${run}-${m.name}` } });
      say(r.body?.deleted === true, `test account ${m.name} deleted`);
    }
  }
} else if (health.body?.environment === "dev") {
  console.log("(set ACCOUNT_TEST_SECRET to run a whole family end to end)");
}

console.log(failed ? `${failed} failed` : "all passed");
process.exit(failed ? 1 : 0);

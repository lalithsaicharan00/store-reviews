// Browser check of the website (Chromium through Playwright), against a deployed copy and the dev API:
//   TEST_LOGIN_SECRET=… node tests/site-check.mjs [https://site-dev.oftenenough.com]
// - every page loads with no errors and no security-policy violations, fits a phone, and works in dark mode;
// - the delete page, end to end: Google's script is replaced by a stand-in (a real Google sign-in needs a person), its
//   answer becomes a real dev account (the test sign-in), and the page's own calls go to the dev API through its real
//   cross-origin rules. The account must then be deleted (or, after Cancel, signed out).
import { createRequire } from "node:module";
const require = createRequire(import.meta.url);
const { chromium } = require(process.env.PLAYWRIGHT_PATH ?? "playwright");

const site = process.argv[2] ?? "https://site-dev.oftenenough.com";
const api = "https://api-dev.oftenenough.com";
const secret = process.env.TEST_LOGIN_SECRET;
const check = (name, ok, detail = "") => { console.log(`${ok ? "PASS" : "FAIL"} ${name}${detail ? " — " + detail : ""}`); if (!ok) process.exitCode = 1; };
const fakeJwt = "e30." + Buffer.from(JSON.stringify({ email: "drill@example.com" })).toString("base64url") + ".sig";
const sha256 = async (t) => [...new Uint8Array(await crypto.subtle.digest("SHA-256", new TextEncoder().encode(t)))].map((b) => b.toString(16).padStart(2, "0")).join("");

// Behind a TLS-inspecting proxy (a cloud dev container), pass its CA's public-key hash, so only that one key is trusted.
const trust = process.env.CHROMIUM_TRUST_SPKI;
const browser = await chromium.launch({ args: trust ? [`--ignore-certificate-errors-spki-list=${trust}`] : [] });

const googleOrigin = new Set();
let beacon = false;
for (const scheme of ["light", "dark"]) {
  const context = await browser.newContext({ viewport: { width: 375, height: 740 }, colorScheme: scheme });
  for (const path of ["/", "/privacy", "/terms", "/support", "/delete-account", "/missing"]) {
    const page = await context.newPage();
    const problems = [];
    page.on("console", (m) => {
      if (m.type() !== "error") return;
      const text = m.text();
      // Google's own sign-in, before the site's address is an authorized origin of the web client (README, setup).
      if (text.includes("GSI_LOGGER") || (text.includes("403") && path === "/delete-account")) { googleOrigin.add(text.includes("origin is not allowed") ? "not allowed" : "other"); return; }
      if (path === "/missing" && text.includes("404")) return; // the 404 page's own status
      // Cloudflare Web Analytics, injected by a zone setting; the site's security policy blocks it (README, setup).
      if (text.includes("static.cloudflareinsights.com")) { beacon = true; return; }
      problems.push(text);
    });
    page.on("pageerror", (e) => problems.push(String(e)));
    const response = await page.goto(site + path, { waitUntil: "networkidle" });
    const fits = await page.evaluate(() => document.documentElement.scrollWidth <= window.innerWidth);
    const bg = await page.evaluate(() => getComputedStyle(document.body).backgroundColor);
    const ok = (path === "/missing" ? response.status() === 404 : response.status() === 200) && problems.length === 0 && fits;
    check(`${scheme} ${path}: loads, no errors, fits a phone`, ok, `${response.status()} ${problems.join(" | ")} bg ${bg}`);
    if (scheme === "dark" && path === "/") check("dark mode has a dark background", bg === "rgb(20, 20, 19)", bg);
    await page.close();
  }
  await context.close();
}

if (beacon) console.log("SETUP Cloudflare Web Analytics is injected into the pages (and blocked by their security policy): turn its automatic setup off for the zone");
if (googleOrigin.has("not allowed")) console.log(`SETUP Google sign-in: add ${site} as an authorized JavaScript origin of the web OAuth client`);

/** Opens the delete page with the stand-in for Google; `answer` decides what the page's Google sign-in returns. */
async function deletePage(answer) {
  const context = await browser.newContext({ viewport: { width: 390, height: 844 } });
  const page = await context.newPage();
  await page.route("https://accounts.google.com/gsi/client", (route) => route.fulfill({
    contentType: "text/javascript",
    body: `window.google = { accounts: { id: {
      initialize(c) { window.__gis = c; },
      renderButton(el) { const b = document.createElement("button"); b.id = "fake-google"; b.textContent = "Sign in with Google";
        b.onclick = () => window.__gis.callback({ credential: ${JSON.stringify(fakeJwt)} }); el.appendChild(b); } } } };`,
  }));
  const seen = {};
  await page.route(`${api}/v1/auth/google`, async (route) => {
    const request = route.request();
    if (request.method() === "OPTIONS") return route.continue();
    const body = JSON.parse(request.postData());
    seen.body = body;
    const reply = await answer(body);
    seen.reply = reply.json;
    return route.fulfill({ status: reply.status, contentType: "application/json", headers: { "access-control-allow-origin": site }, body: JSON.stringify(reply.json) });
  });
  await page.goto(site + "/delete-account", { waitUntil: "networkidle" });
  return { page, context, seen };
}

const realAccount = async (body) => {
  const r = await fetch(`${api}/v1/auth/test`, { method: "POST", headers: { "content-type": "application/json" },
    body: JSON.stringify({ secret, subject: `site-${crypto.randomUUID()}`, create: true, plus: false, device: body.device }) });
  return { status: r.status === 201 ? 200 : r.status, json: await r.json() };
};
const refresh = async (token) => {
  const r = await fetch(`${api}/v1/auth/refresh`, { method: "POST", headers: { "content-type": "application/json" }, body: JSON.stringify({ refreshToken: token }) });
  return { status: r.status, json: await r.json() };
};

{ // Delete, end to end.
  const { page, context, seen } = await deletePage(realAccount);
  await page.click("#fake-google");
  await page.waitForSelector("#step-confirm:not([hidden])");
  const nonceOk = (await sha256(seen.body.nonce)) === (await page.evaluate(() => window.__gis.nonce));
  check("Google is given SHA-256 of the nonce the server gets", nonceOk);
  check("the page says which account it found", (await page.textContent("#who")) === "drill@example.com");
  check("Delete stays off until the box is ticked", await page.isDisabled("#delete"));
  await page.check("#understand");
  await page.click("#delete");
  await page.waitForSelector("#step-done:not([hidden])", { timeout: 15000 });
  check("the page says it's deleted, with a date", /\d/.test(await page.textContent("#gone-by")));
  const after = await refresh(seen.reply.refreshToken);
  check("the account is really deleted on the server (through the real cross-origin call)", after.status === 401 && after.json.error === "account_deleted", after.json.error);
  await context.close();
}

{ // Cancel leaves no session behind.
  const { page, context, seen } = await deletePage(realAccount);
  await page.click("#fake-google");
  await page.waitForSelector("#step-confirm:not([hidden])");
  await page.click("#cancel");
  await page.waitForSelector("#step-sign-in:not([hidden])");
  await page.waitForTimeout(1500);
  const after = await refresh(seen.reply.refreshToken);
  check("Cancel signs the website out again, and the account stays", after.status === 401 && after.json.error === "signed_out", after.json.error);
  await context.close();
}

{ // No account for that Google account.
  const { page, context } = await deletePage(async () => ({ status: 404, json: { error: "unknown_key" } }));
  await page.click("#fake-google");
  await page.waitForSelector("#error:not([hidden])");
  check("no account: it says so and changes nothing", (await page.textContent("#error")).includes("There's no Often Enough account"));
  await context.close();
}

await browser.close();

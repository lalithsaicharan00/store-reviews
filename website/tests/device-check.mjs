// The homepage on each device, through a local copy of the site (`wrangler pages dev website/public`):
//   PLAYWRIGHT_PATH=<playwright-core> node website/tests/device-check.mjs http://localhost:8788
// One store's button on a known device, both with no script or an unknown one, both always in the HTML. The quit
// card's count runs and agrees with its date, and stays still for someone who asked for less motion.
import { createRequire } from "node:module";
const require = createRequire(import.meta.url);
const { chromium } = require(process.env.PLAYWRIGHT_PATH ?? "playwright-core");

const site = process.argv[2];
const devices = [
  ["Android phone", "Mozilla/5.0 (Linux; Android 15; Pixel 9) AppleWebKit/537.36 Chrome/130 Mobile Safari/537.36", 0, ["play"]],
  ["Windows", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/130 Safari/537.36", 0, ["play"]],
  ["iPhone", "Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 Version/18.0 Mobile/15E148 Safari/604.1", 5, ["app"]],
  ["iPad", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 Version/18.0 Safari/605.1.15", 5, ["app"]],
  ["Mac", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 Version/18.0 Safari/605.1.15", 0, ["app"]],
  ["Linux", "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 Chrome/130 Safari/537.36", 0, ["play", "app"]],
];
const browser = await chromium.launch({ channel: "chrome" });
let failed = 0;
const check = (ok, what) => { if (!ok) { failed++; console.log(`FAIL ${what}`); } };
const shown = (page) => page.evaluate(() => [...document.querySelectorAll(".hero [data-store]")].filter((e) => e.getBoundingClientRect().width > 0).map((e) => e.dataset.store));

for (const [name, userAgent, touch, want] of devices) {
  const context = await browser.newContext({ userAgent, hasTouch: touch > 0 });
  const page = await context.newPage();
  if (touch) await page.addInitScript((n) => Object.defineProperty(navigator, "maxTouchPoints", { get: () => n }), touch);
  await page.goto(site + "/", { waitUntil: "networkidle" });
  const seen = await shown(page);
  check(seen.join() === want.join(), `${name} shows ${seen.join()}, wants ${want.join()}`);
  await context.close();
}

const noScript = await browser.newContext({ javaScriptEnabled: false });
const plain = await noScript.newPage();
await plain.goto(site + "/", { waitUntil: "networkidle" });
check((await plain.locator(".hero [data-store]:visible").count()) === 2, "with no script both stores should show");
check((await plain.locator(".run-clock").first().textContent()) === "94d 7:42:18", "with no script the count should be its fixed value");
await noScript.close();

const raw = await (await fetch(site + "/")).text();
check(raw.includes('data-store="play"') && raw.includes('data-store="app"'), "the raw HTML should carry both stores");
check(/Android and iPhone/.test(raw), 'the raw HTML should say "Android and iPhone"');

const running = await browser.newContext();
const live = await running.newPage();
await live.goto(site + "/", { waitUntil: "networkidle" });
const first = await live.locator(".run-clock").first().textContent();
await live.waitForTimeout(2200);
const later = await live.locator(".run-clock").first().textContent();
check(first !== later, `the count should run (${first}, then ${later})`);
const clocks = await live.locator(".run-clock").allTextContents();
check(new Set(clocks).size === 1, `every count should agree: ${clocks.join(", ")}`);
const since = await live.locator(".run-since").first().textContent();
const day = new Date(Date.now() - (94 * 86400 + 7 * 3600 + 42 * 60) * 1000);
check(since === `Since ${day.getDate()} ${day.toLocaleString("en", { month: "short" })}`, `the date should agree with the count: ${since}`);
await running.close();

const calm = await browser.newContext({ reducedMotion: "reduce" });
const still = await calm.newPage();
await still.goto(site + "/", { waitUntil: "networkidle" });
const before = await still.locator(".run-clock").first().textContent();
await still.waitForTimeout(2200);
check(before === (await still.locator(".run-clock").first().textContent()), "with reduced motion the count should stay still");
await calm.close();

await browser.close();
console.log(failed ? `${failed} problems` : "All good: every device, no script, the count");
process.exit(failed ? 1 : 0);

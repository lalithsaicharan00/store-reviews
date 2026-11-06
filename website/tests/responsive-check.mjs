// Browser check of the built website at every width, through a local copy (`wrangler pages dev website/public`), so
// the real security headers and clean addresses apply:
//   PLAYWRIGHT_PATH=<playwright-core> SHOTS=<folder> node website/tests/responsive-check.mjs http://localhost:8788 /privacy
// Each page must load with no errors or security-policy violations, use its own font, never scroll sideways, and
// keep every link and control inside the screen. SHOTS saves a full-page picture at the Figma widths.
import { createRequire } from "node:module";
const require = createRequire(import.meta.url);
const { chromium } = require(process.env.PLAYWRIGHT_PATH ?? "playwright-core");

const [site, ...paths] = process.argv.slice(2);
const widths = [320, 360, 390, 430, 600, 720, 760, 900, 1020, 1100, 1280, 1328, 1440, 1920];
const browser = await chromium.launch({ channel: "chrome" });
let failed = 0;
const check = (ok, what) => { if (!ok) { failed++; console.log(`FAIL ${what}`); } };

for (const path of paths) {
  for (const width of widths) {
    const context = await browser.newContext({ viewport: { width, height: 900 }, hasTouch: width < 760 });
    const page = await context.newPage();
    const problems = [];
    page.on("console", (m) => { if (m.type() === "error") problems.push(m.text()); });
    page.on("pageerror", (e) => problems.push(String(e)));
    page.on("response", (r) => { if (r.status() >= 400) problems.push(`${r.status()} ${r.url()}`); });
    await page.goto(site + path, { waitUntil: "networkidle" });
    await page.evaluate(() => document.fonts.ready);
    const seen = await page.evaluate(() => {
      const screen = document.documentElement.clientWidth;
      const visible = (e) => { const r = e.getBoundingClientRect(); return r.width > 0 && r.height > 0 && getComputedStyle(e).visibility !== "hidden"; };
      const outside = [...document.querySelectorAll("main *, nav *, footer *")].filter(visible).filter((e) => {
        const r = e.getBoundingClientRect();
        return (r.left < -0.5 || r.right > screen + 0.5) && !e.closest("[data-may-overflow]");
      }).map((e) => `${e.tagName}.${e.className}`);
      const clipped = [...document.querySelectorAll("h1,h2,h3,p,a,dt,dd,li,span")].filter(visible).filter((e) => e.scrollWidth > e.clientWidth + 1 && getComputedStyle(e).display !== "inline").map((e) => e.textContent.slice(0, 30));
      return {
        sideways: document.documentElement.scrollWidth - screen,
        font: document.fonts.check('16px "Google Sans Flex"'),
        outside: outside.slice(0, 5),
        clipped: clipped.slice(0, 5),
        smallTap: [...document.querySelectorAll("a,button")].filter(visible).filter((e) => screen < 760 && !e.closest("p,dd") && e.getBoundingClientRect().height < 40).map((e) => e.textContent.slice(0, 20)).slice(0, 5),
      };
    });
    const at = `${path} at ${width}`;
    check(problems.length === 0, `${at}: ${problems.join(" | ")}`);
    check(seen.sideways <= 0, `${at}: scrolls sideways by ${seen.sideways}px`);
    check(seen.font, `${at}: font not loaded`);
    check(seen.outside.length === 0, `${at}: outside the screen: ${seen.outside.join(", ")}`);
    check(seen.clipped.length === 0, `${at}: text cut: ${seen.clipped.join(", ")}`);
    check(seen.smallTap.length === 0, `${at}: small tap target: ${seen.smallTap.join(", ")}`);
    await context.close();
  }
  if (process.env.SHOTS) {
    for (const width of [390, 768, 1024, 1440]) {
      const context = await browser.newContext({ viewport: { width, height: 900 } });
      const page = await context.newPage();
      await page.goto(site + path, { waitUntil: "networkidle" });
      await page.evaluate(() => document.fonts.ready);
      await page.screenshot({ path: `${process.env.SHOTS}/${path === "/" ? "home" : path.replace(/\//g, "_")}-${width}.png`, fullPage: true });
      await context.close();
    }
  }
}
await browser.close();
console.log(failed ? `${failed} problems` : `All good: ${paths.length} page(s) at ${widths.length} widths`);
process.exit(failed ? 1 : 0);

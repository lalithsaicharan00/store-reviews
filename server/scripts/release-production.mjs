// A gradual release to production (Architecture 06 §8): 5% → 25% → 100%, checking the live server at each step and
// rolling back to the previous version if a check fails.
//
//   node scripts/release-production.mjs [--step-minutes 20] [--skip-tests] [--drill-rollback]
//
// --drill-rollback treats the checks at 25% as failed, to prove the rollback works (it releases nothing).
//
// First the tests and the type check run (unless --skip-tests). Each Durable Object stays on one version for a whole
// deployment, and raising the new version's share never moves an object back (Cloudflare's guarantees), so an account
// never flips between versions mid-step. A release that changes Durable Object classes (a new class, a rename) can't
// go out gradually: Cloudflare refuses the upload, and it must go with `npm run deploy:production`.
import { execFileSync } from "node:child_process";

const args = process.argv.slice(2);
const stepMinutes = Number(args[args.indexOf("--step-minutes") + 1]) || (args.includes("--step-minutes") ? 0 : 20);
const run = (cmd, cmdArgs, opts = {}) => execFileSync(cmd, cmdArgs, { encoding: "utf8", stdio: ["ignore", "pipe", "pipe"], ...opts });
const wrangler = (...a) => run("npx", ["wrangler", ...a, "--env", "production"]);
const say = (text) => console.log(`[${new Date().toISOString().slice(11, 19)}] ${text}`);
const sleep = (minutes) => new Promise((r) => setTimeout(r, minutes * 60_000));

function checksPass() {
  try {
    const out = run("node", ["scripts/live-production.mjs"]);
    const failed = out.split("\n").filter((l) => l.startsWith("FAIL"));
    if (failed.length) { say(`checks failed:\n${failed.join("\n")}`); return false; }
    return true;
  } catch (error) {
    say(`checks failed: ${error.stdout ?? error.message}`);
    return false;
  }
}

if (!args.includes("--skip-tests")) {
  say("tests and type check");
  run("npm", ["test"], { stdio: "inherit" });
  run("npx", ["tsc", "--noEmit"], { stdio: "inherit" });
}

const current = JSON.parse(wrangler("deployments", "status", "--json"));
const previous = current.versions.find((v) => v.percentage === 100)?.version_id;
if (!previous) throw new Error(`A release is already part-way (${JSON.stringify(current.versions)}). Finish or roll it back first.`);

let commit = "unknown";
try { commit = run("git", ["rev-parse", "--short", "HEAD"]).trim(); } catch { /* not a git checkout */ }
say(`uploading version for ${commit}`);
let upload;
try {
  upload = wrangler("versions", "upload", "--tag", commit, "--message", `release ${commit}`);
} catch (error) {
  console.error(error.stderr || error.message);
  console.error("If this release changes Durable Object classes, it can't go out gradually: use `npm run deploy:production`.");
  process.exit(1);
}
const version = /Worker Version ID: ([0-9a-f-]{36})/.exec(upload)?.[1];
if (!version) throw new Error(`No version ID in:\n${upload}`);
say(`new version ${version}, previous ${previous}`);

for (const share of [5, 25, 100]) {
  const specs = share === 100 ? [`${version}@100%`] : [`${version}@${share}%`, `${previous}@${100 - share}%`];
  wrangler("versions", "deploy", ...specs, "--yes", "--message", `release ${commit}: ${share}%`);
  say(`${share}% on the new version`);
  if (share < 100 && stepMinutes > 0) {
    say(`watching for ${stepMinutes} minutes`);
    await sleep(stepMinutes);
  }
  if (!checksPass() || (args.includes("--drill-rollback") && share === 25)) {
    wrangler("versions", "deploy", `${previous}@100%`, "--yes", "--message", `rollback of ${commit}`);
    say(`rolled back to ${previous}`);
    process.exit(1);
  }
}
say(`released ${commit} (${version}) to everyone`);

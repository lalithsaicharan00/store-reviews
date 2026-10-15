// A release of the account Worker to production (Rulebook T6): the tests and type check first, then the new version to
// 5% → 25% → 100% of requests, checking the live server at each step and going back to the previous version if a
// check fails. The very first release (nothing deployed yet) goes out whole and is then checked.
//
//   npm run release:production -- [--step-minutes 10] [--skip-tests] [--drill-rollback]
//
// --drill-rollback treats the checks at 25% as failed, to prove the rollback works (it releases nothing).
// Only with the user's go-ahead (T6). Schema changes go first and must work with the old version too:
// `npm run migrate:production`.
import { execFileSync } from "node:child_process";

const args = process.argv.slice(2);
const stepAt = args.indexOf("--step-minutes");
const stepMinutes = stepAt >= 0 ? Number(args[stepAt + 1]) : 10;
const shell = process.platform === "win32";
const run = (cmd, cmdArgs, opts = {}) => execFileSync(cmd, cmdArgs, { encoding: "utf8", stdio: ["ignore", "pipe", "pipe"], shell, ...opts });
const wrangler = (...a) => run("npx", ["wrangler", ...a, "--env", "production"]);
const say = (text) => console.log(`[${new Date().toISOString().slice(11, 19)}] ${text}`);
const sleep = (minutes) => new Promise((r) => setTimeout(r, minutes * 60_000));

function checksPass() {
  try {
    run("node", ["scripts/live-check.mjs", "https://api.oftenenough.com"]);
    return true;
  } catch (error) {
    say(`checks failed:\n${error.stdout ?? error.message}`);
    return false;
  }
}

if (!args.includes("--skip-tests")) {
  say("tests and type check");
  run("npm", ["test"], { stdio: "inherit" });
  run("npx", ["tsc", "--noEmit"], { stdio: "inherit" });
}

let commit = "unknown";
try { commit = run("git", ["rev-parse", "--short", "HEAD"]).trim(); } catch { /* not a git checkout */ }

let current = null;
try { current = JSON.parse(wrangler("deployments", "status", "--json")); } catch { /* nothing deployed yet */ }
const previous = current?.versions?.find((v) => v.percentage === 100)?.version_id;

if (!previous) {
  if (current?.versions?.length) throw new Error(`A release is already part-way (${JSON.stringify(current.versions)}). Finish or roll it back first.`);
  say(`first release of ${commit}: deploying whole`);
  run("npx", ["wrangler", "deploy", "--env", "production"], { stdio: "inherit" });
  if (!checksPass()) {
    say("the first release fails its checks: take it down with `npx wrangler delete --env production` and look");
    process.exit(1);
  }
  say(`released ${commit}`);
  process.exit(0);
}

say(`uploading version for ${commit}`);
const upload = wrangler("versions", "upload", "--tag", commit, "--message", `release ${commit}`);
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

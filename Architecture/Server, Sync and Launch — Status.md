# Server, sync and launch: start here

*Branch **`claude/server-and-sync`**. Written by Claude (Claude Code), 1 Oct 2026. Update this file whenever an item
moves, so the next session (person or agent) can pick up from it alone.*

## ▶ Next up, in order

1. **Server readiness (can start now).** Do these one at a time, each with tests and a deploy to dev:
   1. Rate limiting: per account on `/v1/sync`, per IP on `/v1/auth/*` (details in §4).
   2. Production environment: `env.production` in `server/wrangler.jsonc`, `api.oftenenough.com`, its own D1 and secrets.
   3. Nightly backups to R2 + a restore script, then one practice restore.
   4. Monitoring: uptime check on `/v1/status`, alerts, the daily report email (Resend).
2. **Merge, as soon as `integration` is in `main`:** merge `main` into this branch, follow §2's checklist, run every
   test (§5), then merge this branch into `main`. Until then, don't start work that touches `Core/` or `AppModel`.
3. **Website on `oftenenough.com`:** privacy policy, support page, account deletion without the app (§3 #5).
4. **Waiting on decisions or accounts** (don't start until they arrive): the Plus screen design (purchases in the
   app), a Google OAuth client ID (Google sign-in), the Apple Developer account (Sign in with Apple, registering IDs
   and in-app purchases). See §3.

**Before you begin in a new session:**
- `git fetch origin && git checkout claude/server-and-sync && git pull`
- Check whether `integration` has reached `main`: `git log --oneline origin/main | head` (if yes, step 2 comes first).
- Cloudflare needs `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID` in the environment (both are set in the cloud environment).
- The dev test secret lived only in the 1 Oct session. For `scripts/live-smoke.mjs` or `LiveSyncTest`, upload a new one:
  `cd server && openssl rand -base64 48 | tr -d '\n' > /tmp/t && npx wrangler secret put TEST_LOGIN_SECRET < /tmp/t`,
  then run with `TEST_LOGIN_SECRET=$(cat /tmp/t)`. (GitHub's `SyncUITests` don't need it: they use GitHub's identity token.)

## 1. Built and tested (this branch)

| Part | What | Tested by |
|---|---|---|
| Phone storage | stress tests; import never overwrites; an unreadable database stays read-only; reminders never re-planned from unread data; Swift-facing core functions throw instead of crashing | `Core` JVM tests (DurabilityTest), PersistenceUITests |
| Identity | app "Often Enough", bundle `com.oftenenough.app` (+ `.liveactivity`, `.uitests`, `.refresh`, Keychain `.sync`) | iOS build on GitHub |
| Server (`server/`) | Worker + one Durable Object per account + D1 directory, at `https://api-dev.oftenenough.com`; Apple/Google sign-in, sessions, link/unlink, sign-out, deletion, EU storage | 66 tests in the Workers runtime; `scripts/live-smoke.mjs` against dev |
| Sync | shared Kotlin rules (`Core/sync`, also compiled to JS for the server); outbox and merge on the phone (schema 6 here; becomes 7, see §2); iPhone `SyncService` | sync tests on JVM, JS and server; LiveSyncTest; SyncUITests on GitHub's Simulator |
| Purchases (server) | StoreKit 2 transactions verified against Apple Root CA - G3; entitlements; refund notifications | purchases tests |
| Purchases (app) | `iOS/OftenEnough.storekit` (Plus, Plus Family, upgrade; placeholder prices) | — |

How it works: `server/README.md` (API, deploy), `Architecture/05` and `06` (design), `Core/sync` (merge rules).

## 2. Merging (checklist)

**Where things are (1 Oct 2026):**

```
main ── integration (progress page + sidebar + undo + animations; the branch merging earlier work)
          ├── claude/eloquent-turing-oznzs3 (merging docs, Build Plan 69–77)
          │     └── onboarding-and-help (onboarding agent)
          └── codex/iphone-widgets (widgets agent)
main ── claude/server-and-sync (this branch: rename, server, sync)
```

Only this branch has the new name and bundle ID; the others still use `com.lalithsaicharan.habits` and "Habits".

**Order:** `integration` → `main` (its own agent) → `main` merged into **this** branch here (this branch changes the
core most) → this branch → `main` → onboarding and widgets merge `main`.

**The merge into this branch must** (from a trial merge on 1 Oct; 8 files conflicted):
- [ ] **Renumber the sync schema to 7.** `integration` already has schema 6 (`entry.source`, from the undo work).
      Sync tables become `v6ToV7`; regenerate `Core/schemas/.../7.json`; add a migration test from a real schema-6 database.
- [ ] **Sync `entry.source`:** add it to `SyncCodec` (encode, decode, known fields).
- [ ] **Route the new write paths through `SyncWriter`:** `editEntry`, `mergeAll` (restore from a backup file),
      and keep `hasEntry` / `loadForRestore` reading tombstones. A write that skips `SyncWriter` never reaches other devices.
- [ ] Keep both sides in `AppModel.swift`, `HabitsApp.swift`, `ReminderScheduler.swift`, `HabitDatabase.kt`,
      `HabitRepository.kt` (`@Throws` is already on both sides), `MigrationTest.kt`.
- [ ] After the rename reaches `main`: update `iOS/Tools/perf/measure_perf_driver.sh` (launches the old ID) and the
      checklists that name it.
- [ ] Run everything in §5, including `SyncUITests`, before merging into `main`.

## 3. Everything still to do

| # | Work | Status / blocked by |
|---|---|---|
| 1 | Server readiness (§4) | **next**; possible now |
| 2 | Merging (§2) | waits for `integration` → `main` |
| 3 | Website on `oftenenough.com`: privacy policy, support page, account deletion without the app (Google requires it) | possible now |
| 4 | Backup and restore for free users (Architecture 03) | another agent is planning it; coordinate before touching restore |
| 5 | Purchases in the app: StoreKit 2 buy/restore/launch check, the 5-habit limit from real ownership, sending purchases to `/v1/purchases/verify` | needs the **Plus screen design**; then testable with the `.storekit` file |
| 6 | Sign-in in the app: Apple button, Google sign-in, "One last step" after purchase, Settings → Account (sync status, devices, delete) | Google: **an OAuth client ID** (free, possible now). Apple: **the developer account** (in verification) |
| 7 | With the Apple account: register `com.oftenenough.app` (+ `.liveactivity`, App Group `group.com.oftenenough.app`), the three in-app purchases, sandbox purchases, the App Store notification URL (`/v1/hooks/apple`), Sign in with Apple notifications and token revocation | the developer account |
| 8 | Later: Google Play billing, Android app, Apple Watch | — |

One click in Xcode on the Mac: Product → Scheme → Edit Scheme → Run → Options → StoreKit Configuration →
`OftenEnough.storekit` (not set in the scheme file, because its path format couldn't be checked without Xcode).

## 4. Server readiness: what each item involves

| Item | Why | What to build |
|---|---|---|
| **Rate limiting** | A sync loop or someone hammering sign-in could use up the free plan's 100,000 requests a day and stop sync for everyone (06 §6) | Cloudflare's rate-limit binding: 60 syncs a minute per account (key: account ID); looser per-IP limits on `/v1/auth/*`; a WAF rule so floods never reach the Worker. Answer `429` with `Retry-After`; the app already backs off |
| **Production** | Dev has test sign-ins, the CI sign-in and test certificates; real users must never share it | `env.production`: Worker `often-enough-api` at `api.oftenenough.com`, its own D1 (`often-enough-directory`), its own `TOKEN_KEY`; no `TEST_LOGIN_SECRET`, no `CI_REPOSITORY`, no `APPLE_EXTRA_ROOTS`; `APPLE_ENVIRONMENTS` = `Production,Sandbox`. Point the app's release build at it (`AppModel.apiBase`). Ideally a separate Cloudflare account (06 §8) |
| **Backups** | Durable Objects keep 30 days of point-in-time recovery; R2 nightlies cover longer and our own bugs (06 §9) | A cron trigger: for each account changed that day, write its records to R2 (an EU-jurisdiction bucket for EU accounts); keep 90 nightlies then monthly for a year. A support script restores one account into a new object, compares, and merges missing records back as ops. One practice restore, recorded here |
| **Monitoring** | Know before users do (06 §10) | An outside uptime check on `/v1/status` every minute; alerts on 5xx above 1%; a daily report email through Resend (requests, syncs, new accounts, % of the daily limit, failures). Logs never contain habit content or tokens |

Also before launch: gradual deploys (5% → 25% → 100%), the purchase confirmation email (Resend, with the domain set up
for Apple's private relay), and `/v1/hooks/apple` tested with Apple's sandbox.

## 5. Running the tests

| What | Command | Needs |
|---|---|---|
| Server | `cd server && npm install && npm test && npx tsc --noEmit` | — |
| Shared sync rules | `cd Core && ./gradlew :sync:jvmTest :sync:jsNodeTest` | Java 21 |
| Phone core | `cd Core && ./gradlew jvmTest` | Java 21 |
| Two phones through dev | `cd Core && TEST_LOGIN_SECRET=… ./gradlew jvmTest --tests '*LiveSyncTest*'` | the dev test secret |
| Live server checks | `cd server && TEST_LOGIN_SECRET=… node scripts/live-smoke.mjs` | the dev test secret |
| iPhone (GitHub) | push with `[ios-ci]`, or run the "iOS build and tests" workflow with tests `SyncUITests,PersistenceUITests,TodayUITests` | — |
| After changing `Core/sync` | `server/scripts/build-core.sh`, then the server tests | Java 21 |

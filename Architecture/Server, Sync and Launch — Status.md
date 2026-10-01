# Server, sync and launch: status and next steps

*Written by Claude (Claude Code), 1 Oct 2026, on branch `claude/server-and-sync`. Keep it current as items land.*

## 1. Built and tested (this branch)

| Part | What | Tested by |
|---|---|---|
| Phone storage | stress tests; import never overwrites; an unreadable database stays read-only; reminders never re-planned from unread data | `Core` JVM tests (DurabilityTest), PersistenceUITests |
| Identity | app "Often Enough", bundle `com.oftenenough.app` (+ `.liveactivity`, `.uitests`, `.refresh`, Keychain `.sync`) | iOS build on GitHub |
| Server (`server/`) | Worker + one Durable Object per account + D1 directory, at `api-dev.oftenenough.com`; Apple/Google sign-in, sessions, link/unlink, sign-out, deletion, EU storage | 66 tests in the Workers runtime; `scripts/live-smoke.mjs` against dev |
| Sync | shared Kotlin rules (`Core/sync`, also compiled to JS for the server); outbox and merge on the phone (schema 6 here; see §2) | sync tests on JVM, JS, server; LiveSyncTest; SyncUITests on GitHub's Simulator |
| Purchases (server) | StoreKit 2 transactions verified against Apple Root CA - G3; entitlements; refund notifications | purchases tests |
| Purchases (app) | `iOS/OftenEnough.storekit` (Plus, Plus Family, upgrade; placeholder prices) | — |

## 2. Merging (do this before more work builds on old code)

**Where things are (1 Oct 2026):**

```
main ── integration (progress page + sidebar + undo + animations; the merge branch)
          ├── claude/eloquent-turing-oznzs3 (merging docs, Build Plan 69–77)
          │     └── onboarding-and-help (onboarding agent)
          └── codex/iphone-widgets (widgets agent; 9 integration commits behind)
main ── claude/server-and-sync (this branch: rename, server, sync)
```

`main` and every branch above except this one still use `com.lalithsaicharan.habits` and the name "Habits".

**Order:**
1. `integration` → `main` (its own agent finishes that).
2. Then `main` (with integration) → **into this branch**, here, because this branch changes the core most. Then this branch → `main`.
3. Onboarding and widgets merge `main` after that.

**What the merge into this branch must do** (found with a trial merge on 1 Oct; 8 files conflict):
- **Schema numbers:** `integration` already has schema 6 (`entry.source`, from the undo work, 25 h older). The sync tables here become **schema 7** (`v6ToV7`), with a test from a real schema-6 database.
- **Sync must carry `entry.source`** (SyncCodec), or it would stay on one device.
- **Every new write path goes through sync:** `editEntry`, `mergeAll` (restore from a backup file), `hasEntry`, `loadForRestore`. A write that skips `SyncWriter` never reaches other devices.
- **`@Throws`** on every Swift-facing core function: done here too (without it a failure crashes the iPhone app).
- `AppModel`, `HabitsApp`, `ReminderScheduler`: keep both sides' changes.
- After `main` has the rename: the speed-test script on `integration` (`iOS/Tools/perf/measure_perf_driver.sh`) launches the app by the old ID, and some checklists name it.

## 3. Still to do

| # | Work | Who / blocked by |
|---|---|---|
| 1 | Merging (§2) | this branch, after `integration` lands |
| 2 | Purchases in the app: StoreKit 2 buy/restore/launch check, the 5-habit limit from real ownership, sending purchases to the server | needs the Plus screen design; testable now with the `.storekit` file |
| 3 | Sign-in in the app: Apple button, Google sign-in, "One last step" after purchase, Settings → Account | Google: an OAuth client ID (free, possible now). Apple: the developer account (in verification) |
| 4 | Backup and restore for free users (Architecture 03) | another agent is planning it |
| 5 | Website on `oftenenough.com`: privacy policy, support, account deletion without the app | possible now |
| 6 | Server readiness (§4) | possible now |
| 7 | Waiting on Apple: register IDs and in-app purchases, sandbox purchases, the notification URL, Sign in with Apple notifications and token revocation | the developer account |
| 8 | Later: Google Play billing, Android app, Apple Watch | — |

In Xcode once: Product → Scheme → Edit Scheme → Run → Options → StoreKit Configuration → `OftenEnough.storekit`.

## 4. Server readiness before launch

| Item | Why | What it involves |
|---|---|---|
| **Rate limiting** | A bug that syncs in a loop, or someone hammering sign-in, could use up the free plan's 100,000 requests a day and take sync down for everyone (06 §6) | Cloudflare's rate-limit binding: 60 syncs a minute per account; looser per-IP limits on sign-in; a WAF rule so floods never reach the Worker. The app already backs off |
| **Production server** | Dev has test sign-ins and test certificates; real users must never share it | `env.production`: Worker `often-enough-api` at `api.oftenenough.com`, its own D1, its own secrets (no `TEST_LOGIN_SECRET`, no CI sign-in, no extra roots), Apple's root only. Ideally a separate Cloudflare account (06 §8) |
| **Nightly backups + restore drill** | Durable Objects keep 30 days of point-in-time recovery; R2 nightlies cover longer and our own bugs (06 §9) | A cron Worker copies each account changed that day to R2 (an EU bucket for EU accounts); a support script restores one account into a new object, compares, merges back as ops; a monthly practice restore |
| **Monitoring** | "We know before users do" (06 §10) | An outside uptime check on `/v1/status`; error-rate alerts; a daily report email through Resend (requests, new accounts, % of the daily limit, failures); logs without habit content |

Also before launch: gradual deploys (5% → 25% → 100%), the purchase confirmation email (Resend; domain set up for Apple's relay), Apple notification URL registered, `/v1/hooks/apple` tested with Apple's sandbox.

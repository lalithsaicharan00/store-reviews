# Build Prompt — Google Drive Sync, Stages 1–2 (Delete When Done)

Written by Claude (Claude Code), 11 October 2026, for a cloud session, at the user's request: "create a detailed prompt
… so it continues working … ask it to test everything." Delete this file when the work is merged and the results
report is written (as the Watch and iPad build prompts were).

---

You are building **Google Drive sync in the shared Kotlin core** and proving, against the real Google Drive, whether it
works. Your result decides whether Android Plus (and Google Drive on iPhone, iPad and Mac) gets sync. Work on your own
branch `claude/drive-sync` from `main`. Commit and push as you go (this task says so), untagged while building (T10).

## 1. Read first (in this order)

1. `RULEBOOK.md` (all of it; D1–D17, S16, T1, T2, T7, T10, T12, T17, W1–W5 matter most here) and `CLAUDE.md`.
2. `Android/Docs/README.md`: the user's decisions A1–A9. Then, in that folder:
   - `How Sync Works — iCloud and Google Drive, One Core.md` (the model you're implementing),
   - `Research/Google Drive Sync — Download, Merge, Upload, and the Version Chain.md` (the design, the facts checked),
   - `Research/Sync Status Across Devices — When It Shows, Where, and the Complaints Behind It.md` (the per-device
     record, the states the UI will need, the complaints to prevent).
3. `Architecture/11. iCloud Sync with CloudKit.md` (the iCloud sync as built: outbox, merge on fetch, brake, fresh
   install, delete semantics). Drive must give the same guarantees.
4. `Core/README.md`, `Core/sync/…/SyncRules.kt` and `Hlc.kt` (the merge you reuse unchanged), `Core/src/…/CloudStore.kt`
   and how `iOS/Habits/Cloud/CloudSync.swift` drives it (the store, outbox and merge your Drive engine plugs into).
5. `Architecture/Shared Core Decision.md` before adding any dependency to `Core/`.

## 2. What to build (stage 1)

A Drive carrier in the core that uses **the same store, outbox and merge rules as iCloud**; only the transport differs.

- **Where data lives:** the person's Google Drive **app data folder** (`appDataFolder`, scope `drive.appdata`): one
  compressed snapshot file per year of records (finished years almost never change), the backup-file encoding where it
  fits (`Core/Backup File Format.md`), and one small **device file per device** (name, last checked in, last change
  sent) for the "Pixel 8 last synced…" line (Current Work 91).
- **A sync round:** list the folder (cheap) → if a year file changed since last seen, download it and merge it into the
  local store with `SyncRules.mergeRecord` in one transaction → if this device has changes Drive lacks, build the
  merged snapshot and save it through the version chain → write this device's file → clear outbox rows **only** when a
  saved snapshot built after they were queued is confirmed (by outbox position, as D12 learned).
- **The version chain (the protection):** each saved snapshot carries a **pre-generated file ID** (Drive
  `files.generateIds`) reserved for the next version. Saving = creating a file with that reserved ID. Drive answers
  **409 Conflict** to a second create with the same ID, so a device that loses the race downloads the winner, merges,
  and tries the next reserved ID. Never `files.update` a snapshot in place (Drive v3 has no precondition on updates).
  Delete superseded versions only after a few newer ones exist, never one another device could still be reading as
  the latest.
- **Safety (D4, D14, D17):** a fresh install downloads and merges before it ever uploads; never save a snapshot that
  has far fewer habits/records than the last one seen (keep the larger aside); downloaded deletes past the brake's
  threshold are held for the person (reuse the iCloud brake); unknown fields kept.
- **Errors → states the UI can show:** offline → "waiting" (nothing lost); 401/invalid token → "Google Drive isn't
  connected"; 403 `storageQuotaExceeded` → "Google Drive is full"; 403/429 rate limits → back off exponentially with
  jitter and retry; 5xx → retry. Each state is a value the app can read, never only a log line.
- **When it runs** is the app's job (on open, a few seconds after changes, about once a minute while on screen, in
  the background; no relay server, decision A5). Expose one `syncNow()` and a status; no timers inside the core.
- **Seams:** an interface for the Drive calls (list, generateIds, create-with-id, download, delete, about/quota) and
  one for access tokens (each platform supplies its own sign-in later: Android `AuthorizationClient`, iOS GoogleSignIn).
  Implement: a **FakeDrive** for tests (in memory; faithfully refuses a duplicate reserved ID with 409; can inject
  delays, list lag, cut-off uploads, 403/429/5xx, full quota, revoked tokens) and a **real Drive client** for JVM (used
  by stage 2; choose the HTTP library per the Shared Core Decision so iOS/watchOS builds stay working).
- Keep the CloudKit path byte-for-byte unchanged in behaviour; the iPhone build compiles `Core/`, so nothing you add may
  break `iosArm64`, `iosSimulatorArm64` or the watchOS targets.

## 3. Test it (stage 1, on GitHub)

`Core/` has JVM tests (`./gradlew jvmTest`) but no Linux workflow of its own: add one (fast, untagged pushes don't run
the iOS job). Run it on GitHub (T1), watch each run with a background watcher until it completes (T1), read every
failure before changing anything (T2), never loosen a test.

Property tests against FakeDrive, seeded and repeatable, thousands of runs:
- 2–4 devices, random changes (logs, edits of the same and different fields, deletes, restores), random offline spells,
  random interleavings, **simultaneous saves (the race)**, duplicated and reordered deliveries, an upload cut off
  halfway, a crash between upload and outbox clear, a reinstall (empty database) mid-way, a device away for "months".
- **Must hold every time:** all devices end identical; identical to merging every change in any order; no change ever
  lost; nothing counted twice; a deleted record never comes back; a fresh install never uploads before merging; the
  never-shrink and brake rules fire when they should and only then.
- The user's examples, as named tests: offline phone 2 glasses + tablet 1 = 3; rename on one + colour on the other =
  both; delete vs offline log = deleted with the log kept; a stale device (days old) can't replace newer work; the
  same tap twice = once; a timer stopped on two devices = one entry.
- Size and time: an extreme account (about 25,000 records a year for 15 years): bytes per year file, time to build,
  merge and upload; the cost of an ordinary round with nothing to send (it must be tiny: it runs once a minute).

## 4. Prove it on the real Google Drive (stage 2)

The user created a Web OAuth client and a **test Google account** (never theirs). GitHub repository secrets:
`GDRIVE_TEST_CLIENT_ID`, `GDRIVE_TEST_CLIENT_SECRET`, `GDRIVE_TEST_REFRESH_TOKEN` (scope `drive.appdata` only).
Use them **only** in a `workflow_dispatch` workflow of your own (never on ordinary pushes), exchanging the refresh token
for an access token at run time. Never print tokens, request bodies or file contents (D11); mask everything.
The app is in Google's Testing mode, so the refresh token can expire after about 7 days: on `invalid_grant`, stop and
ask the user to renew it (OAuth Playground, the steps in this folder's README thread; they know them).

Checks, each repeated enough to trust (T12), with the numbers written down:
1. **The deciding check:** two independent clients (separate HTTP clients and processes, as two devices would be)
   create a file with the **same pre-generated ID**: exactly one succeeds and the other gets 409, every time (≥100
   rounds, including IDs generated by client A and used by client B, and near-simultaneous starts). If Drive ever
   accepts both or loses one, the version chain is unsafe: stop, record it, and design the fallback (for example a
   per-device change-file "mailbox", the earlier design) before going on.
2. Full rounds with 2–3 simulated devices on the real Drive: offline then sync, simultaneous saves, an upload cut off
   halfway, a reinstall, the brake; all end identical.
3. How Drive behaves: does a just-created file appear in `files.list` at once (list lag)? revision and ID behaviour;
   rate limits hit; quota units per round (Drive's limits page); latency of a typical round and of an extreme account's
   first download.
4. Clean the test account's app folder after each run.

**"Test everything manually" (the user):** beyond the automated runs, drive the real Drive yourself from scripts in
the workflow, look at what's actually in the app folder after each scenario, and try to break it (half-written files,
odd orders, many devices). Record what you saw, not what you expected.

## 5. Finish

1. Run the iOS job's sync and cloud test classes once on your final commit (the core is compiled into the iPhone app;
   T7; a speed run only if anything on the iPhone's path changed).
2. Write `Android/Docs/Research/Google Drive Sync — Prototype Results.md` ("Written by…", plain English): the verdict
   **Go / Go with changes / No-go**, the numbers, run IDs, what broke and what you changed, what stage 3 (two real
   Android devices) must still check (Android background limits, sign-in, the Android OAuth client's package
   `com.oftenenough.app` and SHA-1), and what stage 4 (the iPhone, iPad and Mac app) needs (a new iOS client, the
   choice between iCloud and Google Drive on the iCloud & Backup page, one sync place at a time).
3. Update `Android/Docs/README.md` (the results under A4/A9), Current Work item 89 (tick with run IDs; W1), the
   research index, and the Rulebook if you learned something (W5).
4. Merge into `main` only when every test has passed (W3); delete this prompt in that merge.

Ask the user only when truly blocked (an expired token, a decision only they can make). Otherwise keep going.

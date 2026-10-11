# Google Drive Sync — Prototype Results

Written by Claude (Claude Code), 11 October 2026, from the build prompt "Google Drive Sync, Stages 1–2": Google Drive
sync built in the shared Kotlin core, tested against a stand-in Drive on GitHub, then proved on the real Google Drive
with the test account the user made. Everything below was measured on GitHub's machines; the run IDs are at the end.

## The verdict: **Go with changes**

**The version chain works on the real Google Drive.** The deciding check (§2) ran 280 times across two runs, with
separate processes (two "devices", each with its own connection and its own sign-in) creating files under the same
reserved ID at the same moment: **every time exactly one save succeeded and every other was refused with 409**, IDs
reserved by either device, with two and with six devices. No ID ever held two files, and no save ever replaced another.
Full sync rounds with three to six devices on the real Drive ended identical every time, through offline spells,
simultaneous saves, cut-off uploads, a reinstall and the brake.

**"With changes"** means the design stands as built; stage 3 has a short list to handle (§6), none of which changes the
design. Two real problems were found while testing and fixed in the core (§5).

## 1. What was built (stage 1)

In the shared core (`Core/`), used the same way by Android, iPhone, iPad and Mac later:

- **`DriveSync`**: one `syncNow()` and a `status()`; no timers (when it runs is the app's job, decision A5). A round:
  list the app folder (one call) → download and merge each newest version not yet merged here, through the brake →
  for each file this device has changes for, build it from this device's data and save it through the version chain →
  only then do the changes it contained leave the outbox (by outbox position, as D12 learned for iCloud) → check in →
  tidy old versions.
- **The same store, outbox, merge and brake as iCloud** (`DriveStore` beside `CloudStore`): `SyncRules.mergeRecord`
  unchanged; one transaction per file; unknown fields kept. The CloudKit path is unchanged in behaviour (its 16 tests and
  the Watch's 20 still pass; one shared helper was moved, not changed).
- **On Drive** (`appDataFolder`, scope `drive.appdata`): one file per year of logs plus one "base" file (habits, steps,
  times, settings, notes), each a **version chain**; and one small file per device (name, platform, last checked in,
  last sent) for "Pixel 8 last synced…" (Current Work 91). A version is a checked zip like the backup file and the
  Watch's fill: every record whole, every field with its sync stamp, a SHA-256 of the records.
- **The version chain**: every version carries an ID reserved for the next (`generateIds`). Saving is creating a file
  with that ID; a device that gets 409 downloads the winner, merges it and tries the winner's reserved ID. Nothing is
  ever updated in place. Two devices starting the same file at once make two first versions: every device merges every
  newest version, saves after the longest, and names the other as taken in; it goes once a few newer versions exist.
  Old versions are deleted once 3 newer ones exist.
- **Safety**: a fresh install downloads and merges before anything goes up, and sends nothing until its welcome is
  finished (`syncNow(allowUpload = false)`); never shrink (a version never holds fewer records than the most this device
  merged into that file; otherwise nothing is saved); the brake both ways, reusing iCloud's thresholds (D17); a file
  from a newer app is never written over ("update the app"); a file Drive stored damaged is skipped for the version
  before it and healed by its writer, whose changes stay queued.
- **States the app can show** (`DriveState`): Synced, Paused (welcome not finished), Offline, Not connected (signed out,
  access removed, `invalid_grant`), Full (`storageQuotaExceeded`), Busy (rate limits and 5xx after exponential backoff
  with jitter, Retry-After respected), Held (Drive's deletes wait for the person), Deletes waiting (this device's),
  Update needed, Problem. Each is a value, never only a log line.
- **The seams**: `DriveApi` (list, get, generateIds, create-with-ID, updateProperties for the device file, download,
  delete, quota) and `DriveTokens`. **`GoogleDrive` speaks Drive's REST protocol in the core**, over a plain-HTTP seam
  (`DriveHttp`) each platform supplies, so every platform reads Drive's answers and errors the same way; no new
  dependency (the Shared Core Decision keeps HTTP with the platform). `JvmDriveHttp` (Java's own client) for desktop and
  the checks; `RefreshTokenAccess` for the checks.
- **Tests run on GitHub on every push that changes `Core/`** (`.github/workflows/core-tests.yml`, new): the JVM tests
  on Linux, and the iPhone and Watch targets compiled on a Mac (`iosArm64`, `iosSimulatorArm64`, three watchOS) — all
  compiled on every run.

## 2. The deciding check on the real Drive

Two processes on one runner, each with its own HTTP client and its own access token, created a file under the same ID
at the same instant, or 20 ms or 150 ms apart either way; half the IDs were reserved by each process (so IDs made by
device A were used by device B and the other way round). Then six processes on the same IDs.

| Run | Processes | IDs | Exactly one save, every other 409 | Files under those IDs | Create time (median / p95 / max) |
|---|---|---|---|---|---|
| 38162572860 | 2 | 120 | **120 / 120** | 120 (one each) | 741 / 953 / 1,594 ms |
| 38162572860 | 6 | 20 | **20 / 20** | 20 | 654 / 2,085 / 2,619 ms |
| 38163084653 | 2 | 120 | **120 / 120** | 120 | 628 / 1,203 / 3,786 ms |
| 38163084653 | 6 | 20 | **20 / 20** | 20 | 593 / 1,852 / 2,471 ms |

The winner varied (A won 84 and 69 of 120; with six, five different winners), so these were real races, not one side
always first. **Drive enforced "only the first save under an ID" every time: 280 of 280.**

## 3. How Drive itself behaves (run 38163084653, "what I saw")

- **List lag: none seen.** 20 files made and listed straight after: all 20 listed on the first try (214–276 ms).
  The engine doesn't rely on this anyway: after a 409 it reads the winner by ID.
- **IDs**: one `generateIds` call gave 1,000 IDs, all 33 characters, all different (fits Drive's 124-byte property).
- **The same ID twice from one device** (a retry after a lost answer): 409, as from another device.
- **An ID nobody reserved**: refused (400 `fileIdNotUsable`).
- **An ID whose file was deleted**: refused again with **400 `invalid`, not 409**. This mattered: see §5.
- **A half-written upload** (a resumable upload under a reserved ID, abandoned half-way): no file appears, by listing or
  by ID; **another device's save under the same ID was accepted**; the abandoned upload finished late got **409**, and
  the file stayed the other device's. So a device that dies mid-upload neither blocks the chain nor overwrites it.
- **Checksums**: Drive's SHA-256 of what it stored matched ours; properties come back exactly.
- **Bursts**: 100 listings at once: all 100 answered (889 ms), no rate limit hit. A list takes 216–263 ms.

## 4. Full rounds and numbers

**On the real Drive** (run 38163084653, three devices, then six; every scenario ended with all devices identical):

| Scenario | Result |
|---|---|
| Phone logs 3; tablet and Mac download | 3 everywhere; first save 3.8 s, first download 3.1 s (includes sign-in) |
| Phone offline logs 2, tablet logs 1 | Phone said Offline with 2 waiting; then 6 everywhere |
| All three save at once, 10 times | 29 refusals (409) met and handled; all 36 logs kept |
| Upload cut off before Drive kept it; then after | Still waiting both times; each log saved once (38) |
| Mac reinstalled | Downloaded everything in 0.7 s, sent nothing before its welcome finished |
| A log in 2025 and 40 deletes at once | Tablet held its deletes until approved; the phone held them (Held, 40) until applied |
| Six devices save one file at once | 15 refusals handled; all six logs kept |
| An idle round | **1 call, 242 ms** |

**An extreme account** (25,000 logs a year for 15 years = 375,000 logs; 12 habits):

| | Stand-in Drive (run 38162929267) | Real Drive (run 38163084653) |
|---|---|---|
| Each year's file | ~385 KB (deflated); base 1 KB | 399–401 KB each; 16 files |
| First upload of everything | 6.8 s | 25.9 s |
| A new device's first download and merge | 15.7 s | 84.6 s |
| A save after one new log (this year's file only) | 0.4 s, 3 calls | 2.0 s |
| The other device taking that in | 0.5–0.7 s | 5.8 s |
| An idle round | 29–38 ms, 1 call | 0.3 s, 1 call |

A typical person's whole history is a few KB; the round that runs about once a minute is one list call (and once every
15 minutes the device's own check-in, so two).

**Against the stand-in Drive** (every push to `Core/`): PROPERTY_LINE

## 5. What broke, and what changed

1. **A reserved ID can be refused with 400, not 409** (found on the real Drive): once a version is tidied away, its ID
   can never be used again, and Drive says so with 400 `invalid`. A device far behind (its listing older than three
   saves) would have tried that ID and stopped with "Problem". Now a 400 under a reserved ID counts as taken: the device
   reads the winner by ID, or lists again and saves after the newest (named test, and the stand-in Drive now refuses
   deleted IDs the same way).
2. **The never-shrink guard fired wrongly** (found by the seeded runs, seed 4): it compared a device's file with a
   version stored damaged that the device couldn't read. It now compares with the most records this device actually
   merged into or saved to that file. The data was never at risk (the damaged version's writer keeps its changes queued
   and sends them again), but the guard stopped progress.
3. Two test mistakes, fixed in the tests: leftover upload faults after the network came back, and a check that every
   field's stamp only grows (wrong for deletes: a delete wins even with an older stamp; the check now asks that merging
   the older version into the newer changes nothing).

## 6. What stage 3 (two real Android devices) must still check

- **Android's background limits**: WorkManager with a network constraint for "send when back online"; Xiaomi, Samsung
  and others delay it. Sync on open stays the main path (A5). Measure how late background rounds really run.
- **Sign-in**: an Android OAuth client for package `com.oftenenough.app` with the release and debug SHA-1, scope
  `drive.appdata` only, through `AuthorizationClient`; what the person sees, and "Not connected" when they remove access.
- **The extreme account's first download** took 85 s on the runner (16 s against the stand-in, so mostly the 16
  downloads and their merge on a busy machine; not broken down yet). Show "Bringing in your habits…" with progress, let
  Today open on what's already merged, and time it on a real phone.
- **Merging another device's current-year file** costs ~6 s for an extreme account each time it changes (25,000
  records compared). Fine for nearly everyone; for the extreme case, consider splitting the current year by month.
- **A reinstalled device appears twice** in the device list (its old file stays until it's 180 days quiet). The device
  list should show only devices seen in the last 14 days (as the Sync Status report already says) and combine same names.
- **Two real phones**: the race and the rounds again, from two networks, with one phone in a lift.

## 7. What stage 4 (iPhone, iPad and Mac with Google Drive) needs

- **A new iOS OAuth client** (the old one was deleted, Current Work 84) and GoogleSignIn, scope `drive.appdata`.
- **`DriveHttp` in Swift on URLSession** (a few dozen lines). Kotlin's `ByteArray` crosses into Swift as `KotlinByteArray`;
  for 400 KB files that copy is small, but check it in a speed run.
- **The choice on the iCloud & Backup page**: iCloud (the default) or Google Drive, **one sync place at a time** (A10).
  Switching binds the outbox to the new account (every row queued), downloads first, merges by ID; nothing is replaced.
- The same states and words on every platform (§1), the sync line on Today (Current Work 91), and D3's "another account
  asks first" for a different Google account.

## Runs

- Core tests (stand-in Drive, iPhone and Watch compile): RUN_LIST
- Real Drive: 38162572860 (the deciding check), 38163084653 (all checks: race, rounds, behaviour, extreme account),
  FINAL_REAL.
- iOS job (the core compiled into the iPhone app; sync and iCloud tests): IOS_RUNS.

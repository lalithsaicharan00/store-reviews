# Free Sync — One Device at a Time

Written by Claude (Claude Code), 11 October 2026, at the user's request: "let's create a plan for sync one device at a
time in free plans … document everything in one particular document: what we need to update in the server, what we
need to do, all of that … and update the UI." Current Work 78.

**Status: decided by the user (11 Oct 2026); built 10 Oct 2026 on branch `app-lock-privacy-security`** (server
`20a05468`, deployed to dev only; app `35c16841`); tests and iPhone checks in Current Work 78. Production waits for the
user's go-ahead.
Screens: [Figma, Account, Backup & Export section](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=950-309)
(4, 4b, 4c, 7, 8; also 2, 3, 3b); images in [`Images/`](Images/) and in the
[Account and Backup Redesign](<../Account and Backup Redesign/README.md>) spec, which this plan updates.

**Read first:** the Rulebook (D1–D14, S, T, W), [Account and Backup Redesign](<../Account and Backup Redesign/README.md>)
(its §8 is the rest of the build), [Free Plan Backups](<../../../../Research/Research Reports/Data, Sync and Accounts/Free Plan Backups — iPhone and iPad, and a Backup That's Never a Day Behind.md>)
(the cost model and the iCloud reinstall fix), [Without an Account — iCloud and Google Drive Backup, or Only This
Phone](<../../../../Research/Research Reports/Data, Sync and Accounts/Without an Account — iCloud and Google Drive Backup, or Only This Phone.md>)
(Current Work 77), Architecture 05 (Sync Engine) and 06 (Server on Cloudflare).

---

## 1. The decision, in plain words

| | Where the habits are kept | How |
|---|---|---|
| **No account** | **iCloud** or **Google Drive**, the person's choice (iCloud by default on iPhone) | A backup file, **backed up as you go** (on leaving the app if something changed, at least 10 minutes apart; after widget or notification logs; at least daily). Unchanged from Current Work 75 |
| **Free account** | **Your account** | **Synced, one device.** Every change goes to the account within seconds, like Plus. One device is signed in at a time: signing in on another phone or tablet **signs the first one out** (it says so first). The signed-out device keeps its habits and goes back to backing up to iCloud / Google Drive |
| **Plus** | **Your account** | **Synced across your devices** (as today): phone, iPad, Watch, web, desktop |

- **One backup place at a time** (Rulebook D4): signed in → the account only; signed out → iCloud or Google Drive.
- **Daily copies:** the account keeps a copy of each day: **7 days on free, 90 days on Plus** (Restore From a Backup).
- **What this replaces:** free accounts uploading the whole backup file to the account ("backed up as you go" to R2).
  "Backed up as you go" stays only for iCloud and Google Drive, without an account.
- **Free stays one device, phone + iPad is Plus** (the user, 11 Oct 2026, after the review check in §2.2).

## 2. Why

### 2.1 The cost (Cloudflare's pricing pages, read 11 Oct 2026)

The user asked whether uploading the whole file again and again would cost a lot as a free user's history grows over
years, and whether sync is more logical.

| Service | Charge | Price | Included in the $5/month Workers plan |
|---|---|---|---|
| R2 (files) | Upload (PutObject, Class A) | $4.50 per million | 1 million a month |
| | Storage | $0.015 per GB-month | 10 GB |
| | Data in or out | free | — |
| Durable Objects (sync) | Requests | $0.15 per million | 1 million |
| | SQLite rows written (each index update counts as another row) | $1.00 per million | 50 million |
| | Stored data | $0.20 per GB-month | 5 GB |
| | Duration | $12.50 per million GB-s | 400,000 GB-s |
| Workers | Requests | $0.30 per million | 10 million |

Model (assumptions: ~80 changes a month, ~1,000 new records a year, ~4 rows written per change as measured on dev on
8 Oct, ~300 bytes a record on the sync server *estimated*, backup file 393 bytes a record *measured* or 89 once made
smaller):

| | Backed up as you go (whole file) | Sync, one device |
|---|---|---|
| Per free user per month, year 1 | ~$0.0004 | ~$0.0006 |
| Per free user per month, year 5 | ~$0.0006 | ~$0.0008 |
| 100,000 free users, year 5, after the plan's included amounts | **~$55 a month** | **~$44 a month** (32 M rows written fit inside the 50 M included) |
| The user's mobile data a month: year 1 / year 5 / a heavy user | ~31 MB / ~157 MB / ~940 MB | **< 0.1 MB, every year** |
| Freshness after a lost phone | minutes | seconds |

**Measured on dev, 10 Oct 2026** (`server/scripts/live-free-sync.mjs`, run 38028154237, a free account used as the app
uses it: 5 habits, 100 logs one sync each, 20 edits): **5 SQLite rows written per new record and 4 per edit** (the
estimate was ~4: the record, its op-log row and their indexes); **about 1,390 bytes stored per new log** and 2,220 per
record overall (the estimate was ~300). The difference is the op log: every change is kept as its own JSON beside the
merged record, which new devices' first downloads read (D14). So for **100,000 free users in year 5** (5,000 records
each, ~7 MB): **about 700 GB stored, ~$140 a month** at $0.20 a GB-month, against the ~$44 estimated above; rows written
(~40 M a month) still fit inside the 50 M included. Storage is the number to watch, not rows. Two things would bring it
down if it matters: compacting the op log (a first download can start from the merged records, so ops every device has
already received can go), and measuring again on a full-size account (a small database pays SQLite's page overhead).
The daily report now carries both numbers from real use (`report.ts`, Analytics Engine).

**R2 charges per upload, not per megabyte**, so the whole file doesn't grow *our* bill much; it grows the *person's*
mobile data every year. Sync sends only what changed. At scale sync is no dearer for us, much lighter for people, and
puts free and Plus on one system (upgrading just allows more devices). Two numbers are estimates to measure on dev once
built: bytes per record on the sync server, and rows written per change.

### 2.2 Why not phone + iPad on free (reviews, 11 Oct 2026)

- **Device sync is what people pay for.** Paying users name sync and devices most often (4.3%, against 1.8% for more
  habits and 0.9% for backup; [Plus Scope](<../../../../Research/Research Reports/Business Model and Monetization/Plus Scope and Account at Purchase.md>)).
  iPad reviewers mention paying 2.1× as often as average, 2.6× when about sync; 58 paid and were angry it didn't reach
  their iPad; **none** complained that iPad sync costs money ([iPad Sync and Server Trust](<../../../../Research/Research Reports/Data, Sync and Accounts/iPad Sync and Server Trust — Backlog 5.md>)).
- **Fresh scan** (all 1,238,784 reviews; 40 matches about paid device sync, all read; [`scan4.py`](Evidence/scan4.py)):
  about 16 say device sync is why they paid ("Got premium on day 2 for sync to other devices for less than a trip to
  McDonald…", `10223796498`); about 5 object to sync being paid, mostly mildly; the rest are about paid sync not
  working.
- **So:** making phone + iPad free gives away the strongest reason to buy Plus for little goodwill (people accept paying
  for sync; they resent paying for safety, which stays free). Nobody is trapped: a free user can move to the iPad any
  time, an iPad-only user uses the iPad as their one device, and moving, backup and export are free (D10).

## 3. How it works

### 3.1 The states of one device

| State | What syncs | Backup place | Backup & Export says |
|---|---|---|---|
| Not signed in | nothing | iCloud or Google Drive (as you go) | **Backed up** · *Today 9:14 · iCloud* (screen 4) |
| Signed in, free | every change, to the account | the account | **Synced** · *Just now · Your account* (4b) |
| Signed in, Plus | every change, all devices | the account | **Synced** · *Just now · 2 devices* (4c) |

There is no "signed in but not syncing" state: on free, the device that isn't syncing is signed out.

### 3.2 Signing in on a device (free)

1. Sign in (Apple or Google), as today; D3 holds (an unknown sign-in never creates an account silently).
2. The app asks the server whether another device is signed in to this free account (`GET /v1/sync/status`, after the
   provider's sign-in, before the session is opened, or with a session that isn't yet allowed to sync).
   - **No other device:** carry on. No question.
   - **Another device is signed in:** the sheet **Use on This iPad?** (screen 7): *Free syncs one device, so your iPhone
     will be signed out. It keeps its habits.* **Continue** · **Cancel**.
3. **Continue** → the server opens this device's session and **ends the other device's session** (one session per free
   account). This device then syncs: a full download first (D14: `"full": true` until the last page), then its own
   habits are sent and **merged** (D3: field by field, never deleting). iCloud / Google Drive backups stop only once the
   server has acknowledged everything (D4).
4. **Cancel** → not signed in; nothing changes on either device.

### 3.3 The old device

- The next time it talks to the server (a sync, or refreshing its token) the server answers that its session has ended
  (`401 session_ended`, reason `signed_in_elsewhere`, with the new device's name). The app **signs out locally, keeping
  every habit** (as Sign Out does today: "Your habits stay on this iPhone"), and goes back to backing up to iCloud /
  Google Drive at once.
- On its next open it says so once, in an alert (screen 8): **Signed out on this iPhone** · *Your account is now used on
  your iPad. This iPhone keeps its habits and backs them up to iCloud.* · **OK**. (An alert: it's unexpected and needs
  acknowledging.)
- **Changes it made but never sent** (it was offline when the other device took over) stay on this device and in its
  iCloud backup; nothing is deleted. If the person signs in here again, step 3.2 runs the other way and those changes
  merge into the account (D3).

### 3.4 Plus, and moving between free and Plus

- **Plus:** every device stays signed in and syncs; no sheet, no sign-out.
- **Free → Plus** (purchase): nothing to do; any device can now sign in without signing the other out.
- **Plus → free** (a refund): the most recently synced device stays signed in; the others are signed out at their next
  contact, with the notice (screen 8).
- **Deleting the account** (D9): unchanged.

### 3.5 Offline, background, widgets

Exactly as Plus today (D1, D12): the phone's own database is the truth; changes wait in the outbox when offline; a
change from a widget, a notification or the Live Activity goes through `SyncService.scheduleSoon` with its background
time; sync is batched (2 s quiet in the background, 3 s in front, never more than 10 s). Widgets are locked (U28): this
changes nothing in widget code; it only lets `scheduleSoon` run for free accounts.

## 4. What changes on the server

| # | File | Change |
|---|---|---|
| S1 | `server/src/account.ts` | **One signed-in device per free account.** `openSession` for a free account: if another device has a live session, either refuse with `409 other_device_signed_in` (with that device's name, platform, last seen) unless the request says `replace: true`, or, with `replace: true`, end the other session (mark it `ended_reason = signed_in_elsewhere`, keep the device row) and open this one. Plus accounts are never limited. A refund that ends Plus keeps the most recently synced device's session and ends the others |
| S2 | `server/src/worker.ts` | **`POST /v1/sync`**: remove the `plus_required` gate (line ~395); a free account may sync from its one live session. **`POST /v1/auth/*`** takes `replace` (S1) and returns `409 other_device_signed_in` when needed. **Token refresh and sync** for an ended session answer `401 session_ended` with `reason: "signed_in_elsewhere"` and the new device's name. Optionally `GET /v1/sync/status` if the app needs to ask before signing in |
| S3 | `server/src/account.ts`, `snapshots.ts` | Nightly snapshots already start from any change in the Durable Object, so free accounts get them once they sync. **Retention by plan:** free keeps the last **7** nightlies; Plus keeps 90, then the 1st of each month (as now). `prunable` takes the plan |
| S4 | `server/src/snapshotFile.ts`, `worker.ts` | **`GET /v1/snapshots`** and **`/v1/snapshots/{day}`**: allowed for free accounts too (today `plusClaims` refuses them), listing 7 days for free and 90 for Plus (Restore From a Backup, screens 6b, 6c) |
| S5 | `server/src/backup.ts` | Free accounts stop uploading whole files. Keep `PUT/GET /v1/backup` working for older builds until none are in use, then retire it; existing copies expire by the bucket's 365-day lifecycle rule. **No production data exists yet** (Free Plan Backups §5.1: the production bucket is empty), so nothing to migrate in production; dev accounts can be reset |
| S6 | `server/src/tokens.ts` | No change needed: the token keeps `plus`; free accounts sync because S2 lifts the gate |
| S7 | `server/src/report.ts`, `admin.ts` | Daily report: free accounts syncing, "signed in elsewhere" a day, rows written per change, bytes per record (to replace this plan's two estimates) |
| S8 | rate limits, `EVERYONE_PLUS` | Sign-in and sync limits per account as today; the `EVERYONE_PLUS` dev flag (Current Work 68) must not hide free behaviour in tests: test and CI sign-ins choose free or Plus (`plus: false`) |

Server checks (Rulebook T6): `npm test` and `npm run typecheck` pass, with new tests for S1–S4 (a second free device
gets 409 without `replace`; with `replace` the first session ends and its refresh/sync gets `401 session_ended`
`signed_in_elsewhere`; Plus is never limited; a refund keeps the most recent device; snapshot lists 7 vs 90 days); deploy
to **dev** and run the live checks. **Production only through `npm run release:production`, with the user's
go-ahead.**

## 5. What changes in the app

| # | File | Change |
|---|---|---|
| A1 | `iOS/Habits/Model/SyncService.swift` | Sync is no longer Plus-only: replace the `isPlus` gates (`scheduleSoon`, the debounce, `syncNow`) with **signed in**. Bind the account (`repository.bindAccount`) for free sign-ins too, so changes enter the outbox. Handle `401 session_ended` / `signed_in_elsewhere`: sign out locally keeping every habit (as Sign Out), remember the new device's name for the notice |
| A2 | `iOS/Habits/Backup/SignInSheet.swift`, `AccountView.swift` | On `409 other_device_signed_in`: the sheet **Use on This iPad?** (screen 7) → **Continue** retries with `replace: true`; **Cancel** stays signed out. Signed-in pages say **Last Synced** (screen 3) |
| A3 | `iOS/Habits/Backup/BackupCenter.swift` | The backup place follows §3.1: signed in → the account (status = the last sync with nothing waiting, as Plus today, 05 §11.2); signed out → iCloud / Google Drive as you go. **Stop uploading files to `/v1/backup` for free accounts.** iCloud stops only after the first full acknowledged sync (D4); after a sign-out (by the person or by another device) iCloud backs up again at once; the old iCloud copy is never deleted |
| A4 | `iOS/Habits/Backup/BackupSyncView.swift` | Screens 4, 4b, 4c: **Backed up to** lists **iCloud · Google Drive · Your Account** in the same order in every state; the tick shows where the habits are kept. Without an account the account row reads *Create one to sync your habits* and opens the **Create Account** sheet over the page (4e: *A free account syncs your habits on one device and brings them back when you sign in on a new device.*); the footer says *iCloud and Google Drive back up your habits automatically. A free account syncs them on one device and brings them back when you sign in on a new device.*; Google Drive's row says *Connect your Google account*; signed in, iCloud and Google Drive say *Used when you're not signed in*. Status: **Backed up** / **Synced**; action **Back Up Now** / **Sync Now** |
| A5 | App start and return | The old-device alert (screen 8), once, after a sign-out by another device |
| A6 | `iOS/Habits/Backup/RestoreViews.swift` | Restore lists the account's daily copies for free (7 days) and Plus (90 days) from `/v1/snapshots` |
| A7 | Help & Feedback | Topics: what free and Plus sync; using another phone or tablet (it signs the first one out); "Signed out on this iPhone" |
| A8 | Analytics (content-free, Analytics Contract) | `sign_in_replaced_other_device`, `signed_out_elsewhere` |

**Words** (Rulebook U11; "the app", never "Often Enough"): iCloud and Google Drive **back up**, automatically; the account
**syncs**. Free **Syncs this iPhone** / *A free account syncs your habits on one device*;
Plus **Syncs across your devices**; never "active device", "primary device", "one device at a time", "session" or
"handover" on screen.

## 6. Data safety, rule by rule

- **D1:** the phone stays the truth; a signed-out device keeps everything.
- **D3:** signing in merges the device's own habits with the account's, field by field; nothing is deleted. A device
  that was signed out by another and signs in again merges its unsent changes back.
- **D4:** a signed-in device counts as backed up only when the server has acknowledged everything; iCloud / Google
  Drive stop only after that, and start again the moment a device is signed out.
- **D5:** restoring a daily copy keeps the 30-day undo; on Plus it replaces the habits on every device and says so.
- **D8:** test launches never sync or back up real data; the test server stays separate.
- **D12:** free changes from widgets and notifications reach the server without opening the app, exactly like Plus.
- **D14:** every sign-in starts with a full download.
- **Before release:** the iCloud reinstall fix (Current Work 75; commit `8b062cb4` started it) must be finished first.

## 7. Tests (Rulebook T1–T17)

- **Server:** S1–S4 unit tests (§4); dev deploy; live checks with two test devices on a free account: first sign-in, the
  second gets 409, Continue signs the first out (its next sync/refresh gets 401 `signed_in_elsewhere`), both devices'
  changes merge when the first signs back in, snapshot listing 7 vs 90.
- **App model checks:** the states (§3.1) and every transition; `scheduleSoon` runs for free; iCloud stops only after a
  full acknowledged sync and restarts after any sign-out; a 401 `signed_in_elsewhere` signs out and keeps every habit.
- **UI tests** (CI, `-uitest`, with launch flags to simulate the server's answers, e.g. `-test-sign-in other-device`,
  `-test-session-ended elsewhere`): the sheet (Continue / Cancel), the old-device alert and the signed-out Backup &
  Export, Backup & Export rows and order in all three states, the account row opening Create Account, Account's **Last
  Synced**, Restore lists per plan.
- **SE layouts** (T15) for 7 and 8. **Speed** (S2, T4): a `PerfDriver` scenario for each Backup & Export state; sync
  adds no main-thread work per tap (S16).
- **iPhone checks, left for the user (U9):** two real devices on one free account (sign in on the second, the first is
  signed out and keeps everything; sign back in on the first and changes merge), widget and notification changes syncing
  in the background for free (D12, `SyncDeviceTests`), mobile data used in a week.

## 8. Rollout

1. Server S1–S8 to dev; tests and live checks.
2. App A1–A8 on the branch; tests on GitHub; speed run against main.
3. Help, the user's iPhone checks.
4. Server to production with the user's go-ahead, then the app.
5. After launch: replace the two estimates (§2.1) with real numbers from the daily report; watch rows written per change.

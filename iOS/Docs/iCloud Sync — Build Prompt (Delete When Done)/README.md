# Build iCloud Sync with CloudKit (prompt for a cloud session)

Written by Claude (Claude Code), 10 October 2026, at the user's request, for a cloud session to pick up and finish.

> **When the work is done and merged, delete this whole folder** (`iOS/Docs/iCloud Sync — Build Prompt (Delete When
> Done)/`) in your last commit. It is a one-time hand-off, not a document to keep.

## 1. The job

Replace our own server's sync and accounts on the iPhone with **iCloud: CloudKit's private database, synced with
`CKSyncEngine`** (Rulebook D16, decided by the user). The full design is written and researched:
**[Architecture 11 — iCloud Sync with CloudKit](<../../../Architecture/11. iCloud Sync with CloudKit.md>). Build it as
written.** If you find something in it that's wrong or can't work, fix the design document in the same change and say
why; don't silently do something else.

**Data must never be lost. That is the top priority of this work, above speed of delivery and above looks.** When a
case is unclear, keep the data and ask the person; never delete, overwrite or drop anything to make sync simpler.

Build **steps 1–4 of Architecture 11 §21**:

1. **Groundwork:** `CloudTransport` (a protocol) with the real `CKSyncEngine` behind it and a `FakeCloud` for tests;
   `SyncRules.mergeRecord` in the shared core; the `sync_meta.ck_system` migration; `CloudSync` (one engine, state
   saved on every `stateUpdate`, sending from the outbox, fetching into merges) (§5–9).
2. **Accounts, zones and the free plan's one syncing device** (§10–12).
3. **Safety:** the fresh-install wait, the mass-change brake, the dated backup files, the clone check, sending after
   changes made outside the app (§13, §15).
4. **The iCloud page** (replacing the Account page and the sync parts of Backup & Restore), the ≡ row renamed
   "iCloud & Backup", and **removing the code listed in §17**.

**Not in this job:** step 5 (checks on the user's real devices, and deploying the CloudKit schema to Production: the
user does those with a local session afterwards); step 6 (yearly compaction: later, but keep §6's record layout so it
can be added); removing the `server/` folder (only after the device checks pass); Android.

## 2. Read first

1. `RULEBOOK.md`, all of it. Especially D1, D2, D4, D5, D6, D8, D10, D13, D16, S2, S7, T1, T2, T7, T10, T14, T15,
   T17, W1, W3, W6.
2. **Architecture 11** (the design), all of it, then Architecture 05 (the sync rules it keeps).
3. `Core/README.md` and `Core/sync/` (`SyncRules.kt`, `Hlc.kt`), `Core/src/commonMain/.../SyncWriter.kt` and
   `Records.kt`: the outbox, clocks and merge already exist; you're replacing the transport.
4. `iOS/Design Rules — Don't Regress.md`, and the current Account and Backup screens' code before you replace them.
5. `iOS/Docs/Checklists/Current Work Checklist.md`, item 81: tick what you finish.

## 3. Decided by the user (don't reopen)

- **No server holds anyone's habits** (D16). Plus comes from StoreKit (another agent is building the Plus screens).
- **No encrypted fields** (`encryptedValues`): ordinary fields can be recovered after an Apple account recovery;
  encrypted ones can't (Architecture 11 §16).
- **Free plan: one syncing device at a time;** Plus syncs every device (§12). The second-device sheet's wording is
  already decided (the Plus screens prompt, image 16).
- **The mass-change brake: 20% of habits and records, or 50 rows** not from one explicit action (§13.2).
- **Google Drive backup stays exactly as it is** for people who keep iCloud off. Don't build anything new for it and
  don't remove it.
- **Don't touch `server/`** in this work.

## 4. The rules that make data loss impossible (from Architecture 11; every one needs a test)

1. **The phone's database is the truth.** Nothing in iCloud (sign-out, another Apple Account, a full iCloud, the
   person deleting the app's iCloud data, a deleted zone) ever deletes local data. Apple's sample code deletes local
   data on sign-out and on a switch of account: **don't copy that.**
2. **The outbox is the record of what hasn't reached iCloud.** An op leaves it only when CloudKit confirms a saved
   record that contains it. On every launch, re-add every row with outbox ops to the engine's pending saves (the
   engine drops items on `quotaExceeded` and can lose its queue).
3. **Nothing is deleted through sync.** Deletes are the `deleted_at` tombstone field; never a CloudKit record
   deletion, except "Delete my data from iCloud" (a deliberate zone deletion).
4. **Fetched changes are applied in one transaction before the event handler returns**, so the engine's saved
   position never runs ahead of the data.
5. **A different Apple Account, or iCloud data deleted by the person, asks first** (§10–11). Never a silent upload
   into someone else's account, never a silent wipe.
6. **The mass-change brake** pauses and asks, in both directions (§13.2).
7. **A fresh install waits for iCloud** before showing "empty" or adding anything; sample habits never sync (§13.1).
8. **The free plan's old device sends its unsent changes before it stops syncing** (§12).
9. **The iCloud page always tells the truth:** synced, waiting, iCloud full, iCloud off, bringing habits in. No silent
   failure path (§17).

## 5. Apple setup (you can do the code part)

- In `iOS/Habits.entitlements`: add `CloudKit` to `com.apple.developer.icloud-services` beside the existing
  `CloudDocuments` (the container `iCloud.com.oftenenough.app` already exists); add `aps-environment`
  (`development`). In `iOS/Habits-Info.plist`: add the `remote-notification` background mode. Remove
  `com.apple.developer.applesignin` with the sign-in code (§17).
- Automatic signing registers these on the user's Apple Developer account the first time the app is built for their
  iPhone. **You can't do that, and GitHub's simulator can't sign in to iCloud**, so all your tests run against
  `FakeCloud`. Make sure simulator builds still succeed with the new entitlements.
- Use the zone names, record type and fields exactly as §6 says (one `Row` type with fixed fields): the CloudKit
  schema must never need to change.

## 6. The iCloud page

There are no mockups for it. Design it from Architecture 11 §17 and the Rulebook: **status first** (W6), native
SwiftUI, monochrome chrome, clean and minimal, every state the page can be in (synced, waiting, full, off, bringing
habits in, free with this device syncing, free with another device syncing, Plus with its devices), the dated
backups with Restore, Export, Import, and "Delete my data from iCloud" (asks first; the phone keeps its data unless
the person also chooses to erase it). Use the words people use ("iCloud", "Back Up Now", "Restore From a Backup").
The user checks the look on their iPhone afterwards (U9).

## 7. Removing the server code

Remove what Architecture 11 §17 lists (our server sync, accounts, sign-in, moving with a code through the server, and
their tests). Before removing any function, search for every caller, including by its bare name (T17). Keep:
`BackupFolder.swift`, `ICloudLookup.swift`, `RestoreViews.swift`, `GoogleDrive.swift`, the shared core's sync rules.
Rewrite D3, D4, D9, D12, D14 and D15 in the Rulebook to describe the iCloud system, as §17 says (the user decided this
in D16; keep each rule's intent, change only the mechanism), and add a "replaced by Architecture 11" note to
Architecture 01, 02, 04, 05 (its transport section) and 06.

## 8. Tests

- **`FakeCloud`** reproducing every error and event in Architecture 11 §4 and §19: conflicts, the 250-record limit,
  `quotaExceeded`, throttling, network loss mid-batch, `zoneNotFound`, `unknownItem`, a purged zone, sign-out,
  account switch, changes delivered twice or out of order, a crash between applying and saving the state, a lost
  engine state.
- **Unit tests** with `FakeCloud`: two and three devices converge after random interleavings (a property test, many
  runs); the outbox only shrinks on confirmed saves; no fetch, account change or zone deletion ever removes a local
  row; the brake trips at 20% / 50 rows; the free handover flushes first; an extreme account (25,000 records a year
  for 15 years, generated) uploads and fetches within time and memory limits.
- **Shared core:** `./gradlew jvmTest` with `mergeRecord` tests (equals per-clock ops; order-free; idempotent).
- **Migration** (D2): `ck_system` added from every past schema (`MigrationTest`).
- **UI tests:** the iCloud page in each state (a test launch argument drives `FakeCloud`), the second-device sheet,
  iCloud full and off, a different Apple Account; the iPhone SE (T15).
- **Speed:** a `PerfDriver` scenario for the iCloud page and for Today while a big fetch is being applied (T4, S2).
- Run everything on GitHub (T1, T10; at most six or seven UI classes a run; watch each run you start). On Linux,
  `swiftc -parse` every changed Swift file first (T17). `iOS/Tools/perf/check_rules.sh` before every push.
- **A real bug found by a test gets fixed.** Never skip, disable or loosen a test (T2).

## 9. Working alongside others

Another cloud session may be building the **Plus screens** at the same time (`iOS/Docs/Plus Screens — Build Prompt`).
Don't change the Plus screens; merge `main` into your branch often; if you both touch the ≡ menu, keep your change to
the one row's name and destination.

## 10. Finish

1. Work on **a new branch of your own** (for example `icloud-sync`), never directly on `main`. This is big: commit in
   steps, and test each step once it's complete (T7).
2. When the tests pass, **merge into `main`**. Don't rush and don't merge failing work.
3. **Branches:** a cloud session can't delete branches. Once merged, mark your branch and any `-ci` branches **"safe
   to delete"** in `iOS/Docs/Checklists/Merging the Branches.md` (W3), and say so in your summary.
4. Tick item 81's finished points, note what's built in `iOS/Docs/What's Built.md`, and add an "iCloud page" section
   to `iOS/Design Rules — Don't Regress.md`.
5. Write down for the user, in item 81, **exactly what's left for them**: the device checks of Architecture 11 §19,
   deploying the schema to Production in the CloudKit Console before any TestFlight build, then tagging and removing
   `server/`.
6. **Delete this folder** (`iOS/Docs/iCloud Sync — Build Prompt (Delete When Done)/`) in the last commit.

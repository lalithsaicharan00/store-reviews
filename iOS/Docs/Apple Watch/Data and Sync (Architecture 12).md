# 12. Apple Watch — Data and Sync

*Written by Claude (Claude Code), 10 October 2026, as Architecture 12 (kept with the rest of the Watch work in this folder). Step 4 of the user's Watch plan (Current Work 82). Builds on
[11. iCloud Sync with CloudKit](<../../../Architecture/11. iCloud Sync with CloudKit.md>) (being built by another agent, item 81) and the Watch
research ([Apple Watch App report](<Research/Apple Watch App — What People Want, What Breaks, and How Ours Works.md>) §5.3,
[Running a Routine on the Watch](<Research/Running a Routine on the Watch — Can It Be Done.md>)).
Replaces the server-based Watch design in 07 §4.*

## 1. The answer

**The Watch keeps its own full copy of the person's habits, in the same database the iPhone uses (Room, from the
shared Kotlin core). It syncs straight with the iPhone over WatchConnectivity, and, once item 81 lands, with iCloud
too. Both devices are equals: neither is the other's server; every change from either side is merged by the same
`SyncRules`, so it counts once however it arrives.**

| Question | Answer | Why |
|---|---|---|
| Is data stored on the Watch? | **Yes, all of it** (not a window of recent days) | It opens instantly and works with the phone away (WA1). The rules that read history (week, month or year goals, quit runs, best runs, schedules) must give the same answer as the iPhone, so they need the same data. An extreme user's year is about 25,000 logs, a few MB |
| Does it sync with the iPhone? | **Yes, directly** (WatchConnectivity) | Fast, no internet needed, works today, before iCloud sync exists |
| Does it sync with iCloud? | **Yes, after item 81**, with its own `CKSyncEngine` | So it keeps up when the iPhone is off or far away. Apple: WatchConnectivity "can't be your app's primary way of accessing data" |
| Which copy is right? | **Every copy, merged** | Each device's database is its own truth (D1); changes are ops with clocks (HLC) merged field by field, deletes as tombstones (05 §7) |
| Can the Watch lose data? | Only changes it hasn't sent yet, if the Watch is wiped before it reconnects | Changes go to the iPhone within seconds when it's near; the queue survives app restarts |

## 2. What's on the Watch

The same tables as the iPhone: `habit`, `step`, `reminder`, `entry`, `setting`, plus the sync bookkeeping
`sync_meta`, `outbox` and `local_state`. Deleted rows stay as tombstones, as on every device.

- **Not on the Watch:** settings that are local to one device (`SyncCodec.isLocalSetting`, today the Today placement)
  and anything to do with backup files, export or the old server account.
- **Running timers are already synced data:** a running timer is the setting `timer.<habit id>` = start time (and the
  day section), removed when it stops. So a timer started on the iPhone shows on the Watch and can be stopped there
  (R4), with no new table.
- **Day start and week start** are synced settings, so "today" is the same day on both (D7, WA5).
- **Size:** a log is a few hundred bytes. An extreme user (25,000 logs a year, Architecture 11 §14) is about 7–10 MB
  a year with indexes; Architecture 11's yearly compaction applies here too. Watches have 32–64 GB.
- **What's read into memory** (as built, 11 Oct 2026): the database keeps every log, but the app reads its last 400
  days (a year goal's whole year, with room) and every log of a quit habit or a task (their runs and repeats read the
  whole past, and they are few): `HabitRepository.loadSince`, `HabitStore.historyWindowDays`. Measured on the Watch
  simulator for the extreme account (25,000 logs a year for 15 years, 225 MB): reading it all took 27 s and 202 MB of
  memory (run 38109083512), against WA1's "opens at once". The rules above still read the same data for today, the
  week, the month and the year; only a run longer than the window, or a best run before it, can't be counted here, so
  the Watch shows no streak it isn't sure of and no best for a habit with older logs (WA11: not sure, no count). The
  iPhone keeps reading everything.
- **Where:** the Watch app's own container. Its complications and Smart Stack widgets read a small snapshot file in an
  App Group (as the iPhone's widgets do, U26), never the database.
- **A complication's ✓ or +** (as built, 10 Oct 2026): the face changes at once to the app's own "after one tap" card,
  and the tap is written to the waiting-taps file in the App Group (the iPhone's `WidgetTaps` format). The Watch app
  saves waiting taps in order, each once, whenever it runs: on opening, on its background refresh (watchOS allows about
  four an hour with a complication on the face; the app asks for one every 15 minutes) and when the iPhone's changes
  wake it. A watchOS widget's intent runs in the extension, which has no database, so a tap reaches the database at the
  app's next run, not at once; it's on disk from the moment it's made and never lost. To check on the Series 10.
- **Test launches** use an in-memory database and their own App Group folder (D8).

## 3. The two ways changes travel

Both carry the same thing: the ops the core already makes (`SyncCodec` fields, a clock, an op ID, the schema version).

### 3.1 Watch ⇄ iPhone (WatchConnectivity), from the first version

1. **First fill.** When the Watch app first runs with an empty database (or was wiped, or never finished its fill), it
   asks the iPhone for a whole copy, a part at a time. Each part is a **checked file** made by the core
   (`peerFillPart`: a zip with a manifest, a record count and the SHA-256 of its records, made and checked like the
   backup file) sent by `transferFile`; the Watch checks it (`acceptPeerFill`) and **merges** it, never replacing
   anything. A damaged part is refused before anything changes, and asked for again. Habits, steps, reminders and
   settings come first, then logs newest first, so Today is right after the first parts; a fill cut off half-way resumes
   from the last part that arrived. The Watch shows "Getting your habits from your iPhone…" until the last part (A6, WA2).
   *Changed while building (10 Oct 2026):* this said "the core's `backupFile`… merges it in (`restore`, Merge)". A backup
   file carries no sync stamps, so a restore stamps every row anew on the Watch; the copy would then win over edits made
   on the iPhone while it travelled (a rename made after the file left was undone when the Watch sent its "newer" copy
   back). So a fill part carries every field's own stamp and merges exactly as if each change had arrived one by one
   (`PeerSyncTest.theFillNeverOverwritesAChangeMadeWhileItTravelled`). Measured: an extreme account (25,000 logs a year
   for 15 years) fills in 76 parts of at most 73 KB, 22.5 s on GitHub's JVM, a Watch database of 118 MB.
2. **After that, ops both ways.** Each side keeps a small queue for the other device:
   - a new table **`peer_out`** (seq, op ID, op; schema 9), filled in the same transaction as the change (like `outbox`)
     once the device has started its link (`peerStart`: the Watch when it first opens, the iPhone when its Watch first says
     hello or asks for a fill, before the first part is made, so nothing falls between the fill and the queue);
   - sent in batches by `transferUserInfo` (queued by the system, delivered in the background, survives the app being
     closed), 0.5 s after the last change (S16); a large batch (more than ~100 ops) goes as a file;
   - the receiver applies the batch in one transaction (`SyncWriter.receive`) and then acknowledges the highest
     sequence number it saved; the sender deletes up to there. A lost acknowledgement only means a resend, which
     merges as a no-op.
3. **The iPhone passes on what it receives.** The Watch's changes must reach iCloud (and other devices) even while
   the Watch itself isn't syncing with iCloud. So when the iPhone receives an op from the Watch, it also puts it in its
   own `outbox`; and ops the iPhone fetches from iCloud go into `peer_out` for the Watch. **This is the one change to
   today's core:** `receive(op, from = peer)` forwards to the other paths; an op never goes back to where it came from,
   and the op ID (unique in each queue) stops loops. *As built:* only an op that changed something is passed on; one
   that changed nothing is already known here, so it stops (3,000 seeded three-device runs converge, `PeerSyncTest`).
4. **The watch face.** While our complication is on the active face, the iPhone sends batches that change today by
   `transferCurrentComplicationUserInfo` (50 a day, Apple), so the face updates promptly; otherwise by
   `transferUserInfo`. The Watch reloads its widgets after every applied batch.

### 3.2 Watch ⇄ iCloud (after item 81)

- The Watch runs the same `CloudSync` layer as the iPhone (one `CKSyncEngine`, the `Habits` zone, the `Row` record,
  Architecture 11 §6). Plus devices all sync (11 §12), and the Watch is Plus only, so it never competes with the free
  plan's one syncing device.
- A Watch change leaves the Watch's `outbox` only when CloudKit confirms it or a fetch shows iCloud already has it. It
  leaves `peer_out` when the iPhone confirms it. The two are independent; whichever path is quicker wins, and the other
  arrives as a duplicate that merges as nothing.
- The Watch fetches when it opens, on a push, and on background refresh (about four times an hour with a complication
  on the face). It never waits for any of these to show anything (WA1).

## 4. Cases that need care

| Case | What happens | Rule |
|---|---|---|
| The same tap arrives twice (both paths, a retry) | Its entry ID was made at the tap, so it's one row | Already true (`EntryRecord`: "the same tap saved twice counts once") |
| Both devices log +1 at the same moment | Two entries, two IDs: both count, as they should | Additive by design |
| ✓ on the Watch while the iPhone un-ticks the same day | Delete wins (tombstone) | `SyncRules` |
| **The same timer stopped on both devices** (offline, or within a second) | Each stop would log its own entry: **the time counted twice** | **New:** the stop's entry ID is made from the habit ID and the timer's start time, so both stops write the same entry; the later stop's minutes win (HLC). Both remove the `timer.` setting, which is harmless |
| The timer started on both while apart | One `timer.` setting; the later start wins and the earlier start's minutes aren't logged | Rare; the iPhone shows the timer as running from the later start. Accepted for version 1, noted in the tests |
| Logging just after midnight before a 3 AM day start | The day is worked out on the device with the synced day start | D7, WA5 |
| The Watch app is older than the iPhone app (or newer) | Ops carry the schema version; unknown fields are kept and passed on (05 §12); Room migrations are tested from every version (D2) | Same as any two devices |
| The Watch is wiped or unpaired with changes not yet sent | Those changes are lost | Kept small by sending within seconds of each change; said in Help |
| Plus ends | The Watch sends everything waiting, then stops syncing and shows the Plus screen; nothing is deleted (D10) | As the free plan's handover (11 §12) |

## 5. What changes in the code

1. **Core:** add the `watchosArm64`, `watchosDeviceArm64` and `watchosSimulatorArm64` targets (Room 3.0.3 and SQLite
   2.7.1 publish them, checked 10 Oct); add `peer_out` with a migration and its tests (D2); `receive(op, from:)` that
   forwards; the timer-stop entry ID; tests in `jvmTest` with a phone, a Watch and iCloud exchanging ops in random order,
   with duplicates, drops and both stops of one timer (the `LiveSyncTest` pattern).
2. **iPhone app:** a `WatchLink` (WCSession) that sends `peer_out` batches, the first-fill file and acknowledgements,
   and applies what the Watch sends. Nothing else on the iPhone changes.
3. **Watch app:** the same `HabitRepository` and store rules, its own `WatchLink`, the widget snapshot, and later the
   `CloudSync` layer from item 81.

## 6. Building and testing without and with a real Watch

- **GitHub can build and test it.** GitHub's macOS 26 runner (the one our workflow uses) has the watchOS 26 SDKs and
  Watch simulators installed (Series 11 42/46 mm, SE 3, Ultra 3; runner image readme, read 10 Oct 2026). Unit tests,
  the core on watchOS, XCUITest UI tests on the Watch simulator, and speed runs all run there, the same way as the
  iPhone app's. A paired iPhone + Watch simulator pair can exchange `sendMessage` and `transferUserInfo`.
- **What needs the real Watch** (the user's Series 10, watchOS 26): Apple's complication transfers (the Simulator
  doesn't support `transferCurrentComplicationUserInfo`), real iCloud (CI can't sign in), the background refresh
  budget, haptics, Double Tap, Always On, notification buttons pressed on the wrist, and the arm64 build on a Series 9
  or later. As with the iPhone (U9), a visual change is looked at on the real device before it's called done.
- **Installing on the Watch:** from Xcode on the Mac, with the iPhone app (the Watch app ships inside it), as the user
  installs the iPhone app today.

## 7. Decided here, and what's left for the user

- Decided (from the evidence and Apple's rules): full copy on the Watch; WatchConnectivity first, iCloud after
  item 81; the iPhone passes on the Watch's changes; the timer-stop entry ID.
- Nothing new for the user to decide. The open choices from the Watch report §9 still stand (version 1's scope, now
  with routines; watchOS 11 or later; a custom Smart Stack layout for the timer's Live Activity, which needs the
  user's say-so under the widget lock, U28).

## Sources

- Our code: `Core/src/commonMain/kotlin/app/habits/core/` (`Records.kt`, `SyncWriter.kt`, `HabitRepository.kt`,
  `BackupFile.kt`, `Restore.kt`); `iOS/Habits/Model/HabitStore.swift` (`toggleTimer`, `stopTimer`, `Keys.timerPrefix`).
- Apple: [Keeping your watchOS content up to date](https://developer.apple.com/documentation/watchos-apps/keeping-your-watchos-app-s-content-up-to-date);
  [remainingComplicationUserInfoTransfers](https://developer.apple.com/documentation/watchconnectivity/wcsession/remainingcomplicationuserinfotransfers);
  [transferCurrentComplicationUserInfo](https://developer.apple.com/documentation/watchconnectivity/wcsession/transfercurrentcomplicationuserinfo(_:));
  [WKApplicationRefreshBackgroundTask](https://developer.apple.com/documentation/watchkit/wkapplicationrefreshbackgroundtask);
  [CKSyncEngine](https://developer.apple.com/documentation/cloudkit/cksyncengine-4b4w9).
- GitHub: [macOS 26 arm64 runner image](https://github.com/actions/runner-images/blob/main/images/macos/macos-26-arm64-Readme.md)
  (installed SDKs and simulators).
- Kotlin: [Kotlin/Native target support](https://kotlinlang.org/docs/native-target-support.html).

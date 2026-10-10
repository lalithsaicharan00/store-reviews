# Apple Watch — Start Here

Written by Claude (Claude Code), 10 October 2026. Everything for building the Apple Watch app (Current Work 82,
roadmap #65) in one folder: the research, the data and sync design, the designs as pictures, and their notes. No
design-tool links: everything needed is in here.

## What the Watch app is

- **Plus only.** Someone without Plus sees one screen that sells it (G); reminders still reach the wrist for free.
- **Today, on the wrist.** Today's habits and tasks in Today's own order and sections, logged the way Today logs them;
  Day details for one habit (today only); manual logging with the Digital Crown; routines run from the Watch alone;
  complications and Smart Stack widgets that log; reminders and alarms with their buttons.
- **Set up and look back on the iPhone.** Creating and editing habits, the habit page (History, Notes, Progress),
  settings, notes.
- **Its own full copy of the data**, in the same Room database as the iPhone (the shared Kotlin core built for watchOS),
  synced straight with the iPhone over WatchConnectivity, and with iCloud once the CloudKit work (item 81) lands.
- **Native watchOS:** one NavigationStack from Today, two levels at most, the Digital Crown with a touch backup for
  everything, Liquid Glass buttons, SF Compact and SF Symbols; our habit colours and round buttons carry over.

## Read in this order

1. [Research/Apple Watch App — What People Want, What Breaks, and How Ours Works](<Research/Apple Watch App — What People Want, What Breaks, and How Ours Works.md>):
   3,051 App Store reviews that mention a watch, hand-coded; Apple's watchOS facts and limits; rules **WA1–WA13**.
2. [Research/Running a Routine on the Watch — Can It Be Done?](<Research/Running a Routine on the Watch — Can It Be Done.md>):
   Routinery and the other routine apps on the Watch; why routines break there; rules **R1–R9**.
3. [Data and Sync (Architecture 12)](<Data and Sync (Architecture 12).md>): where the data lives, how it travels, the
   cases that need care, what changes in the code, and what GitHub's simulator can and can't test.
4. [Designs/Design Notes](<Designs/Design Notes.md>) with the pictures in [Designs/](<Designs/>): every screen, the
   decisions behind them, and the navigation map.
5. The evidence behind the numbers: [Research/Apple Watch Evidence/](<Research/Apple Watch Evidence/Apple Watch — Review Index.md>)
   (every review by code, the scripts, and a quote check).

## Decided

- Watch app is Plus; it can sell Plus itself (StoreKit on watchOS), Plus Family stays on the iPhone.
- Version 1 includes the routine player (step 1 found routines work on the Watch when built as in R1–R9).
- A full copy of the data on the Watch; WatchConnectivity first, iCloud after item 81; the iPhone passes the Watch's
  changes on; a timer stopped on both devices logs once.
- Day details on the Watch is today only; no notes on the Watch; no habit page.
- Manual logging with the Digital Crown (wheels for time, the last value as the start for amounts), with − / + and
  dictation as touch and voice backups.
- watchOS has no alarm API; the iPhone's AlarmKit alarms appear on the Watch by themselves.

## Still open for the user

- Minimum watchOS 11 (recommended: interactive complications, Double Tap, Live Activities in the Smart Stack; leaves out
  Series 4, 5 and the first SE).
- A custom Smart Stack layout for the timer's Live Activity: touches locked widget code (U28), so only with the user's
  say-so.
- Controls and the Action button (H17): proposed for after version 1.

## Build order (from Architecture 12 and the report)

1. The shared core on watchOS (three new Kotlin targets; core tests on the Watch simulator).
2. The Watch app with its own database: Today, Day details, logging and undo, manual logging.
3. WatchConnectivity both ways (first fill by a checked backup file, then ops with acknowledgements), with the
   counted-once tests.
4. The routine player (R1–R9).
5. Complications and Smart Stack widgets, then logging from them.
6. Notifications and timer alerts, the Plus screens, Siri.
7. `CKSyncEngine` on the Watch, after item 81.
8. Checks on the user's iPhone and Apple Watch Series 10 (watchOS 26): what the simulator can't test is listed in
   Architecture 12 §6.

## Building and testing

GitHub's macOS 26 runner has the watchOS 26 SDKs and Watch simulators (Series 11, SE 3, Ultra 3), so the Watch app is
built and tested there like the iPhone app (Rulebook T1–T17). The real Watch is for complication transfers, real
iCloud, haptics, Double Tap, Always On, notification buttons on the wrist and the final look (U9).

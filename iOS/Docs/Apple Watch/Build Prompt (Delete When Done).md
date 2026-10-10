# Build the Apple Watch App (prompt for a cloud session)

Written by Claude (Claude Code), 11 October 2026, at the user's request, for a cloud session to pick up and finish.

> **When the work is done and merged, delete this file** (`iOS/Docs/Apple Watch/Build Prompt (Delete When Done).md`)
> in your last commit. It is a one-time hand-off. **Keep everything else in `iOS/Docs/Apple Watch/`**: it's the
> Watch's documentation.

## 1. The job

Build the whole Apple Watch app (Current Work 82, roadmap #65): **every screen in `iOS/Docs/Apple Watch/Designs/`**,
its data and sync as **`Data and Sync (Architecture 12).md`** says, the complications and Smart Stack widgets, the
notifications, and the Plus screens. Then test it thoroughly: the UI on the Watch simulator, speed, data reliability
and storage, and syncing between the iPhone and the Watch.

Everything you need is in `iOS/Docs/Apple Watch/`. **Start with its `README.md`**, then read the two research reports,
Architecture 12 and `Designs/Design Notes.md` with every picture. The pictures are mockups at 46 mm (208 × 248 points);
they show layout, hierarchy and behaviour. Build with native watchOS SwiftUI components; where a native component
does it better than the mockup, use the native component. If something in the documents is wrong or can't work, fix
the document in the same change and say why; don't silently do something else.

**Priorities, in order:**
1. **No data is ever lost or counted twice** (Rulebook D1–D10; WA3, WA4).
2. **It never fails to open or waits for the iPhone** (WA1, WA2): the reviews' biggest complaints.
3. **It looks clean, minimal and native on the Watch**, and every screen is thought through (§6).
4. **It's fast** (Rulebook S).

## 2. Read first

1. `RULEBOOK.md`, all of it. Especially S1–S8, S10, S12, S16, D1, D2, D7, D8, D10, D13, U1–U4, U9, U13, U14, U16,
   U19, U25, U26, U28, T1–T4, T7, T10, T12, T14, T15, T17, W1, W3.
2. `iOS/Docs/Apple Watch/` in the README's order: WA1–WA13 (report §5.2), R1–R9 (routines §5), Architecture 12, the
   design notes and pictures A–H.
3. The shared core: `Core/README.md`, `Core/build.gradle.kts`, `Core/src/commonMain/.../Records.kt`, `SyncWriter.kt`,
   `HabitRepository.kt`, `BackupFile.kt`, `Restore.kt`, `Core/sync/` (`SyncRules.kt`, `Hlc.kt`).
4. The iPhone code the Watch mirrors: `iOS/Habits/Model/HabitStore.swift` (logging, `toggleTimer`/`stopTimer`, timers
   as `timer.` settings, `today()`), `Today/TodayRows.swift` (`goalLine`, `rowLine`: the row's words),
   `Today/DayActivity.swift` (Day details' actions and words), `Today/RoutinePlayer.swift`, `Model/ReminderScheduler.swift`
   and `Model/AlarmScheduler.swift` (notification and alarm words, `actionLabel`), `Model/TimerPresence.swift`
   (`goalMessage`), the App Intents (Siri), and `iOS/Docs/Widgets — Taps and Updates (Locked).md` for how the iPhone's
   widgets get their data (the Watch's complications follow the same idea, but don't change the iPhone's widgets).
5. `iOS/Design Rules — Don't Regress.md` and `iOS/Docs/Specs/Routine Player — Design Decisions.md`.
6. `iOS/Docs/Checklists/Current Work Checklist.md`, item 82: tick what you finish.

## 3. Decided (don't reopen)

- **Plus only.** Without Plus the Watch shows G1 and can sell Plus itself (StoreKit `purchase(options:)` on watchOS);
  Plus Family stays on the iPhone. Read Plus the same way the iPhone does (the same StoreKit products; if the iPhone
  has a temporary "everyone is Plus" switch for development, the Watch follows it).
- **What's on the Watch and what stays on the iPhone:** `Designs/Design Notes.md`, first section. Day details on the
  Watch is **today only**; **no notes, no habit page, no settings, no sign-in, no onboarding** on the Watch.
- **Version 1 includes:** Today (A), Day details with every habit type and manual logging (B, H1–H10), the routine
  player (C), notifications and timer alerts (D, H13–H15), complications and Smart Stack widgets (E), the Plus screens
  (G), Siri (H16), the failed-save banner (H18), the 42 mm Watch and larger text (H19–H20).
- **Not in version 1:** controls and the Action button (H17); a custom Smart Stack layout for the iPhone's timer Live
  Activity (it touches the locked widget code, U28: the user decides separately); anything Wear OS.
- **Minimum watchOS 11** (decided by the user, 11 Oct 2026): interactive complications, Double Tap, Live Activities in
  the Smart Stack.
- **Data:** a full copy on the Watch in the same Room database (the shared core built for watchOS); WatchConnectivity
  with the iPhone; the iPhone passes the Watch's changes on; a timer stopped on both devices logs once
  (Architecture 12).
- **Alarms:** watchOS has no alarm API; the iPhone's AlarmKit alarms appear on the Watch by themselves. Build nothing
  for them on the Watch, but make sure their buttons act correctly when pressed there (they run the iPhone's intent).
- **Words:** always the iPhone's ("3/8 glasses", "Every day", "Log manually", "Log amount", "Record a slip", "Add a
  check", "Done", "Not done yet · …"). Read them from the iPhone code, not from memory.

## 4. Structure

- **Targets** (match what's there: bundle IDs under `com.oftenenough.app`, Rulebook U8; the App Group the iPhone uses):
  - a **single-target watchOS app** (SwiftUI, no WatchKit extension), embedded in the iPhone app, e.g. bundle ID
    `com.oftenenough.app.watchkitapp`;
  - a **watchOS widget extension** for the complications and Smart Stack widgets;
  - **new Kotlin targets in `Core/build.gradle.kts`**: `watchosArm64`, `watchosDeviceArm64`, `watchosSimulatorArm64`
    (Room 3.0.3 and SQLite 2.7.1 publish them), with a framework the Watch app links. The build runs on GitHub's Mac.
- **Editing the Xcode project** by hand on Linux: change `iOS/Habits.xcodeproj/project.pbxproj` carefully (new targets,
  build phases, "Embed Watch Content", the Kotlin build phase for watchOS, signing settings as the iPhone targets have
  them). Prove each change with a CI build before going on. Add the Watch scheme and a Watch simulator destination to
  `.github/workflows/ios-tests.yml` (GitHub's macOS 26 runner has watchOS 26 simulators: Series 11 46 mm and 42 mm, SE 3,
  Ultra 3); keep the iPhone jobs as they are.
- **Code sharing:** reuse the iPhone's model code where it can be compiled for watchOS (move pure logic into a shared
  Swift folder both targets compile, rather than copying it). The Watch must compute "today", goals, streaks and words
  exactly as the iPhone does.
- **Data and sync** (Architecture 12 §3–5): the `peer_out` table with its migration (D2); `receive(op, from:)` that
  forwards; the timer-stop entry ID; a `WatchLink` on each side (first fill by a checked backup file over
  `transferFile`, then op batches by `transferUserInfo` with acknowledgements, complication batches by
  `transferCurrentComplicationUserInfo` while ours is on the face). **iCloud on the Watch:** if item 81 (CloudKit,
  another agent) is already merged into `main`, run its `CloudSync` on the Watch as §3.2 says; if not, build behind a
  protocol so it plugs in later, and say so in item 82.
- **Test launches** on the Watch use an in-memory database and their own App Group folder (D8).

## 5. Build every screen

Build every screen in the pictures, in the order of the README's build order, each with its states. Use the design
notes for behaviour. Particular care:

- **The header** sits inside the rounded corners: the large title or the back button and title on the left, the time on
  the right, never touching an edge (the user rejected a header that met the edges). Use the system's navigation bar
  and toolbar placements (`topBarLeading`, `topBarTrailing`, `bottomBar`); don't draw your own.
- **Today (A):** one `NavigationStack`, large title; each time-of-day section has a ▶ button (filled in the Now section,
  grey elsewhere, none for Quitting); rows with the habit's colour fill and the round button; done rows sink after the
  pause; "Undo +1 glass" under the row after a tap.
- **Day details (B):** the dial centred between the header and the bottom bar; the main action in the bottom bar's
  middle; Log manually (pencil) and ⋯ in the corners; today's logs and Skip today below, reached with the Crown.
- **Manual logging:** the Digital Crown with a visible focus, − and + by touch, tap the number to dictate or type
  (`TextField`), hours/minutes wheels for time (B3, B15–B18).
- **Routine (C):** full screen; one habit per vertical page (`TabView` vertical paging), the Crown moves pages and never
  logs (R5); the place is each device's own; timers are start times (R2); end alerts are scheduled notifications (R3).
  No `HKWorkoutSession`; no extended runtime session unless you measure a real gain.
- **Complications (E):** every accessory family; interactive buttons with `requestConfirmation(conditions:
  .lowConfidenceSource)`; read a small snapshot the app writes, never the database; a timeline entry at the next day
  start; names hidden when "Hide names outside the app" is on (counts only; buttons still log).
- **Notifications (D):** the Watch app handles the iPhone's notification actions when pressed on the Watch, saving the
  same change with the same ID (WA13); a timer started on the Watch schedules its own goal alert with the iPhone's
  words, cancelled when the timer stops on either device.
- **Siri (H16):** the iPhone's App Intents (Log a Habit, What's Left Today, Open a Habit) available on the Watch.
- **Plus (G):** all seven states, with StoreKit Testing.
- **Accessibility:** VoiceOver labels on everything (the iPhone's labels), Dynamic Type up to the accessibility sizes
  (H20), Reduce Motion, both 46 mm and 42 mm.

## 6. Make it look good, and check it with screenshots

The user wants the Watch app **clean, minimal and very well spaced**. Think about each screen as you build it: what the
person looks at first, the spacing between groups (small inside one job, larger between jobs), alignment to Apple's
watchOS layout margins, nothing crowded, nothing cut by the round corners, one clear main action.

Then **check every screen from screenshots, not by reasoning:**

1. Add a `WatchScreenshotTests` UI test class that opens every screen and state in the pictures (fixtures via test
   launch arguments) and saves a screenshot of each (`XCUIScreen.main.screenshot()`), on **46 mm and 42 mm**, and the
   main screens again at a large accessibility text size.
2. Have CI export them as PNGs where you can read them (the run's artifacts or the `ci-results` branch, as the iPhone's
   screenshots are handled today).
3. **Look at every screenshot yourself.** Compare it with its picture in `Designs/` and with Apple's watchOS look.
   List every problem: clipping, text cut or wrapping badly, crowding, uneven spacing, misalignment, low contrast,
   anything touching an edge, a control too small to tap, a state that looks broken or empty.
4. Fix them, run again, look again, until the list is empty. Keep the final screenshots for the user (commit them to
   `iOS/Docs/Apple Watch/Built Screens/`, small PNGs).

## 7. Test thoroughly

Everything runs on GitHub (T1). You're on Linux: `swiftc -parse` every changed Swift file first (T17), and
`iOS/Tools/perf/check_rules.sh` before every push. Follow T10 (no other agent's runs or branches; tags only when you
mean to test; your own `-ci2` branches for parallel runs), keep a run to six or seven UI classes, and watch every run
you start until it ends (T1). **A failing test is never assumed to be a flake (T2); a real bug gets fixed; never skip,
disable or loosen a test.**

**Data reliability and storage** (shared core, `./gradlew jvmTest`, and Swift tests):
- A **three-device property test** (iPhone, Watch, a fake iCloud) with random interleavings of logs, undos, deletes,
  skips, timer starts and stops, settings changes; ops delivered late, twice, out of order, or lost and resent; devices
  restarting mid-batch. Every run must converge to the same data on every device, with nothing lost and nothing
  counted twice. Thousands of seeded runs.
- **The cases in Architecture 12 §4**, one test each: the same tap twice; both devices +1 at once; ✓ against un-tick;
  **the same timer stopped on both devices logs once**; started on both while apart; logging after midnight before a
  3 AM day start; an older or newer schema on one side (unknown fields kept); a wiped Watch refilled; Plus ending
  (everything sent first, nothing deleted).
- **First fill:** a checked backup file of an extreme account (25,000 logs a year for 15 years, generated) arrives,
  checks and merges within time and memory limits on the Watch simulator; a damaged file is refused and asked again.
- **`peer_out`:** an op leaves only after the acknowledgement; a lost acknowledgement resends harmlessly; the queue
  survives the app being killed; loops are impossible (an op never goes back where it came from).
- **Migration** (D2): the Watch database upgraded from every past schema, a copy kept first (`MigrationTest`).
- **Test launch isolation** (D8) on the Watch.
- **Storage:** report the Watch database's size for the extreme account and how long Today takes to read it.

**Syncing between the iPhone and the Watch:**
- With a `FakeLink` in unit tests: everything above, both directions.
- **End to end on paired simulators** (`xcrun simctl pair` an iPhone and a Watch simulator in CI): log on the Watch, see
  it on the iPhone; log on the iPhone, see it on the Watch; start a timer on one and stop it on the other; run a routine
  on the Watch while the iPhone is open. If the simulators can't run this reliably in CI, say exactly what didn't work
  and keep the `FakeLink` tests as the proof.

**Speed** (S2: measured, never judged by eye):
- A Watch version of the iPhone's speed harness (`PerfDriver`-style scenarios driven by launch arguments, with the
  main-thread stall meter), not XCUITest timing. Scenarios: opening the app to a usable Today (cold and warm); a tap to
  the filled button; scrolling Today with 30 habits; opening Day details; turning the Crown in manual logging; paging a
  routine; applying a large incoming batch while Today is on screen; writing the complication snapshot.
- Targets: hitch time under 5 ms/s, no freeze of 100 ms or more, a tap's feedback in the next frame; report the cold
  launch time to a usable Today. Measure with a year of history and with the extreme account.

**UI tests:** every screen's main path and states (Today, every Day details type, manual logging, routine, Plus with
StoreKit Testing, the empty and first-launch states), on 46 mm and 42 mm (T15-style frames on one line, T14).

## 8. Working alongside others

Other cloud sessions may be building **iCloud sync** (item 81) and the **Plus screens** on their own branches. Don't
change their code; merge `main` into your branch often. Touch the iPhone app only where Architecture 12 §5 says (the
`WatchLink`, and the shared code you move so both targets compile it). **Don't change the iPhone's widgets or their
data flow** (U28, locked).

## 9. Finish

1. Work on **a new branch of your own**, `apple-watch`, never directly on `main`. This is big: commit in steps and
   test each step once it's complete (T7).
2. When everything above passes, **merge into `main`**. Don't rush and don't merge failing work.
3. **Branches:** a cloud session can't delete branches. Once merged, mark `apple-watch` and any `-ci` branches **"safe to
   delete"** in `iOS/Docs/Checklists/Merging the Branches.md` (W3), and say so in your summary.
4. Tick item 82's finished points; add the Watch to `iOS/Docs/What's Built.md`; add an "Apple Watch" section to
   `iOS/Design Rules — Don't Regress.md`; add **WA1–WA13 and R1–R9 to the Rulebook** as U rules, now that they're built
   (with the date and where they came from), and any new rule you learned the hard way.
5. Write down in item 82, for the user, **what's left for them on their iPhone and Apple Watch Series 10 (watchOS 26)**:
   installing from Xcode; the checks in Architecture 12 §6 that the simulator can't do (complication transfers, real
   iCloud, haptics, Double Tap, Always On, notification and alarm buttons on the wrist, the arm64 build); and looking at
   every screen on the real Watch (U9).
6. **Delete this file** in the last commit.

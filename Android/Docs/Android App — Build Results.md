# Android App — Build Results

Written by Claude (Claude Code), 13 October 2026, building the Android app on `claude/android-app` (Current Work 107,
[the build prompt](<Build Prompt — Android App (Delete When Done).md>)). One section per checkpoint: what's built, what
was measured, what's ported outside the core for now, and what needs the user. How to build and run it:
[`Android/README.md`](<../README.md>).

**Continued 13 October 2026** by a second session on the user's Windows PC (its own Android SDK and the Pixel 10
emulator first, GitHub second). The first session's [handoff](<Android App — Handoff for the Next Agent.md>) is history
now: everything it parked in `Android/WIP/` is built. **Where it stands is this page**; what's left is in
"What's left" at the end.

## Checkpoint 1 — Skeleton (13 October 2026)

### Built

- **The Gradle project** (`Android/`): AGP 9.4.1, Gradle 9.8.1, Kotlin 2.4.20, Compose BOM 2026.09.00 (Material 3
  1.4), Room 3.0.3, compileSdk/targetSdk 37, minSdk 26. Versions were read from Google's Maven by a probe run on
  GitHub (Google's Maven isn't reachable from the cloud session).
- **The core on Android:** one additive commit to `Core/` (`a508f0a`): the Android target and Room 3's Android
  compiler, switched on only when Android builds the core (`core.android=true`); `Core`'s own CI stayed green. No
  change to `Core/rules/src`, `Core/spec`, `Core/fixtures` or `Core/schemas`.
- **The adapter** (`data/RulesGateway.kt`): the only file that imports `app.habits.rules`. It turns the app's habits
  and the iPhone's settings rows into `RulesInput`, keeps `LiveRules` current as logs change, and answers every rule
  the screens need (the day a log belongs to, due days, goals, progress, streaks, quit runs, where habits show on
  Today, the day bar's count). `claude/shared-habit-rules-switch` was never checked out, merged or touched; when it
  lands, only this file should change.
- **The database:** the core's `HabitRepository` (Room 3, bundled SQLite) in the app's files, opened once per process;
  a test launch gets an in-memory one (D8). Habits, logs and settings are stored exactly as the iPhone stores them
  (the same settings keys and Swift JSON: `SwiftJson.kt`, tested), so a backup moves between the two.
- **The store** (`data/HabitStore.kt`): a tap changes the screen at once and the write follows, in order (S7); history
  is worked out once and remembered (S5); each habit has its own revision, so a log redraws only its row (S6).
- **Screens:** the welcome both ways (new: three pages, Your days and weeks, Your first habit; coming back: Welcome
  back), Today (sections, every kind of row, Quit or cut down, paused habits, the empty states), the day bar (‹ day ›
  with its ring and count, Go to a day, Back to today), logging and undo for every kind (✓, +N, a week count, ▶/⏸,
  checklist steps, a slip, a task), the long-press menu, light and dark themes, the launcher icon (Brand's tonal mark).
- **CI** (`.github/workflows/android.yml`): every push that changes `Android/**` builds, runs the unit tests and lint;
  `[android-ci]` or a manual run adds the emulator's UI tests (Pixel 6, API 35).

### Tested

- Unit tests (JVM): the iPhone's words case for case (`WordsTest`), the stored formats (`SwiftJsonTest`), the form's
  rules (`FormRulesTest`). Green: run 38319381690 (build, unit tests, lint).
- UI tests on the emulator (`TodayTest`): the welcome both ways, an idea opening the form, logging and undo for a
  check, an amount, a week count, a checklist step, a timer, a quit habit and a task, and the day bar.
  Run 38342494305: 9 of 11 (the tests assumed habits the demo already shows done; fixed). Run 38343622250 (`451d8b1`):
  10 of 11; `aChecklistTicksAStep` tapped a step row composed past the list's edge. `be1b22e` scrolls to it first;
  its run (38369953627) was cancelled by the handoff push before the emulator ran. **Final result (13 Oct, `c7e281a`):
  11 of 11**, on the user's PC (Pixel 10 emulator, Android 16 / API 36, 31.8 s) and on CI's emulator (API 35, run
  38373182612). Two fixes were needed first, both in the tests:
  - **Android 16:** every test failed before its first tap (`NoSuchMethodException: InputManager.getInstance`): Compose's
    test rule brought an older Espresso that calls a method API 36 removed. `espresso-core:3.7.0` is now pinned for the
    instrumented tests. CI's API 35 emulator never showed it.
  - **The checklist test** (`aChecklistTicksAStep`): the tap worked (Skincare read "2/4 steps" with "Undo Last Step"),
    but the after-log line that appears under the row pushed Serum's step past the list's edge, so the check found no
    "Undo Serum". `be1b22e`'s scroll before the tap wasn't enough; a test's wait now scrolls the list to what it waits
    for.

### Found and fixed on the way

- A habit in two parts of the day (Morning and Evening) must tick each part on its own: the adapter dropped each
  placement's slot. Fixed before it shipped anywhere.
- The welcome navigated to its next page before the app's navigation existed (it would have thrown). The page now
  opens once it does.
- My first test of the sentence copied the iPhone's doc comment ("Coffee: at most 3 coffees a day"); the iPhone's code
  leaves out a name that only repeats the unit ("At most 3 coffees a day"). The Android code already matched the
  code; the test was corrected to the code, with the named case added.

## Checkpoint 2 — Every screen (in progress, 13 October 2026)

- **Habit details, Progress, the routine player and the timer** (parked in `Android/WIP/`): compiled as written; their
  word tests pass (`PlayerWordsTest` 6, `ProgressWordsTest` 7); routed (`habit/{id}`, ≡ › Progress, `routine/…`,
  `timer/{id}`). Each page that opens Day details holds its own sheet, so going back to it returns to the open sheet.
  Checked on the Pixel 10 emulator with the demo: History, Progress tab, Progress Week, the player on Morning.
- **Help & Feedback** (search at the top, Contact us, Show the welcome again, every topic opened in place) and
  **About** (the tonal mark, version, the name, privacy, acknowledgements, Open source licences). Help's answers are the
  iPhone's, rewritten to name Android's own controls and to say "log" (Current Work 102); two iPhone topics are left
  out because Android has no such option (Progress's View Options: Full Day, Show Streaks).
- **Pause** (one habit or several; the iPhone's PauseSheet as a page, its words tested), **the Habits and Tasks lists**
  (tap for the page; a long press chooses several for Pause, Archive or Delete, which asks first and offers Archive:
  never on a swipe, U14), **New straight to a task** from ≡ › Tasks' +.
- **Reminders** (design §15): the reminder check (notifications, exact times, battery, each with its fix), a reminder
  that didn't arrive (the reminder code now keeps the alarm it planned and notes one that fired over 10 minutes late or
  never; the reason names the phone's maker), habits with and without reminders.
- **Privacy & Security and App lock** (design §19): `MainActivity` is a `FragmentActivity` for Android's prompt; the
  phone's lock or a six-digit app passcode (a salted PBKDF2 hash only); wrong codes wait as on the iPhone (1, 5, 15
  minutes, then an hour, after 5 in a row); Forgot app passcode? through the phone's lock, or a 24-hour reset when the
  phone has none; Lock again; locking the phone locks the app. While locked the app is hidden from TalkBack and from
  the recents screenshot, and names are hidden outside the app. App lock, the reminder alarm's state and test launches'
  files are left out of Android's backup (`res/xml`), so after moving phones App lock is off and the habits are there.
- **Plus** (design §20): buy (the free habits line, the two plans, what Plus adds, Get Plus and Restore purchases
  pinned) and Plus is yours (the family upgrade for the difference), behind `PlusStore`: `FakePlusStore` in debug
  builds and tests, `NoPlusStore` in a release build until Play Billing is connected (checkpoint 3).
- **Today's Filter and groups**: all habits or one group (each with how many it shows on the day open), New group, Edit
  groups, hide completed habits and tasks; the group form (name, colour, its habits, Pause these habits, Delete group).
- **Arrange your day**: every habit in each time of day; drag the handle (TalkBack: Move up, Move down); each card's ⋮
  renames, retimes, sorts or deletes a time of day and moves Anytime and Quit or cut down.
- **Dark mode:** every screen toured on the Pixel 10 emulator with the system in dark (Material 3's dark roles). All
  readable; nothing missing.
- **Tests:** unit tests 48, all green (new: `PauseWordsTest`, `ReminderWordsTest`, `AppLockTest`, `ArrangeTest`);
  `ScreensTest` (10: Habit details and its tabs, Progress, a routine, Pause, archiving from Habits, a group filtering
  Today, Arrange's Move up, Help's search, Plus with the stand-in store, App lock with a passcode) 10 of 10 on the Pixel
  10 emulator (API 36, 47 s) and with `TodayTest` on CI's emulator (API 35, run 38381027895, `85b8cb5`); lint green.

### Found and fixed on the way (checkpoint 2)

- **Back with the menu open left the app.** Back now closes the drawer first.
- **A drag in Arrange your day did nothing:** the drag's end handler kept the drop position from the composition it was
  made in (always −1). It's now worked out from the live drag when the finger lifts.
- **UI Automator couldn't see a sheet's controls:** a bottom sheet is its own window, so the root's
  `testTagsAsResourceId` doesn't reach it; Day details and Filter set it too (Macrobenchmark needs this).
- **Messages from pages other than Today never showed** (their snackbar host was Today's): every other page now shows
  them at the bottom.

### Decisions to confirm with the user

- **Share usage** shows "Not available yet" like crash diagnostics, not the design's switch: the Android app sends
  nothing, so a switch would promise something that doesn't exist.
- **The Habits list** has no drag to reorder (Arrange your day does that) and no swipe actions (U14).

## Checkpoint 3 — Data out of the phone (the parts that don't need the user's Google set-up, 13 October 2026)

- **Google Drive rounds on a schedule** (`SyncSchedule`, WorkManager): a change anywhere (the app, a reminder's Done, a
  widget) sends one round 3 s after changes stop, the app open or not (D12); a round every 6 hours in the background;
  on open and about once a minute while on screen. Only with Drive connected and the welcome finished (D14); never for
  a test launch (D8). Sync's own reload is marked, so it never schedules another round.
- **App lock, Plus behind its store seam, reminders' check:** built in checkpoint 2 (above).
- **Reminders, the rest of design §15:** "Remind me with" a notification or an alarm (A11 D3: set as Android's alarm
  clock, on its own channel with the phone's alarm sound, ringing until answered; never a full screen), and **Get
  reminders on time**: turning reminders on asks Android's own notification question, then our sheet when exact times
  aren't allowed yet (never in a test launch, T18). Seen on the Pixel 10 emulator.
- **Still waiting on the user:** the OAuth client (real Drive sign-in and the two-emulator sync test), the Play Console
  app (real purchases).

## Checkpoint 4 — Widgets (13 October 2026)

### Built

- **Six Glance widgets**, fixed sizes (design §23): One habit 2×2, Today 4×2 and 4×4, This week 4×2, Tasks 4×2 and
  4×4, each drawing only the app's snapshot (`WidgetItems`, the store's own functions, U26) and its own choice.
- **Every state** (§25): choose a habit, habit removed, no habits yet, nothing planned, section unavailable, open to
  update, without Plus (Today and This week are Plus; they never block or go blank), Large pages (5 rows, ‹ 1/2 ›),
  names hidden (icons and numbers stay).
- **The setup screen** (§24): choose a habit, or all of today or one time of day; a Plus widget without Plus says what
  it does and can be added either way. Android's Reconfigure opens the same screen.
- **The tap (the iPhone's locked rules W1–W18, on Android):** a widget's action runs in the app's own process, so the
  iPhone's hand-over is one step: the tap is written to a durable queue first, the card becomes its app-made "after"
  and every widget redraws, the store saves it idempotently (a + by its own ID, a ✓ as the state it set, a timer as the
  state it set), it leaves the queue only once saved, and the widgets are republished holding their order. The save's
  change asks for a Drive round and reminders like any other (D12). Waiting taps are saved on launch and on every
  return. ▶/⏸ start and stop on the widget; a checklist, a slip, a typed number and the rest of a row open their
  screen, replacing what was open (W8, W9).
- **Up to date:** published 0.5 s after the last change and at once when the app leaves the screen (W11); one alarm
  redraws at the day's start (the snapshot holds seven days), and at the moments a quit run's clock passes an hour or a
  day. Live counts (a running timer, a quit run) tick with Android's own chronometer, so nothing redraws each second.
- **D8:** a test launch never publishes, and never saves or removes the person's waiting taps.

### Measured on the Pixel 10 emulator (API 36), from screen recordings decoded straight through (T11)

| What | Result |
|---|---|
| A +1 on the Today 4×4 widget, the touch's first frame to the row's new count and fill | 373, 383 and 466 ms (three taps); it was ~900 ms before the decoded snapshot was kept in memory |
| Inside the tap (log lines): the queue and the card's "after" written | 69 ms; the redraw asked 36 ms; saved in the store and republished 530 ms later, behind the visible change |
| Five +1 in a row, then three 0.25 s apart | 3 → 8, then 8 → 11 on the widget and in the app; the queue empty after each |
| A ✓ on a task, then again | the whole card and "1 of 1 done" change, then go back; saved as not done |
| ▶ then ⏸ on Read | the timer starts and stops on the widget; the launcher stays in front; the clock ticks |
| ↗ on a quit habit | opens Add slip directly |

### Tested

`WidgetDataTest` (8, on the emulator against a real store): the snapshot agrees with Today; a + card carries five taps
ahead; a check card its flipped day; a + is saved once however often it's sent; a check as the state it set; a timer
as the state it set; a quit habit's best counts the run going on; names left out when hidden.

### Found and fixed on the way

- **The fifth row of a Large widget was missing:** a Glance container holds at most 10 children; the rows have their
  own column now.
- **A quit run read "47d 01:22":** Android's chronometer leaves out the hour under an hour and can't turn a day. An
  "0:" is drawn until then and one alarm redraws at those moments.
- **A quit habit's best run disagreed with Today** (12 days against 47): the widget counted finished runs only.
- **Each redraw parsed the snapshot file three times** (17–52 ms each): it's kept decoded in memory.

### Different from the iPhone, by the Android design (to confirm)

- A week or month goal's row says "2 of 3 this week" (the iPhone's widget: "0 today · 3 a week").
- A task with nothing else to say says how often it comes ("Once", "Every month"); the iPhone's line is empty.

### Still to do for widgets

- Home-screen tests that tap the placed widget on CI (UI Automator): today the taps were driven by hand on the PC's
  emulator. The launcher's own preview shows Glance's loading card until the widget is placed.
- Real phones (Pixel, Samsung, Xiaomi): how fast a tap shows there, and each maker's launcher.

## Checkpoint 5 — Proof (13 October 2026)

### Speed (`SpeedTest`; Pixel 10 emulator, API 36, a debug build; 30 habits, 21,477 logs over two years)

The frames Android itself drew (JankStats and FrameMetrics) under real system touches (UI Automator), beside a control
in the same run. Three runs; the last:

| Scenario | Frames | p50 | p95 | Worst frame | Frames ≥ 32 ms | ≥ 100 ms |
|---|---|---|---|---|---|---|
| Control: Help scrolled (a static page) | 125 | 6.3 ms | 8.2 ms | 16.3 ms | 0 | 0 |
| Today scrolled | 188 | 2.4 ms | 7.0 ms | 12.2 ms | 0 | 0 |
| Day details opened | 46 | 4.7 ms | 18.1 ms | 89.2 ms | 1 | 0 |
| Progress Week scrolled | 127 | 4.7 ms | 11.1 ms | 16.6 ms | 0 | 0 |
| Progress: Week → Year | 61 | 4.7 ms | 36.0 ms | 93.2 ms | 10 | 0 |
| Progress Year scrolled | 119 | 4.8 ms | 15.4 ms | 34.1 ms | 2 | 0 |
| Habits list scrolled | 197 | 4.6 ms | 8.2 ms | 11.2 ms | 0 | 0 |
| Habit details opened | 45 | 4.3 ms | 4.8 ms | 28.7 ms | 0 | 0 |
| Habit History scrolled | 131 | 5.3 ms | 8.4 ms | 11.0 ms | 0 | 0 |
| Habit Progress scrolled | 150 | 3.6 ms | 7.9 ms | 19.5 ms | 0 | 0 |

- **No frame of 100 ms in any scenario.** Every scroll's worst frame is within twice the control's.
- **Found and fixed by it:** switching Progress to Year worked out all 30 habits' years in one go, **709 ms on the main
  thread** (a frozen tap). The cards are now built a few per frame (`ProgressBuilder`): the period and the first cards
  show at once and the rest follow; the worst frame is ~92 ms.
- **Still open:** Day details' first frame (~88 ms) and Week → Year's (~92 ms) are over the 50 ms target for opening a
  screen; both are one frame in a debug build on an emulator. Judge them on a phone with a release build (T5).
- **A lesson the iPhone had already paid for (S2):** the first version of this test drove the app through the Compose
  test rule and read 5–7 frames of 100–250 ms on Progress and History. Those frames had 0 ms of layout and ~10 ms of
  draw: the rest was the test's own clock. With real touches the same screens are the numbers above. One reading was
  repeated before it was believed: a 322 ms frame on opening Habit details appeared once in four runs (28–30 ms in the
  others).
- **Not done:** Macrobenchmark and a Baseline Profile (they need a separate benchmark module and a release-like build;
  `androidx.baselineprofile` is in the build files but unused), startup time, typing in a form.

### Data safety (`DataSafetyTest`, 5, on the emulator against the real database code)

A backup file comes back whole (every habit, log and note) and its restore undoes; Merge of the same data changes
nothing and adds nothing twice; an empty file is never passed off as a restore (D5); a file that isn't a backup is
refused and changes nothing; 40 quick taps all show before any write finishes and are all saved, in order (S7).
Migrations from every past schema are the core's own tests (`core-tests.yml`).

### Tablets and unfolded foldables (A11 D9; the iPad's decisions, U35)

From 840 dp wide the menu is a sidebar that stays, with how many are left beside Today, and the page beside it is one
centred column at most 720 dp wide: the phone's cards at their own size, never stretched. A sidebar choice replaces
the page and never piles pages up. Below 840 dp (a phone, a folded foldable, a small tablet in portrait) the app is
the phone's, exactly: nothing changes for it. `TabletTest` (3) sets the emulator to 1280 × 800 dp for its own run and
puts it back. **Not built from the iPad's set:** a list beside a habit's page, Progress two cards across, popovers,
keyboard shortcuts.

### Also built: the app icon's shortcuts (A11 D8)

Long-press the app icon: **Today**, **Start routine** (the time of day that is now if it has anything left, else the
next card down Today that does) and **New habit**; no badge count on the icon (a count of what's left reads as "due",
U3). Each opens its screen directly, as a widget's link does. Tested in `ScreensTest`.

### Everything, together

Unit tests 52, lint, and 41 emulator tests (`TodayTest` 11, `ScreensTest` 13, `WidgetDataTest` 8, `DataSafetyTest` 5,
`TabletTest` 3, `SpeedTest` 1): green on the Pixel 10 emulator (API 36). **CI (GitHub's API 35 emulator): all 41 green, run 38399799226**
(commit `31d0f7e2`).

Getting there took three CI runs, and each failure was read, not rerun (T2):

- **Run 38390489090, 6 failures:** the back key and everything UI Automator did (`SpeedTest`, `TabletTest`) failed,
  because something of the system's had the focus instead of the app. Tests that need the front window now close system
  dialogs first (`TestDevice.clear`), and a failure names the window that had the focus and what was showing (T14).
- **Run 38396646458, 2 failures, both real:** (1) a crash in Today, `ConcurrentModificationException`: the demo's reload
  resumed on the database's thread and rebuilt the logs while Today was reading them. `HabitStore.load` now always runs
  on the store's own dispatcher, whoever calls it. (2) In the group form on CI's shorter screen the habit row was below
  the fold, so the tap missed it and an empty group was saved: the test brings a row on screen before tapping, and
  checks it's chosen before saving.

## The habit form, as Figma `1302:2` (18 October 2026)

New habit and Edit habit were rebuilt to the Figma section, frame by frame (Current Work 131): the choices, the four
build forms, Quit, Cut down and Task, and every page they open; Edit habit's Type row, the start-over question and
Today's snackbar (D6); Add a 6th habit and Make room. **A time of day is set by its start alone** (Current Work 108, 98):
`SectionPlan.fromStart` works out its end (the next one's start, or the day's end) and `SectionPlan.freeStart` opens a
new one in time nothing covers (4:00 AM with the standard set). The same page opens from Settings › Times of Day.

How it was checked: every frame beside the emulator at 360 × 800 dp (`Research/Temp/habitform/walk.sh`, which uses
only the app's own back buttons); Android's notification question on a normal launch, allowed, refused once and twice;
`HabitFormTest` (6) for the flows that change data. One thing found and left for a decision: without exact alarms,
Android gives a reminder a one-hour window, while Get reminders on time says "up to 10 minutes" (Current Work 131).

## The Habits page, as Figma `2106:2` (19 October 2026)

≡ › Habits was rebuilt to the Figma section (Current Work 132): rows by time of day as on Today (or by group), each with
the line under its name worked out in `HabitListWords.kt` (goal · How often · first reminder, or its status), a ⋮ per
row, selection with its bottom bar, search, Show by, and Archived habits as a page of its own. Every change says so in a
snackbar with Undo; **a delete waits until its Undo has gone** (the rows hide meanwhile, and leaving the page deletes
them), so nothing is lost to a mis-tap (D6). Duplicate is the habit form filled in from the habit (`FormState`'s
`template`) and lands right after it (`HabitStore.placeAfter`, queued behind the add). The page has its own ☰ drawer
(`WithMenu` in `AppRoot`), as a top-level page should; with the sidebar there's none.

Test launches can now start with the design's habits (`demo habits`) and with Plus (`plus`), so the page can be put
beside Figma at 360 × 800 dp. `HabitsPageTest` (11) covers every flow that changes data.

## The Tasks page, as Figma `2373:2` (19 October 2026)

≡ › Tasks was rebuilt to the Figma section (Current Work 133), replacing the old shared list (`AllHabits.kt`, removed).
Two tabs: **One-time** lists every one-time task by when (Today with the ones carried from earlier days first, saying
"Planned for Thu 16 Oct", and the ones done today struck at its end; Tomorrow; the next days by name; later by month;
**No date** last), then the Archived row; **Repeating** lists each repeating task once, grouped by how often it comes,
with three lines: its rhythm, its day ("Waiting since", "Today" or "Next"), and when it was last done or skipped. A
row's ⋮ edits, moves (Tomorrow, Pick a day…, No date; a repeating task moves only this time, before its next one),
duplicates, skips this time (repeating), archives or deletes; a No date row has Do today and Pick a day…; every change
says so with Undo and a delete waits for its Undo (D6). A long press selects (the bar: Move, Archive, Delete); within a
day it lifts the row to drag it. Search lists open tasks, Completed and Archived; the top ⋮ holds Select, **Completed
tasks** (every finish by the day it was done, Mark as not done with Undo, completed one-time tasks deleted with Undo)
and **Archived tasks** (the Archived habits page for tasks). A task's details have its History as events (Waiting, Done
or Skipped, Task created), the archived card with Restore, and a ⋮ of Edit task, Move to another day…, Mark as not done,
Archive, Delete task…. The task form's Date is a menu (Today, Tomorrow, Pick a date…, No date). The menu's Tasks count
is the tasks still open today.

**No date is stored as the last day there is (9999-12-31, `NO_DATE_DAY`)**, so the core's rules (and the iPhone's)
answer "not due" without a change, and the record syncs as an ordinary date. The words for it are in `TaskWords.kt`
(`// MOVE TO CORE`). **The iPhone doesn't know this rule yet:** a No date task synced to it would never show on Today
(right), but its Day details, habit page and widgets would say "Planned for" 31 Dec 9999 until it learns it.

The Habits page's top ⋮ now ends with **Archived habits** (Figma `2106:2`), beside the list's last row.

Test launches can start with the design's tasks (`demo tasks`). `TasksPageTest` (12) covers every flow that changes
data; `HabitsPageTest` gained the ⋮ › Archived habits check. Checked on the Pixel 10 Pro emulator at 360 × 800 dp
beside the frames.

## What's left

| What | Why it isn't done |
|---|---|
| Real Google Drive sign-in, the two-emulator sync test, the real-Drive check | Needs the user's Android OAuth client |
| Play Billing for real, and how Plus Family reaches a family | Needs the user's Play Console app, and a decision |
| A stable debug key in CI's secrets | The user's to add (below) |
| Home-screen tests that tap a placed widget on CI | The widget taps were driven by hand on the PC's emulator and measured from screen recordings |
| Macrobenchmark, a Baseline Profile, startup time, typing speed | Not built |
| The iPad's wider layouts (list beside page, two cards across, popovers, shortcuts) | Only the sidebar and the centred column are built |
| The running timer as Android 16's Live Update | An ongoing notification with Stop and save exists; the Live Update API isn't used yet |
| Usage sharing; a Quick Settings tile (D8, "later") | Not built |
| Real phones: a Pixel, a Samsung, a Xiaomi (U9, T5) | The user's check |

**For the owner of `Core/`:** the core's database is at version 10, but `Core/schemas` holds files only up to 9. Every
build exports `10.json`; it was never committed (this work may not touch `Core/schemas`, so it's left untracked).

## Ported outside the core for now (`// MOVE TO CORE`)

Each is ported from the Swift with tests, and should move into `Core` when the shared rules grow to cover it:

| File | From the iPhone | What |
|---|---|---|
| `data/Words.kt` | `HabitCopy.swift`, `Words.swift`, `Format` | Numbers, amounts, minutes, how often in words, the habit's sentence, day names, clock times |
| `data/StoreWords.kt` | `HabitStore` words, `Entry` descriptions | Today's row lines, Day details' status, "Undo +1 glass", where a log came from |
| `data/HowOften.kt` | `HowOften.swift`, `HabitDefaults` | The form's How often choices, what each saves, the step + adds when the person doesn't say |
| `data/FormWords.kt` | `Outcome.swift` | The form's live sentences under Time of Day and Reminders |
| `data/SectionPlan.kt` | `SectionPlan.swift` | Adding or editing a time of day: each ends where the next begins, overlaps split |
| `data/HabitPageWords.kt`, `ProgressWords.kt`, `PlayerWords.kt` | `HabitPageView` and friends, `ProgressScreen`, `RoutinePlayer` | Habit details', Progress's and the player's numbers and words |
| `data/widgets/WidgetItems.kt`, `WidgetSnapshot.kt` | `HabitStore+Widgets.swift`, `WidgetSnapshot.swift` | The widgets' snapshot: seven days of cards, Today's lists, each ✓ and + card's "after" |
| `data/TaskWords.kt` | None yet: the iPhone has no Tasks page of this design | The Tasks page's days, lines, rhythm groups, next day and History; No date |
| `ui/habit/PauseScreen.kt` (`pauseSummary`), `ui/settings/RemindersSettings.kt` (`reminderLine`) | `PauseSheet.swift`, `RemindersView.swift` | Pause's sentence; a habit's reminders in one line |

## What needs the user

- **Google sign-in (Drive):** an **Android OAuth client** for package `com.oftenenough.app`, scope `drive.appdata`,
  with the debug and release SHA-1. Until it arrives, sign-in and Drive run on the core's stand-in Drive.
- **A stable debug key for CI** (D11: never in the repository or a chat). A cloud session can't create GitHub secrets,
  so on your computer, once:
  ```sh
  keytool -genkeypair -v -keystore oftenenough-debug.keystore -alias oftenenough-debug -keyalg RSA -keysize 2048 -validity 10000 -dname "CN=Often Enough Debug"
  base64 -i oftenenough-debug.keystore | gh secret set ANDROID_DEBUG_KEYSTORE_BASE64 -R lalithsaicharan00/store-reviews
  gh secret set ANDROID_DEBUG_KEYSTORE_PASSWORD -R lalithsaicharan00/store-reviews
  ```
  The next Android run prints its SHA-1 ("Debug key fingerprint"), for the OAuth client.
- **The Play Console app** for Play Billing: the products `com.oftenenough.app.plus` ($24.99),
  `com.oftenenough.app.plusfamily` ($59.99) and `com.oftenenough.app.plusfamily.upgrade` (the difference), and
  license testers. Until then Plus runs on a fake store.
- **Real phones** (Pixel, Samsung, Xiaomi; U9, T5): noted separately at the end.

## Questions for the next report

- How Plus Family should reach a family on Google Play (Play's Family Library only shares some purchases): to decide
  before anything irreversible in the Play Console.

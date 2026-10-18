# Android App — Handoff for the Next Agent

> **History (13 October 2026).** A second session took this over the same day and built what it lists: the parked
> screens and widgets from `Android/WIP/` (that folder is gone), every remaining screen, and checkpoints 1 to 5 as far
> as they can go without the user's Google set-up. **The current state is in
> [Android App — Build Results](<Android App — Build Results.md>)**, with what's left at its end. Read this page only
> for how the first session reasoned.

Written by Claude (Claude Code), 13 October 2026, when the user stopped this session and asked for everything to be
written down so another agent can continue on `claude/android-app` (Current Work 107). Read this first, then the
[build prompt](<Build Prompt — Android App (Delete When Done).md>) (the task, its five checkpoints and its rules), the
[Rulebook](../../RULEBOOK.md) and [`Android/README.md`](<../README.md>) (how to build, test and launch).

## 1. The task and its rules, in short

- **Build the whole Android app, start to end, in five checkpoints** (build prompt): 1 skeleton, 2 every screen and
  dark mode, 3 data out of the phone (backup, restore, Drive sync, Plus, App lock, reminders), 4 widgets, 5 proof
  (speed, data, sync and widget tests green with numbers; tablets and foldables). **Report to the user at each one.**
- Branch **`claude/android-app`**, made from `main`. Build on `Core/rules` from `main`. **Never check out, merge, push
  to or touch the runs of `claude/shared-habit-rules-switch`** (another agent's). Every rules call goes through the
  adapter, `data/RulesGateway.kt` plus `RulesGateway+*.kt` extension files: **the only files that import
  `app.habits.rules`**, so that branch landing changes only them.
- Don't edit `Core/rules/src`, `Core/spec`, `Core/fixtures` or `Core/schemas`. A rule the core lacks is ported in the
  app with a test and `// MOVE TO CORE`, and listed in [Build Results](<Android App — Build Results.md>).
- Designs are images: [Designs/README.md](<Designs/README.md>) (no Figma). Unsure about logic or words: do what the
  iPhone does (`iOS/Habits`).
- Commit and push as you go **without trigger tags** (T10); add `[android-ci]` only to a commit meant to run the
  emulator tests. `main` moves only with the user's go-ahead. No PR unless the user asks. No secrets (D11). Never
  cancel or rerun other agents' runs; don't use `[ios-widgets]`.
- Commits end with the session's attribution lines (the Co-Authored-By / session lines your harness gives you).

## 2. Where it stands (13 October 2026, ~08:40 UTC)

**Checkpoint 1 (skeleton): built, not yet reported to the user.** Last pushed commit: `be1b22e`.

| What | State |
|---|---|
| Gradle project, Core on Android (`a508f0a`), Room 3 database, adapter, store | Built, CI green |
| Welcome (new and returning), Today (every row kind, sections, day bar, empty states, swipe actions, long-press menu) | Built |
| Logging and undo for every kind; Day details; Add log / Log view / Edit / All logs; notes | Built |
| New Habit flow and form with all its pages; Edit habit; Start from an idea; drawer; Day and Week, Appearance, Times of Day, section editor | Built (checkpoint 2 work, committed) |
| Google Drive & Backup page, Restore (30-day undo), spreadsheet export, stand-in Drive (`StandInLink`) | Built (checkpoint 3 work, committed); real Drive waits for the user's OAuth client |
| Reminders with Done / +1 from the notification, boot/time-change replanning; running-timer notification with Stop and save | Built (checkpoint 3 work, committed) |
| Light and dark themes | Built for the screens that exist |
| Unit tests (`WordsTest`, `SwiftJsonTest`, `FormRulesTest`, `DataExportTest`, `ReminderPlanTest`, `LocalDriveTest`) | Green (run 38319381690 and later build jobs) |
| Emulator UI tests (`TodayTest`, 11 tests) | Run 38343622250 (`451d8b1`): 10 of 11 passed; `aChecklistTicksAStep` failed. Fix pushed in `be1b22e`; its run **38369953627** was cancelled by the handoff push before the emulator ran: **rerun it** |

**First thing to do:** open run
[38369953627](https://github.com/lalithsaicharan00/store-reviews/actions/runs/38369953627). It was cancelled
(the handoff push cancelled it: the workflow has `cancel-in-progress` per branch), so rerun the emulator tests by
hand: Actions → Android → Run workflow on `claude/android-app`, `instrumented` on, `classes`
`com.oftenenough.app.TodayTest`. If `aChecklistTicksAStep` still fails, see §5.1. When all 11 pass, record the
numbers in Build Results ("Result: see below" is still a placeholder), tick checkpoint 1 in Current Work 107 and send
the user the checkpoint 1 report (with §6's questions).

## 3. Parked work: `Android/WIP/` (kept, never compiled)

Helper agents and I wrote these during checkpoints 2 and 4. **They have never been built**, so they were moved out of
the source set (Gradle doesn't see `Android/WIP/`) to keep `claude/android-app` building. Paths under `Android/WIP/`
mirror `Android/app/`: move a file back to the same path under `Android/app/` to use it, then build on CI and fix.
Review each one against its design and the iPhone code before trusting it.

| Files (under `Android/WIP/src/`) | What it is | State |
|---|---|---|
| `main/.../ui/habit/HabitDetails.kt`, `HistoryNotesTabs.kt`, `ProgressTab.kt`, `HeatSquares.kt`, `main/.../data/HabitPageWords.kt`, `main/.../data/RulesGateway+HabitPage.kt` | **Habit details** (History, Notes, Progress tabs, ⋮ menu; design §11; iPhone `HabitPageView.swift` and friends). Entry: `HabitDetailsScreen(habitId, store, nav: HabitDetailsNav, onBack)` | Written by a helper; looks complete; unreviewed, uncompiled; not routed (AppRoot's "Habit details" page is still a placeholder) |
| `main/.../ui/progress/Progress.kt`, `HeatMap.kt`, `ProgressMemory.kt`, `main/.../ui/charts/Charts.kt`, `main/.../data/ProgressWords.kt`, `test/.../ProgressWordsTest.kt` | **Progress** (Week, Month, Year; design §12) and `LightBarChart` (S12: one Canvas). Entry: `ProgressScreen(store, prefs, nav: ProgressNav, onBack)` | Same: unreviewed, uncompiled, not routed |
| `main/.../ui/player/RoutinePlayer.kt`, `TimerScreen.kt`, `main/.../data/PlayerWords.kt`, `test/.../PlayerWordsTest.kt` | **Routine player** and full-screen **timer** (design §10; U23, U24). Entry: `RoutinePlayer(store, part, day, habitIds, nav: PlayerNav, onClose)`, `TimerScreen(...)` | Same |
| `main/.../data/widgets/WidgetSnapshot.kt`, `WidgetItems.kt` | The widgets' snapshot (port of the iPhone's `WidgetSnapshot.swift` / `HabitStore+Widgets.swift`): seven days of cards, Today's lists, held order during taps (U4), each ✓/+ card's "after" chain (W3) | Mine; complete; uncompiled. Counted checks show ✓ with no "+1" text (U14) |
| `main/.../app/widgets/WidgetDisk.kt`, `WidgetPublisher.kt` | Widget files (snapshot, durable tap queue, per-widget choice) and the publisher (0.5 s after the last change, at once on leaving the app or a tap; W11). Also `HabitIconBitmaps` (filled-circle icon bitmaps for Glance) | Mine; uncompiled. `WidgetPublisher.updateAll` names six widget classes that **don't exist yet** (§4) |
| `main/res/drawable/ic_w_*.xml` | Widget glyphs (check, play, pause, open ↗, plus, ‹ ›, list, lock, refresh, flame) | Ready |
| `HabitStore-saveWidgetTap.patch` | `HabitStore.saveWidgetTap(habitId, day, kind, id, at)`: saves one widget tap idempotently (✓ as the state it set, + by the tap's own ID, ▶/⏸ as a state); apply with `git apply Android/WIP/HabitStore-saveWidgetTap.patch` | Mine; uncompiled |

**Helpers that produced nothing** (all helpers are stopped; none is running): Help & Feedback / About / Reminders
settings pages; Plus page + purchases behind an interface with a fake store, Privacy & Security, App lock; Today's
Filter sheet and Groups screens; Arrange your day, Pause sheet, Habits and Tasks lists. These are still to build
(the prompts I gave them are in §7 as a checklist).

## 4. What's left, by checkpoint

**Checkpoint 2 — every screen wired; dark mode.** Bring in and route Habit details, Progress, the player and timer
(§3). Build: Help & Feedback, About, Reminders settings (design §15, §21, §22; Current Work 101 and 102 for Help's
words); Privacy & Security and App lock (§19; `MainActivity` must become a `FragmentActivity` for `BiometricPrompt`);
Plus page (§20); Filter and Groups (no Android design: iPhone `Groups/GroupScreens.swift`, `GroupChips.swift`);
Arrange your day, Pause, Habits and Tasks lists (iPhone; U13, U14, D6). `AppRoot.kt` routes menu items to
`Routes.page(title)` placeholders: replace each. Check every screen in dark mode.

**Checkpoint 3 — data out of the phone.** Real Google Drive (Identity `AuthorizationClient`, scope `drive.appdata`;
the core's `GoogleDrive`/`DriveSync` and the app's `HttpDrive` are ready) once the user sends the OAuth client;
automatic backups and sync on a schedule (WorkManager: on open, about once a minute on screen, in the background;
D4, D16); a two-emulator sync test; Play Billing (billing-ktx 9.1.0 is in the build) once the Play Console app
exists, a fake store meanwhile; App lock.

**Checkpoint 4 — widgets** (design §23–25; build prompt item 7; the locked iPhone page
`iOS/Docs/Widgets — Taps and Updates (Locked).md`, W1–W17, adapted to Android). The plan I was following:

1. Restore the WIP widget files and the `saveWidgetTap` patch.
2. `app/widgets/Widgets.kt`: six Glance widgets (`OneHabitWidget` 2×2, `TodayWidget` 4×2, `TodayLargeWidget` 4×4,
   `WeekWidget` 4×2, `TasksWidget` 4×2, `TasksLargeWidget` 4×4), fixed sizes, each with a `GlanceAppWidgetReceiver`.
   Each reads only the snapshot (`WidgetDisk.read`, `snapshot.frame(now)`) and the widget's choice
   (`WidgetDisk.choice(id)`: `habit:<id>`, `section:<id>`, `all`). Every state in §25: choose a habit / habit
   removed / no habits yet / nothing planned / section unavailable / open to update (no snapshot or frame) / content
   hidden / couldn't save / without Plus (Today and This week are Plus; free gets One habit and Tasks; a Plus widget
   without Plus never blocks and never shows blank: "Tick habits off here with Plus · Open Today"), Large pages
   (5 rows a page, ‹ 1/2 ›).
3. The tap (`ActionCallback`): write the `WidgetTap` to the durable queue first, `WidgetDisk.applyTap(item, token)`
   (the card becomes its "after"), `updateAll`, then save in the store (`saveWidgetTap`, source `WIDGET`), remove the
   tap once saved, `WidgetPublisher.publish(hold = true)`. ▶/⏸ start and stop on the widget. Anything needing a screen
   opens it directly, replacing what the app had open: `item/<id>` → Day details (`AppGraph.dayToOpen`), `log/<id>`
   and `slip/<id>` → the Add screen (`Routes.add`), `timer/<id>` → the timer screen. Add an extra to `MainActivity`
   for these routes.
4. Save waiting taps when the store loads and when the app returns (`AppGraph.open`); hook `WidgetPublisher.schedule`
   into `store.onChange`, publish at once on app stop (`ProcessLifecycleOwner`, already a dependency) and at the day's
   start (an alarm). **D8:** a test launch must never write the person's widget files: make `publish` return early
   when `AppGraph.isTest` (or give tests their own folder that placed widgets never read), and a tap arriving while a
   test launch owns the process only queues the tap.
5. Setup activity (`WidgetSetupActivity`, design §24: choose a habit; the day or one section; all tasks or one
   section), provider XML with `reconfigurable|configuration_optional`, strings, manifest receivers.
6. Instrumented widget tests and a tap → visible measurement.

**Checkpoint 5 — proof.** Macrobenchmarks / JankStats (`[android-perf]`), baseline profile, the data and sync tests,
tablets and foldables (A11 D9, U35's iPad decisions), with numbers in Build Results.

## 5. Things to know

### 5.1 The failing emulator test

`TodayTest.aChecklistTicksAStep` tapped "Mark Serum done" and the row never became "Undo Serum" (run 38343622250;
the screen dump shows the step rows present). The store side looks right (`toggleStep` adds an entry; `revisions` is a
snapshot map; `StepRow` reads `store.revision(habit.id)`). My diagnosis: the step rows are added under the last row,
composed just past the list's visible edge, so the click landed off-screen. `be1b22e` makes the test's `tap()` scroll
the list to the node first. If it still fails, check that `StepRow` recomposes (log `rev`), and whether the click
reaches `RoundActionButton` (another node with the same description, e.g. a swipe action, would be clicked first:
`onAllNodes(...)[0]`).

### 5.2 Lessons (also in the Rulebook, T22)

- Swipe actions are composed behind each row (`SwipeRow`), so their labels ("Skip", "Note", "Undo …", "Log slip") are
  in the semantics tree: a test matching those labels can hit a hidden button.
- The demo data (`DemoData`, `demo=today`) has some habits already done today (Meds, Cleanser): tests start from what
  the demo shows.
- CI's shell is `sh`: no `PIPESTATUS`; the emulator step writes to a log, keeps the exit code and prints the tail.
- The Android workflow cancels the branch's running run on every push that touches `Android/**`: don't push while
  waiting on an emulator run you need, or use a temporary branch of your own (T10).
- Google's Maven and the Android SDK aren't reachable from the cloud session: every build is on GitHub Actions.
  Watch runs with a background poller (my script: `Research/Temp/android/watch.sh <branch> Android <sha>`, ignored by
  git, so it won't be there in a new container; it polls `api.github.com/repos/.../actions/runs?branch=…`). Job logs:
  the GitHub MCP tool `get_job_logs`; lint prints its first failure in the log.

### 5.3 Code map (committed)

- `app/AppGraph.kt`: one store per process; `open` (the person's database) or `openForTest` (in-memory, own prefs,
  own stand-in Drive; D8); `dayToOpen` for notification taps.
- `data/HabitStore.kt`: state and every write (S5, S6, S7); `data/RulesGateway.kt`: the adapter.
- `data/Words.kt`, `StoreWords.kt`, `HowOften.kt`, `FormWords.kt`, `SectionPlan.kt`, `ReminderPlan.kt`,
  `DataExport.kt`: ports from Swift, `// MOVE TO CORE`.
- `ui/AppRoot.kt`: navigation (routes `add/{habit}/{day}`, `log/{id}`, `alllogs/…`, `note/…`, `new?idea=`,
  `edit/{id}`, `page/{title}`, `section/{id}`); Day details is a sheet over Today (`dayTarget`).
- `ui/today/`: Today, rows, swipe rows, `TodayLayout` (holds order during a run of taps, U4).
- `app/backup/`, `ui/backup/`: backups, restore, Drive links. `app/reminders/`: reminders and the timer notification.
- Tests: `app/src/test` (JVM), `app/src/androidTest/TodayTest.kt` (emulator).

## 6. Waiting on the user (ask at the checkpoint 1 report)

- An **Android OAuth client** for `com.oftenenough.app`, scope `drive.appdata`, with the debug and release SHA-1.
- The **debug keystore secrets** for CI (instructions in Build Results → "What needs the user"; never in git or chat).
- The **Play Console app** and products `com.oftenenough.app.plus` ($24.99), `com.oftenenough.app.plusfamily` ($59.99),
  `com.oftenenough.app.plusfamily.upgrade`; license testers.
- **How Plus Family reaches a family on Google Play**: research, propose, ask before anything irreversible.
- Real-phone checks (Pixel, Samsung, Xiaomi; U9, T5), noted separately.

## 7. Session housekeeping at handoff

- All helper agents and this session's run watcher are stopped; nothing of this session is running.
- The three "continue" reminders this session had scheduled (Routines "Android app: continue (2 of 3)", "Android app:
  continue and complete", "Android app: continue (5h05m after 13:36)") were **disabled, not deleted**, so this session
  won't wake up and work on the branch alongside the next agent. They can be re-enabled from the Routines list.
- Nothing was merged to `main`. No pull request exists.

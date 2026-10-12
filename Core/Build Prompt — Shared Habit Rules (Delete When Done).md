# Build Prompt — Shared Habit Rules in the Core (Delete When Done)

Written by Claude (Claude Code), 12 October 2026, for a cloud session, at the user's request: "give me the detailed
prompt, whatever it has to do, all the work … ask the agent to have a meaningful branch name." Current Work item **92**.
Delete this file in the final merge, as the earlier build prompts were.

---

You are moving the app's **habit rules** (which day a log belongs to, schedules, goals, streaks and progress) out of
the iPhone's Swift code into the **shared Kotlin core**, so iPhone, iPad, Watch, Mac and Android all compute the same
numbers from one copy. Do the whole job, in two checkpoints, on one branch.

## 0. Branch, commits, CI

- **Branch:** `claude/shared-habit-rules` from `main` (a meaningful name, the user's request). Extra branches for
  running test batches side by side (T1, T10): `claude/shared-habit-rules-ci2`, `-ci3` …, `-perf`, `-perf2` …, and
  `-main-check` for running a failing test on `main` (T2). List every one in
  `iOS/Docs/Checklists/Merging the Branches.md` and mark it safe to delete when done (W3; you can't delete branches).
- Commit and push as you go (this task says to, W4), untagged while building (T10). Never touch other agents' branches
  or runs.
- `core-tests.yml` runs the core's tests on Linux on every push that changes `Core/` (T19); the iPhone, iPad and Watch
  are built and tested by `ios-tests.yml` on GitHub's Macs (T1). Watch every run you start with a background watcher
  until it completes (T1); read every failure before changing anything; never loosen a test (T2).
- No Xcode on Linux: check Swift with `swiftc -parse` / `-typecheck` before a CI build (T17).
- If this environment can't reach `dl.google.com` (Gradle needs it for Room), build on GitHub instead, as the Drive
  session did, and tell the user once they can allow that host in the environment's network settings.

## 1. Read first

1. `RULEBOOK.md` in full and `CLAUDE.md`. Above all: S1, S2, S5, S6, S8, S16 (Core calls run on the database's
   background dispatcher), D6 (streaks computed, never stored; schedules and goals change from an effective date), D7
   (a day is the local calendar day at logging; `store.today()`), U10, U13, U14, U25, U26 and U28 (widgets: their
   snapshot comes from the store's own functions; widgets are locked, nothing they show may change), U30–U35 (the Watch
   and the iPad share the iPhone's model code, U32; the Watch reads only its last 400 days, U34), T1, T2, T7, T10,
   T11 (time-of-day tests at a set clock), T12, T17, T18 (the Watch's UI tests), T19, T20 (the iPad simulator), W1–W5.
2. `Architecture/Shared Core Decision.md` (why one core; no separate Swift and Kotlin copies) and
   `Architecture/05. Sync Engine.md` (the data model: entries as events; streaks and totals always calculated; each
   entry keeps its local date and time zone; custom day start; any week start; schedule changes with effective dates).
3. `Core/README.md` ("Next: the day, schedule, streak and progress rules, with `spec/` and shared `fixtures/`").
4. `Android/Docs/README.md` (decision A3: the same design on both platforms) and
   `Android/Docs/How Sync Works — iCloud and Google Drive, One Core.md`.
5. The Swift that holds the rules today, in `iOS/Habits/Model/`: `HabitStore.swift` and its extensions
   (`+Progress`, `+OverTime`, `+WeekCards`, `+HabitPage`, `+Phase2`, `+Groups`, `+Widgets`, `+Feedback`),
   `Habit.swift`, `Schedule.swift`, `HowOften.swift`, `GoalInput.swift`, `Milestones.swift`, `SectionPlan.swift`,
   `HabitCopy.swift` (numbers in words), and the app's own check suites, which already encode expected behaviour:
   `ProgressCheck`, `ScheduleCheck`, `PlacementCheck`, `UndoCheck`, `WidgetCheck`, `TaskCheck`, `CopyCheck`.
   Also `iOS/Design Rules — Don't Regress.md` for Today, Progress, the habit page and widgets.

## 2. Write down the rules (`Core/spec/`)

Before any Kotlin, write `Core/spec/` in plain English: one file per area, every rule with worked examples, citing the
Rulebook rule or Design Rules decision it comes from. Areas, at least:

- **The day:** which day a moment belongs to (day start such as 3 AM, time zones, travel, daylight-saving shifts both
  ways, a log's own time zone); "today"; week start (Sunday, Monday, Saturday); month and year boundaries; leap days.
- **Schedules:** every day; chosen weekdays; N times a week, month or year; every X days; one-off tasks; schedules and
  goals changed from an effective date (the past keeps its old schedule); paused ranges; skipped days; archived habits.
- **Goals and completion:** at least / at most, per day, week or month; several times a day; amounts, durations,
  checks, checklists, timers; when the round button fills and the completion sound plays (U14); limits (U25).
- **Streaks:** current and best, for every schedule kind; skipped, paused and not-its-day days neutral (U3);
  quit habits' runs since the last slip; what the Watch can't be sure of in 400 days (U34).
- **Progress and placement:** day summaries, week and month figures, Progress's overview (habits, not ticks: U10),
  week cards, milestones, Today's order and sections (U13), and every number a widget shows (U26).

## 3. Checkpoint 1 — the rules in the core, proven to match the iPhone exactly

1. **Golden cases from today's iPhone behaviour (`Core/fixtures/`).** Language-neutral JSON: inputs (habits,
   schedules with effective dates, entries with their times and time zones, skips, pauses, settings, "now") → the
   iPhone's outputs (each rule's answer). Make inputs two ways: hand-written edge cases for every rule in §2 (named
   after the rule they test), and seeded random histories (thousands; a year of history; and the extreme account:
   about 25,000 records a year for 15 years). Produce the outputs **by running the current Swift code** in a macOS job
   on GitHub (a test target or harness that reads input files and writes output files), so the fixtures are what
   people see today, not what anyone assumes.
2. **A difference you think is a Swift bug:** don't copy it silently and don't fix it silently. Record it in
   `Core/spec/`. If fixing it changes what people see (a streak, a total, a filled button), it's a product decision:
   ask the user (Rulebook: a product rule changes only with the user's say-so). Otherwise fix both, note it, and keep
   the fixture showing the corrected answer.
3. **The Kotlin rules** in `Core/` `commonMain`: pure functions over plain data (no platform calls, no clock reads:
   "now" and the time zone are inputs), fast enough for S5's "worked out once and remembered" (the caller caches;
   the core never recomputes a year per tap), callable from Swift through the core framework and from Android
   directly. Match **every** fixture exactly. Benchmark on the JVM: a year of history and the extreme account.
4. **Prove it:** the fixtures run in `core-tests.yml` (Linux); the iPhone, iPad and Watch targets still compile with
   the new core (nothing on the iPhone's path changes yet).
5. **Merge checkpoint 1 into `main`** once every Core test passes and the Apple targets build (W3). Update
   `Core/README.md`, tick the checklist's first half (W1), and say so in the Android README. From here Android is
   unblocked whatever happens in checkpoint 2.

## 4. Checkpoint 2 — iPhone, iPad and Watch use the shared rules

1. **Switch** the Swift model code (shared by iPhone, iPad and Watch, U32) to call the core for every rule in §2.
   Keep `HabitStore`'s shape: it asks the core once and remembers (S5); nothing new in a view's `body` (S8); every
   core call on the database's background dispatcher (S16). Delete each Swift copy only after its replacement passes.
2. **Behaviour must not change:** the fixtures pass through the Swift caller too (the same answers through the bridge);
   the app's check suites pass; then the UI test classes that show these numbers, six or seven per run (T1; heavy
   classes count double): Today, TodayRowLayout, Progress, HabitPage, DayDetails, Groups, Arrange, Placement,
   RoutineCalendar, Widget and WidgetSystem (widgets locked, U28: compare what they show, change nothing), Undo,
   CompletionFeedback, the iPad's classes on the iPad simulator (T20: `IPadUITests`, `IPadWidgetSystemUITests`; a skip
   is never a pass), and the Watch's UI tests (T18). Run time-of-day tests at a set clock (T11).
3. **Speed must not get worse (S2):** `PerfDriver` scenarios in batches of about 20 (T1), and the before/after
   comparison with `ios-perf-bisect` (this branch against `main`, built in one job, four rounds or more, L29) for
   Today's scrolling, +1 and day ‹ ›, the habit page, Progress's period switch, the widgets' snapshot, and the Watch
   (its 400-day window, U34). Targets: hitches under 5 ms/s, no freeze of 100 ms.
4. **Stop rule:** if a screen gets slower or a number changes and you can't fix it, keep that part on the Swift code,
   record why, and finish the rest. Never trade correctness or speed for "one copy".
5. **Merge into `main`** when every test passed on the final code (W3; T7: test once, at the end). The real-iPhone
   speed check (`iOS/Tools/perf/measure_perf_device.sh`) is the user's: note it on item 92, don't wait for it.

## 5. Finish

- `Core/spec/` complete; `Core/README.md` updated; a short results note (what moved, what stayed in Swift and why,
  the fixtures' counts, the speed numbers side by side, every run ID) in `Core/Shared Habit Rules — Results.md`.
- Current Work item 92 ticked with run IDs (W1); Android README's "What comes next" updated; Merging the Branches
  updated; anything learned written into the Rulebook the same day (W5), numbers in `iOS/PERFORMANCE-LESSONS.md`.
- Delete this prompt in the final merge.

Ask the user only when truly blocked or when a rule difference changes what people see. Otherwise keep going until
both checkpoints are done.

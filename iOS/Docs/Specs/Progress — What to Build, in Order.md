# Progress — What to Build, in Order

Written by Claude (Claude Code), 30 September 2026. Build Plan #60 and the fixes it needs (#60a–#60g). The full design, evidence and exact numbers are in [The Progress Page — What People Need, and How to Build It](<../../../Research/Research Reports/Progress and Statistics/The Progress Page — What People Need, and How to Build It.md>); section numbers (§) below are that report's.

**Where Progress lives (final, the user, 30 Sep 2026):** the **Progress row in the ≡ menu** (`MenuPlace.progress`). It is pushed onto Today's navigation stack like every menu page. Today's top-bar chart button goes away with the menu. Build Progress into `MenuPage` (`Menu/SideMenu.swift`), replacing its "coming" page. Don't add any other way in.

## Start here: fix four things that are wrong today (#60a–#60d)

These are wrong or missing in the app as it is now, not only in Progress. Progress's numbers are built on them, so they come first. Each one is small.

| # | What | Why | Where | Test |
|---|---|---|---|---|
| **60a** | **Weekly and monthly goals are done for the day once logged that day.** A habit like "Gym 3 times a week" or "5 km on 3 days a week" counts as done for today, in all four places below, once something is logged today (or once the week's goal is met). On a day with nothing logged it counts as still open today, but it never counts against past days. The four places are Today's "N left", the section's ✓, the routine player's progress segments, and the day bar's ring and "2 of 5". | Today, ticking a 3-times-a-week habit once still leaves it "left" and the player's segment unfinished until the third time. The day bar and calendar ring count it as not done every day until the week is met. This is the Habitify 1★ burst in the report (§5, §16.4). | `HabitStore.isSatisfied` (used by `TodayView` and `RoutinePlayer`), and `daySummary` → `dayScore` (§16.4) for `DayBar` and the calendar sheet. | Golden cases G2, G10 and G16 (§25.2). Today: tick Gym once and the row moves to done for today, "N left" goes down, and the player's segment fills. Update the day-bar UI tests. |
| **60b** | **A daily limit is judged when the day ends.** A cut-down habit ("no more than 3 coffees") is never "done" or "within the limit" before the day is over. Today shows "2 of 3 so far". | Today, a limit counts as met from the first second of the day with nothing logged, and its streak is one day too high (§11.2, §17.2). | `HabitStore.dayMark`, `isDone`, `streak`, `bestStreak`. | G4. |
| **60c** | **Archived habits get an archive date** (`archivedOn`). Days from that date on don't count. On Restore, the archived stretch is saved as a pause, so it never shows as "not done". | Without it, archiving a habit rewrites past days' numbers or counts the habit forever (§17.1). | `Habit`, Kotlin core schema + migration, `RecordMapping`, `HabitStore.archive/restore`. | G8. Core tests (`./gradlew jvmTest`) for the migration. |
| **60d** | **"Log a Slip…" for quit habits.** Long-press a quit row (and on its habit page) → a small sheet with date and time (defaults to now) and an optional note → saved as an event at that moment, with Undo. Editing "Started" stays only for fixing a wrong start. | Today there is no way to record a slip except by editing "Started", which keeps only the latest one. So there is no slip history to show (§10.4). | `QuitRow`, `HabitPageView`, `HabitStore` (an `Entry` with `createdAt` = the slip moment). | G9. |

**Start with 60a.** It is the fix people see every day, and Progress's day rings reuse its definition. 60b and 60c follow. 60d can be built any time before Progress's quit sections (Phase 2).

## Then Progress, Phase 1 (#60e)

In this order:

1. **Shared pieces** (§17.4, §17.6, §17.7): `runs(of:)` (best streak reads from it), the `dataVersion` change counter, and the shared views taken out of existing code: `DayRing` from the day bar, `DayMarkView` from the month calendar, and `DayDetailRow`.
2. **The Progress page** in `MenuPage` (§7):
   - Week and Month, with ‹ ›.
   - The overview: day rings and three numbers, plus the last-period line.
   - The Habits and Archived rows with week and month strips.
   - The Day sheet. Its "Show on Today" clears the menu's path (`MenuModel.path`) and sets Today's day.
   - "How It's Counted" with the legend.
   - View options (Show Percentages, Show Streaks).
   - The empty states.
3. **The habit page** (§8): the total line under the numbers, the tap-a-day popover on the month calendar, and **Over Time** for every type except quit (shapes A–I, §9) with Week, Month, Year and All.
4. **Tests** (§25.3):
   - `-progresscheck` with golden cases G1–G17, and `ProgressUITests` (open Progress **from the ≡ menu**). Add it to the `[ios-ci]` list.
   - The speed test in `PerformanceUITests`, run with `[ios-perf]`: 30 habits and two years of history.

## Later

- **#60f, Phase 2:** the Year view and the habit page's Year grid, Runs, By Weekday, the 30-day rate, and quit's Progress sections (needs 60d) (§25.1).
- **#60g, Phase 3:** a "full day at 100/80/60%" option, money saved for quit habits, a shareable year image, and group stats once groups exist (§15, §25.1).

## Rules to keep while building

- **Progress only reads.** Nothing in it logs or changes data; logging stays on Today.
- **No red, no "missed", "failed" or "relapse".** Every percentage sits beside its fraction.
- **Every past day is judged by `store.rule(habit, on:)`.** Numbers come from `HabitStore`, never from a view.
- **All of it is free.**

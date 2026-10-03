# claude/progress-week-cards @ 55a2d3e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37120151975 · 2026-10-03 12:16 UTC
Commit: Heat key: the five steps in one Canvas, rows chosen by text size instead of ViewThatFits

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,ProgressUITests,UndoUITests): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 26 tests, with 0 failures (0 unexpected) in 1022.363 (1022.386) seconds
	 Executed 26 tests, with 0 failures (0 unexpected) in 1022.363 (1022.387) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 281.245 (281.251) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 309.012 (309.020) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 432.106 (432.112) seconds
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (30.774 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (29.378 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (66.762 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (57.749 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (28.164 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (22.843 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (22.452 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (29.123 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (21.768 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (42.682 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (55.251 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (36.985 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (48.272 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (20.956 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (24.079 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (38.250 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (14.769 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (44.914 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (42.171 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (31.012 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (66.495 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (73.073 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (21.082 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (70.349 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (32.716 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (50.294 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Habit page: scrolling | 14.6 | 186 ms | 1 | 8.9 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page (quit): scrolling | 4.8 | 55 ms | 0 | 2.7 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Progress: scrolling | 0.3 | 19 ms | 0 | 7.6 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.7%  closure #1 in AppModel.ensureLoaded() |
| Progress: period ‹ › and range | 51.5 | 82 ms | 0 | 7.6 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.7%  closure #1 in AppModel.ensureLoaded() |
| Progress: key fold and open | 4.1 | 46 ms | 0 | 7.6 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.7%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 435 ms
- Habit page: longest stall 502 ms
- All Habits: longest stall 287 ms
- Habit page (quit): longest stall 324 ms
- Progress (first): longest stall 404 ms
- Progress (again): longest stall 74 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| habit-page | Widgets: one habit's month | 17 | 77 ms | 43.6 ms |
| habit-page | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| habit-page | Count: a Today row drawn | 42 | 0 ms | 0.1 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's month | 17 | 63 ms | 34.6 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 42 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's month | 17 | 66 ms | 33.6 ms |
| progress | Progress year: whole snapshot | 2 | 36 ms | 22.1 ms |
| progress | Progress year: cards | 2 | 36 ms | 22.1 ms |
| progress | Progress year: one card | 30 | 35 ms | 2.2 ms |
| progress | Progress week: whole snapshot | 2 | 8 ms | 6.7 ms |
| progress | Progress week: cards | 2 | 7 ms | 6.2 ms |
| progress | Progress week: one card | 30 | 6 ms | 4.5 ms |
| progress | Progress month: whole snapshot | 2 | 5 ms | 3.2 ms |
| progress | Progress month: cards | 2 | 5 ms | 3.0 ms |
| progress | Progress month: one card | 30 | 4 ms | 0.3 ms |
| progress | Progress week: one quit card | 4 | 1 ms | 0.5 ms |
| progress | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.2 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 50 | 0 ms | 0.0 ms |
| progress | Count: a Today row drawn | 519 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

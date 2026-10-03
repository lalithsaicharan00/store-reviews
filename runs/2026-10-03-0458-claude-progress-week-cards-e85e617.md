# claude/progress-week-cards @ e85e617

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37096111790 · 2026-10-03 04:58 UTC
Commit: Heat map: signs instead of dates, ✓ only when the goal is met, readable Year

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,ProgressUITests,UndoUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 26 tests, with 1 failure (0 unexpected) in 1045.755 (1045.789) seconds
	 Executed 26 tests, with 1 failure (0 unexpected) in 1045.755 (1045.791) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 303.139 (303.149) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 431.525 (431.538) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 311.091 (311.100) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:162: error: -[HabitsUITests.ProgressUITests testHidePercentages] : XCTAssertFalse failed - Every percentage is hidden
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (31.493 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (39.972 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' failed (63.188 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (60.290 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (26.527 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (26.852 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (10.862 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (28.763 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (23.143 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (43.037 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (70.630 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (38.062 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (47.195 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (23.973 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (24.560 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (38.401 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (17.282 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (41.066 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (45.228 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (25.733 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (71.274 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (70.215 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (22.097 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (69.958 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (40.591 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (45.363 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Progress: scrolling | 19.8 | 48 ms | 0 | 6.0 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Progress: period ‹ › and range | 248.0 | 294 ms | 22 | 6.0 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Progress Year: scrolling | 11.2 | 44 ms | 0 | 10.7 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.8%  closure #1 in AppModel.ensureLoaded() |
| Habit page: scrolling | 35.7 | 154 ms | 3 | 4.9 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.7%  closure #1 in AppModel.ensureLoaded() |
| Habit page (quit): scrolling | 0.3 | 21 ms | 0 | 7.0 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Progress (first): longest stall 774 ms
- Progress (again): longest stall 161 ms
- Progress Year (first): longest stall 688 ms
- Progress Year (again): longest stall 139 ms
- All Habits: longest stall 824 ms
- Habit page: longest stall 767 ms
- All Habits: longest stall 431 ms
- Habit page (quit): longest stall 567 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| progress | Progress year: whole snapshot | 2 | 61 ms | 39.8 ms |
| progress | Progress year: cards | 2 | 60 ms | 39.5 ms |
| progress | Progress year: one card | 30 | 56 ms | 4.4 ms |
| progress | Progress week: whole snapshot | 2 | 27 ms | 16.7 ms |
| progress | Progress week: cards | 2 | 25 ms | 15.3 ms |
| progress | Progress week: one card | 30 | 16 ms | 8.4 ms |
| progress | Progress month: whole snapshot | 2 | 8 ms | 4.2 ms |
| progress | Progress month: cards | 2 | 8 ms | 4.1 ms |
| progress | Progress month: one card | 30 | 6 ms | 0.3 ms |
| progress | Progress week: one quit card | 4 | 4 ms | 3.7 ms |
| progress | Progress year: one quit card | 2 | 1 ms | 0.5 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress-year | Progress year: whole snapshot | 1 | 40 ms | 39.9 ms |
| progress-year | Progress year: cards | 1 | 40 ms | 39.7 ms |
| progress-year | Progress year: one card | 15 | 34 ms | 6.9 ms |
| progress-year | Progress year: one quit card | 2 | 4 ms | 3.5 ms |
| progress-year | Progress week: whole snapshot | 1 | 2 ms | 1.9 ms |
| progress-year | Progress week: cards | 1 | 2 ms | 1.7 ms |
| progress-year | Progress week: one card | 15 | 1 ms | 0.1 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.2 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

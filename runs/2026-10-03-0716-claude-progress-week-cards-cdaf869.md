# claude/progress-week-cards @ cdaf869

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37103895820 · 2026-10-03 07:16 UTC
Commit: Heat map: one ✓ colour per mode; the key folds, on Progress and the habit page

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,ProgressUITests,UndoUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 26 tests, with 1 failure (0 unexpected) in 1015.153 (1015.176) seconds
	 Executed 26 tests, with 1 failure (0 unexpected) in 1015.153 (1015.178) seconds
	 Executed 8 tests, with 1 failure (0 unexpected) in 263.542 (263.547) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 335.798 (335.807) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 415.813 (415.819) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/UndoUITests.swift:181: error: -[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit] : XCTAssertTrue failed
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (19.179 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (74.154 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (83.523 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (54.872 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (24.440 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (17.577 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (7.123 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (28.303 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (26.628 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' failed (39.881 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (55.461 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (32.524 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (48.263 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (20.482 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (20.955 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (33.242 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (12.735 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (44.029 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (40.914 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (23.658 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (64.912 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (71.594 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (19.164 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (66.436 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (32.301 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (52.805 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Progress Year: scrolling | 19.0 | 61 ms | 0 | 11.8 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: scrolling | 25.6 | 148 ms | 1 | 4.3 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  static PerfDriver.run(_:store:)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Progress Year (first): longest stall 745 ms
- Progress Year (again): longest stall 199 ms
- All Habits: longest stall 307 ms
- Habit page: longest stall 579 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| progress-year | Progress year: whole snapshot | 1 | 49 ms | 49.3 ms |
| progress-year | Progress year: cards | 1 | 49 ms | 49.0 ms |
| progress-year | Progress year: one card | 15 | 45 ms | 11.5 ms |
| progress-year | Progress week: whole snapshot | 1 | 3 ms | 2.8 ms |
| progress-year | Progress week: cards | 1 | 3 ms | 2.6 ms |
| progress-year | Progress week: one card | 15 | 2 ms | 0.5 ms |
| progress-year | Progress year: one quit card | 2 | 1 ms | 0.9 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.2 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

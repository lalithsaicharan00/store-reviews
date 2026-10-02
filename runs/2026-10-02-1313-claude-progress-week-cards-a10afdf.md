# claude/progress-week-cards @ a10afdf

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37008740799 · 2026-10-02 13:13 UTC
Commit: UI tests for the Week cards: percentages checked on Month, the quit card reached by swiping, screenshots set light or dark at launch

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,ProgressUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 338.368 (338.383) seconds
	 Executed 13 tests, with 0 failures (0 unexpected) in 505.032 (505.058) seconds
	 Executed 13 tests, with 0 failures (0 unexpected) in 505.032 (505.060) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 166.664 (166.673) seconds
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (51.620 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (14.796 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (31.466 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (44.970 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (68.228 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (34.988 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (26.174 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (12.383 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (32.864 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (20.878 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (69.942 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (70.301 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (26.422 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

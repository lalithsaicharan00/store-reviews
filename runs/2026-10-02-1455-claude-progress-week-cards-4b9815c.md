# claude/progress-week-cards @ 4b9815c

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37018495137 · 2026-10-02 14:55 UTC
Commit: Marks and icons at one shared lightness; over-limit days in the habit's own colour

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ProgressUITests,WeekCardsUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 314.511 (314.524) seconds
	 Executed 13 tests, with 0 failures (0 unexpected) in 488.670 (488.688) seconds
	 Executed 13 tests, with 0 failures (0 unexpected) in 488.670 (488.691) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 174.159 (174.162) seconds
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (44.597 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (15.116 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (29.708 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (35.602 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (77.693 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (37.671 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (19.741 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (8.196 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (28.154 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (18.033 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (72.948 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (77.646 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (23.565 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

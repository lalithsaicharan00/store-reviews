# claude/progress-week-cards @ 2467076

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37010612231 · 2026-10-02 13:35 UTC
Commit: Week key folded until asked and covering every mark; clearer mark names and symbols; one white check on every colour

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,ProgressUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 1 failure (0 unexpected) in 317.697 (317.707) seconds
	 Executed 13 tests, with 1 failure (0 unexpected) in 492.964 (492.980) seconds
	 Executed 13 tests, with 1 failure (0 unexpected) in 492.964 (492.983) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 175.267 (175.271) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:158: error: -[HabitsUITests.ProgressUITests testHidePercentages] : XCTAssertTrue failed - Percentages show by default
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (36.437 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (23.895 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (18.139 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' failed (68.227 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (57.620 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (26.002 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (19.578 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (20.427 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (29.923 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (17.450 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (75.173 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (78.393 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (21.700 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

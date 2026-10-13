# claude/shared-habit-rules-ci39 @ 41045ec

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38329428557 · 2026-10-13 02:38 UTC
Commit: Current Work 92 (checkpoint 2): the shared rules are given their inputs without SwiftUI seeing it; the Watch keeps its Swift rules

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,TodayRowLayoutUITests,ProgressUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 21 tests, with 1 failure (0 unexpected) in 827.780 (827.804) seconds
	 Executed 21 tests, with 1 failure (0 unexpected) in 827.780 (827.806) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 118.677 (118.681) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 311.108 (311.116) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 397.995 (398.003) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:148: error: -[HabitsUITests.ProgressUITests testHidePercentages] : XCTAssertTrue failed - The habit page
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (28.770 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (40.566 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' failed (158.986 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (48.451 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (25.965 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (25.855 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (11.898 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (31.523 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (25.983 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (44.715 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (15.714 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (22.696 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (35.552 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (26.154 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (43.012 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (22.297 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (31.177 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (16.637 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (121.488 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (14.370 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (35.973 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# claude/shared-habit-rules-ci2 @ b122a95

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38225673611 · 2026-10-12 09:26 UTC
Commit: Current Work 92 (checkpoint 2): a log made before the shared rules' copy is built isn't lost

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,TodayRowLayoutUITests,ProgressUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 21 tests, with 0 failures (0 unexpected) in 791.693 (791.733) seconds
	 Executed 21 tests, with 0 failures (0 unexpected) in 791.693 (791.736) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 138.883 (138.891) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 301.562 (301.568) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 351.248 (351.268) seconds
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (85.814 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (34.049 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (70.321 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (45.191 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (25.034 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (21.917 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (11.445 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (31.965 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (25.511 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (54.426 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (24.892 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (22.104 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (37.461 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (24.505 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (45.117 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (22.650 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (28.177 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (15.354 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (117.536 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (14.971 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (33.252 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# animations-and-settings @ 4192beb

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36796303885 · 2026-10-01 00:59 UTC
Commit: Tick feedback, folding and Day and Week / Appearance settings [ios-ci]

- Build: success
- UI tests (TodayUITests,TimerUITests,ProgressUITests,GroupsUITests): failure
- Speed tests: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 268.568 (268.581) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 76.692 (76.696) seconds
	 Executed 25 tests, with 3 failures (0 unexpected) in 1099.446 (1099.493) seconds
	 Executed 25 tests, with 3 failures (0 unexpected) in 1099.446 (1099.495) seconds
	 Executed 5 tests, with 2 failures (0 unexpected) in 434.632 (434.650) seconds
	 Executed 8 tests, with 1 failure (0 unexpected) in 319.554 (319.561) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:102: error: -[HabitsUITests.GroupsUITests testFirstGroupFromFilter] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ScrollHelpers.swift:49: error: -[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay] : Failed to tap "group-habit-Bed by 23:00" Button: No matches found for Elements matching predicate '"group-habit-Bed by 23:00" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayUITests.swift:202: error: -[HabitsUITests.TodayUITests testDoneRowWaitsForThePause] : XCTAssertLessThan failed: ("621.6666666666667") is not less than ("533.0") - Still in place right after the taps
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (139.599 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' failed (91.275 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' failed (65.404 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (86.345 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (52.009 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (26.593 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (15.399 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (24.408 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (32.551 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (43.292 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (32.010 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (31.593 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (9.848 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (31.208 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (21.666 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (32.037 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (44.655 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (30.507 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (50.453 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (27.003 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' failed (17.895 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (17.127 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (114.460 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (19.105 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (43.003 seconds).
```

# progress-page-research @ fa95797

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36795598710 · 2026-10-01 00:42 UTC
Commit: Progress: new numbers on a new day; group tests use a habit not done yet and scroll the group form

- Build: success
- UI tests (GroupsUITests,ProgressUITests): failure
- Speed tests: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 213.498 (213.506) seconds
	 Executed 15 tests, with 1 failure (0 unexpected) in 539.772 (539.794) seconds
	 Executed 15 tests, with 1 failure (0 unexpected) in 539.772 (539.795) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 326.274 (326.285) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:118: error: -[HabitsUITests.GroupsUITests testFirstGroupFromFilter] : XCTAssertTrue failed - ✕ shows everything again
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (74.553 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (76.804 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' failed (61.351 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (70.425 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (43.142 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (22.418 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (13.659 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (20.454 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (30.563 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (28.781 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (24.165 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (24.459 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (6.985 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (25.131 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (16.883 seconds).
```

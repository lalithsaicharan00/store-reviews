# claude/habit-details-ci-2 @ b55579d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37164549968 · 2026-10-04 00:50 UTC
Commit: Today rows: only named accessibility actions on a row's container (a default action or hint merged the texts, so names stopped reading as text); HabitCreation expects +1 for twice a day (U14)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,GroupsUITests,LongTextUITests,TimerUITests,TasksUITests,ProgressUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 51.437 (51.438) seconds
	 Executed 27 tests, with 1 failure (0 unexpected) in 1036.231 (1036.258) seconds
	 Executed 27 tests, with 1 failure (0 unexpected) in 1036.231 (1036.259) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 120.055 (120.057) seconds
	 Executed 3 tests, with 1 failure (0 unexpected) in 121.217 (121.219) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 239.050 (239.058) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 257.078 (257.082) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 247.394 (247.400) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:135: error: -[HabitsUITests.LongTextUITests testFormWithLongText] : XCTAssertEqual failed: ("XCTWaiterResult(rawValue: 2)") is not equal to ("XCTWaiterResult(rawValue: 1)") - The name is cut to 24 letters; the field holds "Read one more chapter of "
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (61.481 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (6.871 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (84.135 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (55.013 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (31.551 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (38.587 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (70.064 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (49.323 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (65.071 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (34.033 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (30.134 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' failed (34.831 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' passed (56.252 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (15.656 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (32.133 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (66.386 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (41.905 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (24.815 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (16.718 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (5.414 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (25.315 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (19.052 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (45.945 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (68.274 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (5.837 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (22.941 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (28.496 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

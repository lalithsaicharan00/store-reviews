# claude/habit-details-ci-2 @ 78a11e4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37141082383 · 2026-10-03 18:07 UTC
Commit: Today's rows: a tap opens the Day sheet for the day shown; ✓ toggles that day's tick, + adds; swipes reveal Note/Skip/Pause and a named Undo; long press matches the sheet; Delete only in the sheet's ⋯ menu; done habits stay in place

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,ProgressUITests,TimerUITests,GroupsUITests,TasksUITests,LongTextUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 failure (0 unexpected) in 37.718 (37.720) seconds
	 Executed 27 tests, with 5 failures (0 unexpected) in 1041.733 (1041.762) seconds
	 Executed 27 tests, with 5 failures (0 unexpected) in 1041.733 (1041.763) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 135.595 (135.597) seconds
	 Executed 3 tests, with 1 failure (0 unexpected) in 145.349 (145.351) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 257.013 (257.023) seconds
	 Executed 5 tests, with 3 failures (0 unexpected) in 218.262 (218.265) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 247.796 (247.801) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:193: error: -[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:223: error: -[HabitsUITests.GroupsUITests testGroupInHabitForm] : XCTAssertTrue failed - Journal is in Mind
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:80: error: -[HabitsUITests.GroupsUITests testFirstGroupFromFilter] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:72: error: -[HabitsUITests.LongTextUITests testTodayWithLongText] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TimerUITests.swift:50: error: -[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime] : XCTAssertTrue failed - The row shows a live clock, not just the button
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (94.695 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (10.020 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (81.669 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (35.284 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (35.344 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (37.857 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' failed (82.672 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' failed (13.646 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' failed (48.451 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (35.636 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (29.223 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' passed (87.086 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' failed (29.039 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (14.260 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (30.030 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (64.987 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (44.549 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (25.150 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (18.393 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (5.773 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (24.637 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (20.017 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (47.215 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (82.254 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (6.125 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (24.129 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' failed (13.590 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

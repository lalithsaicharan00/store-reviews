# claude/habit-details-ci-2 @ c751e33

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37161182541 · 2026-10-03 23:51 UTC
Commit: Today's rows, one shape: one line under every name (what today asks: how far along, or how often, then the time; tasks say Task; quit rows their best run), after-log Undo and Add/Edit Note as small capsules on one line, notes in their own sheet with Save, a task's row opens a task sheet (Done, date, Do Tomorrow), done habits move down again

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,GroupsUITests,LongTextUITests,TimerUITests,TasksUITests,ProgressUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 failure (0 unexpected) in 38.356 (38.358) seconds
	 Executed 27 tests, with 5 failures (0 unexpected) in 1125.607 (1125.642) seconds
	 Executed 27 tests, with 5 failures (0 unexpected) in 1125.607 (1125.644) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 134.457 (134.462) seconds
	 Executed 3 tests, with 1 failure (0 unexpected) in 142.826 (142.829) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 319.818 (319.827) seconds
	 Executed 5 tests, with 3 failures (0 unexpected) in 227.079 (227.084) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 263.072 (263.078) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:193: error: -[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:223: error: -[HabitsUITests.GroupsUITests testGroupInHabitForm] : XCTAssertTrue failed - Journal is in Mind
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:80: error: -[HabitsUITests.GroupsUITests testFirstGroupFromFilter] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:72: error: -[HabitsUITests.LongTextUITests testTodayWithLongText] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TimerUITests.swift:50: error: -[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime] : XCTAssertTrue failed - The row shows a live clock, not just the button
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (109.095 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (8.031 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (135.383 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (38.866 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (28.443 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (41.257 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' failed (83.991 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' failed (17.386 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' failed (46.705 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (37.740 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (35.210 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' passed (73.370 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' failed (34.246 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (14.410 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (30.670 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (66.662 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (45.307 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (27.860 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (19.714 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (8.730 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (28.567 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (21.151 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (48.034 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (79.324 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (7.099 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (25.313 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' failed (13.043 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

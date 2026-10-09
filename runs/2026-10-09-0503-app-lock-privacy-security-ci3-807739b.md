# app-lock-privacy-security-ci3 @ 807739b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37883466803 · 2026-10-09 05:03 UTC
Commit: Rulebook T1: watch each run with a background watcher; parallel batches on their own branches (the user, 9 Oct 2026)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitCreationUITests,FormWalkthroughUITests,GoalFlowUITests,NewFlowUITests,LongTextUITests,TasksUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 126.578 (126.580) seconds
	 Executed 21 tests, with 2 failures (0 unexpected) in 1761.742 (1761.777) seconds
	 Executed 21 tests, with 2 failures (0 unexpected) in 1761.742 (1761.778) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 122.936 (122.937) seconds
	 Executed 3 tests, with 2 failures (0 unexpected) in 117.254 (117.256) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 402.180 (402.186) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 882.170 (882.174) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:43: error: -[HabitsUITests.LongTextUITests testChooserShowsEverything] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:68: error: -[HabitsUITests.LongTextUITests testTodayWithLongText] : XCTAssertTrue failed
Test Case '-[HabitsUITests.FormWalkthroughUITests testAmountPicksSeveralParts]' passed (73.375 seconds).
Test Case '-[HabitsUITests.FormWalkthroughUITests testCheckOffMorningAndEveningWithReminders]' passed (53.203 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' passed (119.228 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (54.946 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' passed (50.745 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' passed (59.025 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' passed (87.226 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (31.010 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (67.608 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (113.298 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (243.817 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (149.284 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (155.791 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (152.372 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' failed (18.148 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' passed (87.681 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' failed (11.425 seconds).
Test Case '-[HabitsUITests.NewFlowUITests testFlow]' passed (110.625 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (49.360 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (67.540 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (6.035 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

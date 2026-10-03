# claude/habit-details-ci @ c0e9137

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37137386467 · 2026-10-03 16:59 UTC
Commit: Quit record card keeps its controls' own ids (its id replaced Log a Slip's); calendar test's undo check reads the day bar; Starts/Ends test drags the form, not Today behind it

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,TodayUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 13 tests, with 0 failures (0 unexpected) in 486.116 (486.130) seconds
	 Executed 13 tests, with 0 failures (0 unexpected) in 486.116 (486.137) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 214.795 (214.802) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 271.320 (271.326) seconds
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (74.092 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (6.784 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (72.733 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (35.422 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (25.765 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (22.597 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (42.530 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (26.958 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (25.427 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (14.565 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (95.301 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (12.803 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (31.139 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

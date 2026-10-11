# claude/pensive-gates-3n4ie8-ci4 @ a1eed4b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38142218065 · 2026-10-11 14:48 UTC
Commit: Current Work 86: Day details keeps Add log and its typed amount as the window narrows; Plus's Buy keeps to its column

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (NewHabitUITests,NewFlowUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 20 tests, with 1 failure (0 unexpected) in 1293.656 (1293.673) seconds
	 Executed 21 tests, with 2 failures (0 unexpected) in 1315.207 (1315.228) seconds
	 Executed 21 tests, with 2 failures (0 unexpected) in 1315.207 (1315.231) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/NewFlowUITests.swift:47: error: -[HabitsUITests.NewFlowUITests testFlow] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/NewHabitUITests.swift:567: error: -[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest] : XCTAssertTrue failed
Test Case '-[HabitsUITests.NewFlowUITests testFlow]' failed (21.551 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (249.777 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (59.237 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (50.846 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (46.552 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (120.954 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (57.114 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (17.106 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (48.605 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (56.620 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (40.484 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (47.920 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (74.570 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (62.405 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (32.793 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (32.204 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (71.849 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' failed (34.357 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (109.972 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (42.174 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (38.116 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

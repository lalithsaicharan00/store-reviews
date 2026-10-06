# claude/dreamy-pasteur-3kgdxu @ b2d562e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37400571007 · 2026-10-06 02:30 UTC
Commit: FocusPlayerUITests: the slow-write navigation test injects 4 s writes and allows 3 s (a wait still fails); › is now a Liquid Glass bar button whose press animation XCUITest waits out (~0.9 s, run 37387468173)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (NewHabitUITests,HabitPageUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 20 tests, with 0 failures (0 unexpected) in 954.737 (954.751) seconds
	 Executed 28 tests, with 2 failures (0 unexpected) in 1843.238 (1843.264) seconds
	 Executed 28 tests, with 2 failures (0 unexpected) in 1843.238 (1843.266) seconds
	 Executed 8 tests, with 2 failures (0 unexpected) in 888.501 (888.511) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:215: error: -[HabitsUITests.HabitPageUITests testSquaresKeyOpensOnlyOnTheFirstVisitToEachHabit] : XCTAssertFalse failed - Next visit: folded
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:218: error: -[HabitsUITests.HabitPageUITests testSquaresKeyOpensOnlyOnTheFirstVisitToEachHabit] : XCTAssertTrue failed - A tap opens it
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (81.686 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (60.308 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFoldByMonthLikeHistory]' passed (41.290 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (275.725 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (109.804 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (222.976 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testSquaresKeyOpensOnlyOnTheFirstVisitToEachHabit]' failed (60.186 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (36.526 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (85.900 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (40.948 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (41.069 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (42.384 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (84.911 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (39.183 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (12.741 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (39.527 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (53.106 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (35.400 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (44.039 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (66.751 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (49.981 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (25.708 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (28.005 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (61.769 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (41.220 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (92.862 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (37.851 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (31.385 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# claude/habit-details-ci @ 70d556f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37167904731 · 2026-10-04 02:12 UTC
Commit: Tests follow the row work: swipes drag a fixed distance (a name is too narrow for XCUITest's swipe), yesterday opens Anytime first, the task test uses the task fixture, GoalFlow types other amounts through the Day sheet, results read "3/3 times"; the delete question gets an explicit Cancel

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitCreationUITests,NewHabitUITests,PersistenceUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 19 tests, with 1 failure (0 unexpected) in 974.466 (974.480) seconds
	 Executed 29 tests, with 1 failure (0 unexpected) in 2088.126 (2088.161) seconds
	 Executed 29 tests, with 1 failure (0 unexpected) in 2088.126 (2088.162) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 130.383 (130.387) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 983.277 (983.287) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/NewHabitUITests.swift:47: error: -[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay] : XCTAssertTrue failed
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (80.014 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (105.042 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (220.572 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (140.043 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (164.151 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (273.456 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (117.148 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (45.174 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (44.673 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (49.150 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' failed (101.885 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (44.546 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (13.067 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (45.781 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (50.171 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (40.628 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (45.148 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (45.863 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (24.771 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (27.150 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (58.691 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (38.856 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (98.542 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (46.783 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (36.440 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (33.973 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (44.090 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (41.508 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (10.811 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

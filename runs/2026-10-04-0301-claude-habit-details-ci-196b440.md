# claude/habit-details-ci @ 196b440

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37170556707 · 2026-10-04 03:01 UTC
Commit: A skipped habit stays on Today as a neutral "Skipped today" row (it vanished, so Undo Skip had nowhere to be); sheets say Yesterday; NewHabit expects +1 for twice a day

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (NewHabitUITests,PersistenceUITests,HabitCreationUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 19 tests, with 0 failures (0 unexpected) in 835.455 (835.468) seconds
	 Executed 29 tests, with 0 failures (0 unexpected) in 1853.334 (1853.362) seconds
	 Executed 29 tests, with 0 failures (0 unexpected) in 1853.334 (1853.364) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 123.105 (123.108) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 894.775 (894.782) seconds
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (87.749 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (124.496 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (263.201 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (158.257 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (136.979 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (124.092 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (87.197 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (38.290 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (40.381 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (40.618 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (77.504 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (35.867 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (12.071 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (39.000 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (48.701 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (30.142 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (40.302 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (44.716 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (26.620 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (25.307 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (60.241 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (37.692 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (80.140 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (40.605 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (30.063 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (32.105 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (40.149 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (40.680 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (10.171 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

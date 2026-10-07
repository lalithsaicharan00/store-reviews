# day-details-logs-notes-redesign-ci-b @ b4d1328

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37616765534 · 2026-10-07 12:42 UTC
Commit: Rulebook U27 (go back before deleting what a row opened) and T15 (check small screens on the SE simulator; verify saves in the same launch)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitCreationUITests,NewHabitUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 20 tests, with 0 failures (0 unexpected) in 1013.623 (1013.636) seconds
	 Executed 26 tests, with 0 failures (0 unexpected) in 2087.736 (2087.764) seconds
	 Executed 26 tests, with 0 failures (0 unexpected) in 2087.736 (2087.766) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 1074.113 (1074.124) seconds
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (159.687 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (133.991 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (269.187 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (181.184 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (160.511 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (169.554 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (107.148 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (44.947 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (46.337 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (44.871 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (86.630 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (50.487 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (14.175 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (41.935 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (45.473 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (34.162 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (44.156 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (69.644 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (51.422 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (24.041 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (28.239 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (69.076 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (38.986 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (93.624 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (43.741 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (34.527 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# claude/habit-details-ci-2 @ 9a0b575

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37133200890 · 2026-10-03 16:14 UTC
Commit: Calendar tests: the calendar's dates are plain (2 Oct decision), so the day's count is checked on the day bar

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (NewHabitUITests,HabitCreationUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 19 tests, with 0 failures (0 unexpected) in 972.977 (972.995) seconds
	 Executed 25 tests, with 0 failures (0 unexpected) in 1917.120 (1917.154) seconds
	 Executed 25 tests, with 0 failures (0 unexpected) in 1917.120 (1917.156) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 944.142 (944.154) seconds
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (135.929 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (116.154 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (235.981 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (149.395 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (155.597 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (151.086 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (92.823 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (38.352 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (40.379 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (42.464 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (87.549 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (41.623 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (14.308 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (47.949 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (46.634 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (33.944 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (42.938 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (116.077 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (29.233 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (30.587 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (65.882 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (35.267 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (90.482 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (44.915 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (31.571 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

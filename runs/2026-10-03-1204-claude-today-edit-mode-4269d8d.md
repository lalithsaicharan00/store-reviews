# claude/today-edit-mode @ 4269d8d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37119513937 · 2026-10-03 12:04 UTC
Commit: Text limits: put the cut-back value in on the next turn, so a fast-typed or pasted name never shows more than is kept (U6)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,LongTextUITests,GroupsUITests,NewHabitUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 19 tests, with 0 failures (0 unexpected) in 868.816 (868.907) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 160.658 (160.660) seconds
	 Executed 32 tests, with 0 failures (0 unexpected) in 1464.217 (1464.324) seconds
	 Executed 32 tests, with 0 failures (0 unexpected) in 1464.217 (1464.326) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 212.213 (212.219) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 222.531 (222.534) seconds
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (78.077 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (9.374 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (73.550 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (28.137 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (23.075 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (30.889 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (62.341 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (46.252 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (53.619 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (29.430 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (20.940 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' passed (76.866 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' passed (62.852 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (94.636 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (37.047 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (37.611 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (36.463 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (77.713 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (40.984 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (12.352 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (40.746 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (51.395 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (33.534 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (40.298 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (46.154 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (24.110 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (28.160 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (60.420 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (42.766 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (92.786 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (41.768 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (29.873 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

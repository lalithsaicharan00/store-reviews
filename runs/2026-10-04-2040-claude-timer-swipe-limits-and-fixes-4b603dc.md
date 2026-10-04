# claude/timer-swipe-limits-and-fixes @ 4b603dc

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37230304257 · 2026-10-04 20:40 UTC
Commit: TodayRowSheetUITests: swipe buttons checked against Apple's 44-point minimum (iOS draws them 50 wide; 60 was an arbitrary number of mine)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (NewHabitUITests,SyncUITests,TodayRowSheetUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 20 tests, with 0 failures (0 unexpected) in 1223.442 (1223.459) seconds
	 Executed 27 tests, with 0 failures (0 unexpected) in 1509.738 (1509.761) seconds
	 Executed 27 tests, with 0 failures (0 unexpected) in 1509.738 (1509.764) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 240.222 (240.226) seconds
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (154.951 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (60.361 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (59.694 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (58.155 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (124.640 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (43.896 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (14.815 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (50.030 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (54.318 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (32.763 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (50.687 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (85.566 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (67.484 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (29.881 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (34.475 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (69.085 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (45.574 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (88.092 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (56.364 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (42.612 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (46.073 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (23.079 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (54.356 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (50.944 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (43.532 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (45.373 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (22.940 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

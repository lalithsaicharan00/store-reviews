# claude/habit-details-perf @ 2c42b97

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37176340808 · 2026-10-04 04:58 UTC
Commit: Checklists: Next Up 7, 8, 13 and 21 done (18's mental-model part), the row sheet and row layout checklists ticked, the merge recorded (the user's one-time decision; W3 stands)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitCreationUITests,NewHabitUITests,PersistenceUITests,NewFlowUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 19 tests, with 0 failures (0 unexpected) in 699.336 (699.350) seconds
	 Executed 30 tests, with 2 failures (0 unexpected) in 1712.743 (1712.774) seconds
	 Executed 30 tests, with 2 failures (0 unexpected) in 1712.743 (1712.777) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 109.906 (109.909) seconds
	 Executed 6 tests, with 2 failures (0 unexpected) in 808.638 (808.646) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:230: error: -[HabitsUITests.HabitCreationUITests testMonthAndYearShapes] : Failed to tap Button (First Match): No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate 'label BEGINSWITH "Month,"'`, given input App element pid: 33676
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:43: error: -[HabitsUITests.HabitCreationUITests testMonthAndYearShapes] : XCTAssertTrue failed - Can't find Button (First Match)
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (130.189 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (130.082 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' failed (134.697 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (151.840 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (139.345 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (122.487 seconds).
Test Case '-[HabitsUITests.NewFlowUITests testFlow]' passed (94.863 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (75.858 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (29.412 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (31.301 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (34.658 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (66.301 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (30.577 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (10.330 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (33.701 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (36.253 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (26.154 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (33.698 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (40.184 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (18.543 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (22.226 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (49.920 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (30.354 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (73.118 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (32.853 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (23.894 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (27.993 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (37.035 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (35.948 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (8.931 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

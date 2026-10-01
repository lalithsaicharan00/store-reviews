# claude/server-and-sync @ 670d321

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36923940244 · 2026-10-01 21:47 UTC
Commit: Backup & Export: 'Before You Delete the App' goes last, so Sync and the account stay near the top; tests scroll to what they check

- Core storage and migrations: success
- Build: success
- UI tests (BackupUITests,TodayUITests,ProgressUITests,NewHabitUITests,HabitCreationUITests,UndoUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 232.988 (232.996) seconds
	 Executed 19 tests, with 0 failures (0 unexpected) in 988.209 (988.223) seconds
	 Executed 6 tests, with 1 failure (0 unexpected) in 1148.136 (1148.150) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 290.607 (290.618) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:81: error: -[HabitsUITests.HabitCreationUITests testBigNumbers] : Failed to get matching snapshots: Timed out while evaluating UI query.
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (72.780 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (65.252 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (38.486 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (29.707 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (31.058 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (15.716 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (17.785 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (19.823 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' failed (121.086 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (148.655 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (329.354 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (206.205 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (166.387 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (176.449 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (110.527 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (52.425 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (58.566 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (58.351 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (101.499 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (44.304 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (12.452 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (45.219 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (36.839 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (31.447 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (44.709 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (47.785 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (26.704 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (32.104 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (63.656 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (40.771 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (94.034 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (43.934 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (42.883 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (22.302 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (12.785 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndRuns]' passed (20.847 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (30.149 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (40.287 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (25.304 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (24.010 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (9.566 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (28.154 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (19.583 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (20.559 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (39.589 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (21.123 seconds).
```

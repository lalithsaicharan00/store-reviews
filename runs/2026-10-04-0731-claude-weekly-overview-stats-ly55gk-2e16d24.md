# claude/weekly-overview-stats-ly55gk @ 2e16d24

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37183092725 · 2026-10-04 07:31 UTC
Commit: Merge main (Current Work Checklist, Product Roadmap, CI coordination T10) into the player branch; item 1 completed, 17/33/34 built and tested, waiting only for the iPhone look

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,TodayRowLayoutUITests,NewHabitUITests,ArrangeUITests,BackupUITests,ProgressUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 19 tests, with 0 failures (0 unexpected) in 1317.225 (1317.242) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 129.761 (129.766) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 354.000 (354.007) seconds
	 Executed 53 tests, with 1 failure (0 unexpected) in 2623.475 (2623.539) seconds
	 Executed 53 tests, with 1 failure (0 unexpected) in 2623.475 (2623.543) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 196.388 (196.394) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 330.935 (330.946) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 295.167 (295.177) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ArrangeUITests.swift:152: error: -[HabitsUITests.ArrangeUITests testHideCompleted] : Failed to get matching snapshot: No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate 'label BEGINSWITH "Add " AND label ENDSWITH " to Water"'`, given input App element pid: 28512
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (158.495 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (24.241 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (93.322 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (43.646 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' failed (34.296 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (52.145 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (7.260 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (37.704 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (24.046 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (26.890 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (13.771 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (12.397 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (22.175 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (121.944 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (52.124 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (50.066 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (65.219 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (144.051 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (76.615 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (18.363 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (75.032 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (95.945 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (43.508 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (65.756 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (73.438 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (31.051 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (37.418 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (92.434 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (50.173 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (126.352 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (56.883 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (40.853 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (17.520 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (31.250 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (81.193 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (55.402 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (26.965 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (20.205 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (8.804 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (29.980 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (23.848 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (54.730 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (24.263 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (24.573 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (26.195 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (24.559 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (47.400 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (24.004 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (29.232 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (30.091 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (123.261 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

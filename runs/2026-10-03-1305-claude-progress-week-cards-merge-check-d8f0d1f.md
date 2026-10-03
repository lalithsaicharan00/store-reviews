# claude/progress-week-cards-merge-check @ d8f0d1f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37122431511 · 2026-10-03 13:05 UTC
Commit: Merge main into claude/progress-week-cards again (Arrange Your Day, text limits, Next Up)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,LongTextUITests,NewHabitUITests,HabitCreationUITests,BackupUITests,PersistenceUITests,SyncUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 19 tests, with 0 failures (0 unexpected) in 718.296 (718.305) seconds
	 Executed 3 tests, with 1 failure (0 unexpected) in 110.653 (110.655) seconds
	 Executed 4 tests, with 2 failures (0 unexpected) in 104.267 (104.269) seconds
	 Executed 46 tests, with 5 failures (0 unexpected) in 2183.468 (2183.495) seconds
	 Executed 46 tests, with 5 failures (0 unexpected) in 2183.468 (2183.496) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 181.004 (181.008) seconds
	 Executed 6 tests, with 1 failure (0 unexpected) in 893.908 (893.912) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 142.661 (142.664) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ArrangeUITests.swift:150: error: -[HabitsUITests.ArrangeUITests testHideCompleted] : Failed to get matching snapshot: No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate 'label BEGINSWITH "Add " AND label ENDSWITH " to Water"'`, given input App element pid: 29781
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitCreationUITests.swift:126: error: -[HabitsUITests.HabitCreationUITests testOtherTypes] : XCTAssertTrue failed - Today shows Coffee for L1-cut-down
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:72: error: -[HabitsUITests.LongTextUITests testTodayWithLongText] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/PersistenceUITests.swift:116: error: -[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch] : XCTAssertTrue failed - The tick is still there after a relaunch
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/PersistenceUITests.swift:59: error: -[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp] : XCTAssertTrue failed - The last tap (done) is stored
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (48.304 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (5.553 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (76.745 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (23.854 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' failed (26.548 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (33.030 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (5.384 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (28.865 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (19.417 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (20.460 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (10.820 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (10.132 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (14.553 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (113.998 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (154.030 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (222.819 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' failed (139.465 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (134.633 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (128.962 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (22.341 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' passed (70.752 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' failed (17.560 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (74.368 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (31.122 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (34.905 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (35.325 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (63.396 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (31.206 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (10.332 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (35.411 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (38.977 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (24.341 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (32.879 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (40.998 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (21.270 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (23.979 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (52.332 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (33.230 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (74.712 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (34.713 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (24.800 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (27.138 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' failed (30.866 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' failed (37.350 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (8.913 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (32.678 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

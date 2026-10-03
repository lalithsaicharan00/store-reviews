# claude/progress-week-cards @ 29490af

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37129403586 · 2026-10-03 15:23 UTC
Commit: UI tests start with completed habits shown; Hide Completed test holds Today long enough on a slow simulator

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,LongTextUITests,NewHabitUITests,HabitCreationUITests,BackupUITests,PersistenceUITests,SyncUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 3 tests, with 0 failures (0 unexpected) in 163.160 (163.164) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 264.583 (264.602) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 964.942 (964.954) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 197.459 (197.471) seconds
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (94.034 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (7.697 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (93.413 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (37.757 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (31.682 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (50.248 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (11.555 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (37.325 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (24.228 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (28.488 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (15.718 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (11.783 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (18.114 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (73.730 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (132.836 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (279.243 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (163.040 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (161.823 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (154.271 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (26.318 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' passed (75.993 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' passed (60.850 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (90.164 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (39.585 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (43.085 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (59.714 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (100.510 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (40.033 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (12.799 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (46.816 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (40.158 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (30.909 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (41.732 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (49.157 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (25.558 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (35.222 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (142.111 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (50.767 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (111.005 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (47.927 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

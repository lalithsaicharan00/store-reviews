# claude/progress-week-cards-merge-check @ 569f547

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37115222096 · 2026-10-03 11:02 UTC
Commit: Rulebook check before merging into main: no "due" or "missed" in the app's words; speed scenarios for the new interactions

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (BackupUITests,PersistenceUITests,SyncUITests,OnboardingUITests,AnalyticsUITests,HabitCreationUITests,NewHabitUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 19 tests, with 0 failures (0 unexpected) in 801.052 (801.065) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 129.609 (129.613) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 53.707 (53.711) seconds
	 Executed 48 tests, with 0 failures (0 unexpected) in 2448.124 (2448.166) seconds
	 Executed 48 tests, with 0 failures (0 unexpected) in 2448.124 (2448.170) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 155.379 (155.382) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 939.192 (939.197) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 333.411 (333.417) seconds
Test Case '-[HabitsUITests.AnalyticsUITests testDurableContentFreeTracking]' passed (17.276 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testFailedPersistenceNeverCounts]' passed (7.419 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testUsageConsentIsOptionalAndSeparate]' passed (16.059 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testWelcomeConsentIsOptional]' passed (12.953 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (182.969 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (9.303 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (37.661 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (23.758 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (28.546 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (19.927 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (11.608 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (19.638 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (67.556 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testDailyShapes]' passed (115.700 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testMonthAndYearShapes]' passed (275.086 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testOtherTypes]' passed (166.572 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testSetDayShapes]' passed (170.624 seconds).
Test Case '-[HabitsUITests.HabitCreationUITests testWeeklyShapes]' passed (143.654 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (84.067 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (32.267 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (32.748 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (39.193 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (67.564 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (40.559 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (12.676 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (46.593 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (45.362 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (32.886 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (47.490 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (47.179 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (24.332 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (26.486 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (56.667 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (31.765 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (77.428 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (31.046 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (24.746 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (15.073 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNotNowAndHelp]' passed (55.463 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (5.981 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testRestoreFromTheWelcome]' passed (7.376 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipLeadsToAHelpfulToday]' passed (30.113 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' passed (41.371 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (31.186 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (45.196 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (42.574 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (10.653 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (35.775 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

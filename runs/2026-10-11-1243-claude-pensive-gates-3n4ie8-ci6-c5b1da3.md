# claude/pensive-gates-3n4ie8-ci6 @ c5b1da3

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38131144606 · 2026-10-11 12:43 UTC
Commit: Current Work 86/88: Day details' popover hangs on Today, pointing at its row; iPad tests; iPad speed runs; coming back to the iPhone

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (PlusUITests,ICloudUITests,BackupUITests,PersistenceUITests,OnboardingUITests,TestLaunchIsolationUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 322.186 (322.192) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 132.993 (132.997) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 172.734 (172.739) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 1732.476 (1732.486) seconds
Test Case '-[HabitsUITests.BackupUITests testBackupFilesInICloud]' passed (72.185 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (10.855 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverything]' passed (21.280 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (24.605 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreListsICloudAndAFile]' passed (14.679 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreSaysThisIPhone]' passed (19.677 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheICloudPageFromAnEmptyToday]' passed (9.453 seconds).
Test Case '-[HabitsUITests.ICloudUITests testADifferentAppleAccountAsksFirst]' passed (14.311 seconds).
Test Case '-[HabitsUITests.ICloudUITests testRemovedFromICloudAsksFirst]' passed (15.560 seconds).
Test Case '-[HabitsUITests.ICloudUITests testSyncAgainstTheFakeICloud]' passed (147.964 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTheExtremeAccount]' passed (1329.204 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTheICloudPageInEveryState]' passed (171.719 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTheSecondDeviceSheet]' passed (24.461 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTodaysCardWhenICloudNeedsYou]' passed (29.257 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (51.626 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' passed (21.825 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (36.218 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHabitsComeBackFromICloud]' passed (14.852 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' passed (59.939 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (22.524 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' passed (51.021 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (6.340 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' passed (22.529 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (35.314 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (33.734 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (41.913 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (45.199 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (12.147 seconds).
Test Case '-[HabitsUITests.PlusUITests testAskToBuyShowsWaiting]' passed (15.006 seconds).
Test Case '-[HabitsUITests.PlusUITests testBringingBackAnArchivedHabit]' passed (30.239 seconds).
Test Case '-[HabitsUITests.PlusUITests testBuyingPlusSavesTheSixthHabit]' passed (76.939 seconds).
Test Case '-[HabitsUITests.PlusUITests testMakeRoomArchivesOneAndGoesAhead]' passed (67.626 seconds).
Test Case '-[HabitsUITests.PlusUITests testOwnerUpgradesAndFamilyMemberPage]' passed (40.917 seconds).
Test Case '-[HabitsUITests.PlusUITests testPlusEndedIsToldOnce]' passed (12.404 seconds).
Test Case '-[HabitsUITests.PlusUITests testPlusPageAndRestoreWithNothingFound]' passed (15.186 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# app-lock-privacy-security-ci2 @ 2beebde

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37999286664 · 2026-10-09 22:57 UTC
Commit: Current Work 73.1 and 76: tests close the idea form with its own Cancel, read the one-second Setting things up page in one query, and open the menu only once Account has gone (run 37995167302)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (BackupUITests,SyncUITests,OnboardingBackupScreenshotUITests,OnboardingUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 0 failures (0 unexpected) in 383.563 (384.164) seconds
	 Executed 27 tests, with 3 failures (0 unexpected) in 971.955 (972.573) seconds
	 Executed 27 tests, with 3 failures (0 unexpected) in 971.955 (972.574) seconds
	 Executed 5 tests, with 3 failures (0 unexpected) in 207.000 (207.005) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 335.790 (335.796) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingBackupScreenshotUITests.swift:30: error: -[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome] : failed - Create my own habit not found
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingBackupScreenshotUITests.swift:30: error: -[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome] : failed - Skip setup not found
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingBackupScreenshotUITests.swift:83: error: -[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome] : XCTAssertTrue failed - Cancel returns to the ideas
Test Case '-[HabitsUITests.BackupUITests testAccountInTheMenuAndMovingToAnotherDevice]' passed (78.489 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (58.891 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (8.869 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (39.418 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (33.001 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (21.153 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (10.088 seconds).
Test Case '-[HabitsUITests.BackupUITests testICloudWithoutAnAccount]' passed (46.052 seconds).
Test Case '-[HabitsUITests.BackupUITests testPlusBackupAccountAndRestoreSayAllDevices]' passed (39.157 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreWithoutAnAccountSaysThisIPhone]' passed (18.991 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (14.299 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (15.155 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome]' failed (76.054 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testB_WelcomeBack]' passed (35.076 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testC_WelcomeReplay]' passed (24.614 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testD_BackupAndExport]' passed (50.853 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testE_PlusAndPrivacy]' passed (20.402 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (48.491 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' passed (18.240 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (32.993 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' passed (63.011 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (23.156 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' passed (61.233 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (8.841 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' passed (45.128 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (34.696 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (45.602 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

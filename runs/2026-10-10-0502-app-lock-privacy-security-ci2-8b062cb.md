# app-lock-privacy-security-ci2 @ 8b062cb

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38024262349 · 2026-10-10 05:02 UTC
Commit: Current Work 75: a fresh install finds its iCloud backup, and never writes over files iCloud hasn't brought down yet

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (BackupUITests,OnboardingUITests,OnboardingBackupScreenshotUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 1 failure (0 unexpected) in 435.841 (435.849) seconds
	 Executed 26 tests, with 1 failure (0 unexpected) in 989.385 (989.405) seconds
	 Executed 26 tests, with 1 failure (0 unexpected) in 989.385 (989.407) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 210.543 (210.546) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 343.001 (343.009) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:290: error: -[HabitsUITests.BackupUITests testAccountInTheMenuAndMovingToAnotherDevice] : XCTAssertTrue failed - Back | Account | Vertical scroll bar, 1 page | Not signed in, Your habits are only on this iPhone. | Sign In | Create Account | With an account, your habits are backed up to it as you go, and come back when you sign in on a new phone or tablet. | A free account is for one device. Syncing several devices is part of Plus. | Account | Not signed in | Your habits are only on this iPhone. | Sign In | Forward | Create Account | Forward
Test Case '-[HabitsUITests.BackupUITests testAccountInTheMenuAndMovingToAnotherDevice]' failed (123.106 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (46.729 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (8.875 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (38.239 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (25.615 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (23.804 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (9.809 seconds).
Test Case '-[HabitsUITests.BackupUITests testICloudWithoutAnAccount]' passed (52.236 seconds).
Test Case '-[HabitsUITests.BackupUITests testPlusBackupAccountAndRestoreSayAllDevices]' passed (48.423 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreWithoutAnAccountSaysThisIPhone]' passed (21.989 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (16.228 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (20.788 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome]' passed (80.995 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testB_WelcomeBack]' passed (35.029 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testC_WelcomeReplay]' passed (21.123 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testD_BackupAndExport]' passed (53.292 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testE_PlusAndPrivacy]' passed (20.104 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (50.969 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' passed (17.885 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (35.931 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' passed (66.914 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (27.234 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' passed (55.770 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (7.180 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' passed (47.735 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (33.382 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

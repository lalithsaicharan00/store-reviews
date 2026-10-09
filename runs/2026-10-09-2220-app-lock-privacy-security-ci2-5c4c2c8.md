# app-lock-privacy-security-ci2 @ 5c4c2c8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37995167302 · 2026-10-09 22:20 UTC
Commit: Current Work 58.13: the SE test's App Lock row has its own name (it hid the test's row helper)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (BackupUITests,SyncUITests,OnboardingBackupScreenshotUITests,OnboardingUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 1 failure (0 unexpected) in 448.671 (448.681) seconds
	 Executed 27 tests, with 4 failures (0 unexpected) in 1055.190 (1055.218) seconds
	 Executed 27 tests, with 4 failures (0 unexpected) in 1055.190 (1055.220) seconds
	 Executed 5 tests, with 2 failures (0 unexpected) in 215.650 (215.659) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 340.685 (340.692) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:438: error: -[HabitsUITests.BackupUITests testAccountInTheMenuAndMovingToAnotherDevice] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingBackupScreenshotUITests.swift:30: error: -[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome] : failed - Create my own habit not found
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingBackupScreenshotUITests.swift:30: error: -[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome] : failed - Skip setup not found
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingUITests.swift:334: error: -[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst] : Failed to get matching snapshot: No matches found for Elements matching predicate '"onboarding-page-working" IN identifiers' from input {(
Test Case '-[HabitsUITests.BackupUITests testAccountInTheMenuAndMovingToAnotherDevice]' failed (108.008 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (54.276 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (8.836 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (35.626 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (23.515 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (24.095 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (11.460 seconds).
Test Case '-[HabitsUITests.BackupUITests testICloudWithoutAnAccount]' passed (59.059 seconds).
Test Case '-[HabitsUITests.BackupUITests testPlusBackupAccountAndRestoreSayAllDevices]' passed (48.127 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreWithoutAnAccountSaysThisIPhone]' passed (27.706 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (25.797 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (22.167 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome]' failed (72.706 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testB_WelcomeBack]' passed (36.025 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testC_WelcomeReplay]' passed (21.685 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testD_BackupAndExport]' passed (64.175 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testE_PlusAndPrivacy]' passed (21.059 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (51.491 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' failed (19.150 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (35.740 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' passed (57.535 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (22.804 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' passed (57.490 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (8.118 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' passed (51.709 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (36.650 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (50.184 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# app-lock-privacy-security-ci2 @ 8b453f0

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38039875406 · 2026-10-10 09:35 UTC
Commit: Tests for free sync and the move: the right alert, the file picker's ✕, Water for the old device's habits; the closed sidebar is no longer an "alert"

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (BackupUITests,OnboardingUITests,OnboardingBackupScreenshotUITests,SyncUITests,AnalyticsUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 360.233 (360.239) seconds
	 Executed 12 tests, with 1 failure (0 unexpected) in 391.713 (391.721) seconds
	 Executed 32 tests, with 1 failure (0 unexpected) in 1079.025 (1079.051) seconds
	 Executed 32 tests, with 1 failure (0 unexpected) in 1079.025 (1079.052) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 53.574 (53.577) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 224.529 (224.533) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:66: error: -[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet] : XCTAssertTrue failed - Attributes: Application, 0x1135e1180, pid: 41434, label: 'Often Enough'
Test Case '-[HabitsUITests.AnalyticsUITests testDurableContentFreeTracking]' passed (20.182 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testFailedPersistenceNeverCounts]' passed (6.803 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testUsageConsentIsOptionalAndSeparate]' passed (15.853 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testWelcomeConsentIsOptional]' passed (10.736 seconds).
Test Case '-[HabitsUITests.BackupUITests testAccountInTheMenuAndMovingToAnotherDevice]' passed (45.894 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountSyncsOnOneDevice]' passed (89.026 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (8.792 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (37.798 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (20.537 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' failed (25.874 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (12.270 seconds).
Test Case '-[HabitsUITests.BackupUITests testICloudWithoutAnAccount]' passed (46.836 seconds).
Test Case '-[HabitsUITests.BackupUITests testPlusBackupAccountAndRestoreSayAllDevices]' passed (39.002 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreWithoutAnAccountSaysThisIPhone]' passed (18.926 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (17.908 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (28.849 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome]' passed (70.277 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testB_WelcomeBack]' passed (34.630 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testC_WelcomeReplay]' passed (26.442 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testD_BackupAndExport]' passed (73.993 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testE_PlusAndPrivacy]' passed (19.186 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (49.233 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' passed (16.359 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (34.416 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' passed (57.181 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (23.369 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testMoveFromAnotherDeviceThroughTheServer]' passed (33.969 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' passed (52.517 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (7.911 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' passed (48.850 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (36.428 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (48.976 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

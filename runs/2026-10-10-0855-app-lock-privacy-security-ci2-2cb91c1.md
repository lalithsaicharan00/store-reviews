# app-lock-privacy-security-ci2 @ 2cb91c1

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38037588319 · 2026-10-10 08:55 UTC
Commit: Merge remote-tracking branch 'origin/app-lock-privacy-security' into app-lock-privacy-security

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (BackupUITests,OnboardingUITests,OnboardingBackupScreenshotUITests,SyncUITests,AnalyticsUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 2 failures (0 unexpected) in 378.105 (378.113) seconds
	 Executed 12 tests, with 3 failures (2 unexpected) in 315.260 (315.266) seconds
	 Executed 32 tests, with 9 failures (2 unexpected) in 1144.984 (1145.013) seconds
	 Executed 32 tests, with 9 failures (2 unexpected) in 1144.984 (1145.014) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 76.098 (76.102) seconds
	 Executed 5 tests, with 3 failures (0 unexpected) in 339.753 (339.758) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:222: error: -[HabitsUITests.BackupUITests testAFreeAccountSyncsOnOneDevice] : XCTAssertFalse failed - The notice is shown once
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:445: error: -[HabitsUITests.BackupUITests testICloudWithoutAnAccount] : XCTAssertTrue failed: throwing "NSInternalInconsistencyException: Invalid query - string identifier 'iCloud backs up your habits automatically. A free account syncs them on one device and brings them back when you sign in on a new device.' exceeds maximum length of 128 characters. You can work around this limitation by constructing a query with a custom NSPredicate that specifies the property (label, title, value, placeholderValue, or identifier) to match against." - Back | Backup & Export | Vertical scroll bar, 2 pages
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:87: error: -[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone] : XCTAssertTrue failed: throwing "NSInternalInconsistencyException: Invalid query - string identifier 'iCloud backs up your habits automatically. A free account syncs them on one device and brings them back when you sign in on a new device.' exceeds maximum length of 128 characters. You can work around this limitation by constructing a query with a custom NSPredicate that specifies the property (label, title, value, placeholderValue, or identifier) to match against." - Back | Backup & Export | Vertical scroll bar, 2 pages
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingBackupScreenshotUITests.swift:186: error: -[HabitsUITests.OnboardingBackupScreenshotUITests testD_BackupAndExport] : XCTAssertTrue failed - OK closes it
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingBackupScreenshotUITests.swift:30: error: -[HabitsUITests.OnboardingBackupScreenshotUITests testD_BackupAndExport] : failed - Erase All My Data not found
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingBackupScreenshotUITests.swift:30: error: -[HabitsUITests.OnboardingBackupScreenshotUITests testD_BackupAndExport] : failed - Your Account not found
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingUITests.swift:314: error: -[HabitsUITests.OnboardingUITests testReturningWaysBack] : Failed to get matching snapshot: Find single matching element. Multiple matching elements found for <XCUIElementQuery: 0x10a41a170>.
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingUITests.swift:333: error: -[HabitsUITests.OnboardingUITests testMoveFromAnotherDeviceThroughTheServer] : XCTAssertTrue failed - The old device has the demo habits
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SyncUITests.swift:94: error: -[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice] : XCTAssertTrue failed - Signed in, the copies are in the account: Synced, Just now · 2 devices
Test Case '-[HabitsUITests.AnalyticsUITests testDurableContentFreeTracking]' passed (12.153 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testFailedPersistenceNeverCounts]' passed (7.129 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testUsageConsentIsOptionalAndSeparate]' passed (47.319 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testWelcomeConsentIsOptional]' passed (9.496 seconds).
Test Case '-[HabitsUITests.BackupUITests testAccountInTheMenuAndMovingToAnotherDevice]' passed (40.253 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountSyncsOnOneDevice]' failed (66.503 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (6.692 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (36.599 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (20.238 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (20.774 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (9.647 seconds).
Test Case '-[HabitsUITests.BackupUITests testICloudWithoutAnAccount]' failed (14.892 seconds).
Test Case '-[HabitsUITests.BackupUITests testPlusBackupAccountAndRestoreSayAllDevices]' passed (37.943 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreWithoutAnAccountSaysThisIPhone]' passed (20.175 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (16.358 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' failed (25.188 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome]' passed (95.354 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testB_WelcomeBack]' passed (99.178 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testC_WelcomeReplay]' passed (25.664 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testD_BackupAndExport]' failed (99.533 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testE_PlusAndPrivacy]' passed (20.024 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (51.692 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' passed (18.932 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (37.165 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' passed (72.967 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (28.247 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testMoveFromAnotherDeviceThroughTheServer]' failed (21.775 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' passed (57.389 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (7.697 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' failed (42.206 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (40.035 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' failed (35.769 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

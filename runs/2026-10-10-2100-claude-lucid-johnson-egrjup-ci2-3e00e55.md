# claude/lucid-johnson-egrjup-ci2 @ 3e00e55

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38083494538 · 2026-10-10 21:00 UTC
Commit: iCloud sync: Design Rules' iCloud page, What's Built, and what's left for the user in item 81

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (BackupUITests,OnboardingUITests,OnboardingBackupScreenshotUITests,TodayUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 295.302 (295.307) seconds
	 Executed 30 tests, with 2 failures (0 unexpected) in 1025.971 (1025.994) seconds
	 Executed 30 tests, with 2 failures (0 unexpected) in 1025.971 (1025.997) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 275.122 (275.127) seconds
	 Executed 7 tests, with 2 failures (0 unexpected) in 214.108 (214.112) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 241.439 (241.443) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:22: error: -[HabitsUITests.BackupUITests testBackupIntegrityChecks] : XCTAssertTrue failed - Attributes: Application, 0x108365e00, pid: 42833, label: 'Often Enough'
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:44: error: -[HabitsUITests.BackupUITests testTheICloudPageFromAnEmptyToday] : XCTAssertFalse failed - Sign In
Test Case '-[HabitsUITests.BackupUITests testBackupFilesInICloud]' passed (58.355 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' failed (65.707 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverything]' passed (22.919 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (24.566 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreListsICloudAndAFile]' passed (14.145 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreSaysThisIPhone]' passed (18.626 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheICloudPageFromAnEmptyToday]' failed (9.790 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome]' passed (64.136 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testB_WelcomeBack]' passed (31.446 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testC_WelcomeReplay]' passed (19.030 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testD_ICloudAndBackup]' passed (132.754 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testE_PlusAndPrivacy]' passed (27.757 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (46.659 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' passed (15.842 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (31.934 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHabitsComeBackFromICloud]' passed (13.055 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' passed (55.273 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (22.510 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' passed (50.958 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (6.595 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' passed (20.823 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (31.653 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (17.146 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (36.106 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (15.901 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (21.007 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (10.636 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (98.291 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (10.171 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (32.182 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

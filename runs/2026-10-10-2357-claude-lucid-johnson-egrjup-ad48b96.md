# claude/lucid-johnson-egrjup @ ad48b96

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38094553071 · 2026-10-10 23:57 UTC
Commit: Merge main (the Plus screens) into claude/lucid-johnson-egrjup

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ICloudUITests/testSyncAgainstTheFakeICloud,ICloudUITests/testTheICloudPageInEveryState,ICloudUITests/testTodaysCardWhenICloudNeedsYou,ICloudUITests/testRemovedFromICloudAsksFirst,ICloudUITests/testADifferentAppleAccountAsksFirst,ICloudUITests/testTheSecondDeviceSheet,BackupUITests,OnboardingBackupScreenshotUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 18 tests, with 2 failures (0 unexpected) in 1103.024 (1103.040) seconds
	 Executed 18 tests, with 2 failures (0 unexpected) in 1103.024 (1103.042) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 253.495 (253.498) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 620.601 (620.606) seconds
	 Executed 7 tests, with 2 failures (0 unexpected) in 228.928 (228.934) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:213: error: -[HabitsUITests.BackupUITests testBackupFilesInICloud] : XCTAssertTrue failed - Vertical scroll bar, 1 page | Menu | Edit | Filter | New Habit
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:91: error: -[HabitsUITests.BackupUITests testErasingEverything] : XCTAssertFalse failed - The demo habits are there to start with
Test Case '-[HabitsUITests.BackupUITests testBackupFilesInICloud]' failed (118.338 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (14.855 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverything]' failed (10.265 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (37.574 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreListsICloudAndAFile]' passed (16.886 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreSaysThisIPhone]' passed (20.900 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheICloudPageFromAnEmptyToday]' passed (10.110 seconds).
Test Case '-[HabitsUITests.ICloudUITests testADifferentAppleAccountAsksFirst]' passed (15.970 seconds).
Test Case '-[HabitsUITests.ICloudUITests testRemovedFromICloudAsksFirst]' passed (16.900 seconds).
Test Case '-[HabitsUITests.ICloudUITests testSyncAgainstTheFakeICloud]' passed (144.197 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTheICloudPageInEveryState]' passed (397.672 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTheSecondDeviceSheet]' passed (20.696 seconds).
Test Case '-[HabitsUITests.ICloudUITests testTodaysCardWhenICloudNeedsYou]' passed (25.167 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome]' passed (67.915 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testB_WelcomeBack]' passed (34.781 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testC_WelcomeReplay]' passed (20.018 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testD_ICloudAndBackup]' passed (111.133 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testE_PlusAndPrivacy]' passed (19.648 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

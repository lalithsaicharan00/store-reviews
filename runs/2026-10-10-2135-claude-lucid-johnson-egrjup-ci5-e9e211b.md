# claude/lucid-johnson-egrjup-ci5 @ e9e211b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38086171673 · 2026-10-10 21:35 UTC
Commit: Tests: the reminder check says what failed; the iCloud page test allows iCloud's own "Sign in to iCloud"

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (RemindersUITests/testPlanningActionsPermissionsFailuresAndClockChanges,BackupUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 7 tests, with 1 failure (0 unexpected) in 193.934 (193.940) seconds
	 Executed 8 tests, with 1 failure (0 unexpected) in 261.383 (261.393) seconds
	 Executed 8 tests, with 1 failure (0 unexpected) in 261.383 (261.394) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:24: error: -[HabitsUITests.BackupUITests testBackupIntegrityChecks] : XCTAssertEqual failed: ("Backup failed: folder: the weeks' copies are a week apart") is not equal to ("Backup: all checks passed")
Test Case '-[HabitsUITests.BackupUITests testBackupFilesInICloud]' passed (79.026 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' failed (9.100 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverything]' passed (23.230 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (26.621 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreListsICloudAndAFile]' passed (17.949 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreSaysThisIPhone]' passed (24.269 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheICloudPageFromAnEmptyToday]' passed (13.739 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (67.449 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

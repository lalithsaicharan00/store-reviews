# app-lock-privacy-security-base @ f7d6d2c

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37902867982 · 2026-10-09 08:30 UTC
Commit: Current Work 58.10: the test taps Save a Backup File by its id, now that the row has a line under it (run 37898228068)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (BackupUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 9 tests, with 1 failure (0 unexpected) in 315.740 (315.771) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 315.740 (315.774) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 315.740 (315.776) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:252: error: -[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone] : XCTAssertTrue failed
Test Case '-[HabitsUITests.BackupUITests testAccountInTheMenuAndMovingToANewIPhone]' passed (46.080 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (47.995 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (7.884 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' failed (104.221 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (28.724 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (35.963 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (13.060 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (12.040 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (19.773 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

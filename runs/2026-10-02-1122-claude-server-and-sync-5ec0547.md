# claude/server-and-sync @ 5ec0547

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36998817823 · 2026-10-02 11:22 UTC
Commit: Data safety: a test launch can't reach the person's account, backups or local copies on a real iPhone

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (BackupUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 8 tests, with 0 failures (0 unexpected) in 250.361 (250.374) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 250.361 (250.375) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 250.361 (250.377) seconds
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (54.603 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (39.074 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (55.893 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (24.181 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (28.582 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (18.616 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (11.192 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (18.220 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

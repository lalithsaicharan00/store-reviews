# claude/server-and-sync @ e111ea7

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36891224528 · 2026-10-01 16:35 UTC
Commit: Account: devices, sign-in methods, delete account (with an optional erase of this iPhone)

- Build: success
- UI tests (BackupUITests): failure
- Speed tests: skipped

## UI tests
```
	 Executed 4 tests, with 1 failure (0 unexpected) in 197.924 (197.930) seconds
	 Executed 4 tests, with 1 failure (0 unexpected) in 197.924 (197.931) seconds
	 Executed 4 tests, with 1 failure (0 unexpected) in 197.924 (197.932) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:105: error: -[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone] : XCTUnwrap failed: expected non-nil value of type "String" - ["message": There's no account for this sign-in yet., "error": unknown_key]
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (140.608 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' failed (21.385 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (10.049 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (25.883 seconds).
```

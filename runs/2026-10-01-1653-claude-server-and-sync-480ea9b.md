# claude/server-and-sync @ 480ea9b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36893392425 · 2026-10-01 16:53 UTC
Commit: BackupUITests: the other device signs in only after the app has made the account

- Build: success
- UI tests (BackupUITests,SyncUITests,TodayUITests): failure
- Speed tests: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 55.148 (55.149) seconds
	 Executed 4 tests, with 1 failure (0 unexpected) in 195.817 (195.822) seconds
	 Executed 7 tests, with 1 failure (0 unexpected) in 297.226 (297.241) seconds
	 Executed 7 tests, with 1 failure (0 unexpected) in 297.226 (297.244) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:117: error: -[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone] : XCTAssertTrue failed - It asks about this iPhone's habits
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (139.597 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' failed (30.941 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (10.717 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (14.562 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (46.261 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (22.637 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (32.511 seconds).
```

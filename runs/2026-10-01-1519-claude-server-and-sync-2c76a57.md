# claude/server-and-sync @ 2c76a57

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36881841127 · 2026-10-01 15:19 UTC
Commit: iPhone: Backup & Sync, sign-in, restore, problem card

- Build: success
- UI tests (BackupUITests,SyncUITests,PersistenceUITests,TodayUITests): failure
- Speed tests: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 50.600 (50.601) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 61.434 (61.435) seconds
	 Executed 3 tests, with 2 failures (0 unexpected) in 134.357 (134.361) seconds
	 Executed 8 tests, with 2 failures (0 unexpected) in 304.505 (304.516) seconds
	 Executed 8 tests, with 2 failures (0 unexpected) in 304.505 (304.517) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:26: error: -[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:68: error: -[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer] : XCTAssertTrue failed - Signed in: the backup goes to the account
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' failed (58.951 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (9.172 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' failed (66.234 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (52.228 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (9.206 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (58.115 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (19.082 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (31.518 seconds).
```

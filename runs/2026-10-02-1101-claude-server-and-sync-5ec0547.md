# claude/server-and-sync @ 5ec0547

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36995529935 · 2026-10-02 11:01 UTC
Commit: Data safety: a test launch can't reach the person's account, backups or local copies on a real iPhone

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (BackupUITests,SyncUITests,PersistenceUITests,OnboardingUITests,TodayUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 27 tests, with 1 failure (0 unexpected) in 909.471 (909.500) seconds
	 Executed 27 tests, with 1 failure (0 unexpected) in 909.471 (909.502) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 138.010 (138.013) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 186.391 (186.395) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 270.217 (270.224) seconds
	 Executed 8 tests, with 1 failure (0 unexpected) in 277.298 (277.309) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:209: error: -[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone] : XCTAssertTrue failed
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (55.780 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (8.084 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' failed (103.494 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (39.087 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (27.221 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (13.036 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (11.402 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (19.193 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (18.722 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNotNowAndHelp]' passed (68.325 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (7.487 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testRestoreFromTheWelcome]' passed (11.170 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipLeadsToAHelpfulToday]' passed (34.302 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' passed (46.384 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (39.370 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (49.365 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (38.987 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (10.288 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (37.556 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (19.871 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (38.499 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (19.378 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (25.520 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (13.996 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (102.501 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (13.865 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (36.587 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

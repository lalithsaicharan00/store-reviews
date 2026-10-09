# app-lock-privacy-security-base @ b10bcb9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37920022403 · 2026-10-09 11:23 UTC
Commit: Current Work 58.12: Backup & Export says iCloud backs up without an account, why to create one, and the one-device limit

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (BackupUITests,SyncUITests,TodayUITests,OnboardingUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 326.403 (326.415) seconds
	 Executed 26 tests, with 0 failures (0 unexpected) in 920.441 (920.478) seconds
	 Executed 26 tests, with 0 failures (0 unexpected) in 920.441 (920.480) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 233.949 (233.961) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 299.409 (299.417) seconds
Test Case '-[HabitsUITests.BackupUITests testAccountInTheMenuAndMovingToANewIPhone]' passed (39.581 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (62.111 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (12.816 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (39.267 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (45.364 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (25.440 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (14.754 seconds).
Test Case '-[HabitsUITests.BackupUITests testICloudWithoutAnAccount]' passed (57.952 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (11.648 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (17.471 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (32.588 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (20.002 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNotNowAndHelp]' passed (70.692 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (10.526 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testRestoreFromTheWelcome]' passed (11.803 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipLeadsToAHelpfulToday]' passed (36.762 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' passed (51.575 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (60.680 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (20.266 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (45.177 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (21.662 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (34.053 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (19.235 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (113.081 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (14.127 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (31.808 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

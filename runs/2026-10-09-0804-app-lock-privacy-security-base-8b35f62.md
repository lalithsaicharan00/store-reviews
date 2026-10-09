# app-lock-privacy-security-base @ 8b35f62

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37898228068 · 2026-10-09 08:04 UTC
Commit: Current Work 58.10–58.11: Backup & Export redesigned from research; Account in the menu

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (BackupUITests,TodayUITests,OnboardingUITests,SyncUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 25 tests, with 1 failure (0 unexpected) in 982.774 (982.804) seconds
	 Executed 25 tests, with 1 failure (0 unexpected) in 982.774 (982.806) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 244.841 (244.850) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 336.609 (336.617) seconds
	 Executed 9 tests, with 1 failure (0 unexpected) in 357.699 (357.707) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:84: error: -[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone] : Failed to tap "Save a Backup File" Button: No matches found for Elements matching predicate '"Save a Backup File" IN identifiers' from input {(
Test Case '-[HabitsUITests.BackupUITests testAccountInTheMenuAndMovingToANewIPhone]' passed (54.483 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (131.551 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (10.340 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (56.706 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (29.625 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (28.457 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (11.230 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (12.533 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' failed (22.773 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (33.193 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (18.303 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNotNowAndHelp]' passed (73.033 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (8.341 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testRestoreFromTheWelcome]' passed (12.432 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipLeadsToAHelpfulToday]' passed (47.756 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' passed (51.783 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (43.625 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (32.963 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (49.354 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (25.657 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (29.771 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (16.398 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (126.364 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (12.840 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (43.262 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

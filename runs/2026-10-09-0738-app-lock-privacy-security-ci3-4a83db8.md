# app-lock-privacy-security-ci3 @ 4a83db8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37896911637 · 2026-10-09 07:38 UTC
Commit: Current Work 58.10–58.11: the user's Backup & Export and account points, recorded before the research (W1)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TimerUITests,UndoUITests,SyncUITests,BackupUITests,PersistenceUITests,AppReliabilityUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 27 tests, with 0 failures (0 unexpected) in 908.985 (909.012) seconds
	 Executed 27 tests, with 0 failures (0 unexpected) in 908.985 (909.015) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 153.358 (153.360) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 141.793 (141.798) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 233.135 (233.141) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 235.770 (235.775) seconds
Test Case '-[HabitsUITests.AppReliabilityUITests testBurstsRetriesStormsMidnightTravelAndAYear]' passed (99.148 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (85.777 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (8.260 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (37.937 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (28.977 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (28.064 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (15.542 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (13.797 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (17.416 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (42.543 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (49.557 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (49.506 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (11.752 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (45.782 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (32.602 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (36.045 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (30.696 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (17.518 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (24.932 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (38.418 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (48.550 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (33.145 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogManuallyAddsOneLog]' passed (28.419 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (21.253 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (19.262 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (30.130 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (13.958 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

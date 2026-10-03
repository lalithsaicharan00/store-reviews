# claude/habit-details-ci @ 9a0b575

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37133199342 · 2026-10-03 15:54 UTC
Commit: Calendar tests: the calendar's dates are plain (2 Oct decision), so the day's count is checked on the day bar

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,LongTextUITests,PersistenceUITests,SyncUITests,BackupUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 21 tests, with 1 failure (0 unexpected) in 856.036 (856.071) seconds
	 Executed 21 tests, with 1 failure (0 unexpected) in 856.036 (856.075) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 231.748 (231.761) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 138.379 (138.382) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 276.756 (276.762) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 169.371 (169.379) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ArrangeUITests.swift:24: error: -[HabitsUITests.ArrangeUITests testAddTimeOfDay] : Failed to launch <XCUIApplicationImpl: 0x10a406b80 com.oftenenough.app at /Users/runner/work/store-reviews/store-reviews/iOS/DerivedData/Build/Products/Debug-iphonesimulator/Habits.app> via Xcode: Timed out while launching application via Xcode.
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' failed (69.857 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (30.258 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (93.466 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (52.375 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (30.800 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (40.563 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (6.843 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (33.424 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (22.450 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (25.815 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (12.156 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (10.755 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (17.362 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (26.794 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' passed (142.577 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' passed (62.377 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (35.209 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (49.304 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (43.131 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (10.735 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (39.783 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

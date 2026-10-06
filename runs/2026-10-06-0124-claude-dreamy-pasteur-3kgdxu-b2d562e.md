# claude/dreamy-pasteur-3kgdxu @ b2d562e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37395447112 · 2026-10-06 01:24 UTC
Commit: FocusPlayerUITests: the slow-write navigation test injects 4 s writes and allows 3 s (a wait still fails); › is now a Liquid Glass bar button whose press animation XCUITest waits out (~0.9 s, run 37387468173)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetUITests,WidgetSystemUITests,TasksUITests,LongTextUITests,PersistenceUITests,BackupUITests,GroupsUITests/testGroupOrderIsThePersonsOwn,OnboardingUITests/testWelcomeToFirstHabit): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 256.077 (256.087) seconds
	 Executed 27 tests, with 1 test skipped and 2 failures (0 unexpected) in 1295.511 (1295.555) seconds
	 Executed 27 tests, with 1 test skipped and 2 failures (0 unexpected) in 1295.511 (1295.557) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 132.731 (132.733) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 185.369 (185.372) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 151.477 (151.479) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 182.450 (182.453) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 303.701 (303.713) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:332: error: -[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn] : XCTAssertTrue failed - Your order, with Sort A to Z
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingUITests.swift:108: error: -[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit] : XCTAssertTrue failed - The new habit shows on Today
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (71.224 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (12.553 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (107.160 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (28.082 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (33.108 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (17.398 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (15.670 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (18.507 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' failed (33.252 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (44.229 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' passed (86.333 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' passed (54.807 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' failed (50.456 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (39.574 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (46.414 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (51.990 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (13.499 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (48.748 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (76.650 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (7.333 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (189.953 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (129.376 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (20.432 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (17.697 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (7.787 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (7.158 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

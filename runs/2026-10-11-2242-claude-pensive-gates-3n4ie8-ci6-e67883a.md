# claude/pensive-gates-3n4ie8-ci6 @ e67883a

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38179032673 · 2026-10-11 22:42 UTC
Commit: Merge main (the Apple Watch app, Google Drive sync in the core, docs) into the iPad build

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (PlusUITests,PersistenceUITests,WidgetUITests,WidgetSystemUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 250.434 (250.439) seconds
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 265.710 (265.716) seconds
	 Executed 23 tests, with 2 tests skipped and 0 failures (0 unexpected) in 1061.513 (1061.539) seconds
	 Executed 23 tests, with 2 tests skipped and 0 failures (0 unexpected) in 1061.513 (1061.540) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 262.118 (262.124) seconds
	 Executed 7 tests, with 1 test skipped and 0 failures (0 unexpected) in 283.251 (283.257) seconds
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (125.410 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (78.646 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (46.993 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (11.068 seconds).
Test Case '-[HabitsUITests.PlusUITests testAskToBuyShowsWaiting]' passed (16.974 seconds).
Test Case '-[HabitsUITests.PlusUITests testBringingBackAnArchivedHabit]' passed (29.247 seconds).
Test Case '-[HabitsUITests.PlusUITests testBuyingPlusSavesTheSixthHabit]' passed (37.936 seconds).
Test Case '-[HabitsUITests.PlusUITests testMakeRoomArchivesOneAndGoesAhead]' passed (28.199 seconds).
Test Case '-[HabitsUITests.PlusUITests testOwnerUpgradesAndFamilyMemberPage]' passed (34.916 seconds).
Test Case '-[HabitsUITests.PlusUITests testPlusEndedIsToldOnce]' passed (10.664 seconds).
Test Case '-[HabitsUITests.PlusUITests testPlusPageAndRestoreWithNothingFound]' passed (18.152 seconds).
Test Case '-[HabitsUITests.PlusUITests testPricesThatFailShowTryAgain]' passed (35.553 seconds).
Test Case '-[HabitsUITests.PlusUITests testSecondDeviceSheetOpensThePlusPage]' passed (18.263 seconds).
Test Case '-[HabitsUITests.PlusUITests testSixthHabitSheetOffersBothPlansAndNoNotNow]' passed (20.531 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (162.269 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (184.342 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (35.270 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (27.657 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (15.036 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (12.647 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (8.139 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# claude/exciting-mccarthy-g6vlu5 @ a26c5ae

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37865611952 · 2026-10-09 01:18 UTC
Commit: Merge main (Current Work 67-72 sync and reliability, 58 research) into the cloud session's branch

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (GroupsUITests,TestLaunchIsolationUITests,WidgetUITests,ArrangeUITests,TodayUITests,PersistenceUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 1 failure (0 unexpected) in 611.047 (611.060) seconds
	 Executed 34 tests, with 1 failure (0 unexpected) in 1590.541 (1590.584) seconds
	 Executed 34 tests, with 1 failure (0 unexpected) in 1590.541 (1590.587) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 148.266 (148.271) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 255.195 (255.201) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 241.299 (241.304) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 275.177 (275.185) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:393: error: -[HabitsUITests.GroupsUITests testGroupDragDropsReliably] : XCTAssertEqual failed: ("1") is not equal to ("0") - Every drag takes: app: 1 of 6 missed
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (78.428 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (11.455 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (89.506 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (40.036 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (35.771 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (47.755 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (44.672 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (72.735 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (52.311 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' failed (134.468 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (79.824 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (44.108 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (50.344 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (42.442 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (42.388 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (41.197 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (51.125 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (45.323 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (10.620 seconds).
Test Case '-[HabitsUITests.TestLaunchIsolationUITests testATestLaunchLeavesThePersonsWidgetsAndSettings]' passed (59.558 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (20.595 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (41.932 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (23.009 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (25.004 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (12.656 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (102.386 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (15.684 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (33.912 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (140.926 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (23.081 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (31.067 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (18.473 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (17.768 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (9.984 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

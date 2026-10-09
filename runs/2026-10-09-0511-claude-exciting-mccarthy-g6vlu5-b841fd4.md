# claude/exciting-mccarthy-g6vlu5 @ b841fd4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37883781450 · 2026-10-09 05:11 UTC
Commit: Rulebook T10 and CLAUDE.md: never wait for another agent's runs; temporary branches of your own for parallel runs (the user, 9 Oct 2026)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (GroupsUITests,TestLaunchIsolationUITests,WidgetUITests,ArrangeUITests,TodayUITests,PersistenceUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 650.607 (650.619) seconds
	 Executed 34 tests, with 0 failures (0 unexpected) in 1685.094 (1685.134) seconds
	 Executed 34 tests, with 0 failures (0 unexpected) in 1685.094 (1685.136) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 145.349 (145.353) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 344.822 (344.832) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 225.569 (225.574) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 265.948 (265.953) seconds
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (81.729 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (95.494 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (86.199 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (44.893 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (36.508 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (36.141 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (44.236 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (79.084 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (53.293 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' passed (126.130 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (75.448 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (46.202 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (47.407 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (99.886 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (42.778 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (44.587 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (46.487 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (43.369 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (10.906 seconds).
Test Case '-[HabitsUITests.TestLaunchIsolationUITests testATestLaunchLeavesThePersonsWidgetsAndSettings]' passed (52.799 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (19.466 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (42.188 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (20.362 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (25.497 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (14.906 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (96.805 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (13.040 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (33.684 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (135.481 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (20.700 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (30.060 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (16.555 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (14.482 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (8.291 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

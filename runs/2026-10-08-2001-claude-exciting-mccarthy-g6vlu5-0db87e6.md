# claude/exciting-mccarthy-g6vlu5 @ 0db87e6

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37831649390 · 2026-10-08 20:01 UTC
Commit: Current Work 74: a test launch keeps its own widget folder and holds the person's settings aside (D8)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TestLaunchIsolationUITests,WidgetUITests,ArrangeUITests,TodayUITests,PersistenceUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 24 tests, with 0 failures (0 unexpected) in 1048.020 (1048.049) seconds
	 Executed 24 tests, with 0 failures (0 unexpected) in 1048.020 (1048.052) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 140.349 (140.352) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 325.959 (325.968) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 239.709 (239.713) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 287.901 (287.908) seconds
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (69.682 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (9.681 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (163.206 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (50.818 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (32.571 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (36.220 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (46.831 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (46.495 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (10.804 seconds).
Test Case '-[HabitsUITests.TestLaunchIsolationUITests testATestLaunchLeavesThePersonsWidgetsAndSettings]' passed (54.102 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (23.874 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (44.033 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (22.799 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (27.335 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (14.497 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (105.615 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (14.247 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (35.502 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (149.451 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (19.969 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (29.462 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (16.891 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (15.279 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (8.656 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

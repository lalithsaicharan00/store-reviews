# claude/widget-implementation-testing-ki9pva @ 92f1a77

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37525264513 · 2026-10-06 20:54 UTC
Commit: Rulebook: U26 (widgets draw only what the app worked out; lists, order and buttons) and T14 (one-line failure messages; a system test's database is the fixture's alone)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetUITests,AppReliabilityUITests,TodayUITests,TimerUITests,UndoUITests,PersistenceUITests,AnalyticsUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 36 tests, with 0 failures (0 unexpected) in 1200.501 (1200.540) seconds
	 Executed 36 tests, with 0 failures (0 unexpected) in 1200.501 (1200.543) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 152.307 (152.310) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 59.647 (59.655) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 138.812 (138.818) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 234.716 (234.720) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 238.584 (238.589) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 301.483 (301.489) seconds
Test Case '-[HabitsUITests.AnalyticsUITests testDurableContentFreeTracking]' passed (20.398 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testFailedPersistenceNeverCounts]' passed (7.952 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testUsageConsentIsOptionalAndSeparate]' passed (19.426 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testWelcomeConsentIsOptional]' passed (11.870 seconds).
Test Case '-[HabitsUITests.AppReliabilityUITests testBurstsRetriesStormsMidnightTravelAndAYear]' passed (74.951 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (47.177 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (48.128 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (44.820 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (12.182 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (32.304 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (33.644 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (31.913 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (14.156 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (26.796 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (25.286 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (44.546 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (23.624 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (28.793 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (15.328 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (111.033 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (14.597 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (38.275 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (36.789 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (42.847 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (31.899 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogSheetSharesEntryEditingAndStillAdds]' passed (43.381 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (21.211 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (19.689 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (29.257 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (13.511 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (137.384 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (21.389 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (29.233 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (17.844 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (18.754 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (10.113 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

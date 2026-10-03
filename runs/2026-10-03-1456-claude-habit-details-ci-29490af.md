# claude/habit-details-ci @ 29490af

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37129406775 · 2026-10-03 14:56 UTC
Commit: UI tests start with completed habits shown; Hide Completed test holds Today long enough on a slow simulator

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,GroupsUITests,TimerUITests,OnboardingUITests,AnalyticsUITests,FocusPlayerUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 0 failures (0 unexpected) in 284.847 (284.854) seconds
	 Executed 2 tests, with 0 failures (0 unexpected) in 55.545 (55.548) seconds
	 Executed 37 tests, with 0 failures (0 unexpected) in 1145.395 (1145.437) seconds
	 Executed 37 tests, with 0 failures (0 unexpected) in 1145.395 (1145.439) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 102.846 (102.860) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 275.749 (275.753) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 175.597 (175.602) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 250.811 (250.816) seconds
Test Case '-[HabitsUITests.AnalyticsUITests testDurableContentFreeTracking]' passed (71.009 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testFailedPersistenceNeverCounts]' passed (8.731 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testUsageConsentIsOptionalAndSeparate]' passed (12.500 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testWelcomeConsentIsOptional]' passed (10.606 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (22.284 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (55.960 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (18.449 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (18.937 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitCheckInNeverLogsConsumptionOrCompletesTheDay]' passed (20.655 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' passed (26.771 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (17.264 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (22.804 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSectionWithOnlyALimitStillHasStart]' passed (10.393 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (5.846 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (32.898 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (32.587 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (32.511 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (74.526 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (64.272 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (69.806 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (34.634 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (16.283 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNotNowAndHelp]' passed (67.134 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (6.847 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testRestoreFromTheWelcome]' passed (8.593 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipLeadsToAHelpfulToday]' passed (29.838 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' passed (46.902 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (25.758 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (29.788 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (18.752 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (39.037 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (18.439 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (25.442 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (14.010 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (94.583 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (11.175 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (29.373 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

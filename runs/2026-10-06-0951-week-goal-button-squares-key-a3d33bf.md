# week-goal-button-squares-key @ a3d33bf

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37438879527 · 2026-10-06 09:51 UTC
Commit: TodayRowSheetUITests: a week count's Day sheet offers Add a check, not Mark done (Current Work 54; found by run 37432849062, 44 of 45 passed)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayRowSheetUITests,ProgressUITests,ScheduleUITests,WeekCardsUITests,HabitPageUITests,FocusPlayerUITests,CompletionFeedbackUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 487.372 (487.380) seconds
	 Executed 15 tests, with 0 failures (0 unexpected) in 454.633 (454.644) seconds
	 Executed 55 tests, with 0 failures (0 unexpected) in 2536.820 (2536.880) seconds
	 Executed 55 tests, with 0 failures (0 unexpected) in 2536.820 (2536.882) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 195.529 (195.533) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 207.256 (207.261) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 895.795 (895.805) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 273.829 (273.837) seconds
Test Case '-[HabitsUITests.CompletionFeedbackUITests testCompletionPlaysOnceWhenAHabitBecomesCompleteAndNeverForQuitOrLimits]' passed (22.406 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' passed (43.821 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (23.022 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (64.821 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (19.115 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack]' passed (49.117 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (19.516 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown]' passed (27.095 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' passed (30.813 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' passed (28.869 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testOnlyALimitShowsUnderQuitOrCutDownWithoutStart]' passed (15.322 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (26.571 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSwipeMovesOneHabitAtATime]' passed (14.157 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (7.103 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (49.896 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (35.395 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (62.969 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (47.292 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFoldByMonthLikeHistory]' passed (43.765 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (288.580 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (125.180 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (227.519 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (62.057 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (38.434 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (12.538 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (27.895 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (68.656 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (54.617 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (31.391 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (19.875 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (8.261 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (28.474 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (22.122 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testCalendarAndPersistenceRules]' passed (5.955 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testEveryFewDaysAndWeeks]' passed (31.573 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testLargeTextHowOften]' passed (31.078 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testMonthDatesAndShortMonths]' passed (39.282 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testTaskAfterCompletion]' passed (33.306 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testYearlyDateAndLeapDay]' passed (54.335 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (23.052 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (46.637 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (46.825 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (27.194 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (30.132 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (33.416 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (44.012 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (43.886 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (23.532 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (44.909 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (66.540 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (72.345 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (21.331 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

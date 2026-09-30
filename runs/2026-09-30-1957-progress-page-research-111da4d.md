# progress-page-research @ 111da4d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36764049530 · 2026-09-30 19:57 UTC
Commit: Progress: checklist By Step list and a running-total chart with a pace line in Over Time

- Build: success
- UI tests (ProgressUITests,RoutineCalendarUITests,FocusPlayerUITests,SectionHeaderUITests,ScheduleUITests,PersistenceUITests,PlacementUITests): failure
- Speed tests: success

## UI tests
```
	 Executed 12 tests, with 8 failures (0 unexpected) in 310.205 (310.217) seconds
	 Executed 35 tests, with 14 failures (0 unexpected) in 906.203 (906.240) seconds
	 Executed 35 tests, with 14 failures (0 unexpected) in 906.203 (906.242) seconds
	 Executed 6 tests, with 1 failure (0 unexpected) in 175.708 (175.713) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 166.020 (166.027) seconds
	 Executed 7 tests, with 5 failures (0 unexpected) in 160.503 (160.507) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:100: error: -[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime] : Failed to get matching snapshot: No matches found for Elements matching predicate '"focus-clock-value" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:135: error: -[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable] : Failed to tap "Add" Button: No matches found for Elements matching predicate '"Add" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:150: error: -[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination] : Failed to get matching snapshot: No matches found for Elements matching predicate '"focus-quantity" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:208: error: -[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes] : Failed to get matching snapshot: No matches found for Elements matching predicate '"focus-quantity" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:260: error: -[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites] : Failed to get matching snapshot: Find single matching element. Multiple matching elements found for <XCUIElementQuery: 0x1077fccd0>.
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:41: error: -[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit] : Failed to get matching snapshot: No matches found for Elements matching predicate '"focus-quantity" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:65: error: -[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit] : Failed to get matching snapshot: No matches found for Elements matching predicate '"focus-checklist-progress" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:80: error: -[HabitsUITests.FocusPlayerUITests testLimitCheckInNeverLogsConsumptionOrCompletesTheDay] : Failed to get matching snapshot: No matches found for Elements matching predicate '"focus-quantity" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:118: error: -[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries] : XCTAssertFalse failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:189: error: -[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo] : Failed to tap "Finish routine" Button: Find single matching element. Multiple matching elements found for <XCUIElementQuery: 0x1077fe990>.
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:224: error: -[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize] : XCTAssertFalse failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:30: error: -[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:52: error: -[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ScheduleUITests.swift:57: error: -[HabitsUITests.ScheduleUITests testEveryFewDaysAndWeeks] : Failed to get matching snapshot: No matches found for Descendants matching type Switch from input {(
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' failed (43.399 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' failed (15.831 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' failed (31.274 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (39.372 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitCheckInNeverLogsConsumptionOrCompletesTheDay]' failed (21.858 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' passed (32.825 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' failed (20.945 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' failed (27.634 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSectionWithOnlyALimitStillHasStart]' passed (14.782 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (7.070 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' failed (31.991 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' failed (23.223 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (53.393 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (7.553 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDaySheetShowsOnToday]' passed (25.602 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (12.747 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (29.400 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (37.231 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (26.265 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (7.623 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtOverTime]' passed (27.153 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' failed (23.877 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (31.147 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (25.496 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' failed (17.367 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' failed (26.837 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' failed (11.024 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' failed (24.756 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testCalendarAndPersistenceRules]' passed (5.719 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testEveryFewDaysAndWeeks]' failed (21.702 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testLargeTextHowOften]' passed (33.805 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testMonthDatesAndShortMonths]' passed (32.398 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testTaskAfterCompletion]' passed (31.478 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testYearlyDateAndLeapDay]' passed (50.607 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (32.821 seconds).
```

## Speed (simulator on GitHub's Mac, a year of history; compare runs, not absolute numbers)

| Screen | App busy (main thread, minus the test) | SwiftUI redraw | Most time in the app's own code |
|---|---|---|---|
| testScrollToday | 0.3 % | 0.2 % | 0.0%  HabitStore.quitRuns(of:now:) |
| testTapToday | 19.6 % | 2.0 % | 0.7%  HabitRow.row(now:)<br>0.5%  HabitStore.isDayMet(_:on:)<br>0.4%  HabitStore.isDone(_:on:)<br>0.4%  HabitStore.streak(of:asOf:) |
| testMenuOpenClose | 10.0 % | 1.1 % | 0.0%  DYLD-STUB$$type metadata accessor for MainActor<br>0.0%  closure #1 in closure #1 in TodayView.topBar.getter<br>0.0%  MenuModel.setOpen(_:reduceMotion:then:)<br>0.0%  partial apply for closure #1 in MenuModel.setOpen(_:reduceMotion:then:) |
| testScrollAllHabits | 8.1 % | 1.0 % | 0.1%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.1%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.1%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.0%  kotlin::alloc::FinalizerQueueTraits::processSingle(kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>& |
| testScrollHabitPage | 8.3 % | 2.7 % | (none above noise) |
| testCalendarMonths | 16.8 % | 1.6 % | 1.6%  CalendarSheet.dayButton(_:)<br>1.5%  HabitStore.todayScore(on:)<br>1.5%  HabitStore.dayScore(on:habits:today:)<br>1.4%  HabitStore.outcome(_:on:today:) |
| testProgress | 16.8 % | 2.5 % | 0.1%  ProgressModel.load(_:store:)<br>0.1%  HabitStore.progressSnapshot(_:containing:today:)<br>0.1%  HabitStore.progressRow(_:in:range:today:)<br>0.1%  Collection.map<A, B>(_:) |
| testProgressHabitPage | 9.0 % | 2.7 % | 0.6%  OverTimeSection.load(_:)<br>0.5%  HabitStore.overTime(_:range:anchor:today:)<br>0.2%  HabitStore.dayProgress(of:on:now:)<br>0.2%  partial apply for closure #31 in HabitStore.overTime(_:range:anchor:today:) |

Time to open (tap until the screen is there, including the test's own checks):

- Calendar: 3.5 s
- Habit page from Progress: 3.7 s
- Habit page: 3.4 s
- Habits: 2.1 s
- Habits: 2.5 s
- Menu: 3.1 s
- Menu: 3.3 s
- Menu: 3.4 s
- Menu: 3.8 s
- Menu: 4.3 s
- Progress: 2.8 s
- Progress: 3.5 s

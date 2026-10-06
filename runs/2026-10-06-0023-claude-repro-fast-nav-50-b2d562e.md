# claude/repro-fast-nav-50 @ b2d562e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37390754817 · 2026-10-06 00:23 UTC
Commit: FocusPlayerUITests: the slow-write navigation test injects 4 s writes and allows 3 s (a wait still fails); › is now a Liquid Glass bar button whose press animation XCUITest waits out (~0.9 s, run 37387468173)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ProgressUITests,GoalFlowUITests,ArrangeUITests,TodayRowSheetUITests,ScheduleUITests,OnboardingUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 38 tests, with 1 failure (0 unexpected) in 1241.034 (1241.062) seconds
	 Executed 38 tests, with 1 failure (0 unexpected) in 1241.034 (1241.063) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 212.559 (212.563) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 166.059 (166.062) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 169.982 (169.985) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 307.641 (307.645) seconds
	 Executed 6 tests, with 1 failure (0 unexpected) in 160.311 (160.315) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 224.482 (224.488) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingUITests.swift:108: error: -[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit] : XCTAssertTrue failed - The new habit shows on Today
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (68.150 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (9.824 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (74.901 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (30.289 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (29.395 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' passed (70.533 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (43.680 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' passed (36.888 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' passed (56.487 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' passed (72.603 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (27.450 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (15.501 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNotNowAndHelp]' passed (57.775 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (6.203 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testRestoreFromTheWelcome]' passed (8.273 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipLeadsToAHelpfulToday]' passed (29.923 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' failed (42.637 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (11.652 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHabitPageYearAndMilestones]' passed (26.124 seconds).
Test Case '-[HabitsUITests.ProgressUITests testHidePercentages]' passed (57.121 seconds).
Test Case '-[HabitsUITests.ProgressUITests testLogSlipAndUndo]' passed (40.418 seconds).
Test Case '-[HabitsUITests.ProgressUITests testOpenSwitchAndBack]' passed (23.268 seconds).
Test Case '-[HabitsUITests.ProgressUITests testPreviousStopsAtFirstPeriod]' passed (16.489 seconds).
Test Case '-[HabitsUITests.ProgressUITests testProgressChecks]' passed (6.677 seconds).
Test Case '-[HabitsUITests.ProgressUITests testRowOpensHabitPageAtProgress]' passed (24.351 seconds).
Test Case '-[HabitsUITests.ProgressUITests testYearAndMonthTap]' passed (18.384 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testCalendarAndPersistenceRules]' passed (5.574 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testEveryFewDaysAndWeeks]' passed (27.398 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testLargeTextHowOften]' passed (25.425 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testMonthDatesAndShortMonths]' passed (34.349 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testTaskAfterCompletion]' passed (23.790 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testYearlyDateAndLeapDay]' passed (53.445 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (18.778 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (41.200 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (34.749 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (20.917 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (32.301 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (18.114 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

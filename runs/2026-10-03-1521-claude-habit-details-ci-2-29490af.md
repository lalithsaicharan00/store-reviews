# claude/habit-details-ci-2 @ 29490af

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37129408523 · 2026-10-03 15:21 UTC
Commit: UI tests start with completed habits shown; Hide Completed test holds Today long enough on a slow simulator

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (FormWalkthroughUITests,GoalFlowUITests,HabitScenarioUITests,NewFlowUITests,PlacementUITests,RemindersUITests,RoutineCalendarUITests,ScheduleUITests,SectionHeaderUITests,WidgetSystemUITests,WidgetUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 123.768 (123.772) seconds
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 261.824 (261.831) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 62.087 (62.089) seconds
	 Executed 43 tests, with 1 test skipped and 5 failures (0 unexpected) in 2566.653 (2566.713) seconds
	 Executed 43 tests, with 1 test skipped and 5 failures (0 unexpected) in 2566.653 (2566.717) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 159.011 (159.019) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 192.844 (192.848) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 494.515 (494.524) seconds
	 Executed 7 tests, with 3 failures (0 unexpected) in 153.754 (153.758) seconds
	 Executed 8 tests, with 2 failures (0 unexpected) in 990.931 (990.937) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitScenarioUITests.swift:311: error: -[HabitsUITests.HabitScenarioUITests testStartsAndEnds] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitScenarioUITests.swift:317: error: -[HabitsUITests.HabitScenarioUITests testStartsAndEnds] : Failed to tap Button (First Match): No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate 'label BEGINSWITH "Ends"'`, given input App element pid: 79129
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:163: error: -[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits] : XCTAssertEqual failed: ("Optional("Today")") is not equal to ("Optional("Today. 6 of 15 done")")
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:195: error: -[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation] : XCTAssertNotEqual failed: ("Optional("Today")") is equal to ("Optional("Today")")
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:229: error: -[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo] : XCTAssertEqual failed: ("Optional("Today")") is not equal to ("Optional("Today. 1 of 1 done")")
Test Case '-[HabitsUITests.FormWalkthroughUITests testAmountPicksSeveralParts]' passed (59.087 seconds).
Test Case '-[HabitsUITests.FormWalkthroughUITests testCheckOffMorningAndEveningWithReminders]' passed (64.681 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testButtonAddsItsStepAndRowOpensAddAmount]' passed (86.003 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testHowOftenChoicesSayTheAmount]' passed (165.913 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testNumberShowsWithoutAUnit]' passed (50.378 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testOwnStep]' passed (74.501 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testTypingKeyByKey]' passed (82.539 seconds).
Test Case '-[HabitsUITests.GoalFlowUITests testUnitScreen]' passed (35.182 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (231.276 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (52.089 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' passed (214.812 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (138.496 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (72.303 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (42.976 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (215.505 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testStartsAndEnds]' failed (23.472 seconds).
Test Case '-[HabitsUITests.NewFlowUITests testFlow]' passed (93.505 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (5.498 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (10.804 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (23.376 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (12.285 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (15.622 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (20.224 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' failed (10.684 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' failed (16.717 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (19.197 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (39.526 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (17.971 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' failed (29.435 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testCalendarAndPersistenceRules]' passed (5.449 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testEveryFewDaysAndWeeks]' passed (33.771 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testLargeTextHowOften]' passed (29.417 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testMonthDatesAndShortMonths]' passed (38.132 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testTaskAfterCompletion]' passed (29.271 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testYearlyDateAndLeapDay]' passed (56.805 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (28.915 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (166.006 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (105.126 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (21.595 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (18.421 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (7.043 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (6.826 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

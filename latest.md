# claude/pensive-gates-3n4ie8-ci8 @ c5b1da3

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38131148201 · 2026-10-11 12:06 UTC
Commit: Current Work 86/88: Day details' popover hangs on Today, pointing at its row; iPad tests; iPad speed runs; coming back to the iPhone

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (LongTextUITests,CompletionFeedbackUITests,WeekCardsUITests,RoutineCalendarUITests,AnalyticsUITests,HabitScenarioUITests,DayDetailsScreenshotUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 21 tests, with 0 failures (0 unexpected) in 789.834 (789.850) seconds
	 Executed 3 tests, with 1 failure (0 unexpected) in 120.467 (120.470) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 63.162 (63.169) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 207.747 (207.752) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 1103.240 (1103.256) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:68: error: -[HabitsUITests.LongTextUITests testTodayWithLongText] : XCTAssertTrue failed
Test Case '-[HabitsUITests.AnalyticsUITests testDurableContentFreeTracking]' passed (27.947 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testFailedPersistenceNeverCounts]' passed (7.532 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testUsageConsentIsOptionalAndSeparate]' passed (13.710 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testWelcomeConsentIsOptional]' passed (13.973 seconds).
Test Case '-[HabitsUITests.CompletionFeedbackUITests testCompletionPlaysOnceWhenAHabitBecomesCompleteAndNeverForQuitOrLimits]' passed (11.487 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test01_amount]' passed (86.453 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test02_noUnitWeek]' passed (52.737 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test03_currencyMonth]' passed (35.066 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test04_limit]' passed (41.607 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test05_time]' passed (36.850 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test06_timerRunningAndEarlierDay]' passed (43.470 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test07_fractionalTimer]' passed (23.585 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test08_onceADay]' passed (34.224 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test09_severalADay]' passed (35.397 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test10_weekGoal]' passed (27.325 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test11_monthGoal]' passed (27.833 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test12_daysAWeek]' passed (27.058 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test12b_olderMultiCheckLog]' passed (19.608 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test13_checklist]' passed (25.609 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test14_quit]' passed (48.232 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test15_task]' passed (20.373 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test16_dayStates]' passed (61.886 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test17_notes]' passed (48.476 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test18_deleteConfirmations]' passed (57.664 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test19_lightMode]' passed (18.134 seconds).
Test Case '-[HabitsUITests.DayDetailsScreenshotUITests test20_managementMenu]' passed (18.248 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCountsAndAmounts]' passed (165.273 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testCutDown]' passed (35.950 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySets]' passed (223.419 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testDaySetsNamedAndAll]' passed (160.684 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testEachTypeStartsWithDefaults]' passed (97.772 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testLongest]' passed (79.063 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testMonthDateSets]' passed (286.403 seconds).
Test Case '-[HabitsUITests.HabitScenarioUITests testStartsAndEnds]' passed (54.676 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (28.153 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' passed (81.128 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' failed (11.186 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (24.781 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (31.287 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (25.180 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (20.920 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (42.990 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (19.616 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (42.974 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (44.114 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

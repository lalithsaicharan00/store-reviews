# week-goal-button-squares-key @ f883d2f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37432849062 · 2026-10-06 08:49 UTC
Commit: Week goals count up and fill only when met; wider after-log gap; one app-wide squares key; hide-a-week-goal research

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,TodayRowSheetUITests,DayDetailsUITests,ArrangeUITests,RoutineCalendarUITests,OnboardingUITests,TodayRowLayoutUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 4 tests, with 0 failures (0 unexpected) in 132.772 (132.774) seconds
	 Executed 45 tests, with 1 failure (0 unexpected) in 1989.614 (1989.669) seconds
	 Executed 45 tests, with 1 failure (0 unexpected) in 1989.614 (1989.673) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 331.442 (331.448) seconds
	 Executed 6 tests, with 1 failure (0 unexpected) in 220.891 (220.896) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 209.813 (209.819) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 252.701 (252.706) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 290.785 (290.792) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 551.211 (551.225) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayRowSheetUITests.swift:86: error: -[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind] : XCTAssertTrue failed - Call family: day-done
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (63.633 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (9.280 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (178.518 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (45.654 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (34.356 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEditLogAsksBeforeLosingOrDeleting]' passed (48.338 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (73.302 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (135.518 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (128.124 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMultiCheckRecordEditsItsCount]' passed (28.769 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipRecordEditAndDelete]' passed (35.676 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (41.325 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' passed (60.159 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (28.749 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (16.296 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNotNowAndHelp]' passed (63.308 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (9.037 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testRestoreFromTheWelcome]' passed (11.303 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipLeadsToAHelpfulToday]' passed (32.695 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' passed (48.425 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (25.402 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (33.170 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (27.491 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (36.939 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (55.886 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (22.230 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (51.583 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (59.397 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (12.440 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (19.977 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (40.958 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (20.784 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' failed (52.540 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (37.715 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (26.666 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (34.955 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (48.232 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (21.292 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (41.623 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (22.864 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (29.385 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (13.775 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (113.691 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (13.307 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (34.848 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

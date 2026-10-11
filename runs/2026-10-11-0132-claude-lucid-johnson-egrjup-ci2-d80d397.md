# claude/lucid-johnson-egrjup-ci2 @ d80d397

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38099886275 · 2026-10-11 01:32 UTC
Commit: Widgets faster: week and month totals from the per-day index; the widget lock opened for speed work; App Lock's SE test scrolls to App Passcode

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,TodayRowLayoutUITests,RoutineCalendarUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 19 tests, with 0 failures (0 unexpected) in 776.687 (776.720) seconds
	 Executed 19 tests, with 0 failures (0 unexpected) in 776.687 (776.729) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 113.299 (113.302) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 368.326 (368.343) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 295.062 (295.072) seconds
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (74.308 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' passed (60.471 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (43.869 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (34.547 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (67.878 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (31.288 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (55.964 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (37.438 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (18.809 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (20.596 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (36.456 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (23.243 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (40.972 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (19.159 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (26.411 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (14.332 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (121.064 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (15.331 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (34.550 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

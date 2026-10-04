# claude/habit-details-ci-2 @ 196b440

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37170557651 · 2026-10-04 02:42 UTC
Commit: A skipped habit stays on Today as a neutral "Skipped today" row (it vanished, so Undo Skip had nowhere to be); sheets say Yesterday; NewHabit expects +1 for twice a day

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,GroupsUITests,SectionHeaderUITests,PlacementUITests,RoutineCalendarUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 19 tests, with 1 failure (0 unexpected) in 806.891 (806.910) seconds
	 Executed 19 tests, with 1 failure (0 unexpected) in 806.891 (806.911) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 183.203 (183.209) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 317.104 (317.108) seconds
	 Executed 7 tests, with 1 failure (0 unexpected) in 273.372 (273.376) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RoutineCalendarUITests.swift:171: error: -[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits] : Failed to get matching snapshot: No matches found for Elements matching predicate '"calendar-day-2026-11-4" IN identifiers' from input {(
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (59.141 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (6.884 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (66.433 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (26.450 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (24.295 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (28.107 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (59.902 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (41.709 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (88.142 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (99.244 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (8.137 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarSixWeekMonthAtLargeTextSize]' passed (23.296 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarTotalsAndDaysWithoutHabits]' failed (23.439 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testCalendarUpdatesAfterLoggingAndPastNavigation]' passed (40.663 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testChecklistRoutineUsesExistingEntries]' passed (85.991 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testNonTimedRoutineAndSkipDoNotFalselyComplete]' passed (42.492 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testPlayFollowsHeaderRules]' passed (18.716 seconds).
Test Case '-[HabitsUITests.RoutineCalendarUITests testSingleHabitFullCompletionAndUndo]' passed (38.776 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (25.075 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

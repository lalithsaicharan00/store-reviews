# claude/shared-habit-rules-ci3 @ b122a95

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38225676841 · 2026-10-12 09:36 UTC
Commit: Current Work 92 (checkpoint 2): a log made before the shared rules' copy is built isn't lost

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,GroupsUITests,PlacementUITests,ScheduleUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 595.361 (595.369) seconds
	 Executed 22 tests, with 0 failures (0 unexpected) in 1112.507 (1112.530) seconds
	 Executed 22 tests, with 0 failures (0 unexpected) in 1112.507 (1112.532) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 268.475 (268.481) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 241.957 (241.962) seconds
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (73.630 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (11.104 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (105.799 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (37.803 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (40.139 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (42.482 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (43.516 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (80.581 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (52.095 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' passed (138.202 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (70.870 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (46.730 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (50.566 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (34.934 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (35.386 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (6.714 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testCalendarAndPersistenceRules]' passed (11.730 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testEveryFewDaysAndWeeks]' passed (39.444 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testLargeTextHowOften]' passed (39.355 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testMonthDatesAndShortMonths]' passed (54.138 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testTaskAfterCompletion]' passed (36.594 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testYearlyDateAndLeapDay]' passed (60.697 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

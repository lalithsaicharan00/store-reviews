# claude/shared-habit-rules-ci28 @ fc19872

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38317988744 · 2026-10-13 00:15 UTC
Commit: Current Work 92 (checkpoint 2): the shared rules are given habits and settings again only when one they read changed; history asks once a month

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,GroupsUITests,PlacementUITests,ScheduleUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 577.130 (577.139) seconds
	 Executed 22 tests, with 0 failures (0 unexpected) in 1099.564 (1099.594) seconds
	 Executed 22 tests, with 0 failures (0 unexpected) in 1099.564 (1099.599) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 280.497 (280.507) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 227.746 (227.752) seconds
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (95.370 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (9.216 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (97.679 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (43.055 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (35.178 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (40.578 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (50.700 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (80.863 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (48.512 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' passed (127.559 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (67.261 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (43.350 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (44.049 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (34.923 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (39.336 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (14.191 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testCalendarAndPersistenceRules]' passed (8.181 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testEveryFewDaysAndWeeks]' passed (43.396 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testLargeTextHowOften]' passed (45.965 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testMonthDatesAndShortMonths]' passed (37.999 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testTaskAfterCompletion]' passed (33.661 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testYearlyDateAndLeapDay]' passed (58.544 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

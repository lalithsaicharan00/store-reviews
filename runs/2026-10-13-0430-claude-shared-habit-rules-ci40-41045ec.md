# claude/shared-habit-rules-ci40 @ 41045ec

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38329431161 · 2026-10-13 04:30 UTC
Commit: Current Work 92 (checkpoint 2): the shared rules are given their inputs without SwiftUI seeing it; the Watch keeps its Swift rules

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,GroupsUITests,PlacementUITests,ScheduleUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 1 failure (0 unexpected) in 579.416 (579.426) seconds
	 Executed 22 tests, with 1 failure (0 unexpected) in 1138.674 (1138.705) seconds
	 Executed 22 tests, with 1 failure (0 unexpected) in 1138.674 (1138.709) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 338.234 (338.244) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 213.429 (213.435) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:44: error: -[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits] : XCTAssertTrue failed
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (128.115 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (11.857 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (122.157 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (42.785 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (33.320 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (40.137 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' failed (18.454 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (80.079 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (58.479 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' passed (142.559 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (67.806 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (41.331 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (48.056 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (38.134 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (44.382 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (7.596 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testCalendarAndPersistenceRules]' passed (7.089 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testEveryFewDaysAndWeeks]' passed (37.435 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testLargeTextHowOften]' passed (35.030 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testMonthDatesAndShortMonths]' passed (40.801 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testTaskAfterCompletion]' passed (31.693 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testYearlyDateAndLeapDay]' passed (61.380 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# claude/shared-habit-rules-ci18 @ 7087be7

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38261592955 · 2026-10-12 16:53 UTC
Commit: Merge remote-tracking branch 'origin/main' into claude/shared-habit-rules-switch

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,GroupsUITests,PlacementUITests,ScheduleUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 577.961 (577.967) seconds
	 Executed 22 tests, with 2 failures (0 unexpected) in 1127.177 (1127.197) seconds
	 Executed 22 tests, with 2 failures (0 unexpected) in 1127.177 (1127.200) seconds
	 Executed 5 tests, with 2 failures (0 unexpected) in 321.473 (321.481) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 220.826 (220.830) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ArrangeUITests.swift:101: error: -[HabitsUITests.ArrangeUITests testEditArrangesTheDay] : XCTAssertTrue failed - Back to Today
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ArrangeUITests.swift:117: error: -[HabitsUITests.ArrangeUITests testAddTimeOfDay] : XCTAssertTrue failed - The new one in Your day
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' failed (54.002 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (20.676 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' failed (109.046 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (43.259 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (94.490 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (35.584 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (46.370 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (72.370 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (50.199 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' passed (123.946 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (75.698 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (54.166 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (46.529 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (37.678 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (35.420 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (6.917 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testCalendarAndPersistenceRules]' passed (6.816 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testEveryFewDaysAndWeeks]' passed (37.260 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testLargeTextHowOften]' passed (35.445 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testMonthDatesAndShortMonths]' passed (42.840 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testTaskAfterCompletion]' passed (33.904 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testYearlyDateAndLeapDay]' passed (64.560 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# claude/shared-habit-rules-ci2 @ dbc7c92

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38216853635 · 2026-10-12 08:18 UTC
Commit: Current Work 92 (checkpoint 2): returns where a body stopped being one expression; import Core in +Phase2

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,TodayRowLayoutUITests,ProgressUITests,GroupsUITests,ArrangeUITests,PlacementUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 685.380 (685.399) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 359.092 (359.105) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ArrangeUITests.swift:84: error: -[HabitsUITests.ArrangeUITests testEditArrangesTheDay] : XCTAssertFalse failed - Already at the bottom
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (108.968 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (15.006 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' failed (118.224 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (73.274 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (43.620 seconds).
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (44.495 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (49.968 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (93.333 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (61.731 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' passed (157.191 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (77.977 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (44.832 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (63.347 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (49.082 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (43.423 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (8.354 seconds).
Test Case '-[HabitsUITests.ProgressUITests testEmptyState]' passed (16.510 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

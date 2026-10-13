# claude/shared-habit-rules-ci40 @ f9baf63

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38348370810 · 2026-10-13 05:24 UTC
Commit: Current Work 92 (checkpoint 2): a Today row's numbers in one call to the shared rules (HabitRules.row, coreRow)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (GroupsUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 561.949 (561.962) seconds
	 Executed 10 tests, with 0 failures (0 unexpected) in 561.949 (561.964) seconds
	 Executed 10 tests, with 0 failures (0 unexpected) in 561.949 (561.965) seconds
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (36.218 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (39.130 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (79.128 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (66.341 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' passed (124.066 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (69.504 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (40.275 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (44.169 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (30.587 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (32.532 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# claude/shared-habit-rules-main-check8 @ 6c6bcf0

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38348373467 · 2026-10-13 05:42 UTC
Commit: Android build prompt: wait for the user's OAuth client and Play Console app; build everything else meanwhile

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (GroupsUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 1 failure (0 unexpected) in 635.297 (635.313) seconds
	 Executed 10 tests, with 1 failure (0 unexpected) in 635.297 (635.322) seconds
	 Executed 10 tests, with 1 failure (0 unexpected) in 635.297 (635.327) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:44: error: -[HabitsUITests.GroupsUITests testGroupDragDropsReliably] : XCTAssertTrue failed
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (59.737 seconds).
Test Case '-[HabitsUITests.GroupsUITests testDeletingAGroupKeepsItsHabits]' passed (134.366 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (85.099 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' passed (50.463 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' failed (16.262 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (70.602 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (43.261 seconds).
Test Case '-[HabitsUITests.GroupsUITests testNamesAreUniqueAndAGroupCanPause]' passed (103.496 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (34.879 seconds).
Test Case '-[HabitsUITests.GroupsUITests testTodayAndProgressKeepTheirOwnChoiceAndStartPlaysWhatsShown]' passed (37.134 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

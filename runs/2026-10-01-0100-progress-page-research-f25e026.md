# progress-page-research @ f25e026

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36797688716 · 2026-10-01 01:00 UTC
Commit: Groups test: wait for the filter to clear, then bring Water into view

- Build: success
- UI tests (GroupsUITests): failure
- Speed tests: skipped

## UI tests
```
	 Executed 5 tests, with 1 failure (0 unexpected) in 317.150 (317.160) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 317.150 (317.162) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 317.150 (317.164) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:118: error: -[HabitsUITests.GroupsUITests testFirstGroupFromFilter] : XCTAssertTrue failed - ✕ clears the filter
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (52.245 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (90.943 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' failed (60.132 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (77.908 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (35.922 seconds).
```

# progress-page-research @ d7d215d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36799068550 · 2026-10-01 01:21 UTC
Commit: Today: the filter chip's ✕ clears the filter (a borderless button in its list row)

- Build: success
- UI tests (GroupsUITests,TodayUITests): failure
- Speed tests: skipped

## UI tests
```
	 Executed 3 tests, with 0 failures (0 unexpected) in 131.250 (131.252) seconds
	 Executed 5 tests, with 1 failure (0 unexpected) in 259.499 (259.504) seconds
	 Executed 8 tests, with 1 failure (0 unexpected) in 390.749 (390.758) seconds
	 Executed 8 tests, with 1 failure (0 unexpected) in 390.749 (390.759) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:118: error: -[HabitsUITests.GroupsUITests testFirstGroupFromFilter] : XCTAssertTrue failed - ✕ clears the filter
Test Case '-[HabitsUITests.GroupsUITests testChipsAndEmptyGroup]' passed (48.831 seconds).
Test Case '-[HabitsUITests.GroupsUITests testEditRenameDeleteAndEmptyDay]' passed (73.033 seconds).
Test Case '-[HabitsUITests.GroupsUITests testFirstGroupFromFilter]' failed (45.899 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupInHabitForm]' passed (60.331 seconds).
Test Case '-[HabitsUITests.GroupsUITests testProgressAndHabitsByGroup]' passed (31.405 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (18.946 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (78.678 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (33.626 seconds).
```

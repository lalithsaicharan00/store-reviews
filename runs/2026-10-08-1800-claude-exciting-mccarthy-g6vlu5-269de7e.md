# claude/exciting-mccarthy-g6vlu5 @ 269de7e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37817858014 · 2026-10-08 18:00 UTC
Commit: Current Work 53: on a group screen the Filter sheet leaves drags to its content; a test that repeats the drag per sheet setting

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (GroupsUITests/testGroupDragDropsReliably,GroupsUITests/testGroupOrderIsThePersonsOwn): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 failure (0 unexpected) in 193.176 (193.179) seconds
	 Executed 2 tests, with 1 failure (0 unexpected) in 193.176 (193.181) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/GroupsUITests.swift:362: error: -[HabitsUITests.GroupsUITests testGroupDragDropsReliably] : XCTAssertTrue failed - Edit mode shows the reorder handles
Test Case '-[HabitsUITests.GroupsUITests testGroupDragDropsReliably]' failed (146.928 seconds).
Test Case '-[HabitsUITests.GroupsUITests testGroupOrderIsThePersonsOwn]' passed (46.248 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

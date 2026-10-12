# claude/shared-habit-rules-ci11 @ b122a95

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38225697750 · 2026-10-12 11:03 UTC
Commit: Current Work 92 (checkpoint 2): a log made before the shared rules' copy is built isn't lost

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (IPadWidgetSystemUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadWidgetSystemUITests.swift:85: error: -[HabitsUITests.IPadWidgetSystemUITests testExtraLargeTodayOnTheHomeScreen] : XCTAssertTrue failed - Today in Extra Large in the iPad's gallery: Often Enough, Tasks [Widget, Large]
Test Case '-[HabitsUITests.IPadWidgetSystemUITests testExtraLargeTodayOnTheHomeScreen]' failed (143.078 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

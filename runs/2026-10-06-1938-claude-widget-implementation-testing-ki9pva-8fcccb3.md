# claude/widget-implementation-testing-ki9pva @ 8fcccb3

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37517071563 · 2026-10-06 19:38 UTC
Commit: App reliability: overlapping backups as main-actor tasks (the task-group form hit a compiler limitation)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetSystemUITests,AppReliabilityUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 2 failures (0 unexpected) in 242.619 (242.623) seconds
	 Executed 3 tests, with 2 failures (0 unexpected) in 310.740 (311.232) seconds
	 Executed 3 tests, with 2 failures (0 unexpected) in 310.740 (311.233) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:111: error: -[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence] : XCTAssertTrue failed - Page 2 after ›: Today, 0 of 13 done | Today | Previous page | Page 2 of 9 | Next page | Coffee, 0 of 2 cups · Daily limit | 0 of 2 cups · Daily limit | Horizontal scroll bar, 1 page | Horizontal scroll bar, 1 page
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:153: error: -[HabitsUITests.WidgetSystemUITests testLockScreenWidgetPickerAvailability] : Failed to get matching snapshots: Lost connection to the application (pid 34489). (Underlying Error: Couldn’t communicate with a helper application. Try your operation again. If that fails, quit and relaunch the application and try again. The connection to service created from an endpoint was invalidated: Failed to check-in, peer may have been unloaded: mach_error=10000003.)
Test Case '-[HabitsUITests.AppReliabilityUITests testBurstsRetriesStormsMidnightTravelAndAYear]' passed (68.121 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' failed (157.108 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testLockScreenWidgetPickerAvailability]' failed (85.511 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

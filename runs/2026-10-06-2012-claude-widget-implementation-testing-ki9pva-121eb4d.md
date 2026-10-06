# claude/widget-implementation-testing-ki9pva @ 121eb4d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37520968925 · 2026-10-06 20:12 UTC
Commit: Widget fixture keeps its database as built: a cold widget launch no longer adds the debug every-type set

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetSystemUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 failure (0 unexpected) in 265.687 (265.692) seconds
	 Executed 2 tests, with 1 failure (0 unexpected) in 265.687 (265.694) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:153: error: -[HabitsUITests.WidgetSystemUITests testLockScreenWidgetPickerAvailability] : Failed to get matching snapshots: Lost connection to the application (pid 41104). (Underlying Error: Couldn’t communicate with a helper application. Try your operation again. If that fails, quit and relaunch the application and try again. The connection to service created from an endpoint was invalidated: Failed to check-in, peer may have been unloaded: mach_error=10000003.)
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (196.154 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testLockScreenWidgetPickerAvailability]' failed (69.533 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

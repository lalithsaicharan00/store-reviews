# apple-watch-ci4 @ 1cc16d8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38125309070 · 2026-10-11 08:38 UTC
Commit: Apple Watch: Day details' first screen is the dial alone, sized to what shows; the Undo first below it

- Core storage and migrations: success
- Build: failure
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (TodayUITests,TimerUITests,PlusUITests,PersistenceUITests,DayDetailsUITests,WidgetUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/WatchWidgets/WatchWidgets.swift:42:91: error: 'accessoryCorner' is unavailable in iOS
/Users/runner/work/store-reviews/store-reviews/iOS/WatchWidgets/WatchWidgets.swift:98:91: error: 'accessoryCorner' is unavailable in iOS
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

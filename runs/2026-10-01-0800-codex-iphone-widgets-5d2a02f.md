# codex/iphone-widgets @ 5d2a02f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36833362319 · 2026-10-01 08:00 UTC
Commit: Build independently of simulator discovery, repair Xcode startup and test larger widget text [ios-ci] [ios-widgets] [ios-perf]

- Core storage and migrations: success
- Build: failure
- UI tests (WidgetUITests,WidgetSystemUITests,UndoUITests/testStoreCorrectionsRecalculateAndPersist,TimerUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/Shared/WidgetIntents.swift:29:44: error: 'nonisolated' cannot be applied to mutable stored properties
/Users/runner/work/store-reviews/store-reviews/iOS/Shared/WidgetIntents.swift:33:61: error: 'nonisolated' cannot be applied to mutable stored properties
/Users/runner/work/store-reviews/store-reviews/iOS/Shared/WidgetIntents.swift:34:57: error: 'nonisolated' cannot be applied to mutable stored properties
/Users/runner/work/store-reviews/store-reviews/iOS/Shared/WidgetIntents.swift:43:36: error: 'nonisolated' cannot be applied to mutable stored properties
/Users/runner/work/store-reviews/store-reviews/iOS/Shared/WidgetIntents.swift:44:52: error: 'nonisolated' cannot be applied to mutable stored properties
/Users/runner/work/store-reviews/store-reviews/iOS/Shared/WidgetIntents.swift:52:35: error: 'nonisolated' cannot be applied to mutable stored properties
/Users/runner/work/store-reviews/store-reviews/iOS/Shared/WidgetIntents.swift:53:34: error: 'nonisolated' cannot be applied to mutable stored properties
/Users/runner/work/store-reviews/store-reviews/iOS/Shared/WidgetIntents.swift:54:36: error: 'nonisolated' cannot be applied to mutable stored properties
/Users/runner/work/store-reviews/store-reviews/iOS/Shared/WidgetIntents.swift:55:44: error: 'nonisolated' cannot be applied to mutable stored properties
/Users/runner/work/store-reviews/store-reviews/iOS/Shared/WidgetIntents.swift:72:35: error: 'nonisolated' cannot be applied to mutable stored properties
/Users/runner/work/store-reviews/store-reviews/iOS/Shared/WidgetIntents.swift:73:35: error: 'nonisolated' cannot be applied to mutable stored properties
```

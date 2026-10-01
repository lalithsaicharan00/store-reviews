# codex/iphone-widgets @ e81cd9d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36836261617 · 2026-10-01 08:29 UTC
Commit: Preserve widget actions across cold launches and fix App Lock initialization [ios-ci] [ios-widgets] [ios-perf]

- Core storage and migrations: success
- Build: failure
- UI tests (WidgetUITests,WidgetSystemUITests,UndoUITests/testStoreCorrectionsRecalculateAndPersist,TimerUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/WidgetCheck.swift:216:34: error: cannot convert value of type 'any KeyPath<EnvironmentValues, WidgetFamily> & Sendable' to expected argument type 'WritableKeyPath<EnvironmentValues, WidgetFamily>'
```

# codex/iphone-widgets @ 9da746b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36836588686 · 2026-10-01 08:33 UTC
Commit: Load widget UI fixtures and honor quit end dates in snapshots [ios-ci] [ios-widgets] [ios-perf]

- Core storage and migrations: success
- Build: failure
- UI tests (WidgetUITests,WidgetSystemUITests,UndoUITests/testStoreCorrectionsRecalculateAndPersist,TimerUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/WidgetCheck.swift:216:34: error: cannot convert value of type 'any KeyPath<EnvironmentValues, WidgetFamily> & Sendable' to expected argument type 'WritableKeyPath<EnvironmentValues, WidgetFamily>'
```

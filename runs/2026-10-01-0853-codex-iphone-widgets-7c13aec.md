# codex/iphone-widgets @ 7c13aec

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36838738192 · 2026-10-01 08:53 UTC
Commit: Extract Today routing handler to keep Swift type checking bounded [ios-ci] [ios-widgets] [ios-perf]

- Core storage and migrations: success
- Build: failure
- UI tests (WidgetUITests,WidgetSystemUITests,UndoUITests/testStoreCorrectionsRecalculateAndPersist,TimerUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Today/TodayView.swift:137:19: error: the compiler is unable to type-check this expression in reasonable time; try breaking up the expression into distinct sub-expressions
```

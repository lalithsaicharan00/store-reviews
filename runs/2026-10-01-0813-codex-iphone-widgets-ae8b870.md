# codex/iphone-widgets @ ae8b870

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36834448579 · 2026-10-01 08:13 UTC
Commit: Fix shared AppIntent isolation and verify signed simulator App Group publication [ios-ci] [ios-widgets] [ios-perf]

- Core storage and migrations: success
- Build: failure
- UI tests (WidgetUITests,WidgetSystemUITests,UndoUITests/testStoreCorrectionsRecalculateAndPersist,TimerUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/App/AppLock.swift:26:26: error: 'self' used in property access 'isLocked' before all stored properties are initialized
```

# codex/iphone-widgets @ f6ce080

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36859697190 · 2026-10-01 12:10 UTC
Commit: Keep timer widget invalidation local and verify all nine Home gallery previews plus cold persistence [ios-ci] [ios-widgets] [ios-widgets-validation] [ios-perf]

- Core storage and migrations: success
- Build: failure
- UI tests (WidgetUITests/testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks,WidgetSystemUITests/testHomeScreenInstallTapAndColdPersistence,TimerUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/WidgetCheck.swift:58:15: error: value of type 'HabitStore' has no member 'startTimer'
```

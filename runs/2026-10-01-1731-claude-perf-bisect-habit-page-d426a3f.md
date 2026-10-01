# claude/perf-bisect-habit-page @ d426a3f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36899282234 · 2026-10-01 17:31 UTC
Commit: Widget gallery test looks for Often Enough; merging checklist: second round, the app's IDs, branches to delete

- Core storage and migrations: success
- Build: failure
- UI tests (OnboardingUITests,WidgetUITests,WidgetSystemUITests,TimerUITests,BackupUITests,PersistenceUITests,RemindersUITests,TasksUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/AddHabit/NewHabitView.swift:306:9: error: cannot find '_name' in scope
```

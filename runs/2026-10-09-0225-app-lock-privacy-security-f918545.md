# app-lock-privacy-security @ f918545

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37874227531 · 2026-10-09 02:25 UTC
Commit: Current Work 58: fix the first build (run 37871923889)

- Core storage and migrations: success
- Build: failure
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (AppLockUITests,WidgetUITests,WidgetSystemUITests,TodayUITests,RemindersUITests,NewHabitUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/HabitStore+Widgets.swift:645:78: error: main actor-isolated instance method 'withoutNames()' cannot be called from outside of the actor
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# apple-watch-ci2 @ e64a020

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38126067324 · 2026-10-11 09:00 UTC
Commit: Apple Watch: final round on the merged code (scratch branch run)

- Core storage and migrations: success
- Build: success
- Release build: failure
- Same-build speed baseline: skipped
- UI tests (TodayUITests,TimerUITests,PersistenceUITests,PlusUITests,TestLaunchIsolationUITests,AppReliabilityUITests,UndoUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Release build
```
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/App/MainThreadMeter.swift:70:63: error: cannot find type 'CFAbsoluteTime' in scope
** BUILD FAILED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

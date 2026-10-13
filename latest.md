# claude/shared-habit-rules-diag @ 032c9d2

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38328966570 · 2026-10-13 02:37 UTC
Commit: Scratch (safe to delete): time each phase of the Reminders self-check

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (RemindersUITests/testPlanningActionsPermissionsFailuresAndClockChanges): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RemindersUITests.swift:17: error: -[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges] : failed - DIAG waited 124 s; Reminders: all checks passed | 100 rules / 38094 entries: plan median 109.8 ms, cold 112.0 ms, content 29.0 ms | basic 1858 ms; actions 164 ms; races 138 ms; seed 122088 ms; performance 122454 ms; calendar 141 ms; clock 18 ms; 
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' failed (148.676 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

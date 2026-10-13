# claude/shared-habit-rules-diag-main @ 2d34870

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38328968932 · 2026-10-13 02:13 UTC
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
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RemindersUITests.swift:17: error: -[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges] : failed - DIAG waited 89 s; Reminders: all checks passed | 100 rules / 38094 entries: plan median 160.2 ms, cold 183.2 ms, content 71.3 ms | basic 2471 ms; actions 258 ms; races 139 ms; seed 86126 ms; performance 86707 ms; calendar 167 ms; clock 26 ms; 
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' failed (111.605 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

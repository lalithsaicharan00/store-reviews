# claude/progress-week-cards @ 569f547

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37118075606 · 2026-10-03 11:34 UTC
Commit: Rulebook check before merging into main: no "due" or "missed" in the app's words; speed scenarios for the new interactions

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (none): skipped
- Speed tests: success
- Speed tests through XCTest: skipped

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 23.8 | 316 ms | 1 | 1.3 % (separate profile) | (none above noise) |
| Habit page (quit): scrolling | 5.0 | 53 ms | 0 | 2.0 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 544 ms
- Habit page (quit): longest stall 1311 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 143 ms | 92.0 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 1.0 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 0.6 ms |
| scroll-today | Count: a Today row drawn | 24 | 0 ms | 0.3 ms |
| scroll-today | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's month | 17 | 106 ms | 52.3 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 1 ms | 1.3 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 1 ms | 0.7 ms |
| habit-page-quit | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 27 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# claude/progress-week-cards @ 569f547

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37118044623 · 2026-10-03 11:15 UTC
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
| Habit page (quit): scrolling | 17.7 | 145 ms | 1 | 2.1 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Habit page: scrolling | 55.0 | 780 ms | 1 | 1.2 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 584 ms
- Habit page (quit): longest stall 1358 ms
- All Habits: longest stall 572 ms
- Habit page: longest stall 619 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| habit-page-quit | Widgets: one habit's month | 17 | 145 ms | 65.1 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 1 ms | 1.1 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 1 ms | 0.6 ms |
| habit-page-quit | Count: a Today row drawn | 78 | 1 ms | 0.5 ms |
| habit-page-quit | Count: Today's list drawn | 17 | 0 ms | 0.1 ms |
| habit-page | Widgets: one habit's month | 17 | 162 ms | 104.1 ms |
| habit-page | Widgets: the snapshot | 1 | 2 ms | 1.5 ms |
| habit-page | Reminders: plan every alert | 1 | 1 ms | 0.6 ms |
| habit-page | Count: a Today row drawn | 27 | 0 ms | 0.3 ms |
| habit-page | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

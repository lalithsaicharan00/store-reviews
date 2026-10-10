# habit-progress-milestones-perf @ f985d8e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38042251659 · 2026-10-10 10:05 UTC
Commit: Habit Progress tests: the SE check with the squares key folded (and a picture with it open), the pictures in the list's order; the speed run scrolls to Milestones and opens All milestones three times

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
| Habit page: Progress scrolling (milestones) | 4.6 | 64 ms | 0 | 5.2 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: Milestones shelf scrolling | 0.1 | 19 ms | 0 | 5.2 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All milestones: scrolling | 1.5 | 39 ms | 0 | 5.2 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: History scrolling | 6.3 | 99 ms | 0 | 8.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.7%  closure #1 in AppModel.ensureLoaded() |
| Habit page: Progress scrolling | 2.4 | 38 ms | 0 | 8.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.7%  closure #1 in AppModel.ensureLoaded() |
| Habit page: switching tabs | 41.6 | 88 ms | 0 | 8.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.7%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 409 ms
- Habit page: longest stall 982 ms
- Habit page: Progress (milestones): longest stall 165 ms
- All milestones (first): longest stall 22587 ms
- All milestones (second): longest stall 112 ms
- All milestones (third): longest stall 90 ms
- All Habits: longest stall 313 ms
- Habit page: longest stall 303 ms
- Habit page: Notes: longest stall 35 ms
- Habit page: Progress: longest stall 250 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| habit-milestones | Widgets: one habit's week | 17 | 99 ms | 48.1 ms |
| habit-milestones | Habit page: milestones | 1 | 7 ms | 6.9 ms |
| habit-milestones | Habit page: history | 1 | 6 ms | 6.2 ms |
| habit-milestones | Habit page: overall record | 1 | 4 ms | 4.1 ms |
| habit-milestones | Widgets: the snapshot | 1 | 2 ms | 2.4 ms |
| habit-milestones | Count: Today's list drawn | 9 | 1 ms | 0.6 ms |
| habit-milestones | Reminders: plan every alert | 1 | 0 ms | 0.4 ms |
| habit-milestones | Count: a Today row drawn | 12 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's week | 17 | 97 ms | 43.5 ms |
| habit-page | Habit page: milestones | 1 | 7 ms | 7.2 ms |
| habit-page | Habit page: history | 1 | 5 ms | 5.1 ms |
| habit-page | Habit page: overall record | 1 | 4 ms | 4.3 ms |
| habit-page | Widgets: the snapshot | 1 | 2 ms | 1.9 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

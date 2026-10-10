# habit-progress-milestones-perf @ 3ef060e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38039014037 · 2026-10-10 09:11 UTC
Commit: Habit Progress: Overall record boxes, milestones as medals, All milestones page

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
| Habit page: Milestones shelf scrolling | 0.0 | 0 ms | 0 | 1.9 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| All milestones: scrolling | 11.6 | 77 ms | 0 | 1.9 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Habit page: History scrolling | 1.0 | 31 ms | 0 | 8.4 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: Progress scrolling | 4.7 | 45 ms | 0 | 8.4 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: switching tabs | 19.4 | 42 ms | 0 | 8.4 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page (weekly total): History scrolling | 0.2 | 19 ms | 0 | 13.1 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page (weekly total): Progress scrolling | 0.0 | 0 ms | 0 | 13.1 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page (quit): History scrolling | 0.0 | 0 ms | 0 | 6.7 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized static PerfDriver.scroll()<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page (quit): Progress scrolling | 5.2 | 63 ms | 0 | 6.7 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized static PerfDriver.scroll()<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 1348 ms
- Habit page: longest stall 1348 ms
- Habit page: Progress (milestones): longest stall 552 ms
- All milestones (first): longest stall 50301 ms
- All milestones (again): longest stall 139 ms
- All Habits: longest stall 455 ms
- Habit page: longest stall 296 ms
- Habit page: Notes: longest stall 31 ms
- Habit page: Progress: longest stall 136 ms
- All Habits: longest stall 381 ms
- Habit page (weekly total): longest stall 20 ms
- Habit page (weekly total): Progress: longest stall 0 ms
- All Habits: longest stall 495 ms
- Habit page (quit): longest stall 810 ms
- Habit page (quit): Progress: longest stall 260 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| habit-milestones | Widgets: one habit's week | 17 | 133 ms | 56.3 ms |
| habit-milestones | Habit page: milestones | 1 | 10 ms | 9.7 ms |
| habit-milestones | Habit page: overall record | 1 | 10 ms | 9.6 ms |
| habit-milestones | Habit page: history | 1 | 9 ms | 8.7 ms |
| habit-milestones | Widgets: the snapshot | 1 | 2 ms | 2.1 ms |
| habit-milestones | Reminders: plan every alert | 1 | 0 ms | 0.4 ms |
| habit-milestones | Count: Today's list drawn | 8 | 0 ms | 0.4 ms |
| habit-milestones | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's week | 17 | 84 ms | 53.5 ms |
| habit-page | Habit page: milestones | 1 | 6 ms | 6.2 ms |
| habit-page | Habit page: history | 1 | 6 ms | 5.9 ms |
| habit-page | Habit page: overall record | 1 | 4 ms | 4.5 ms |
| habit-page | Widgets: the snapshot | 1 | 2 ms | 1.6 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 27 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's week | 17 | 106 ms | 33.4 ms |
| habit-page-total | Widgets: the snapshot | 1 | 2 ms | 1.7 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-total | Count: Today's list drawn | 17 | 0 ms | 0.1 ms |
| habit-page-total | Count: a Today row drawn | 63 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's week | 17 | 85 ms | 46.5 ms |
| habit-page-quit | Habit page: overall record | 1 | 5 ms | 5.4 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 3 ms | 3.0 ms |
| habit-page-quit | Habit page: history | 1 | 1 ms | 1.4 ms |
| habit-page-quit | Habit page: milestones | 1 | 1 ms | 1.0 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| habit-page-quit | Count: Today's list drawn | 7 | 0 ms | 0.1 ms |
| habit-page-quit | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

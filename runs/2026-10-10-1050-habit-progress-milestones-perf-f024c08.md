# habit-progress-milestones-perf @ f024c08

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38044515941 · 2026-10-10 10:50 UTC
Commit: Speed runs: habit-milestones-blank, a blank page pushed where All milestones goes, the control for its first opening

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
| Habit page: Progress scrolling (milestones) | 1.9 | 34 ms | 0 | 6.3 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: Milestones shelf scrolling | 0.0 | 0 ms | 0 | 6.3 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All milestones: scrolling | 0.0 | 0 ms | 0 | 6.3 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: Progress scrolling (milestones) | 22.3 | 80 ms | 0 | 3.8 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Habit page: Milestones shelf scrolling | 0.0 | 0 ms | 0 | 3.8 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| All milestones: scrolling | 0.0 | 0 ms | 0 | 3.8 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Habit page: Progress scrolling (milestones) | 6.0 | 38 ms | 0 | 6.5 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: Milestones shelf scrolling | 0.0 | 0 ms | 0 | 6.5 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All milestones: scrolling | 0.0 | 0 ms | 0 | 6.5 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: Progress scrolling (milestones) | 1.3 | 26 ms | 0 | 10.6 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: Milestones shelf scrolling | 0.0 | 0 ms | 0 | 10.6 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All milestones: scrolling | 0.0 | 0 ms | 0 | 10.6 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 1221 ms
- Habit page: longest stall 1221 ms
- Habit page: Progress (milestones): longest stall 510 ms
- All milestones (first): longest stall 305 ms
- All milestones (second): longest stall 136 ms
- All milestones (third): longest stall 155 ms
- All Habits: longest stall 574 ms
- Habit page: longest stall 648 ms
- Habit page: Progress (milestones): longest stall 345 ms
- All milestones (first): longest stall 285 ms
- All milestones (second): longest stall 185 ms
- All milestones (third): longest stall 146 ms
- All Habits: longest stall 551 ms
- Habit page: longest stall 521 ms
- Habit page: Progress (milestones): longest stall 186 ms
- All milestones (first): longest stall 153 ms
- All milestones (second): longest stall 149 ms
- All milestones (third): longest stall 134 ms
- All Habits: longest stall 367 ms
- Habit page: longest stall 400 ms
- Habit page: Progress (milestones): longest stall 173 ms
- All milestones (first): longest stall 161 ms
- All milestones (second): longest stall 107 ms
- All milestones (third): longest stall 94 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| habit-milestones-blank | Widgets: one habit's week | 17 | 130 ms | 78.0 ms |
| habit-milestones-blank | Habit page: history | 1 | 6 ms | 6.1 ms |
| habit-milestones-blank | Habit page: milestones | 1 | 6 ms | 5.6 ms |
| habit-milestones-blank | Habit page: overall record | 1 | 4 ms | 3.9 ms |
| habit-milestones-blank | Widgets: the snapshot | 1 | 2 ms | 2.4 ms |
| habit-milestones-blank | Reminders: plan every alert | 1 | 1 ms | 0.7 ms |
| habit-milestones-blank | Count: a Today row drawn | 9 | 0 ms | 0.5 ms |
| habit-milestones-blank | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-milestones | Widgets: one habit's week | 17 | 145 ms | 104.8 ms |
| habit-milestones | Habit page: milestones | 1 | 11 ms | 11.4 ms |
| habit-milestones | Habit page: overall record | 1 | 10 ms | 10.5 ms |
| habit-milestones | Habit page: history | 1 | 7 ms | 7.0 ms |
| habit-milestones | Widgets: the snapshot | 1 | 2 ms | 1.8 ms |
| habit-milestones | Reminders: plan every alert | 1 | 1 ms | 0.6 ms |
| habit-milestones | Count: a Today row drawn | 9 | 0 ms | 0.2 ms |
| habit-milestones | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-milestones-blank | Widgets: one habit's week | 17 | 139 ms | 89.7 ms |
| habit-milestones-blank | Habit page: history | 1 | 7 ms | 7.1 ms |
| habit-milestones-blank | Habit page: milestones | 1 | 6 ms | 6.3 ms |
| habit-milestones-blank | Habit page: overall record | 1 | 5 ms | 4.6 ms |
| habit-milestones-blank | Widgets: the snapshot | 1 | 2 ms | 2.1 ms |
| habit-milestones-blank | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-milestones-blank | Count: Today's list drawn | 17 | 0 ms | 0.0 ms |
| habit-milestones-blank | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| habit-milestones | Widgets: one habit's week | 17 | 80 ms | 43.7 ms |
| habit-milestones | Habit page: milestones | 1 | 7 ms | 6.7 ms |
| habit-milestones | Habit page: history | 1 | 6 ms | 6.2 ms |
| habit-milestones | Habit page: overall record | 1 | 6 ms | 5.7 ms |
| habit-milestones | Widgets: the snapshot | 1 | 4 ms | 3.6 ms |
| habit-milestones | Count: Today's list drawn | 8 | 0 ms | 0.1 ms |
| habit-milestones | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-milestones | Count: a Today row drawn | 6 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

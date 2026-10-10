# habit-progress-milestones-perf @ 32dcca9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38046476058 · 2026-10-10 11:23 UTC
Commit: Habit Progress: a best run's and best week's dates in the phone's own order, as every other date on the page ("Sep 26 – Oct 1" in US English, "26 Sep – 1 Oct" in British)

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
| Habit page: Progress scrolling (milestones) | 9.4 | 47 ms | 0 | 8.1 % (separate profile) | 0.8%  AppModel.shared.unsafeMutableAddressor<br>0.8%  one-time initialization function for shared<br>0.8%  AppModel.().init()<br>0.3%  ??? |
| Habit page: Milestones shelf scrolling | 0.0 | 0 ms | 0 | 8.1 % (separate profile) | 0.8%  AppModel.shared.unsafeMutableAddressor<br>0.8%  one-time initialization function for shared<br>0.8%  AppModel.().init()<br>0.3%  ??? |
| All milestones: scrolling | 0.6 | 26 ms | 0 | 8.1 % (separate profile) | 0.8%  AppModel.shared.unsafeMutableAddressor<br>0.8%  one-time initialization function for shared<br>0.8%  AppModel.().init()<br>0.3%  ??? |
| Habit page: Progress scrolling (milestones) | 7.7 | 65 ms | 0 | 2.1 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Habit page: Milestones shelf scrolling | 6.4 | 57 ms | 0 | 2.1 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| All milestones: scrolling | 0.0 | 0 ms | 0 | 2.1 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Habit page: Progress scrolling (milestones) | 11.4 | 55 ms | 0 | 7.3 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: Milestones shelf scrolling | 0.0 | 0 ms | 0 | 7.3 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All milestones: scrolling | 0.0 | 0 ms | 0 | 7.3 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 862 ms
- Habit page: longest stall 2713 ms
- Habit page: Progress (milestones): longest stall 0 ms
- All milestones (first): longest stall 374 ms
- All milestones (second): longest stall 169 ms
- All milestones (third): longest stall 204 ms
- All Habits: longest stall 570 ms
- Habit page: longest stall 578 ms
- Habit page: Progress (milestones): longest stall 290 ms
- All milestones (first): longest stall 277 ms
- All milestones (second): longest stall 137 ms
- All milestones (third): longest stall 128 ms
- All Habits: longest stall 486 ms
- Habit page: longest stall 526 ms
- Habit page: Progress (milestones): longest stall 218 ms
- All milestones (first): longest stall 335 ms
- All milestones (second): longest stall 172 ms
- All milestones (third): longest stall 192 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| habit-milestones | Widgets: one habit's week | 17 | 147 ms | 104.1 ms |
| habit-milestones | Habit page: overall record | 1 | 16 ms | 16.1 ms |
| habit-milestones | Habit page: milestones | 1 | 15 ms | 15.0 ms |
| habit-milestones | Habit page: history | 1 | 7 ms | 7.2 ms |
| habit-milestones | Widgets: the snapshot | 1 | 5 ms | 5.3 ms |
| habit-milestones | Reminders: plan every alert | 1 | 3 ms | 2.5 ms |
| habit-milestones | Count: a Today row drawn | 9 | 1 ms | 0.7 ms |
| habit-milestones | Count: Today's list drawn | 8 | 0 ms | 0.1 ms |
| habit-milestones-blank | Widgets: one habit's week | 17 | 85 ms | 45.7 ms |
| habit-milestones-blank | Habit page: history | 1 | 7 ms | 7.2 ms |
| habit-milestones-blank | Habit page: overall record | 1 | 6 ms | 6.5 ms |
| habit-milestones-blank | Habit page: milestones | 1 | 6 ms | 6.2 ms |
| habit-milestones-blank | Widgets: the snapshot | 1 | 2 ms | 1.6 ms |
| habit-milestones-blank | Count: a Today row drawn | 45 | 0 ms | 0.1 ms |
| habit-milestones-blank | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-milestones-blank | Count: Today's list drawn | 15 | 0 ms | 0.0 ms |
| habit-milestones | Widgets: one habit's week | 17 | 112 ms | 68.8 ms |
| habit-milestones | Habit page: milestones | 1 | 13 ms | 13.1 ms |
| habit-milestones | Habit page: history | 1 | 9 ms | 9.1 ms |
| habit-milestones | Habit page: overall record | 1 | 8 ms | 8.2 ms |
| habit-milestones | Widgets: the snapshot | 1 | 2 ms | 1.6 ms |
| habit-milestones | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-milestones | Count: Today's list drawn | 18 | 0 ms | 0.1 ms |
| habit-milestones | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

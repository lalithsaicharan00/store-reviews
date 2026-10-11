# codex/store-today-capture @ 737f77b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38136223228 · 2026-10-11 14:14 UTC
Commit: Prepare native Today artwork capture with habits and one task

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests/testStoreTodayCapture): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayUITests.swift:92: error: -[HabitsUITests.TodayUITests testStoreTodayCapture] : XCTAssertTrue failed - Sample must be visible without scrolling: Buy groceries, frame=(76.0, 846.8333333333334, 104.66666666666666, 20.333333333333258)
Test Case '-[HabitsUITests.TodayUITests testStoreTodayCapture]' failed (31.084 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 28.8 | 169 ms | 2 | 7.2 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 63.6 | 128 ms | 1 | 6.1 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: +1 alone | 1.3 | 30 ms | 0 | 6.1 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: day ‹ › alone | 132.7 | 118 ms | 2 | 6.1 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 | 6.1 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |
| Timer screen: a running clock | 5.7 | 66 ms | 0 | 6.1 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.3%  closure #1 in HabitStore.queueEntryChange() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1166 ms
- Today: a row's Day sheet (again): longest stall 473 ms
- Today: the note sheet: longest stall 5178 ms
- Today: the timer screen: longest stall 0 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's week | 17 | 124 ms | 72.2 ms |
| scroll-today | Widgets: the snapshot | 1 | 2 ms | 1.9 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 1.2 ms |
| scroll-today | Count: Today's list drawn | 10 | 0 ms | 0.3 ms |
| scroll-today | Count: a Today row drawn | 42 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's week | 34 | 146 ms | 46.1 ms |
| tap-today | Widgets: the snapshot | 18 | 26 ms | 3.5 ms |
| tap-today | Change: Siri's habit names | 58 | 7 ms | 0.9 ms |
| tap-today | Reminders: plan every alert | 59 | 4 ms | 0.2 ms |
| tap-today | Count: Today's list drawn | 100 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 690 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 15 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

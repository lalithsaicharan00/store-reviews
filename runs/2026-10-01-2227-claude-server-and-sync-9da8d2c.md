# claude/server-and-sync @ 9da8d2c

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36931139843 · 2026-10-01 22:27 UTC
Commit: Speed: Progress keeps its worked-out numbers between openings (keyed by the data version, which every load moves)

- Core storage and migrations: success
- Build: success
- UI tests (HabitCreationUITests/testBigNumbers): success
- Speed tests: failure
- Speed tests through XCTest: skipped

## UI tests
```
Test Case '-[HabitsUITests.HabitCreationUITests testBigNumbers]' passed (127.324 seconds).
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 45.8 | 309 ms | 2 | 5.5 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 137.4 | 159 ms | 2 |  | (none above noise) |
| Today: group filter | 2.9 | 30 ms | 0 |  | (none above noise) |
| Menu: open and close | 45.4 | 113 ms | 1 |  | (none above noise) |
| menu-pages | not measured (no record: did the app start?) | | | | |
| All Habits: scrolling | 1.7 | 36 ms | 0 |  | (none above noise) |
| Habit page: scrolling | 84.9 | 1024 ms | 2 |  | (none above noise) |
| Habit page (weekly total): scrolling | 1.0 | 32 ms | 0 |  | (none above noise) |
| Habit page (quit): scrolling | 9.0 | 122 ms | 1 |  | (none above noise) |
| habit-edit | not measured (no record: did the app start?) | | | | |
| Progress: scrolling | 0.2 | 19 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 206.8 | 1103 ms | 7 |  | (none above noise) |
| Calendar: month ‹ › | 10.9 | 29 ms | 0 |  | (none above noise) |
| Habit form: typing | 16.6 | 162 ms | 1 | 6.3 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.9%  closure #1 in AppModel.ensureLoaded() |
| Routine player: ‹ › | 18.5 | 91 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 0.1 | 19 ms | 0 | 22.2 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 49.7 | 65 ms | 0 | 22.2 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 483.2 | 382 ms | 31 | 22.2 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 81.8 | 104 ms | 1 | 20.2 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 8.6 | 84 ms | 0 | 20.2 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 71.6 | 60 ms | 0 | 20.2 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 283.0 | 277 ms | 4 | 20.2 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 2.5 | 34 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Tasks: longest stall 633 ms
- Times of Day: longest stall 241 ms
- Day and Week: longest stall 284 ms
- Reminders: longest stall 282 ms
- Appearance: longest stall 166 ms
- Backup & Export: longest stall 170 ms
- Privacy: longest stall 208 ms
- Plus: longest stall 93 ms
- Help & Feedback: longest stall 586 ms
- About: longest stall 252 ms
- All Habits (first): longest stall 256 ms
- All Habits (again): longest stall 177 ms
- All Habits: longest stall 450 ms
- Habit page: longest stall 392 ms
- All Habits: longest stall 270 ms
- Habit page (weekly total): longest stall 0 ms
- All Habits: longest stall 310 ms
- Habit page (quit): longest stall 2031 ms
- All Habits: longest stall 137 ms
- Habit page: longest stall 266 ms
- Edit habit (first): longest stall 597 ms
- Edit habit (again): longest stall 222 ms
- Progress (first): longest stall 746 ms
- Progress (again): longest stall 210 ms
- Calendar (first): longest stall 428 ms
- Calendar (again): longest stall 215 ms
- New Habit (first): longest stall 304 ms
- New Habit (again): longest stall 160 ms
- Habit form (first): longest stall 1441 ms
- Habit form (again): longest stall 411 ms
- Routine player (first): longest stall 487 ms
- Routine player (again): longest stall 134 ms
- All Habits: longest stall 427 ms
- Habit page: longest stall 444 ms
- Day sheet (first): longest stall 574 ms
- Day sheet (again): longest stall 331 ms
- Entry editor: longest stall 1031 ms
- Save entry: longest stall 759 ms
- All Habits: longest stall 319 ms
- Habit page: longest stall 294 ms
- Day sheet (first): longest stall 358 ms
- Day sheet (again): longest stall 193 ms
- Log sheet: longest stall 379 ms
- Log keyboard dismissal: longest stall 205 ms
- Entry editor: longest stall 630 ms
- Save entry: longest stall 683 ms
- Widgets guide (first): longest stall 356 ms
- Widgets guide (again): longest stall 129 ms

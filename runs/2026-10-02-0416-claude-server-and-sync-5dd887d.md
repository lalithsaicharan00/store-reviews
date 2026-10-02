# claude/server-and-sync @ 5dd887d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36961443706 · 2026-10-02 04:16 UTC
Commit: No Mac minutes limit: the repository is public, so Actions minutes are free and unlimited (the user, 2 Oct)

- Core storage and migrations: success
- Build: success
- UI tests (none): skipped
- Speed tests: success
- Speed tests through XCTest: skipped

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 34.4 | 521 ms | 1 | 3.6 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 53.9 | 89 ms | 0 |  | (none above noise) |
| Today: group filter | 3.0 | 31 ms | 0 |  | (none above noise) |
| Menu: open and close | 64.2 | 158 ms | 4 |  | (none above noise) |
| All Habits: scrolling | 9.2 | 72 ms | 0 |  | (none above noise) |
| Habit page: scrolling | 87.0 | 1181 ms | 1 |  | (none above noise) |
| Habit page (weekly total): scrolling | 0.3 | 19 ms | 0 |  | (none above noise) |
| Habit page (quit): scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 174.4 | 233 ms | 10 |  | (none above noise) |
| Calendar: month ‹ › | 29.9 | 103 ms | 1 |  | (none above noise) |
| Habit form: typing | 15.8 | 87 ms | 0 | 12.7 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 17.4 | 65 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 2.6 | 31 ms | 0 | 13.1 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 23.8 | 40 ms | 0 | 13.1 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 47.3 | 74 ms | 0 | 13.1 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 90.2 | 72 ms | 0 | 14.1 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 2.7 | 35 ms | 0 | 14.1 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 39.8 | 44 ms | 0 | 14.1 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 47.7 | 79 ms | 0 | 14.1 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.4%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 0.6 | 19 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Tasks: longest stall 493 ms
- Times of Day: longest stall 257 ms
- Day and Week: longest stall 386 ms
- Reminders: longest stall 309 ms
- Appearance: longest stall 367 ms
- Backup & Export: longest stall 306 ms
- Privacy: longest stall 180 ms
- Plus: longest stall 151 ms
- Help & Feedback: longest stall 771 ms
- About: longest stall 234 ms
- All Habits (first): longest stall 431 ms
- All Habits (again): longest stall 152 ms
- All Habits: longest stall 471 ms
- Habit page: longest stall 384 ms
- All Habits: longest stall 318 ms
- Habit page (weekly total): longest stall 0 ms
- All Habits: longest stall 328 ms
- Habit page (quit): longest stall 882 ms
- All Habits: longest stall 230 ms
- Habit page: longest stall 233 ms
- Edit habit (first): longest stall 640 ms
- Edit habit (again): longest stall 352 ms
- Progress (first): longest stall 584 ms
- Progress (again): longest stall 142 ms
- Calendar (first): longest stall 510 ms
- Calendar (again): longest stall 278 ms
- New Habit (first): longest stall 537 ms
- New Habit (again): longest stall 182 ms
- Habit form (first): longest stall 2191 ms
- Habit form (again): longest stall 378 ms
- Routine player (first): longest stall 602 ms
- Routine player (again): longest stall 110 ms
- All Habits: longest stall 366 ms
- Habit page: longest stall 326 ms
- Day sheet (first): longest stall 429 ms
- Day sheet (again): longest stall 241 ms
- Entry editor: longest stall 828 ms
- Save entry: longest stall 219 ms
- All Habits: longest stall 398 ms
- Habit page: longest stall 394 ms
- Day sheet (first): longest stall 521 ms
- Day sheet (again): longest stall 251 ms
- Log sheet: longest stall 491 ms
- Log keyboard dismissal: longest stall 272 ms
- Entry editor: longest stall 508 ms
- Save entry: longest stall 687 ms
- Widgets guide (first): longest stall 416 ms
- Widgets guide (again): longest stall 181 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| progress | Progress year: whole snapshot | 2 | 136 ms | 106.8 ms |
| progress | Progress year: day scores | 2 | 51 ms | 50.8 ms |
| progress | Progress year: one habit's row | 30 | 51 ms | 4.4 ms |
| progress | Progress week: whole snapshot | 2 | 23 ms | 16.0 ms |
| progress | Progress year: previous period | 1 | 16 ms | 16.5 ms |
| progress | Progress month: whole snapshot | 2 | 12 ms | 8.1 ms |
| progress | Progress week: day scores | 2 | 9 ms | 9.0 ms |
| progress | Progress year: row dots | 2 | 8 ms | 5.4 ms |
| progress | Progress month: one habit's row | 30 | 4 ms | 0.4 ms |
| progress | Progress week: one habit's row | 30 | 3 ms | 1.3 ms |
| progress | Progress month: previous period | 2 | 3 ms | 2.6 ms |
| progress | Progress week: previous period | 2 | 3 ms | 2.2 ms |
| progress | Progress month: day scores | 2 | 1 ms | 1.0 ms |
| progress | Progress: earliest day | 6 | 1 ms | 0.4 ms |
| progress | Progress week: one quit row | 4 | 0 ms | 0.1 ms |
| progress | Progress year: one habit's goals | 1 | 0 ms | 0.2 ms |
| progress | Progress year: one quit row | 2 | 0 ms | 0.1 ms |
| progress | Progress month: one quit row | 4 | 0 ms | 0.1 ms |
| progress | Progress month: one habit's goals | 2 | 0 ms | 0.0 ms |
| progress | Progress week: one habit's goals | 2 | 0 ms | 0.0 ms |

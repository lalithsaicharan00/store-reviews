# claude/repro-fast-nav-50 @ f2e70c6

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37410175611 · 2026-10-06 04:20 UTC
Commit: Checklist 53: the group drag test fails on main at night (found by the full test; not from this branch)

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
| Today: scrolling | 0.0 | 0 ms | 0 | 0.5 % (separate profile) | 0.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.2%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.2%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 35.3 | 68 ms | 0 |  | (none above noise) |
| Today: +1 alone | 2.3 | 35 ms | 0 |  | (none above noise) |
| Today: day ‹ › alone | 21.9 | 55 ms | 0 |  | (none above noise) |
| Today: Day sheet scrolling | 13.9 | 135 ms | 1 |  | (none above noise) |
| Timer screen: a running clock | 0.0 | 17 ms | 0 |  | (none above noise) |
| Today: group filter | 2.9 | 42 ms | 0 |  | (none above noise) |
| Arrange Your Day: scrolling | 0.1 | 19 ms | 0 |  | (none above noise) |
| Arrange Your Day: move Anytime and sort | 0.5 | 21 ms | 0 |  | (none above noise) |
| Today: hide completed on and off | 5.0 | 26 ms | 0 |  | (none above noise) |
| Menu: open and close | 25.6 | 148 ms | 1 |  | (none above noise) |
| All Habits: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page: History scrolling | 0.6 | 26 ms | 0 |  | (none above noise) |
| Habit page: Progress scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page: switching tabs | 1.6 | 24 ms | 0 |  | (none above noise) |
| Habit page (weekly total): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (weekly total): Progress scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): Progress scrolling | 0.2 | 19 ms | 0 |  | (none above noise) |
| Progress: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 69.2 | 104 ms | 1 |  | (none above noise) |
| Progress: key fold and open | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress Year: scrolling | 1.9 | 44 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 1.2 | 36 ms | 0 |  | (none above noise) |
| Habit form: typing | 4.0 | 49 ms | 0 | 8.2 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 11.9 | 46 ms | 0 |  | (none above noise) |
| Routine player: fast ‹ › | 23.8 | 71 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 2.4 | 28 ms | 0 | 15.8 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>2.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 15.3 | 45 ms | 0 | 15.8 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>2.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 320.7 | 114 ms | 6 | 15.8 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>2.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 4.7 | 83 ms | 0 | 16.2 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  static PerfDriver.run(_:store:)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 4.7 | 65 ms | 0 | 16.2 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  static PerfDriver.run(_:store:)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 7.1 | 33 ms | 0 | 16.2 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  static PerfDriver.run(_:store:)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 114.9 | 136 ms | 1 | 16.2 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  static PerfDriver.run(_:store:)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.3 | 19 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 0.1 | 18 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 740 ms
- Today: a row's Day sheet (again): longest stall 256 ms
- Today: the note sheet: longest stall 1746 ms
- Today: the timer screen: longest stall 1368 ms
- Arrange Your Day (first): longest stall 182 ms
- Arrange Your Day (again): longest stall 56 ms
- Blank page (control, first): longest stall 140 ms
- Tasks (first): longest stall 195 ms
- Tasks (again): longest stall 147 ms
- Times of Day (first): longest stall 108 ms
- Times of Day (again): longest stall 105 ms
- Day and Week (first): longest stall 209 ms
- Day and Week (again): longest stall 111 ms
- Reminders (first): longest stall 136 ms
- Reminders (again): longest stall 197 ms
- Appearance (first): longest stall 214 ms
- Appearance (again): longest stall 142 ms
- Backup & Export (first): longest stall 139 ms
- Backup & Export (again): longest stall 228 ms
- Privacy (first): longest stall 96 ms
- Privacy (again): longest stall 138 ms
- Plus (first): longest stall 89 ms
- Plus (again): longest stall 99 ms
- Help & Feedback (first): longest stall 231 ms
- Help & Feedback (again): longest stall 158 ms
- About (first): longest stall 188 ms
- About (again): longest stall 145 ms
- Blank page (control, again): longest stall 73 ms
- All Habits (first): longest stall 244 ms
- All Habits (again): longest stall 173 ms
- All Habits: longest stall 262 ms
- Habit page: longest stall 821 ms
- Habit page: Notes: longest stall 0 ms
- Habit page: Progress: longest stall 199 ms
- All Habits: longest stall 232 ms
- Habit page (weekly total): longest stall 0 ms
- Habit page (weekly total): Progress: longest stall 0 ms
- All Habits: longest stall 232 ms
- Habit page (quit): longest stall 276 ms
- Habit page (quit): Progress: longest stall 96 ms
- All Habits: longest stall 264 ms
- Habit page: longest stall 281 ms
- Edit habit (first): longest stall 453 ms
- Edit habit (again): longest stall 199 ms
- Progress (first): longest stall 676 ms
- Progress (again): longest stall 158 ms
- Progress Year (first): longest stall 387 ms
- Progress Year (again): longest stall 79 ms
- Calendar (first): longest stall 280 ms
- Calendar (again): longest stall 183 ms
- New Habit (first): longest stall 232 ms
- New Habit (again): longest stall 153 ms
- Habit form (first): longest stall 743 ms
- Habit form (again): longest stall 315 ms
- Habit form, no keyboard (first): longest stall 404 ms
- Habit form, no keyboard (again): longest stall 217 ms
- Habit form, the launch's first keyboard: longest stall 196 ms
- Habit form, keyboard again: longest stall 230 ms
- Routine player (first): longest stall 390 ms
- Routine player (again): longest stall 104 ms
- All Habits: longest stall 348 ms
- Habit page: longest stall 322 ms
- Day sheet (first): longest stall 322 ms
- Day sheet (again): longest stall 188 ms
- Entry editor: longest stall 887 ms
- Save entry: longest stall 604 ms
- All Habits: longest stall 309 ms
- Habit page: longest stall 412 ms
- Day sheet (first): longest stall 353 ms
- Day sheet (again): longest stall 176 ms
- Log sheet: longest stall 298 ms
- Log keyboard dismissal: longest stall 101 ms
- Entry editor: longest stall 503 ms
- Save entry: longest stall 583 ms
- Typing control: longest stall 794 ms
- Widgets guide (first): longest stall 424 ms
- Widgets guide (again): longest stall 163 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 72 ms | 35.2 ms |
| scroll-today | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| scroll-today | Count: Today's list drawn | 15 | 0 ms | 0.0 ms |
| scroll-today | Count: a Today row drawn | 69 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 19 | 73 ms | 31.0 ms |
| tap-today | Reminders: plan every alert | 59 | 3 ms | 0.1 ms |
| tap-today | Widgets: the snapshot | 3 | 2 ms | 1.6 ms |
| tap-today | Change: Siri's habit names | 58 | 2 ms | 0.1 ms |
| tap-today | Count: Today's list drawn | 99 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 16 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 431 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 16 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's month | 17 | 58 ms | 29.0 ms |
| groups | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| groups | Count: Today's list drawn | 44 | 0 ms | 0.0 ms |
| groups | Count: a Today row drawn | 237 | 0 ms | 0.0 ms |
| arrange | Widgets: one habit's month | 34 | 91 ms | 29.3 ms |
| arrange | Reminders: plan every alert | 28 | 1 ms | 0.1 ms |
| arrange | Arrange: each card's habits | 29 | 1 ms | 0.2 ms |
| arrange | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| arrange | Change: Siri's habit names | 27 | 1 ms | 0.1 ms |
| arrange | Count: Today's list drawn | 41 | 0 ms | 0.0 ms |
| arrange | Count: a Today row drawn | 195 | 0 ms | 0.0 ms |
| arrange | Count: Arrange Your Day drawn | 29 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's month | 17 | 61 ms | 28.6 ms |
| menu | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| menu | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| menu-pages | Widgets: one habit's month | 17 | 63 ms | 33.7 ms |
| menu-pages | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| menu-pages | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| menu-pages | Count: Today's list drawn | 76 | 0 ms | 0.0 ms |
| menu-pages | Count: a Today row drawn | 294 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's month | 17 | 67 ms | 29.4 ms |
| all-habits | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| all-habits | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| all-habits | Count: a Today row drawn | 27 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's month | 17 | 62 ms | 29.0 ms |
| habit-page | Habit page: history | 1 | 7 ms | 7.0 ms |
| habit-page | Habit page: overall record | 1 | 3 ms | 2.6 ms |
| habit-page | Habit page: milestones | 1 | 1 ms | 1.2 ms |
| habit-page | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's month | 17 | 74 ms | 34.6 ms |
| habit-page-total | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-total | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| habit-page-total | Count: a Today row drawn | 18 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's month | 17 | 52 ms | 25.7 ms |
| habit-page-quit | Habit page: history | 1 | 2 ms | 2.0 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page-quit | Habit page: overall record | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Habit page: milestones | 1 | 0 ms | 0.0 ms |
| habit-page-quit | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| habit-edit | Widgets: one habit's month | 17 | 59 ms | 30.0 ms |
| habit-edit | Habit page: history | 1 | 6 ms | 6.1 ms |
| habit-edit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-edit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-edit | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-edit | Count: a Today row drawn | 40 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's month | 17 | 59 ms | 29.3 ms |
| progress | Progress year: whole snapshot | 2 | 43 ms | 28.0 ms |
| progress | Progress year: cards | 2 | 43 ms | 27.9 ms |
| progress | Progress year: one card | 30 | 41 ms | 3.0 ms |
| progress | Progress week: whole snapshot | 2 | 8 ms | 6.7 ms |
| progress | Progress week: cards | 2 | 8 ms | 6.1 ms |
| progress | Progress week: one card | 30 | 7 ms | 4.9 ms |
| progress | Progress month: whole snapshot | 2 | 5 ms | 3.2 ms |
| progress | Progress month: cards | 2 | 5 ms | 3.1 ms |
| progress | Progress month: one card | 30 | 4 ms | 0.6 ms |
| progress | Progress week: one quit card | 4 | 0 ms | 0.2 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.2 ms |
| progress | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 25 | 0 ms | 0.0 ms |
| progress | Count: a Today row drawn | 120 | 0 ms | 0.0 ms |
| progress-year | Widgets: one habit's month | 17 | 64 ms | 34.5 ms |
| progress-year | Progress year: whole snapshot | 1 | 24 ms | 24.4 ms |
| progress-year | Progress year: cards | 1 | 24 ms | 24.3 ms |
| progress-year | Progress year: one card | 15 | 23 ms | 5.7 ms |
| progress-year | Progress week: whole snapshot | 1 | 1 ms | 1.3 ms |
| progress-year | Progress week: cards | 1 | 1 ms | 1.1 ms |
| progress-year | Progress week: one card | 15 | 1 ms | 0.1 ms |
| progress-year | Progress year: one quit card | 2 | 1 ms | 0.5 ms |
| progress-year | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.2 ms |
| progress-year | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress-year | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| progress-year | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's month | 17 | 69 ms | 36.0 ms |
| calendar | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| calendar | Count: a Today row drawn | 36 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's month | 17 | 64 ms | 34.9 ms |
| new-habit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| new-habit | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| new-habit | Count: a Today row drawn | 76 | 0 ms | 0.0 ms |
| form-parts | Widgets: one habit's month | 17 | 62 ms | 32.8 ms |
| form-parts | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| form-parts | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| form-parts | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| form-parts | Count: a Today row drawn | 81 | 0 ms | 0.0 ms |
| player | Widgets: one habit's month | 18 | 55 ms | 25.1 ms |
| player | Reminders: plan every alert | 50 | 2 ms | 0.1 ms |
| player | Change: Siri's habit names | 49 | 2 ms | 0.1 ms |
| player | Widgets: the snapshot | 2 | 2 ms | 1.4 ms |
| player | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| player | Count: a Today row drawn | 33 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 146 | 966 ms | 13.0 ms |
| day-sheet | Widgets: one habit's month | 17 | 90 ms | 56.9 ms |
| day-sheet | Change: Siri's habit names | 145 | 7 ms | 0.1 ms |
| day-sheet | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| day-sheet | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| day-sheet | Count: Today's list drawn | 9 | 0 ms | 0.1 ms |
| day-sheet | Count: the Day sheet drawn | 156 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 177 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's activity drawn | 205 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 9 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 146 | 697 ms | 12.4 ms |
| log-sheet | Widgets: one habit's month | 18 | 98 ms | 40.8 ms |
| log-sheet | Widgets: the snapshot | 2 | 6 ms | 5.5 ms |
| log-sheet | Change: Siri's habit names | 145 | 6 ms | 0.1 ms |
| log-sheet | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 174 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 155 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's activity drawn | 204 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's entries drawn | 6 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 8 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's month | 17 | 84 ms | 34.9 ms |
| typing-control | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| typing-control | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| typing-control | Count: a Today row drawn | 27 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's month | 17 | 86 ms | 45.6 ms |
| widget-guide | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| widget-guide | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-guide | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| widget-guide | Count: a Today row drawn | 36 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's month | 40 | 133 ms | 42.5 ms |
| widget-log | Widgets: the snapshot | 24 | 9 ms | 1.0 ms |
| widget-log | Reminders: plan every alert | 49 | 4 ms | 0.1 ms |
| widget-log | Change: Siri's habit names | 54 | 2 ms | 0.2 ms |
| widget-log | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| widget-log | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# claude/habit-details-perf @ 78a11e4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37141085645 · 2026-10-03 18:12 UTC
Commit: Today's rows: a tap opens the Day sheet for the day shown; ✓ toggles that day's tick, + adds; swipes reveal Note/Skip/Pause and a named Undo; long press matches the sheet; Delete only in the sheet's ⋯ menu; done habits stay in place

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
| Today: scrolling | 37.5 | 239 ms | 2 | 3.3 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 34.1 | 60 ms | 0 |  | (none above noise) |
| Today: +1 alone | 0.0 | 0 ms | 0 |  | (none above noise) |
| Today: day ‹ › alone | 13.3 | 44 ms | 0 |  | (none above noise) |
| Today: Day sheet scrolling | 1.5 | 22 ms | 0 |  | (none above noise) |
| Today: group filter | 1.4 | 25 ms | 0 |  | (none above noise) |
| Arrange Your Day: scrolling | 3.5 | 33 ms | 0 |  | (none above noise) |
| Arrange Your Day: move Anytime and sort | 1.7 | 28 ms | 0 |  | (none above noise) |
| Today: hide completed on and off | 11.3 | 86 ms | 0 |  | (none above noise) |
| Menu: open and close | 34.2 | 174 ms | 1 |  | (none above noise) |
| All Habits: scrolling | 2.9 | 31 ms | 0 |  | (none above noise) |
| Habit page: History scrolling | 15.5 | 167 ms | 1 |  | (none above noise) |
| Habit page: Progress scrolling | 15.4 | 92 ms | 0 |  | (none above noise) |
| Habit page: switching tabs | 50.4 | 142 ms | 1 |  | (none above noise) |
| Habit page (weekly total): History scrolling | 2.4 | 24 ms | 0 |  | (none above noise) |
| Habit page (weekly total): Progress scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): Progress scrolling | 0.3 | 21 ms | 0 |  | (none above noise) |
| Progress: scrolling | 2.9 | 29 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 96.3 | 113 ms | 1 |  | (none above noise) |
| Progress: key fold and open | 9.7 | 34 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress Year: scrolling | 4.9 | 52 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 5.7 | 42 ms | 0 |  | (none above noise) |
| Habit form: typing | 43.1 | 491 ms | 1 | 14.3 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 13.9 | 63 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 5.2 | 33 ms | 0 | 17.1 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  closure #1 in static PerfDriver.startIfAsked(store:)<br>1.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 1.9 | 24 ms | 0 | 17.1 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  closure #1 in static PerfDriver.startIfAsked(store:)<br>1.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 246.6 | 85 ms | 0 | 17.1 % (separate profile) | 1.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  closure #1 in static PerfDriver.startIfAsked(store:)<br>1.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 4.2 | 52 ms | 0 | 11.3 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 3.9 | 49 ms | 0 | 11.3 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 1.8 | 26 ms | 0 | 11.3 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 191.8 | 151 ms | 1 | 11.3 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 0.4 | 22 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1844 ms
- Today: a row's Day sheet (again): longest stall 325 ms
- Arrange Your Day (first): longest stall 260 ms
- Arrange Your Day (again): longest stall 72 ms
- Blank page (control, first): longest stall 163 ms
- Tasks (first): longest stall 200 ms
- Tasks (again): longest stall 122 ms
- Times of Day (first): longest stall 111 ms
- Times of Day (again): longest stall 98 ms
- Day and Week (first): longest stall 238 ms
- Day and Week (again): longest stall 156 ms
- Reminders (first): longest stall 147 ms
- Reminders (again): longest stall 112 ms
- Appearance (first): longest stall 188 ms
- Appearance (again): longest stall 165 ms
- Backup & Export (first): longest stall 279 ms
- Backup & Export (again): longest stall 169 ms
- Privacy (first): longest stall 130 ms
- Privacy (again): longest stall 132 ms
- Plus (first): longest stall 78 ms
- Plus (again): longest stall 105 ms
- Help & Feedback (first): longest stall 302 ms
- Help & Feedback (again): longest stall 152 ms
- About (first): longest stall 161 ms
- About (again): longest stall 149 ms
- Blank page (control, again): longest stall 80 ms
- All Habits (first): longest stall 324 ms
- All Habits (again): longest stall 280 ms
- All Habits: longest stall 583 ms
- Habit page: longest stall 1724 ms
- Habit page: Notes: longest stall 188 ms
- Habit page: Progress: longest stall 249 ms
- All Habits: longest stall 632 ms
- Habit page (weekly total): longest stall 0 ms
- Habit page (weekly total): Progress: longest stall 0 ms
- All Habits: longest stall 381 ms
- Habit page (quit): longest stall 565 ms
- Habit page (quit): Progress: longest stall 149 ms
- All Habits: longest stall 300 ms
- Habit page: longest stall 396 ms
- Edit habit (first): longest stall 724 ms
- Edit habit (again): longest stall 244 ms
- Progress (first): longest stall 1139 ms
- Progress (again): longest stall 228 ms
- Progress Year (first): longest stall 590 ms
- Progress Year (again): longest stall 148 ms
- Calendar (first): longest stall 545 ms
- Calendar (again): longest stall 285 ms
- New Habit (first): longest stall 417 ms
- New Habit (again): longest stall 196 ms
- Habit form (first): longest stall 1510 ms
- Habit form (again): longest stall 261 ms
- Habit form, no keyboard (first): longest stall 515 ms
- Habit form, no keyboard (again): longest stall 213 ms
- Habit form, the launch's first keyboard: longest stall 286 ms
- Habit form, keyboard again: longest stall 226 ms
- Routine player (first): longest stall 442 ms
- Routine player (again): longest stall 135 ms
- All Habits: longest stall 404 ms
- Habit page: longest stall 608 ms
- Day sheet (first): longest stall 558 ms
- Day sheet (again): longest stall 440 ms
- Entry editor: longest stall 971 ms
- Save entry: longest stall 487 ms
- All Habits: longest stall 477 ms
- Habit page: longest stall 599 ms
- Day sheet (first): longest stall 486 ms
- Day sheet (again): longest stall 365 ms
- Log sheet: longest stall 585 ms
- Log keyboard dismissal: longest stall 160 ms
- Entry editor: longest stall 474 ms
- Save entry: longest stall 455 ms
- Typing control: longest stall 800 ms
- Widgets guide (first): longest stall 258 ms
- Widgets guide (again): longest stall 97 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 80 ms | 44.9 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.4 ms |
| scroll-today | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| scroll-today | Count: Today's list drawn | 7 | 0 ms | 0.3 ms |
| scroll-today | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 18 | 63 ms | 31.9 ms |
| tap-today | Reminders: plan every alert | 57 | 3 ms | 0.2 ms |
| tap-today | Change: Siri's habit names | 56 | 2 ms | 0.2 ms |
| tap-today | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| tap-today | Count: Today's list drawn | 86 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 15 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 367 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 5 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's month | 17 | 229 ms | 199.2 ms |
| groups | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| groups | Count: Today's list drawn | 48 | 0 ms | 0.0 ms |
| groups | Count: a Today row drawn | 522 | 0 ms | 0.0 ms |
| arrange | Widgets: one habit's month | 34 | 88 ms | 30.7 ms |
| arrange | Reminders: plan every alert | 28 | 2 ms | 0.4 ms |
| arrange | Change: Siri's habit names | 27 | 1 ms | 0.2 ms |
| arrange | Arrange: each card's habits | 29 | 1 ms | 0.1 ms |
| arrange | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| arrange | Count: Today's list drawn | 40 | 0 ms | 0.0 ms |
| arrange | Count: a Today row drawn | 358 | 0 ms | 0.0 ms |
| arrange | Count: Arrange Your Day drawn | 29 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's month | 17 | 65 ms | 32.0 ms |
| menu | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| menu | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| menu-pages | Widgets: one habit's month | 17 | 71 ms | 32.2 ms |
| menu-pages | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| menu-pages | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| menu-pages | Count: Today's list drawn | 74 | 0 ms | 0.0 ms |
| menu-pages | Count: a Today row drawn | 516 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's month | 17 | 84 ms | 39.9 ms |
| all-habits | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| all-habits | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| all-habits | Count: a Today row drawn | 57 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's month | 17 | 112 ms | 46.5 ms |
| habit-page | Habit page: history | 1 | 19 ms | 19.3 ms |
| habit-page | Habit page: overall record | 1 | 5 ms | 4.6 ms |
| habit-page | Habit page: milestones | 1 | 1 ms | 1.2 ms |
| habit-page | Reminders: plan every alert | 1 | 1 ms | 0.7 ms |
| habit-page | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| habit-page | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 54 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's month | 17 | 110 ms | 66.9 ms |
| habit-page-total | Reminders: plan every alert | 1 | 1 ms | 1.0 ms |
| habit-page-total | Widgets: the snapshot | 1 | 0 ms | 0.5 ms |
| habit-page-total | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-total | Count: a Today row drawn | 41 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's month | 17 | 73 ms | 42.0 ms |
| habit-page-quit | Habit page: history | 1 | 3 ms | 2.9 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.4 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page-quit | Habit page: overall record | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-page-quit | Habit page: milestones | 1 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 52 | 0 ms | 0.0 ms |
| habit-edit | Widgets: one habit's month | 17 | 80 ms | 31.4 ms |
| habit-edit | Habit page: history | 1 | 8 ms | 8.4 ms |
| habit-edit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-edit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-edit | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-edit | Count: a Today row drawn | 69 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's month | 17 | 83 ms | 43.3 ms |
| progress | Progress year: whole snapshot | 2 | 49 ms | 30.5 ms |
| progress | Progress year: cards | 2 | 49 ms | 30.4 ms |
| progress | Progress year: one card | 30 | 46 ms | 3.2 ms |
| progress | Progress week: whole snapshot | 2 | 12 ms | 8.6 ms |
| progress | Progress week: cards | 2 | 11 ms | 7.7 ms |
| progress | Progress month: whole snapshot | 2 | 10 ms | 6.7 ms |
| progress | Progress month: cards | 2 | 10 ms | 6.6 ms |
| progress | Progress week: one card | 30 | 9 ms | 6.0 ms |
| progress | Progress month: one card | 30 | 7 ms | 1.5 ms |
| progress | Progress year: one quit card | 2 | 1 ms | 0.6 ms |
| progress | Widgets: the snapshot | 1 | 1 ms | 0.7 ms |
| progress | Progress week: one quit card | 4 | 1 ms | 0.3 ms |
| progress | Progress month: one quit card | 4 | 1 ms | 0.4 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 48 | 0 ms | 0.0 ms |
| progress | Count: a Today row drawn | 511 | 0 ms | 0.0 ms |
| progress-year | Widgets: one habit's month | 17 | 89 ms | 46.2 ms |
| progress-year | Progress year: whole snapshot | 1 | 36 ms | 36.4 ms |
| progress-year | Progress year: cards | 1 | 36 ms | 36.3 ms |
| progress-year | Progress year: one card | 15 | 34 ms | 8.4 ms |
| progress-year | Progress week: whole snapshot | 1 | 4 ms | 3.6 ms |
| progress-year | Progress week: cards | 1 | 3 ms | 3.3 ms |
| progress-year | Progress week: one card | 15 | 2 ms | 0.3 ms |
| progress-year | Widgets: the snapshot | 1 | 1 ms | 0.7 ms |
| progress-year | Progress year: one quit card | 2 | 1 ms | 0.4 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.3 ms |
| progress-year | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress-year | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| progress-year | Count: a Today row drawn | 86 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's month | 17 | 161 ms | 112.0 ms |
| calendar | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: Today's list drawn | 10 | 0 ms | 0.1 ms |
| calendar | Count: a Today row drawn | 82 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's month | 17 | 92 ms | 54.4 ms |
| new-habit | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| new-habit | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| new-habit | Count: a Today row drawn | 147 | 0 ms | 0.0 ms |
| form-parts | Widgets: one habit's month | 17 | 96 ms | 53.4 ms |
| form-parts | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| form-parts | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| form-parts | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| form-parts | Count: a Today row drawn | 153 | 0 ms | 0.0 ms |
| player | Widgets: one habit's month | 18 | 70 ms | 31.2 ms |
| player | Reminders: plan every alert | 38 | 2 ms | 0.1 ms |
| player | Widgets: the snapshot | 2 | 2 ms | 1.6 ms |
| player | Change: Siri's habit names | 37 | 2 ms | 0.1 ms |
| player | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| player | Count: a Today row drawn | 76 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 149 | 863 ms | 12.8 ms |
| day-sheet | Widgets: one habit's month | 17 | 87 ms | 43.8 ms |
| day-sheet | Change: Siri's habit names | 148 | 7 ms | 0.1 ms |
| day-sheet | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| day-sheet | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| day-sheet | Count: the Day sheet drawn | 157 | 0 ms | 0.0 ms |
| day-sheet | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 134 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 8 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's entries drawn | 54 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 146 | 821 ms | 13.8 ms |
| log-sheet | Widgets: one habit's month | 18 | 116 ms | 48.4 ms |
| log-sheet | Change: Siri's habit names | 145 | 6 ms | 0.1 ms |
| log-sheet | Widgets: the snapshot | 2 | 1 ms | 1.0 ms |
| log-sheet | Reminders: plan every alert | 3 | 0 ms | 0.3 ms |
| log-sheet | Count: Today's list drawn | 10 | 0 ms | 0.1 ms |
| log-sheet | Count: the Day sheet drawn | 155 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's entries drawn | 56 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 131 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 7 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's month | 17 | 62 ms | 34.4 ms |
| typing-control | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| typing-control | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| typing-control | Count: a Today row drawn | 83 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's month | 17 | 58 ms | 30.0 ms |
| widget-guide | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| widget-guide | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-guide | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| widget-guide | Count: a Today row drawn | 86 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's month | 40 | 131 ms | 36.2 ms |
| widget-log | Widgets: the snapshot | 24 | 10 ms | 0.7 ms |
| widget-log | Reminders: plan every alert | 48 | 3 ms | 0.7 ms |
| widget-log | Change: Siri's habit names | 54 | 3 ms | 0.1 ms |
| widget-log | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| widget-log | Count: a Today row drawn | 85 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

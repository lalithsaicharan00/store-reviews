# claude/progress-week-cards @ d8f0d1f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37122433095 · 2026-10-03 13:37 UTC
Commit: Merge main into claude/progress-week-cards again (Arrange Your Day, text limits, Next Up)

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
| Today: scrolling | 34.4 | 139 ms | 2 | 3.8 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 32.2 | 79 ms | 0 |  | (none above noise) |
| Today: +1 alone | 0.3 | 22 ms | 0 |  | (none above noise) |
| Today: day ‹ › alone | 8.7 | 46 ms | 0 |  | (none above noise) |
| Today: group filter | 0.0 | 0 ms | 0 |  | (none above noise) |
| Arrange Your Day: scrolling | 0.2 | 20 ms | 0 |  | (none above noise) |
| Arrange Your Day: move Anytime and sort | 1.3 | 26 ms | 0 |  | (none above noise) |
| Today: hide completed on and off | 9.6 | 39 ms | 0 |  | (none above noise) |
| Menu: open and close | 26.7 | 140 ms | 1 |  | (none above noise) |
| All Habits: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page: scrolling | 15.1 | 140 ms | 1 |  | (none above noise) |
| Habit page (weekly total): scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): scrolling | 29.2 | 455 ms | 1 |  | (none above noise) |
| Progress: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 44.8 | 87 ms | 0 |  | (none above noise) |
| Progress: key fold and open | 0.3 | 19 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress Year: scrolling | 0.1 | 18 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 8.0 | 28 ms | 0 |  | (none above noise) |
| Habit form: typing | 4.0 | 34 ms | 0 | 10.4 % (separate profile) | 1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 4.8 | 41 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 9.8 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 0.1 | 18 ms | 0 | 9.8 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 27.6 | 30 ms | 0 | 9.8 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: typing | 1.9 | 42 ms | 0 | 8.7 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Log sheet: entry list scrolling | 0.8 | 29 ms | 0 | 8.7 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 0.0 | 0 ms | 0 | 8.7 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 26.7 | 51 ms | 0 | 8.7 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 0.0 | 0 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Arrange Your Day (first): longest stall 190 ms
- Arrange Your Day (again): longest stall 74 ms
- Blank page (control, first): longest stall 134 ms
- Tasks (first): longest stall 223 ms
- Tasks (again): longest stall 118 ms
- Times of Day (first): longest stall 116 ms
- Times of Day (again): longest stall 79 ms
- Day and Week (first): longest stall 207 ms
- Day and Week (again): longest stall 126 ms
- Reminders (first): longest stall 182 ms
- Reminders (again): longest stall 219 ms
- Appearance (first): longest stall 178 ms
- Appearance (again): longest stall 192 ms
- Backup & Export (first): longest stall 146 ms
- Backup & Export (again): longest stall 136 ms
- Privacy (first): longest stall 136 ms
- Privacy (again): longest stall 135 ms
- Plus (first): longest stall 90 ms
- Plus (again): longest stall 112 ms
- Help & Feedback (first): longest stall 271 ms
- Help & Feedback (again): longest stall 159 ms
- About (first): longest stall 175 ms
- About (again): longest stall 148 ms
- Blank page (control, again): longest stall 111 ms
- All Habits (first): longest stall 157 ms
- All Habits (again): longest stall 183 ms
- All Habits: longest stall 252 ms
- Habit page: longest stall 953 ms
- All Habits: longest stall 255 ms
- Habit page (weekly total): longest stall 0 ms
- All Habits: longest stall 289 ms
- Habit page (quit): longest stall 289 ms
- All Habits: longest stall 258 ms
- Habit page: longest stall 298 ms
- Edit habit (first): longest stall 479 ms
- Edit habit (again): longest stall 257 ms
- Progress (first): longest stall 404 ms
- Progress (again): longest stall 143 ms
- Progress Year (first): longest stall 401 ms
- Progress Year (again): longest stall 194 ms
- Calendar (first): longest stall 245 ms
- Calendar (again): longest stall 154 ms
- New Habit (first): longest stall 231 ms
- New Habit (again): longest stall 131 ms
- Habit form (first): longest stall 552 ms
- Habit form (again): longest stall 267 ms
- Habit form, no keyboard (first): longest stall 432 ms
- Habit form, no keyboard (again): longest stall 192 ms
- Habit form, the launch's first keyboard: longest stall 242 ms
- Habit form, keyboard again: longest stall 228 ms
- Routine player (first): longest stall 300 ms
- Routine player (again): longest stall 100 ms
- All Habits: longest stall 156 ms
- Habit page: longest stall 312 ms
- Day sheet (first): longest stall 332 ms
- Day sheet (again): longest stall 176 ms
- Entry editor: longest stall 580 ms
- Save entry: longest stall 221 ms
- All Habits: longest stall 256 ms
- Habit page: longest stall 276 ms
- Day sheet (first): longest stall 338 ms
- Day sheet (again): longest stall 176 ms
- Log sheet: longest stall 277 ms
- Log keyboard dismissal: longest stall 50 ms
- Entry editor: longest stall 333 ms
- Save entry: longest stall 110 ms
- Typing control: longest stall 418 ms
- Widgets guide (first): longest stall 164 ms
- Widgets guide (again): longest stall 100 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's month | 17 | 79 ms | 40.9 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.4 ms |
| scroll-today | Count: Today's list drawn | 7 | 0 ms | 0.3 ms |
| scroll-today | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| scroll-today | Count: a Today row drawn | 36 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's month | 18 | 67 ms | 34.1 ms |
| tap-today | Reminders: plan every alert | 57 | 2 ms | 0.1 ms |
| tap-today | Change: Siri's habit names | 56 | 2 ms | 0.1 ms |
| tap-today | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| tap-today | Count: Today's list drawn | 80 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 551 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's month | 17 | 59 ms | 30.5 ms |
| groups | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| groups | Count: Today's list drawn | 51 | 0 ms | 0.0 ms |
| groups | Count: a Today row drawn | 564 | 0 ms | 0.0 ms |
| arrange | Widgets: one habit's month | 34 | 92 ms | 32.8 ms |
| arrange | Reminders: plan every alert | 28 | 1 ms | 0.1 ms |
| arrange | Change: Siri's habit names | 27 | 1 ms | 0.1 ms |
| arrange | Arrange: each card's habits | 29 | 1 ms | 0.1 ms |
| arrange | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| arrange | Count: Today's list drawn | 40 | 0 ms | 0.0 ms |
| arrange | Count: a Today row drawn | 353 | 0 ms | 0.0 ms |
| arrange | Count: Arrange Your Day drawn | 29 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's month | 17 | 59 ms | 31.0 ms |
| menu | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| menu | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 36 | 0 ms | 0.0 ms |
| menu-pages | Widgets: one habit's month | 17 | 60 ms | 30.9 ms |
| menu-pages | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| menu-pages | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| menu-pages | Count: a Today row drawn | 537 | 0 ms | 0.0 ms |
| menu-pages | Count: Today's list drawn | 75 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's month | 17 | 60 ms | 31.9 ms |
| all-habits | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| all-habits | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| all-habits | Count: a Today row drawn | 63 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's month | 17 | 60 ms | 31.1 ms |
| habit-page | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 54 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's month | 17 | 60 ms | 31.1 ms |
| habit-page-total | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-total | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| habit-page-total | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's month | 17 | 69 ms | 33.9 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 42 | 0 ms | 0.0 ms |
| habit-edit | Widgets: one habit's month | 17 | 67 ms | 35.4 ms |
| habit-edit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| habit-edit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-edit | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-edit | Count: a Today row drawn | 64 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's month | 17 | 63 ms | 29.8 ms |
| progress | Progress year: whole snapshot | 2 | 33 ms | 21.1 ms |
| progress | Progress year: cards | 2 | 33 ms | 21.0 ms |
| progress | Progress year: one card | 30 | 31 ms | 2.5 ms |
| progress | Progress week: whole snapshot | 2 | 9 ms | 7.1 ms |
| progress | Progress week: cards | 2 | 8 ms | 6.6 ms |
| progress | Progress week: one card | 30 | 7 ms | 5.2 ms |
| progress | Progress month: whole snapshot | 2 | 4 ms | 2.6 ms |
| progress | Progress month: cards | 2 | 4 ms | 2.5 ms |
| progress | Progress month: one card | 30 | 3 ms | 0.3 ms |
| progress | Progress week: one quit card | 4 | 0 ms | 0.2 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.2 ms |
| progress | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 51 | 0 ms | 0.0 ms |
| progress | Count: a Today row drawn | 471 | 0 ms | 0.0 ms |
| progress-year | Widgets: one habit's month | 17 | 62 ms | 31.9 ms |
| progress-year | Progress year: whole snapshot | 1 | 26 ms | 26.2 ms |
| progress-year | Progress year: cards | 1 | 26 ms | 26.1 ms |
| progress-year | Progress year: one card | 15 | 25 ms | 6.2 ms |
| progress-year | Progress week: whole snapshot | 1 | 1 ms | 1.2 ms |
| progress-year | Progress week: cards | 1 | 1 ms | 1.1 ms |
| progress-year | Progress week: one card | 15 | 1 ms | 0.1 ms |
| progress-year | Progress year: one quit card | 2 | 1 ms | 0.4 ms |
| progress-year | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.1 ms |
| progress-year | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress-year | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| progress-year | Count: a Today row drawn | 90 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's month | 17 | 55 ms | 25.8 ms |
| calendar | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| calendar | Count: a Today row drawn | 60 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's month | 17 | 60 ms | 30.8 ms |
| new-habit | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| new-habit | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| new-habit | Count: a Today row drawn | 127 | 0 ms | 0.0 ms |
| form-parts | Widgets: one habit's month | 17 | 66 ms | 34.6 ms |
| form-parts | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| form-parts | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| form-parts | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| form-parts | Count: a Today row drawn | 117 | 0 ms | 0.0 ms |
| player | Widgets: one habit's month | 18 | 62 ms | 31.3 ms |
| player | Widgets: the snapshot | 2 | 2 ms | 1.6 ms |
| player | Reminders: plan every alert | 38 | 2 ms | 0.1 ms |
| player | Change: Siri's habit names | 37 | 1 ms | 0.1 ms |
| player | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| player | Count: a Today row drawn | 60 | 0 ms | 0.0 ms |
| day-sheet | Widgets: one habit's month | 17 | 56 ms | 27.2 ms |
| day-sheet | Change: Siri's habit names | 145 | 5 ms | 0.0 ms |
| day-sheet | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| day-sheet | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| day-sheet | Entry editor: whole editor drawn | 8 | 0 ms | 0.1 ms |
| day-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 207 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 16 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's entries drawn | 53 | 0 ms | 0.0 ms |
| log-sheet | Widgets: one habit's month | 18 | 76 ms | 29.4 ms |
| log-sheet | Change: Siri's habit names | 148 | 5 ms | 0.1 ms |
| log-sheet | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| log-sheet | Reminders: plan every alert | 3 | 0 ms | 0.2 ms |
| log-sheet | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 216 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 18 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's entries drawn | 60 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 7 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's month | 17 | 59 ms | 28.8 ms |
| typing-control | Widgets: the snapshot | 1 | 0 ms | 0.3 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| typing-control | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| typing-control | Count: a Today row drawn | 66 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's month | 17 | 60 ms | 29.9 ms |
| widget-guide | Widgets: the snapshot | 1 | 0 ms | 0.4 ms |
| widget-guide | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-guide | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| widget-guide | Count: a Today row drawn | 75 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's month | 40 | 114 ms | 28.3 ms |
| widget-log | Widgets: the snapshot | 24 | 9 ms | 0.7 ms |
| widget-log | Reminders: plan every alert | 47 | 2 ms | 0.1 ms |
| widget-log | Change: Siri's habit names | 54 | 2 ms | 0.1 ms |
| widget-log | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| widget-log | Count: a Today row drawn | 171 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

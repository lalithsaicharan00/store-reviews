# day-details-logs-notes-redesign-ci-f @ aa6ee1e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37624454758 · 2026-10-07 14:31 UTC
Commit: Day details on the iPhone SE: 44-pt buttons and rows, the first and logs gaps as designed

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
| Today: scrolling | 22.8 | 162 ms | 2 | 7.0 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 47.4 | 53 ms | 0 |  | (none above noise) |
| Today: +1 alone | 2.4 | 46 ms | 0 |  | (none above noise) |
| Today: day ‹ › alone | 80.4 | 101 ms | 1 |  | (none above noise) |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Timer screen: a running clock | 25.8 | 170 ms | 3 |  | (none above noise) |
| Today: group filter | 37.3 | 66 ms | 0 |  | (none above noise) |
| Arrange Your Day: scrolling | 4.8 | 36 ms | 0 |  | (none above noise) |
| Arrange Your Day: move Anytime and sort | 26.9 | 119 ms | 1 |  | (none above noise) |
| Today: hide completed on and off | 51.2 | 119 ms | 1 |  | (none above noise) |
| Menu: open and close | 63.3 | 393 ms | 2 |  | (none above noise) |
| All Habits: scrolling | 7.0 | 40 ms | 0 |  | (none above noise) |
| Habit page: History scrolling | 4.2 | 36 ms | 0 |  | (none above noise) |
| Habit page: Progress scrolling | 19.2 | 132 ms | 1 |  | (none above noise) |
| Habit page: switching tabs | 49.0 | 122 ms | 1 |  | (none above noise) |
| Habit page (weekly total): History scrolling | 3.1 | 52 ms | 0 |  | (none above noise) |
| Habit page (weekly total): Progress scrolling | 0.0 | 17 ms | 0 |  | (none above noise) |
| Habit page (quit): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): Progress scrolling | 1.3 | 26 ms | 0 |  | (none above noise) |
| Progress: scrolling | 16.3 | 64 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 117.6 | 171 ms | 4 |  | (none above noise) |
| Progress: key fold and open | 1.1 | 34 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress Year: scrolling | 21.3 | 60 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 6.2 | 33 ms | 0 |  | (none above noise) |
| Habit form: typing | 14.8 | 78 ms | 0 | 3.2 % (separate profile) | 0.9%  __swift_instantiateConcreteTypeFromMangledNameV2<br>0.8%  closure #11 in TodayView.observedNavigation.getter<br>0.8%  closure #1 in closure #11 in TodayView.observedNavigation.getter<br>0.8%  HabitForm.init(type:group:idea:onSaved:) |
| Routine player: ‹ › | 32.6 | 68 ms | 0 |  | (none above noise) |
| Routine player: fast ‹ › | 23.6 | 61 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 10.8 % (separate profile) | 1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:)<br>1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 10.8 % (separate profile) | 1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:)<br>1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Entry editor: typing | 0.0 | 0 ms | 0 | 10.8 % (separate profile) | 1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:)<br>1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Day sheet: add, edit and exact undo | 90.8 | 104 ms | 1 | 10.8 % (separate profile) | 1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:)<br>1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Log sheet: typing | 1.7 | 36 ms | 0 | 8.0 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 8.0 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 0.3 | 20 ms | 0 | 8.0 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 126.2 | 94 ms | 0 | 8.0 % (separate profile) | 1.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Add screen (Water): typing | 0.4 | 19 ms | 0 |  | (none above noise) |
| Add screen (Read): typing | 5.1 | 30 ms | 0 |  | (none above noise) |
| Add note: typing | 3.4 | 66 ms | 0 | 11.5 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Edit note: typing | 2.0 | 47 ms | 0 | 11.5 % (separate profile) | 1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 1.2 | 32 ms | 0 |  | (none above noise) |
| Widget: full publication, every habit's week | 0.0 | 0 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 740 ms
- Today: a row's Day sheet (again): longest stall 448 ms
- Today: the note sheet: longest stall 1169 ms
- Today: the timer screen: longest stall 0 ms
- Arrange Your Day (first): longest stall 360 ms
- Arrange Your Day (again): longest stall 90 ms
- Blank page (control, first): longest stall 258 ms
- Tasks (first): longest stall 375 ms
- Tasks (again): longest stall 291 ms
- Times of Day (first): longest stall 282 ms
- Times of Day (again): longest stall 259 ms
- Day and Week (first): longest stall 527 ms
- Day and Week (again): longest stall 268 ms
- Reminders (first): longest stall 356 ms
- Reminders (again): longest stall 240 ms
- Appearance (first): longest stall 431 ms
- Appearance (again): longest stall 362 ms
- Backup & Export (first): longest stall 338 ms
- Backup & Export (again): longest stall 235 ms
- Privacy (first): longest stall 223 ms
- Privacy (again): longest stall 224 ms
- Plus (first): longest stall 185 ms
- Plus (again): longest stall 172 ms
- Help & Feedback (first): longest stall 441 ms
- Help & Feedback (again): longest stall 264 ms
- About (first): longest stall 208 ms
- About (again): longest stall 291 ms
- Blank page (control, again): longest stall 268 ms
- All Habits (first): longest stall 574 ms
- All Habits (again): longest stall 299 ms
- All Habits: longest stall 233 ms
- Habit page: longest stall 1446 ms
- Habit page: Notes: longest stall 33 ms
- Habit page: Progress: longest stall 213 ms
- All Habits: longest stall 490 ms
- Habit page (weekly total): longest stall 0 ms
- Habit page (weekly total): Progress: longest stall 0 ms
- All Habits: longest stall 301 ms
- Habit page (quit): longest stall 509 ms
- Habit page (quit): Progress: longest stall 146 ms
- All Habits: longest stall 583 ms
- Habit page: longest stall 727 ms
- Edit habit (first): longest stall 1194 ms
- Edit habit (again): longest stall 524 ms
- Progress (first): longest stall 1306 ms
- Progress (again): longest stall 218 ms
- Progress Year (first): longest stall 546 ms
- Progress Year (again): longest stall 180 ms
- Calendar (first): longest stall 431 ms
- Calendar (again): longest stall 247 ms
- New Habit (first): longest stall 414 ms
- New Habit (again): longest stall 145 ms
- Habit form (first): longest stall 794 ms
- Habit form (again): longest stall 321 ms
- Habit form, no keyboard (first): longest stall 698 ms
- Habit form, no keyboard (again): longest stall 288 ms
- Habit form, the launch's first keyboard: longest stall 836 ms
- Habit form, keyboard again: longest stall 434 ms
- Routine player (first): longest stall 495 ms
- Routine player (again): longest stall 146 ms
- Routine player: Day details: longest stall 652 ms
- All Habits: longest stall 284 ms
- Habit page: longest stall 607 ms
- Day sheet (first): longest stall 417 ms
- Day sheet (again): longest stall 273 ms
- All logs: longest stall 116 ms
- Day sheet (for a log): longest stall 196 ms
- Entry editor: longest stall 118 ms
- Edit log (keyboard): longest stall 864 ms
- Save entry: longest stall 186 ms
- All Habits: longest stall 339 ms
- Habit page: longest stall 405 ms
- Day sheet (first): longest stall 377 ms
- Day sheet (again): longest stall 204 ms
- Log sheet: longest stall 1027 ms
- Log keyboard dismissal: longest stall 136 ms
- All logs: longest stall 161 ms
- Day sheet (for a log): longest stall 275 ms
- Entry editor: longest stall 185 ms
- Edit log (keyboard): longest stall 303 ms
- Save entry: longest stall 120 ms
- All Habits: longest stall 235 ms
- Habit page (Water): longest stall 434 ms
- Day sheet (Water): longest stall 440 ms
- Add screen (Water): longest stall 774 ms
- All Habits: longest stall 176 ms
- Habit page (Read): longest stall 178 ms
- Day sheet (Read): longest stall 224 ms
- Add screen (Read): longest stall 209 ms
- All Habits: longest stall 271 ms
- Habit page (Call family): longest stall 190 ms
- Day sheet (Call family): longest stall 159 ms
- Add screen (Call family): longest stall 188 ms
- All Habits: longest stall 232 ms
- Habit page (Meds): longest stall 208 ms
- Day sheet (Meds): longest stall 485 ms
- Add screen (Meds): longest stall 242 ms
- All Habits: longest stall 173 ms
- Habit page (Skincare): longest stall 156 ms
- Day sheet (Skincare): longest stall 227 ms
- Add screen (Skincare): longest stall 241 ms
- All Habits: longest stall 205 ms
- Habit page (Smoking): longest stall 210 ms
- Day sheet (Smoking): longest stall 281 ms
- Add screen (Smoking): longest stall 181 ms
- All Habits: longest stall 232 ms
- Habit page: longest stall 404 ms
- Day sheet: longest stall 346 ms
- Add note: longest stall 534 ms
- Note view: longest stall 137 ms
- Edit note (keyboard): longest stall 154 ms
- Typing control: longest stall 848 ms
- Widgets guide (first): longest stall 345 ms
- Widgets guide (again): longest stall 159 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's week | 17 | 82 ms | 55.7 ms |
| scroll-today | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| scroll-today | Reminders: plan every alert | 1 | 0 ms | 0.4 ms |
| scroll-today | Count: Today's list drawn | 6 | 0 ms | 0.1 ms |
| scroll-today | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's week | 19 | 100 ms | 57.7 ms |
| tap-today | Widgets: the snapshot | 3 | 7 ms | 2.8 ms |
| tap-today | Reminders: plan every alert | 59 | 4 ms | 0.2 ms |
| tap-today | Change: Siri's habit names | 58 | 3 ms | 0.2 ms |
| tap-today | Count: Today's list drawn | 92 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 625 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 15 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's week | 17 | 79 ms | 57.3 ms |
| groups | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| groups | Count: Today's list drawn | 54 | 0 ms | 0.0 ms |
| groups | Count: a Today row drawn | 600 | 0 ms | 0.0 ms |
| arrange | Widgets: one habit's week | 34 | 150 ms | 59.2 ms |
| arrange | Widgets: the snapshot | 2 | 5 ms | 2.9 ms |
| arrange | Reminders: plan every alert | 27 | 2 ms | 0.2 ms |
| arrange | Change: Siri's habit names | 27 | 2 ms | 0.2 ms |
| arrange | Arrange: each card's habits | 29 | 2 ms | 0.2 ms |
| arrange | Count: Today's list drawn | 41 | 0 ms | 0.1 ms |
| arrange | Count: a Today row drawn | 366 | 0 ms | 0.0 ms |
| arrange | Count: Arrange Your Day drawn | 29 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's week | 17 | 70 ms | 48.6 ms |
| menu | Widgets: the snapshot | 1 | 1 ms | 1.3 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.3 ms |
| menu | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| menu-pages | Widgets: one habit's week | 17 | 65 ms | 36.6 ms |
| menu-pages | Widgets: the snapshot | 1 | 1 ms | 1.3 ms |
| menu-pages | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| menu-pages | Count: Today's list drawn | 75 | 0 ms | 0.0 ms |
| menu-pages | Count: a Today row drawn | 566 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's week | 17 | 56 ms | 38.1 ms |
| all-habits | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| all-habits | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| all-habits | Count: a Today row drawn | 54 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's week | 17 | 70 ms | 44.5 ms |
| habit-page | Habit page: history | 1 | 7 ms | 7.0 ms |
| habit-page | Habit page: overall record | 1 | 3 ms | 2.7 ms |
| habit-page | Habit page: milestones | 1 | 1 ms | 1.2 ms |
| habit-page | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| habit-page | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 42 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's week | 17 | 70 ms | 45.3 ms |
| habit-page-total | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-total | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| habit-page-total | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's week | 17 | 87 ms | 58.2 ms |
| habit-page-quit | Habit page: history | 1 | 1 ms | 1.0 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| habit-page-quit | Habit page: overall record | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-quit | Habit page: milestones | 1 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |
| habit-edit | Widgets: one habit's week | 17 | 118 ms | 97.2 ms |
| habit-edit | Habit page: history | 1 | 18 ms | 18.2 ms |
| habit-edit | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| habit-edit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-edit | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| habit-edit | Count: a Today row drawn | 76 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's week | 17 | 100 ms | 78.6 ms |
| progress | Progress year: whole snapshot | 2 | 52 ms | 29.8 ms |
| progress | Progress year: cards | 2 | 52 ms | 29.6 ms |
| progress | Progress year: one card | 30 | 48 ms | 3.5 ms |
| progress | Progress month: whole snapshot | 2 | 16 ms | 10.1 ms |
| progress | Progress month: cards | 2 | 16 ms | 10.0 ms |
| progress | Progress month: one card | 30 | 13 ms | 5.6 ms |
| progress | Progress week: whole snapshot | 2 | 13 ms | 9.4 ms |
| progress | Progress week: cards | 2 | 12 ms | 8.8 ms |
| progress | Progress week: one card | 30 | 9 ms | 6.4 ms |
| progress | Progress week: one quit card | 4 | 1 ms | 0.8 ms |
| progress | Widgets: the snapshot | 1 | 1 ms | 1.4 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.3 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| progress | Count: Today's list drawn | 25 | 0 ms | 0.0 ms |
| progress | Count: a Today row drawn | 238 | 0 ms | 0.0 ms |
| progress-year | Widgets: one habit's week | 17 | 62 ms | 41.6 ms |
| progress-year | Progress year: whole snapshot | 1 | 26 ms | 26.4 ms |
| progress-year | Progress year: cards | 1 | 26 ms | 26.2 ms |
| progress-year | Progress year: one card | 15 | 25 ms | 6.4 ms |
| progress-year | Progress week: whole snapshot | 1 | 4 ms | 3.9 ms |
| progress-year | Progress week: cards | 1 | 4 ms | 3.6 ms |
| progress-year | Progress week: one card | 15 | 2 ms | 0.3 ms |
| progress-year | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| progress-year | Progress week: one quit card | 2 | 1 ms | 0.7 ms |
| progress-year | Progress year: one quit card | 2 | 0 ms | 0.3 ms |
| progress-year | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress-year | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| progress-year | Count: a Today row drawn | 88 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's week | 17 | 87 ms | 54.0 ms |
| calendar | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| calendar | Count: a Today row drawn | 72 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's week | 17 | 56 ms | 38.1 ms |
| new-habit | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| new-habit | Count: Today's list drawn | 14 | 0 ms | 0.0 ms |
| new-habit | Count: a Today row drawn | 134 | 0 ms | 0.0 ms |
| form-parts | Widgets: one habit's week | 17 | 59 ms | 38.9 ms |
| form-parts | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| form-parts | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| form-parts | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| form-parts | Count: a Today row drawn | 117 | 0 ms | 0.0 ms |
| player | Widgets: one habit's week | 19 | 83 ms | 52.7 ms |
| player | Widgets: the snapshot | 3 | 7 ms | 3.3 ms |
| player | Reminders: plan every alert | 50 | 3 ms | 0.1 ms |
| player | Change: Siri's habit names | 49 | 2 ms | 0.1 ms |
| player | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| player | Count: a Today row drawn | 72 | 0 ms | 0.0 ms |
| player | Count: the Day sheet drawn | 9 | 0 ms | 0.0 ms |
| player | Count: the Day sheet's activity drawn | 9 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 145 | 717 ms | 10.0 ms |
| day-sheet | Widgets: one habit's week | 17 | 61 ms | 38.1 ms |
| day-sheet | Change: Siri's habit names | 144 | 6 ms | 0.1 ms |
| day-sheet | Widgets: the snapshot | 1 | 2 ms | 1.7 ms |
| day-sheet | Reminders: plan every alert | 2 | 0 ms | 0.1 ms |
| day-sheet | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 216 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 154 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's activity drawn | 202 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 188 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 145 | 654 ms | 9.1 ms |
| log-sheet | Widgets: one habit's week | 17 | 62 ms | 41.4 ms |
| log-sheet | Change: Siri's habit names | 144 | 6 ms | 0.1 ms |
| log-sheet | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| log-sheet | Reminders: plan every alert | 2 | 0 ms | 0.1 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 188 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 159 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 204 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's activity drawn | 207 | 0 ms | 0.0 ms |
| add-screens | Widgets: one habit's week | 17 | 70 ms | 43.8 ms |
| add-screens | Habit page: history | 6 | 31 ms | 8.9 ms |
| add-screens | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| add-screens | Count: Today's list drawn | 27 | 0 ms | 0.1 ms |
| add-screens | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| add-screens | Count: a Today row drawn | 192 | 0 ms | 0.0 ms |
| add-screens | Count: the Day sheet drawn | 73 | 0 ms | 0.0 ms |
| add-screens | Count: the Day sheet's activity drawn | 73 | 0 ms | 0.0 ms |
| notes | Widgets: one habit's week | 17 | 66 ms | 42.9 ms |
| notes | Habit page: history | 3 | 17 ms | 6.6 ms |
| notes | Widgets: the snapshot | 3 | 4 ms | 1.9 ms |
| notes | Reminders: plan every alert | 4 | 0 ms | 0.2 ms |
| notes | Change: Siri's habit names | 3 | 0 ms | 0.1 ms |
| notes | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| notes | Count: a Today row drawn | 81 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet drawn | 14 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's week | 17 | 113 ms | 73.5 ms |
| typing-control | Widgets: the snapshot | 1 | 2 ms | 2.0 ms |
| typing-control | Count: Today's list drawn | 10 | 0 ms | 0.1 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| typing-control | Count: a Today row drawn | 66 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's week | 17 | 70 ms | 49.0 ms |
| widget-guide | Widgets: the snapshot | 1 | 1 ms | 1.0 ms |
| widget-guide | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-guide | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| widget-guide | Count: a Today row drawn | 76 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's week | 40 | 81 ms | 36.5 ms |
| widget-log | Widgets: the snapshot | 24 | 24 ms | 3.0 ms |
| widget-log | Reminders: plan every alert | 48 | 3 ms | 0.1 ms |
| widget-log | Change: Siri's habit names | 54 | 2 ms | 0.2 ms |
| widget-log | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| widget-log | Count: a Today row drawn | 165 | 0 ms | 0.0 ms |
| widget-publish | Widgets: one habit's week | 408 | 548 ms | 49.2 ms |
| widget-publish | Widgets: the snapshot | 24 | 21 ms | 2.1 ms |
| widget-publish | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-publish | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| widget-publish | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

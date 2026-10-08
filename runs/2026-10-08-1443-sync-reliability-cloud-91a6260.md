# sync-reliability-cloud @ 91a6260

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37788586127 · 2026-10-08 14:43 UTC
Commit: Current Work 67: speed run after the HabitStore changes (seedDemo, reloadAfterSync) [ios-perf]

- Core storage and migrations: success
- Build: success
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (none): skipped
- Speed tests: success
- Speed tests through XCTest: skipped

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 28.1 | 258 ms | 2 | 7.9 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.7%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 71.9 | 83 ms | 0 |  | (none above noise) |
| Today: +1 alone | 18.1 | 114 ms | 1 |  | (none above noise) |
| Today: day ‹ › alone | 128.3 | 135 ms | 3 |  | (none above noise) |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Timer screen: a running clock | 31.4 | 126 ms | 1 |  | (none above noise) |
| Today: group filter | 31.5 | 62 ms | 0 |  | (none above noise) |
| Arrange Your Day: scrolling | 3.3 | 30 ms | 0 |  | (none above noise) |
| Arrange Your Day: move Anytime and sort | 21.4 | 52 ms | 0 |  | (none above noise) |
| Today: hide completed on and off | 80.2 | 126 ms | 2 |  | (none above noise) |
| Menu: open and close | 81.8 | 258 ms | 4 |  | (none above noise) |
| All Habits: scrolling | 1.3 | 23 ms | 0 |  | (none above noise) |
| Habit page: History scrolling | 1.4 | 38 ms | 0 |  | (none above noise) |
| Habit page: Progress scrolling | 13.9 | 128 ms | 1 |  | (none above noise) |
| Habit page: switching tabs | 54.6 | 95 ms | 0 |  | (none above noise) |
| Habit page (weekly total): History scrolling | 7.2 | 54 ms | 0 |  | (none above noise) |
| Habit page (weekly total): Progress scrolling | 6.9 | 52 ms | 0 |  | (none above noise) |
| Habit page (quit): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): Progress scrolling | 2.4 | 48 ms | 0 |  | (none above noise) |
| Progress: scrolling | 9.7 | 42 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 119.8 | 140 ms | 6 |  | (none above noise) |
| Progress: key fold and open | 1.0 | 32 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress Year: scrolling | 25.7 | 70 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 23.9 | 157 ms | 1 |  | (none above noise) |
| Habit form: typing | 25.6 | 79 ms | 0 | 14.9 % (separate profile) | 2.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 53.7 | 81 ms | 0 |  | (none above noise) |
| Routine player: fast ‹ › | 22.0 | 57 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 13.4 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 13.4 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:) |
| Entry editor: typing | 0.3 | 21 ms | 0 | 13.4 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:) |
| Day sheet: add, edit and exact undo | 150.5 | 84 ms | 0 | 13.4 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:) |
| Log sheet: typing | 0.4 | 19 ms | 0 | 9.2 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 9.2 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 0.3 | 19 ms | 0 | 9.2 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 73.7 | 74 ms | 0 | 9.2 % (separate profile) | 0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Add screen (Water): typing | 0.5 | 22 ms | 0 |  | (none above noise) |
| Add screen (Read): typing | 10.8 | 38 ms | 0 |  | (none above noise) |
| Add note: typing | 2.9 | 52 ms | 0 | 12.4 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Edit note: typing | 3.5 | 61 ms | 0 | 12.4 % (separate profile) | 2.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 0.5 | 19 ms | 0 |  | (none above noise) |
| Widget: full publication, every habit's week | 0.0 | 0 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 1078 ms
- Today: a row's Day sheet (again): longest stall 522 ms
- Today: the note sheet: longest stall 4016 ms
- Today: the timer screen: longest stall 0 ms
- Arrange Your Day (first): longest stall 548 ms
- Arrange Your Day (again): longest stall 82 ms
- Blank page (control, first): longest stall 334 ms
- Tasks (first): longest stall 314 ms
- Tasks (again): longest stall 130 ms
- Times of Day (first): longest stall 341 ms
- Times of Day (again): longest stall 134 ms
- Day and Week (first): longest stall 478 ms
- Day and Week (again): longest stall 148 ms
- Reminders (first): longest stall 424 ms
- Reminders (again): longest stall 305 ms
- Appearance (first): longest stall 227 ms
- Appearance (again): longest stall 344 ms
- Backup & Export (first): longest stall 287 ms
- Backup & Export (again): longest stall 192 ms
- Privacy (first): longest stall 144 ms
- Privacy (again): longest stall 200 ms
- Plus (first): longest stall 158 ms
- Plus (again): longest stall 162 ms
- Help & Feedback (first): longest stall 700 ms
- Help & Feedback (again): longest stall 225 ms
- About (first): longest stall 328 ms
- About (again): longest stall 324 ms
- Blank page (control, again): longest stall 190 ms
- All Habits (first): longest stall 550 ms
- All Habits (again): longest stall 172 ms
- All Habits: longest stall 661 ms
- Habit page: longest stall 1198 ms
- Habit page: Notes: longest stall 111 ms
- Habit page: Progress: longest stall 214 ms
- All Habits: longest stall 601 ms
- Habit page (weekly total): longest stall 0 ms
- Habit page (weekly total): Progress: longest stall 0 ms
- All Habits: longest stall 228 ms
- Habit page (quit): longest stall 398 ms
- Habit page (quit): Progress: longest stall 181 ms
- All Habits: longest stall 527 ms
- Habit page: longest stall 527 ms
- Edit habit (first): longest stall 681 ms
- Edit habit (again): longest stall 450 ms
- Progress (first): longest stall 1330 ms
- Progress (again): longest stall 242 ms
- Progress Year (first): longest stall 684 ms
- Progress Year (again): longest stall 177 ms
- Calendar (first): longest stall 371 ms
- Calendar (again): longest stall 278 ms
- New Habit (first): longest stall 493 ms
- New Habit (again): longest stall 197 ms
- Habit form (first): longest stall 912 ms
- Habit form (again): longest stall 452 ms
- Habit form, no keyboard (first): longest stall 715 ms
- Habit form, no keyboard (again): longest stall 452 ms
- Habit form, the launch's first keyboard: longest stall 691 ms
- Habit form, keyboard again: longest stall 364 ms
- Routine player (first): longest stall 654 ms
- Routine player (again): longest stall 159 ms
- Routine player: Day details: longest stall 835 ms
- All Habits: longest stall 461 ms
- Habit page: longest stall 424 ms
- Day sheet (first): longest stall 339 ms
- Day sheet (again): longest stall 338 ms
- All logs: longest stall 118 ms
- Day sheet (for a log): longest stall 218 ms
- Entry editor: longest stall 150 ms
- Edit log (keyboard): longest stall 1146 ms
- Save entry: longest stall 230 ms
- All Habits: longest stall 304 ms
- Habit page: longest stall 326 ms
- Day sheet (first): longest stall 306 ms
- Day sheet (again): longest stall 322 ms
- Log sheet: longest stall 798 ms
- Log keyboard dismissal: longest stall 275 ms
- All logs: longest stall 205 ms
- Day sheet (for a log): longest stall 199 ms
- Entry editor: longest stall 119 ms
- Edit log (keyboard): longest stall 190 ms
- Save entry: longest stall 58 ms
- All Habits: longest stall 338 ms
- Habit page (Water): longest stall 313 ms
- Day sheet (Water): longest stall 280 ms
- Add screen (Water): longest stall 660 ms
- All Habits: longest stall 240 ms
- Habit page (Read): longest stall 176 ms
- Day sheet (Read): longest stall 172 ms
- Add screen (Read): longest stall 256 ms
- All Habits: longest stall 185 ms
- Habit page (Call family): longest stall 160 ms
- Day sheet (Call family): longest stall 204 ms
- Add screen (Call family): longest stall 208 ms
- All Habits: longest stall 238 ms
- Habit page (Meds): longest stall 195 ms
- Day sheet (Meds): longest stall 333 ms
- Add screen (Meds): longest stall 355 ms
- All Habits: longest stall 162 ms
- Habit page (Skincare): longest stall 177 ms
- Day sheet (Skincare): longest stall 278 ms
- Add screen (Skincare): longest stall 279 ms
- All Habits: longest stall 167 ms
- Habit page (Smoking): longest stall 101 ms
- Day sheet (Smoking): longest stall 182 ms
- Add screen (Smoking): longest stall 161 ms
- All Habits: longest stall 458 ms
- Habit page: longest stall 392 ms
- Day sheet: longest stall 369 ms
- Add note: longest stall 620 ms
- Note view: longest stall 144 ms
- Edit note (keyboard): longest stall 121 ms
- Typing control: longest stall 663 ms
- Widgets guide (first): longest stall 465 ms
- Widgets guide (again): longest stall 266 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's week | 17 | 160 ms | 71.5 ms |
| scroll-today | Reminders: plan every alert | 1 | 5 ms | 5.3 ms |
| scroll-today | Widgets: the snapshot | 1 | 3 ms | 2.7 ms |
| scroll-today | Count: Today's list drawn | 7 | 0 ms | 0.4 ms |
| scroll-today | Count: a Today row drawn | 12 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's week | 33 | 221 ms | 129.2 ms |
| tap-today | Widgets: the snapshot | 17 | 29 ms | 3.5 ms |
| tap-today | Reminders: plan every alert | 54 | 4 ms | 0.3 ms |
| tap-today | Change: Siri's habit names | 57 | 3 ms | 0.2 ms |
| tap-today | Count: Today's list drawn | 92 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 599 | 0 ms | 0.1 ms |
| tap-today | Count: the Day sheet drawn | 14 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 14 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's week | 17 | 161 ms | 112.2 ms |
| groups | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| groups | Count: Today's list drawn | 44 | 0 ms | 0.0 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| groups | Count: a Today row drawn | 450 | 0 ms | 0.1 ms |
| arrange | Widgets: one habit's week | 34 | 148 ms | 77.3 ms |
| arrange | Widgets: the snapshot | 13 | 23 ms | 3.0 ms |
| arrange | Reminders: plan every alert | 28 | 3 ms | 0.4 ms |
| arrange | Arrange: each card's habits | 29 | 2 ms | 0.2 ms |
| arrange | Change: Siri's habit names | 27 | 2 ms | 0.1 ms |
| arrange | Count: Today's list drawn | 43 | 0 ms | 0.0 ms |
| arrange | Count: a Today row drawn | 336 | 0 ms | 0.0 ms |
| arrange | Count: Arrange Your Day drawn | 29 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's week | 17 | 95 ms | 61.4 ms |
| menu | Widgets: the snapshot | 1 | 3 ms | 2.7 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| menu | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 6 | 0 ms | 0.0 ms |
| menu-pages | Widgets: one habit's week | 17 | 95 ms | 51.9 ms |
| menu-pages | Widgets: the snapshot | 1 | 1 ms | 1.0 ms |
| menu-pages | Reminders: plan every alert | 3 | 0 ms | 0.2 ms |
| menu-pages | Count: Today's list drawn | 75 | 0 ms | 0.1 ms |
| menu-pages | Count: a Today row drawn | 514 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's week | 17 | 138 ms | 89.0 ms |
| all-habits | Widgets: the snapshot | 1 | 2 ms | 2.1 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| all-habits | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| all-habits | Count: a Today row drawn | 34 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's week | 17 | 95 ms | 60.7 ms |
| habit-page | Habit page: history | 1 | 7 ms | 7.0 ms |
| habit-page | Habit page: overall record | 1 | 2 ms | 2.1 ms |
| habit-page | Habit page: milestones | 1 | 1 ms | 1.3 ms |
| habit-page | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's week | 17 | 127 ms | 71.0 ms |
| habit-page-total | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| habit-page-total | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-total | Count: a Today row drawn | 18 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's week | 17 | 94 ms | 48.6 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 2 ms | 2.2 ms |
| habit-page-quit | Habit page: history | 1 | 0 ms | 0.5 ms |
| habit-page-quit | Habit page: overall record | 1 | 0 ms | 0.3 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| habit-page-quit | Habit page: milestones | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Count: Today's list drawn | 9 | 0 ms | 0.1 ms |
| habit-page-quit | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| habit-edit | Widgets: one habit's week | 17 | 120 ms | 65.2 ms |
| habit-edit | Habit page: history | 1 | 12 ms | 11.8 ms |
| habit-edit | Widgets: the snapshot | 1 | 4 ms | 3.7 ms |
| habit-edit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-edit | Count: Today's list drawn | 16 | 0 ms | 0.0 ms |
| habit-edit | Count: a Today row drawn | 113 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's week | 17 | 67 ms | 36.8 ms |
| progress | Progress year: whole snapshot | 2 | 48 ms | 32.1 ms |
| progress | Progress year: cards | 2 | 48 ms | 32.0 ms |
| progress | Progress year: one card | 30 | 45 ms | 5.1 ms |
| progress | Progress week: whole snapshot | 2 | 12 ms | 9.7 ms |
| progress | Progress week: cards | 2 | 11 ms | 8.8 ms |
| progress | Progress week: one card | 30 | 10 ms | 7.3 ms |
| progress | Progress month: whole snapshot | 2 | 6 ms | 3.1 ms |
| progress | Progress month: cards | 2 | 6 ms | 3.0 ms |
| progress | Progress month: one card | 30 | 5 ms | 1.4 ms |
| progress | Widgets: the snapshot | 1 | 2 ms | 2.1 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.3 ms |
| progress | Progress week: one quit card | 4 | 0 ms | 0.2 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.3 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 25 | 0 ms | 0.1 ms |
| progress | Count: a Today row drawn | 214 | 0 ms | 0.0 ms |
| progress-year | Widgets: one habit's week | 17 | 92 ms | 51.9 ms |
| progress-year | Progress year: whole snapshot | 1 | 35 ms | 34.9 ms |
| progress-year | Progress year: cards | 1 | 35 ms | 34.6 ms |
| progress-year | Progress year: one card | 15 | 33 ms | 12.7 ms |
| progress-year | Progress week: whole snapshot | 1 | 5 ms | 5.1 ms |
| progress-year | Progress week: cards | 1 | 5 ms | 4.8 ms |
| progress-year | Progress week: one card | 15 | 3 ms | 0.8 ms |
| progress-year | Widgets: the snapshot | 1 | 2 ms | 1.7 ms |
| progress-year | Progress year: one quit card | 2 | 0 ms | 0.3 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.3 ms |
| progress-year | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| progress-year | Count: Today's list drawn | 13 | 0 ms | 0.1 ms |
| progress-year | Count: a Today row drawn | 66 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's week | 17 | 67 ms | 42.1 ms |
| calendar | Widgets: the snapshot | 1 | 2 ms | 2.1 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| calendar | Count: a Today row drawn | 36 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's week | 17 | 111 ms | 71.8 ms |
| new-habit | Widgets: the snapshot | 1 | 2 ms | 2.1 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.4 ms |
| new-habit | Count: Today's list drawn | 16 | 0 ms | 0.1 ms |
| new-habit | Count: a Today row drawn | 110 | 0 ms | 0.0 ms |
| form-parts | Widgets: one habit's week | 17 | 90 ms | 51.1 ms |
| form-parts | Widgets: the snapshot | 1 | 3 ms | 3.2 ms |
| form-parts | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| form-parts | Count: Today's list drawn | 16 | 0 ms | 0.0 ms |
| form-parts | Count: a Today row drawn | 123 | 0 ms | 0.0 ms |
| player | Widgets: one habit's week | 31 | 163 ms | 99.9 ms |
| player | Widgets: the snapshot | 15 | 25 ms | 5.0 ms |
| player | Reminders: plan every alert | 50 | 4 ms | 0.5 ms |
| player | Change: Siri's habit names | 49 | 3 ms | 0.5 ms |
| player | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| player | Count: a Today row drawn | 36 | 0 ms | 0.0 ms |
| player | Count: the Day sheet drawn | 9 | 0 ms | 0.0 ms |
| player | Count: the Day sheet's activity drawn | 9 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 148 | 712 ms | 11.5 ms |
| day-sheet | Widgets: one habit's week | 18 | 89 ms | 37.4 ms |
| day-sheet | Change: Siri's habit names | 147 | 8 ms | 1.5 ms |
| day-sheet | Widgets: the snapshot | 2 | 5 ms | 3.1 ms |
| day-sheet | Reminders: plan every alert | 2 | 0 ms | 0.2 ms |
| day-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's activity drawn | 211 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 177 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 162 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 197 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 145 | 629 ms | 9.6 ms |
| log-sheet | Widgets: one habit's week | 18 | 106 ms | 36.5 ms |
| log-sheet | Change: Siri's habit names | 144 | 5 ms | 0.1 ms |
| log-sheet | Widgets: the snapshot | 2 | 4 ms | 2.3 ms |
| log-sheet | Reminders: plan every alert | 2 | 0 ms | 0.1 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 150 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 174 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's activity drawn | 198 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 179 | 0 ms | 0.0 ms |
| add-screens | Widgets: one habit's week | 17 | 93 ms | 43.5 ms |
| add-screens | Habit page: history | 6 | 36 ms | 12.7 ms |
| add-screens | Widgets: the snapshot | 1 | 1 ms | 1.4 ms |
| add-screens | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| add-screens | Count: Today's list drawn | 26 | 0 ms | 0.0 ms |
| add-screens | Count: the Day sheet drawn | 73 | 0 ms | 0.0 ms |
| add-screens | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| add-screens | Count: the Day sheet's activity drawn | 73 | 0 ms | 0.0 ms |
| notes | Widgets: one habit's week | 17 | 67 ms | 34.6 ms |
| notes | Habit page: history | 3 | 23 ms | 8.7 ms |
| notes | Widgets: the snapshot | 3 | 6 ms | 3.1 ms |
| notes | Reminders: plan every alert | 4 | 0 ms | 0.1 ms |
| notes | Change: Siri's habit names | 3 | 0 ms | 0.1 ms |
| notes | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet drawn | 14 | 0 ms | 0.0 ms |
| notes | Count: a Today row drawn | 39 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's week | 17 | 89 ms | 49.9 ms |
| typing-control | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| typing-control | Count: Today's list drawn | 11 | 0 ms | 0.1 ms |
| typing-control | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's week | 17 | 76 ms | 37.2 ms |
| widget-guide | Widgets: the snapshot | 1 | 3 ms | 3.0 ms |
| widget-guide | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-guide | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| widget-guide | Count: a Today row drawn | 40 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's week | 56 | 122 ms | 41.9 ms |
| widget-log | Widgets: the snapshot | 40 | 40 ms | 2.6 ms |
| widget-log | Reminders: plan every alert | 77 | 5 ms | 0.2 ms |
| widget-log | Change: Siri's habit names | 84 | 4 ms | 0.1 ms |
| widget-log | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| widget-log | Count: a Today row drawn | 249 | 0 ms | 0.0 ms |
| widget-publish | Widgets: one habit's week | 408 | 532 ms | 39.2 ms |
| widget-publish | Widgets: the snapshot | 24 | 24 ms | 2.0 ms |
| widget-publish | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| widget-publish | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| widget-publish | Count: a Today row drawn | 12 | 0 ms | 0.0 ms |

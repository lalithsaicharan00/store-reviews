# claude/exciting-mccarthy-g6vlu5-ci3 @ b841fd4

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37883786912 · 2026-10-09 05:39 UTC
Commit: Rulebook T10 and CLAUDE.md: never wait for another agent's runs; temporary branches of your own for parallel runs (the user, 9 Oct 2026)

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
| Today: scrolling | 0.0 | 0 ms | 0 | 0.8 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 18.7 | 55 ms | 0 |  | (none above noise) |
| Today: +1 alone | 0.4 | 23 ms | 0 |  | (none above noise) |
| Today: day ‹ › alone | 9.5 | 38 ms | 0 |  | (none above noise) |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Timer screen: a running clock | 0.0 | 0 ms | 0 |  | (none above noise) |
| Today: group filter | 10.2 | 38 ms | 0 |  | (none above noise) |
| Arrange Your Day: scrolling | 0.1 | 18 ms | 0 |  | (none above noise) |
| Arrange Your Day: move Anytime and sort | 1.8 | 32 ms | 0 |  | (none above noise) |
| Today: hide completed on and off | 8.7 | 65 ms | 0 |  | (none above noise) |
| Menu: open and close | 36.9 | 161 ms | 1 |  | (none above noise) |
| All Habits: scrolling | 2.4 | 24 ms | 0 |  | (none above noise) |
| Habit page: History scrolling | 2.3 | 45 ms | 0 |  | (none above noise) |
| Habit page: Progress scrolling | 39.5 | 300 ms | 3 |  | (none above noise) |
| Habit page: switching tabs | 8.3 | 50 ms | 0 |  | (none above noise) |
| Habit page (weekly total): History scrolling | 0.2 | 19 ms | 0 |  | (none above noise) |
| Habit page (weekly total): Progress scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): Progress scrolling | 0.3 | 21 ms | 0 |  | (none above noise) |
| Progress: scrolling | 1.7 | 30 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 82.6 | 98 ms | 0 |  | (none above noise) |
| Progress: key fold and open | 0.1 | 18 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress Year: scrolling | 4.8 | 37 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 2.2 | 37 ms | 0 |  | (none above noise) |
| Habit form: typing | 11.3 | 83 ms | 0 | 13.1 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.2%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 24.5 | 69 ms | 0 |  | (none above noise) |
| Routine player: fast ‹ › | 18.7 | 58 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 10.0 % (separate profile) | 1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:)<br>0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 10.0 % (separate profile) | 1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:)<br>0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Entry editor: typing | 0.2 | 20 ms | 0 | 10.0 % (separate profile) | 1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:)<br>0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Day sheet: add, edit and exact undo | 77.6 | 93 ms | 0 | 10.0 % (separate profile) | 1.0%  perfTimed<A>(_:_:)<br>1.0%  static MainThreadMeter.time<A>(_:_:)<br>0.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Log sheet: typing | 3.6 | 68 ms | 0 | 13.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 13.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 6.4 | 58 ms | 0 | 13.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 144.5 | 95 ms | 0 | 13.5 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Add screen (Water): typing | 3.7 | 74 ms | 0 |  | (none above noise) |
| Add screen (Read): typing | 10.5 | 33 ms | 0 |  | (none above noise) |
| Add note: typing | 2.7 | 50 ms | 0 | 13.9 % (separate profile) | 2.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>2.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Edit note: typing | 1.5 | 41 ms | 0 | 13.9 % (separate profile) | 2.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.3%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>2.3%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 0.2 | 20 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 5.1 | 64 ms | 0 |  | (none above noise) |
| Widget: full publication, every habit's week | 0.0 | 0 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 456 ms
- Today: a row's Day sheet (again): longest stall 155 ms
- Today: the note sheet: longest stall 647 ms
- Today: the timer screen: longest stall 884 ms
- Arrange Your Day (first): longest stall 121 ms
- Arrange Your Day (again): longest stall 111 ms
- Blank page (control, first): longest stall 112 ms
- Tasks (first): longest stall 238 ms
- Tasks (again): longest stall 158 ms
- Times of Day (first): longest stall 141 ms
- Times of Day (again): longest stall 173 ms
- Day and Week (first): longest stall 289 ms
- Day and Week (again): longest stall 163 ms
- Reminders (first): longest stall 219 ms
- Reminders (again): longest stall 117 ms
- Appearance (first): longest stall 251 ms
- Appearance (again): longest stall 220 ms
- Backup & Export (first): longest stall 165 ms
- Backup & Export (again): longest stall 247 ms
- Privacy (first): longest stall 241 ms
- Privacy (again): longest stall 223 ms
- Plus (first): longest stall 275 ms
- Plus (again): longest stall 187 ms
- Help & Feedback (first): longest stall 442 ms
- Help & Feedback (again): longest stall 173 ms
- About (first): longest stall 194 ms
- About (again): longest stall 174 ms
- Blank page (control, again): longest stall 129 ms
- All Habits (first): longest stall 262 ms
- All Habits (again): longest stall 234 ms
- All Habits: longest stall 381 ms
- Habit page: longest stall 1236 ms
- Habit page: Notes: longest stall 18 ms
- Habit page: Progress: longest stall 206 ms
- All Habits: longest stall 453 ms
- Habit page (weekly total): longest stall 0 ms
- Habit page (weekly total): Progress: longest stall 0 ms
- All Habits: longest stall 309 ms
- Habit page (quit): longest stall 328 ms
- Habit page (quit): Progress: longest stall 178 ms
- All Habits: longest stall 279 ms
- Habit page: longest stall 303 ms
- Edit habit (first): longest stall 568 ms
- Edit habit (again): longest stall 235 ms
- Progress (first): longest stall 484 ms
- Progress (again): longest stall 135 ms
- Progress Year (first): longest stall 352 ms
- Progress Year (again): longest stall 160 ms
- Calendar (first): longest stall 275 ms
- Calendar (again): longest stall 238 ms
- New Habit (first): longest stall 320 ms
- New Habit (again): longest stall 151 ms
- Habit form (first): longest stall 560 ms
- Habit form (again): longest stall 384 ms
- Habit form, no keyboard (first): longest stall 743 ms
- Habit form, no keyboard (again): longest stall 245 ms
- Habit form, the launch's first keyboard: longest stall 365 ms
- Habit form, keyboard again: longest stall 383 ms
- Routine player (first): longest stall 440 ms
- Routine player (again): longest stall 203 ms
- Routine player: Day details: longest stall 711 ms
- All Habits: longest stall 274 ms
- Habit page: longest stall 471 ms
- Day sheet (first): longest stall 281 ms
- Day sheet (again): longest stall 241 ms
- All logs: longest stall 101 ms
- Day sheet (for a log): longest stall 278 ms
- Entry editor: longest stall 125 ms
- Edit log (keyboard): longest stall 786 ms
- Save entry: longest stall 118 ms
- All Habits: longest stall 442 ms
- Habit page: longest stall 464 ms
- Day sheet (first): longest stall 332 ms
- Day sheet (again): longest stall 147 ms
- Log sheet: longest stall 485 ms
- Log keyboard dismissal: longest stall 257 ms
- All logs: longest stall 240 ms
- Day sheet (for a log): longest stall 340 ms
- Entry editor: longest stall 193 ms
- Edit log (keyboard): longest stall 514 ms
- Save entry: longest stall 151 ms
- All Habits: longest stall 391 ms
- Habit page (Water): longest stall 452 ms
- Day sheet (Water): longest stall 368 ms
- Add screen (Water): longest stall 608 ms
- All Habits: longest stall 285 ms
- Habit page (Read): longest stall 233 ms
- Day sheet (Read): longest stall 141 ms
- Add screen (Read): longest stall 203 ms
- All Habits: longest stall 213 ms
- Habit page (Call family): longest stall 232 ms
- Day sheet (Call family): longest stall 229 ms
- Add screen (Call family): longest stall 261 ms
- All Habits: longest stall 244 ms
- Habit page (Meds): longest stall 217 ms
- Day sheet (Meds): longest stall 484 ms
- Add screen (Meds): longest stall 349 ms
- All Habits: longest stall 196 ms
- Habit page (Skincare): longest stall 254 ms
- Day sheet (Skincare): longest stall 333 ms
- Add screen (Skincare): longest stall 298 ms
- All Habits: longest stall 222 ms
- Habit page (Smoking): longest stall 140 ms
- Day sheet (Smoking): longest stall 155 ms
- Add screen (Smoking): longest stall 170 ms
- All Habits: longest stall 310 ms
- Habit page: longest stall 303 ms
- Day sheet: longest stall 344 ms
- Add note: longest stall 596 ms
- Note view: longest stall 136 ms
- Edit note (keyboard): longest stall 101 ms
- Typing control: longest stall 745 ms
- Widgets guide (first): longest stall 427 ms
- Widgets guide (again): longest stall 197 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's week | 17 | 82 ms | 43.2 ms |
| scroll-today | Widgets: the snapshot | 1 | 4 ms | 3.7 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 0.5 ms |
| scroll-today | Count: Today's list drawn | 16 | 0 ms | 0.3 ms |
| scroll-today | Count: a Today row drawn | 6 | 0 ms | 0.0 ms |
| tap-today | Widgets: one habit's week | 33 | 123 ms | 35.4 ms |
| tap-today | Widgets: the snapshot | 17 | 16 ms | 2.6 ms |
| tap-today | Reminders: plan every alert | 58 | 3 ms | 0.1 ms |
| tap-today | Change: Siri's habit names | 58 | 2 ms | 0.1 ms |
| tap-today | Count: Today's list drawn | 92 | 0 ms | 0.0 ms |
| tap-today | Count: a Today row drawn | 396 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 15 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's week | 17 | 61 ms | 32.0 ms |
| groups | Widgets: the snapshot | 1 | 2 ms | 2.0 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| groups | Count: Today's list drawn | 45 | 0 ms | 0.0 ms |
| groups | Count: a Today row drawn | 234 | 0 ms | 0.0 ms |
| arrange | Widgets: one habit's week | 34 | 74 ms | 25.3 ms |
| arrange | Widgets: the snapshot | 12 | 9 ms | 1.1 ms |
| arrange | Reminders: plan every alert | 26 | 1 ms | 0.1 ms |
| arrange | Change: Siri's habit names | 25 | 1 ms | 0.1 ms |
| arrange | Arrange: each card's habits | 27 | 1 ms | 0.1 ms |
| arrange | Count: Today's list drawn | 41 | 0 ms | 0.0 ms |
| arrange | Count: a Today row drawn | 183 | 0 ms | 0.0 ms |
| arrange | Count: Arrange Your Day drawn | 27 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's week | 17 | 60 ms | 33.0 ms |
| menu | Widgets: the snapshot | 1 | 2 ms | 1.5 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| menu | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| menu-pages | Widgets: one habit's week | 17 | 66 ms | 30.7 ms |
| menu-pages | Widgets: the snapshot | 1 | 2 ms | 1.6 ms |
| menu-pages | Reminders: plan every alert | 3 | 0 ms | 0.1 ms |
| menu-pages | Count: Today's list drawn | 75 | 0 ms | 0.0 ms |
| menu-pages | Count: a Today row drawn | 279 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's week | 17 | 118 ms | 71.3 ms |
| all-habits | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| all-habits | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| all-habits | Count: a Today row drawn | 18 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's week | 17 | 59 ms | 35.6 ms |
| habit-page | Habit page: history | 1 | 7 ms | 6.6 ms |
| habit-page | Habit page: overall record | 1 | 4 ms | 4.0 ms |
| habit-page | Habit page: milestones | 1 | 2 ms | 2.1 ms |
| habit-page | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| habit-page | Count: Today's list drawn | 9 | 0 ms | 0.1 ms |
| habit-page | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's week | 17 | 82 ms | 36.7 ms |
| habit-page-total | Widgets: the snapshot | 1 | 4 ms | 3.7 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.4 ms |
| habit-page-total | Count: Today's list drawn | 8 | 0 ms | 0.1 ms |
| habit-page-total | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's week | 17 | 68 ms | 36.9 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| habit-page-quit | Habit page: history | 1 | 1 ms | 0.6 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| habit-page-quit | Habit page: overall record | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-quit | Habit page: milestones | 1 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| habit-edit | Widgets: one habit's week | 17 | 87 ms | 40.5 ms |
| habit-edit | Habit page: history | 1 | 12 ms | 11.7 ms |
| habit-edit | Widgets: the snapshot | 1 | 3 ms | 2.8 ms |
| habit-edit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-edit | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-edit | Count: a Today row drawn | 28 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's week | 17 | 81 ms | 42.0 ms |
| progress | Progress year: whole snapshot | 2 | 32 ms | 20.5 ms |
| progress | Progress year: cards | 2 | 32 ms | 20.4 ms |
| progress | Progress year: one card | 30 | 30 ms | 2.3 ms |
| progress | Progress week: whole snapshot | 2 | 10 ms | 8.1 ms |
| progress | Progress week: cards | 2 | 9 ms | 7.3 ms |
| progress | Progress week: one card | 30 | 8 ms | 6.2 ms |
| progress | Progress month: whole snapshot | 2 | 7 ms | 5.7 ms |
| progress | Progress month: cards | 2 | 7 ms | 5.5 ms |
| progress | Progress month: one card | 30 | 6 ms | 1.0 ms |
| progress | Widgets: the snapshot | 1 | 5 ms | 4.6 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.2 ms |
| progress | Progress week: one quit card | 4 | 0 ms | 0.2 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 26 | 0 ms | 0.0 ms |
| progress | Count: a Today row drawn | 111 | 0 ms | 0.0 ms |
| progress-year | Widgets: one habit's week | 17 | 71 ms | 47.3 ms |
| progress-year | Progress year: whole snapshot | 1 | 36 ms | 36.1 ms |
| progress-year | Progress year: cards | 1 | 36 ms | 35.9 ms |
| progress-year | Progress year: one card | 15 | 34 ms | 7.2 ms |
| progress-year | Progress week: whole snapshot | 1 | 1 ms | 1.4 ms |
| progress-year | Progress week: cards | 1 | 1 ms | 1.3 ms |
| progress-year | Progress week: one card | 15 | 1 ms | 0.1 ms |
| progress-year | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| progress-year | Progress year: one quit card | 2 | 0 ms | 0.3 ms |
| progress-year | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| progress-year | Progress week: one quit card | 2 | 0 ms | 0.1 ms |
| progress-year | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| progress-year | Count: a Today row drawn | 33 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's week | 17 | 67 ms | 38.4 ms |
| calendar | Widgets: the snapshot | 1 | 2 ms | 2.2 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| calendar | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's week | 17 | 60 ms | 35.1 ms |
| new-habit | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| new-habit | Count: Today's list drawn | 15 | 0 ms | 0.0 ms |
| new-habit | Count: a Today row drawn | 67 | 0 ms | 0.0 ms |
| form-parts | Widgets: one habit's week | 17 | 94 ms | 65.4 ms |
| form-parts | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| form-parts | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| form-parts | Count: Today's list drawn | 16 | 0 ms | 0.0 ms |
| form-parts | Count: a Today row drawn | 77 | 0 ms | 0.0 ms |
| player | Widgets: one habit's week | 31 | 88 ms | 39.2 ms |
| player | Widgets: the snapshot | 15 | 22 ms | 3.2 ms |
| player | Reminders: plan every alert | 50 | 3 ms | 0.1 ms |
| player | Change: Siri's habit names | 49 | 2 ms | 0.1 ms |
| player | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| player | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| player | Count: the Day sheet drawn | 9 | 0 ms | 0.0 ms |
| player | Count: the Day sheet's activity drawn | 9 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 145 | 605 ms | 12.4 ms |
| day-sheet | Widgets: one habit's week | 18 | 80 ms | 42.5 ms |
| day-sheet | Change: Siri's habit names | 144 | 5 ms | 0.2 ms |
| day-sheet | Widgets: the snapshot | 2 | 2 ms | 1.4 ms |
| day-sheet | Reminders: plan every alert | 2 | 0 ms | 0.1 ms |
| day-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 148 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's activity drawn | 196 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 182 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 145 | 718 ms | 12.1 ms |
| log-sheet | Widgets: one habit's week | 18 | 63 ms | 26.9 ms |
| log-sheet | Change: Siri's habit names | 144 | 6 ms | 0.1 ms |
| log-sheet | Widgets: the snapshot | 2 | 4 ms | 2.5 ms |
| log-sheet | Reminders: plan every alert | 2 | 0 ms | 0.1 ms |
| log-sheet | Entry editor: whole editor drawn | 190 | 0 ms | 0.0 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 161 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's activity drawn | 209 | 0 ms | 0.0 ms |
| add-screens | Widgets: one habit's week | 17 | 65 ms | 40.3 ms |
| add-screens | Habit page: history | 6 | 40 ms | 14.0 ms |
| add-screens | Widgets: the snapshot | 1 | 2 ms | 1.6 ms |
| add-screens | Count: Today's list drawn | 26 | 0 ms | 0.1 ms |
| add-screens | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| add-screens | Count: a Today row drawn | 75 | 0 ms | 0.0 ms |
| add-screens | Count: the Day sheet drawn | 73 | 0 ms | 0.0 ms |
| add-screens | Count: the Day sheet's activity drawn | 73 | 0 ms | 0.0 ms |
| notes | Widgets: one habit's week | 17 | 80 ms | 33.8 ms |
| notes | Habit page: history | 3 | 15 ms | 7.3 ms |
| notes | Widgets: the snapshot | 4 | 5 ms | 1.9 ms |
| notes | Reminders: plan every alert | 4 | 0 ms | 0.2 ms |
| notes | Change: Siri's habit names | 3 | 0 ms | 0.1 ms |
| notes | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| notes | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet drawn | 14 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's week | 17 | 87 ms | 38.1 ms |
| typing-control | Widgets: the snapshot | 1 | 5 ms | 4.6 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| typing-control | Count: Today's list drawn | 11 | 0 ms | 0.1 ms |
| typing-control | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's week | 17 | 135 ms | 80.4 ms |
| widget-guide | Widgets: the snapshot | 1 | 1 ms | 1.2 ms |
| widget-guide | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-guide | Count: Today's list drawn | 12 | 0 ms | 0.1 ms |
| widget-guide | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's week | 55 | 122 ms | 35.9 ms |
| widget-log | Widgets: the snapshot | 39 | 41 ms | 2.8 ms |
| widget-log | Reminders: plan every alert | 75 | 4 ms | 0.2 ms |
| widget-log | Change: Siri's habit names | 82 | 4 ms | 0.2 ms |
| widget-log | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| widget-log | Count: a Today row drawn | 234 | 0 ms | 0.0 ms |
| widget-publish | Widgets: one habit's week | 408 | 462 ms | 43.2 ms |
| widget-publish | Widgets: the snapshot | 24 | 25 ms | 2.6 ms |
| widget-publish | Reminders: plan every alert | 1 | 0 ms | 0.4 ms |
| widget-publish | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| widget-publish | Count: a Today row drawn | 6 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

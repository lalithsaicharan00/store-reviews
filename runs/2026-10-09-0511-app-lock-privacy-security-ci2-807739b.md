# app-lock-privacy-security-ci2 @ 807739b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37883016504 · 2026-10-09 05:11 UTC
Commit: Rulebook T1: watch each run with a background watcher; parallel batches on their own branches (the user, 9 Oct 2026)

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
| Today: scrolling | 0.0 | 0 ms | 0 | 3.7 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.8%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 128.9 | 143 ms | 2 |  | (none above noise) |
| Today: +1 alone | 6.3 | 31 ms | 0 |  | (none above noise) |
| Today: day ‹ › alone | 86.4 | 122 ms | 1 |  | (none above noise) |
| Today: Day sheet scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Timer screen: a running clock | 28.3 | 154 ms | 2 |  | (none above noise) |
| Today: group filter | 55.4 | 100 ms | 0 |  | (none above noise) |
| Arrange Your Day: scrolling | 24.7 | 50 ms | 0 |  | (none above noise) |
| Arrange Your Day: move Anytime and sort | 34.9 | 80 ms | 0 |  | (none above noise) |
| Today: hide completed on and off | 116.7 | 215 ms | 2 |  | (none above noise) |
| Menu: open and close | 100.8 | 184 ms | 9 |  | (none above noise) |
| All Habits: scrolling | 3.6 | 33 ms | 0 |  | (none above noise) |
| Habit page: History scrolling | 10.5 | 90 ms | 0 |  | (none above noise) |
| Habit page: Progress scrolling | 16.7 | 81 ms | 0 |  | (none above noise) |
| Habit page: switching tabs | 46.2 | 164 ms | 1 |  | (none above noise) |
| Habit page (weekly total): History scrolling | 1.9 | 32 ms | 0 |  | (none above noise) |
| Habit page (weekly total): Progress scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): History scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Habit page (quit): Progress scrolling | 5.4 | 63 ms | 0 |  | (none above noise) |
| Progress: scrolling | 2.2 | 48 ms | 0 |  | (none above noise) |
| Progress: period ‹ › and range | 126.1 | 141 ms | 5 |  | (none above noise) |
| Progress: key fold and open | 1.8 | 44 ms | 0 |  | (none above noise) |
| Progress Year: sideways | 0.0 | 0 ms | 0 |  | (none above noise) |
| Progress Year: scrolling | 12.4 | 55 ms | 0 |  | (none above noise) |
| Calendar: month ‹ › | 0.6 | 21 ms | 0 |  | (none above noise) |
| Habit form: typing | 42.9 | 453 ms | 2 | 12.0 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Routine player: ‹ › | 19.2 | 57 ms | 0 |  | (none above noise) |
| Routine player: fast ‹ › | 19.0 | 52 ms | 0 |  | (none above noise) |
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 10.0 % (separate profile) | 1.1%  perfTimed<A>(_:_:)<br>1.1%  static MainThreadMeter.time<A>(_:_:)<br>1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 10.0 % (separate profile) | 1.1%  perfTimed<A>(_:_:)<br>1.1%  static MainThreadMeter.time<A>(_:_:)<br>1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Entry editor: typing | 0.2 | 18 ms | 0 | 10.0 % (separate profile) | 1.1%  perfTimed<A>(_:_:)<br>1.1%  static MainThreadMeter.time<A>(_:_:)<br>1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Day sheet: add, edit and exact undo | 64.2 | 56 ms | 0 | 10.0 % (separate profile) | 1.1%  perfTimed<A>(_:_:)<br>1.1%  static MainThreadMeter.time<A>(_:_:)<br>1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A) |
| Log sheet: typing | 0.1 | 18 ms | 0 | 10.6 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 10.6 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 0.0 | 0 ms | 0 | 10.6 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 72.2 | 72 ms | 0 | 10.6 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Add screen (Water): typing | 0.1 | 19 ms | 0 |  | (none above noise) |
| Add screen (Read): typing | 5.8 | 32 ms | 0 |  | (none above noise) |
| Add note: typing | 3.2 | 68 ms | 0 | 10.0 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Edit note: typing | 3.9 | 49 ms | 0 | 10.0 % (separate profile) | 1.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.7%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Control: typing in a bare number field | 0.0 | 0 ms | 0 |  | (none above noise) |
| Widgets guide: scrolling | 6.5 | 35 ms | 0 |  | (none above noise) |
| Widget: durable amount log and publication | 0.6 | 23 ms | 0 |  | (none above noise) |
| Widget: full publication, every habit's week | 0.0 | 0 ms | 0 |  | (none above noise) |
| Privacy & Security: scrolling | 0.0 | 0 ms | 0 |  | (none above noise) |
| Hide names: widgets published and reminders re-planned | 4.5 | 37 ms | 0 |  | (none above noise) |
| Lock keypad: typing | 0.0 | 0 ms | 0 |  | (none above noise) |
| Lock: the right code opens | 18.1 | 42 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 969 ms
- Today: a row's Day sheet (again): longest stall 346 ms
- Today: the note sheet: longest stall 4627 ms
- Today: the timer screen: longest stall 0 ms
- Arrange Your Day (first): longest stall 534 ms
- Arrange Your Day (again): longest stall 229 ms
- Blank page (control, first): longest stall 175 ms
- Tasks (first): longest stall 417 ms
- Tasks (again): longest stall 319 ms
- Times of Day (first): longest stall 238 ms
- Times of Day (again): longest stall 166 ms
- Day and Week (first): longest stall 626 ms
- Day and Week (again): longest stall 341 ms
- Reminders (first): longest stall 331 ms
- Reminders (again): longest stall 241 ms
- Appearance (first): longest stall 446 ms
- Appearance (again): longest stall 337 ms
- Backup & Export (first): longest stall 353 ms
- Backup & Export (again): longest stall 336 ms
- Privacy & Security (first): longest stall 275 ms
- Privacy & Security (again): longest stall 210 ms
- Plus (first): longest stall 158 ms
- Plus (again): longest stall 99 ms
- Help & Feedback (first): longest stall 376 ms
- Help & Feedback (again): longest stall 217 ms
- About (first): longest stall 254 ms
- About (again): longest stall 225 ms
- Blank page (control, again): longest stall 167 ms
- All Habits (first): longest stall 488 ms
- All Habits (again): longest stall 310 ms
- All Habits: longest stall 386 ms
- Habit page: longest stall 1463 ms
- Habit page: Notes: longest stall 96 ms
- Habit page: Progress: longest stall 263 ms
- All Habits: longest stall 526 ms
- Habit page (weekly total): longest stall 0 ms
- Habit page (weekly total): Progress: longest stall 0 ms
- All Habits: longest stall 435 ms
- Habit page (quit): longest stall 414 ms
- Habit page (quit): Progress: longest stall 129 ms
- All Habits: longest stall 484 ms
- Habit page: longest stall 463 ms
- Edit habit (first): longest stall 803 ms
- Edit habit (again): longest stall 303 ms
- Progress (first): longest stall 514 ms
- Progress (again): longest stall 99 ms
- Progress Year (first): longest stall 552 ms
- Progress Year (again): longest stall 182 ms
- Calendar (first): longest stall 381 ms
- Calendar (again): longest stall 232 ms
- New Habit (first): longest stall 375 ms
- New Habit (again): longest stall 228 ms
- Habit form (first): longest stall 832 ms
- Habit form (again): longest stall 387 ms
- Habit form, no keyboard (first): longest stall 523 ms
- Habit form, no keyboard (again): longest stall 256 ms
- Habit form, the launch's first keyboard: longest stall 304 ms
- Habit form, keyboard again: longest stall 264 ms
- Routine player (first): longest stall 490 ms
- Routine player (again): longest stall 155 ms
- Routine player: Day details: longest stall 494 ms
- All Habits: longest stall 357 ms
- Habit page: longest stall 357 ms
- Day sheet (first): longest stall 304 ms
- Day sheet (again): longest stall 179 ms
- All logs: longest stall 97 ms
- Day sheet (for a log): longest stall 171 ms
- Entry editor: longest stall 115 ms
- Edit log (keyboard): longest stall 618 ms
- Save entry: longest stall 82 ms
- All Habits: longest stall 290 ms
- Habit page: longest stall 255 ms
- Day sheet (first): longest stall 268 ms
- Day sheet (again): longest stall 130 ms
- Log sheet: longest stall 402 ms
- Log keyboard dismissal: longest stall 42 ms
- All logs: longest stall 134 ms
- Day sheet (for a log): longest stall 147 ms
- Entry editor: longest stall 116 ms
- Edit log (keyboard): longest stall 163 ms
- Save entry: longest stall 59 ms
- All Habits: longest stall 276 ms
- Habit page (Water): longest stall 278 ms
- Day sheet (Water): longest stall 253 ms
- Add screen (Water): longest stall 408 ms
- All Habits: longest stall 175 ms
- Habit page (Read): longest stall 172 ms
- Day sheet (Read): longest stall 172 ms
- Add screen (Read): longest stall 169 ms
- All Habits: longest stall 176 ms
- Habit page (Call family): longest stall 166 ms
- Day sheet (Call family): longest stall 217 ms
- Add screen (Call family): longest stall 331 ms
- All Habits: longest stall 188 ms
- Habit page (Meds): longest stall 338 ms
- Day sheet (Meds): longest stall 269 ms
- Add screen (Meds): longest stall 252 ms
- All Habits: longest stall 266 ms
- Habit page (Skincare): longest stall 377 ms
- Day sheet (Skincare): longest stall 432 ms
- Add screen (Skincare): longest stall 461 ms
- All Habits: longest stall 286 ms
- Habit page (Smoking): longest stall 230 ms
- Day sheet (Smoking): longest stall 226 ms
- Add screen (Smoking): longest stall 224 ms
- All Habits: longest stall 506 ms
- Habit page: longest stall 390 ms
- Day sheet: longest stall 346 ms
- Add note: longest stall 523 ms
- Note view: longest stall 144 ms
- Edit note (keyboard): longest stall 228 ms
- Typing control: longest stall 677 ms
- Widgets guide (first): longest stall 364 ms
- Widgets guide (again): longest stall 411 ms
- Privacy & Security (first): longest stall 238 ms
- Privacy & Security (again): longest stall 136 ms
- Lock cover with keypad: longest stall 85 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| scroll-today | Widgets: one habit's week | 17 | 187 ms | 98.9 ms |
| scroll-today | Widgets: the snapshot | 1 | 4 ms | 4.2 ms |
| scroll-today | Reminders: plan every alert | 1 | 1 ms | 1.4 ms |
| scroll-today | Count: a Today row drawn | 6 | 0 ms | 0.5 ms |
| scroll-today | Count: Today's list drawn | 7 | 0 ms | 0.4 ms |
| tap-today | Widgets: one habit's week | 34 | 210 ms | 91.6 ms |
| tap-today | Widgets: the snapshot | 18 | 32 ms | 3.9 ms |
| tap-today | Change: Siri's habit names | 57 | 7 ms | 0.6 ms |
| tap-today | Reminders: plan every alert | 58 | 5 ms | 0.3 ms |
| tap-today | Count: a Today row drawn | 384 | 0 ms | 0.1 ms |
| tap-today | Count: Today's list drawn | 93 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 6 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's activity drawn | 6 | 0 ms | 0.0 ms |
| groups | Widgets: one habit's week | 17 | 156 ms | 99.2 ms |
| groups | Widgets: the snapshot | 1 | 2 ms | 1.6 ms |
| groups | Count: Today's list drawn | 46 | 0 ms | 0.1 ms |
| groups | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| groups | Count: a Today row drawn | 234 | 0 ms | 0.0 ms |
| arrange | Widgets: one habit's week | 34 | 177 ms | 83.1 ms |
| arrange | Widgets: the snapshot | 13 | 24 ms | 4.5 ms |
| arrange | Reminders: plan every alert | 27 | 4 ms | 0.9 ms |
| arrange | Change: Siri's habit names | 27 | 4 ms | 0.4 ms |
| arrange | Arrange: each card's habits | 29 | 2 ms | 0.1 ms |
| arrange | Count: Today's list drawn | 46 | 1 ms | 0.2 ms |
| arrange | Count: a Today row drawn | 202 | 1 ms | 0.4 ms |
| arrange | Count: Arrange Your Day drawn | 29 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's week | 17 | 156 ms | 103.4 ms |
| menu | Widgets: the snapshot | 1 | 6 ms | 6.0 ms |
| menu | Reminders: plan every alert | 1 | 2 ms | 1.6 ms |
| menu | Count: Today's list drawn | 6 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 3 | 0 ms | 0.1 ms |
| menu-pages | Widgets: one habit's week | 17 | 112 ms | 64.7 ms |
| menu-pages | Widgets: the snapshot | 1 | 2 ms | 1.7 ms |
| menu-pages | Reminders: plan every alert | 3 | 0 ms | 0.2 ms |
| menu-pages | Count: a Today row drawn | 330 | 0 ms | 0.0 ms |
| menu-pages | Count: Today's list drawn | 84 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's week | 17 | 84 ms | 50.5 ms |
| all-habits | Widgets: the snapshot | 1 | 6 ms | 5.6 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| all-habits | Count: a Today row drawn | 21 | 0 ms | 0.1 ms |
| all-habits | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's week | 17 | 92 ms | 52.5 ms |
| habit-page | Habit page: history | 1 | 7 ms | 6.6 ms |
| habit-page | Habit page: overall record | 1 | 2 ms | 2.1 ms |
| habit-page | Widgets: the snapshot | 1 | 1 ms | 1.2 ms |
| habit-page | Habit page: milestones | 1 | 1 ms | 1.0 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| habit-page-total | Widgets: one habit's week | 17 | 130 ms | 96.1 ms |
| habit-page-total | Widgets: the snapshot | 1 | 2 ms | 2.4 ms |
| habit-page-total | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| habit-page-total | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-total | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| habit-page-quit | Widgets: one habit's week | 17 | 83 ms | 47.3 ms |
| habit-page-quit | Widgets: the snapshot | 1 | 2 ms | 2.4 ms |
| habit-page-quit | Habit page: history | 1 | 1 ms | 0.6 ms |
| habit-page-quit | Habit page: overall record | 1 | 0 ms | 0.3 ms |
| habit-page-quit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Habit page: milestones | 1 | 0 ms | 0.1 ms |
| habit-page-quit | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| habit-page-quit | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| habit-edit | Widgets: one habit's week | 17 | 97 ms | 61.9 ms |
| habit-edit | Habit page: history | 1 | 13 ms | 12.6 ms |
| habit-edit | Widgets: the snapshot | 1 | 1 ms | 0.8 ms |
| habit-edit | Reminders: plan every alert | 1 | 1 ms | 0.7 ms |
| habit-edit | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| habit-edit | Count: a Today row drawn | 25 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's week | 17 | 71 ms | 37.6 ms |
| progress | Progress year: whole snapshot | 2 | 59 ms | 37.3 ms |
| progress | Progress year: cards | 2 | 59 ms | 37.2 ms |
| progress | Progress year: one card | 30 | 55 ms | 3.9 ms |
| progress | Progress week: whole snapshot | 2 | 11 ms | 9.0 ms |
| progress | Progress week: cards | 2 | 10 ms | 8.1 ms |
| progress | Progress week: one card | 30 | 9 ms | 6.5 ms |
| progress | Progress month: whole snapshot | 2 | 6 ms | 3.4 ms |
| progress | Progress month: cards | 2 | 6 ms | 3.3 ms |
| progress | Progress month: one card | 30 | 5 ms | 0.9 ms |
| progress | Widgets: the snapshot | 1 | 1 ms | 1.4 ms |
| progress | Count: Today's list drawn | 27 | 1 ms | 0.7 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.3 ms |
| progress | Progress week: one quit card | 4 | 0 ms | 0.2 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.1 ms |
| progress | Count: a Today row drawn | 114 | 0 ms | 0.1 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| progress-year | Widgets: one habit's week | 17 | 115 ms | 75.1 ms |
| progress-year | Progress year: whole snapshot | 1 | 28 ms | 27.8 ms |
| progress-year | Progress year: cards | 1 | 28 ms | 27.6 ms |
| progress-year | Progress year: one card | 15 | 26 ms | 6.1 ms |
| progress-year | Progress week: whole snapshot | 1 | 3 ms | 2.9 ms |
| progress-year | Progress week: cards | 1 | 2 ms | 2.2 ms |
| progress-year | Widgets: the snapshot | 1 | 1 ms | 1.1 ms |
| progress-year | Progress week: one card | 15 | 1 ms | 0.1 ms |
| progress-year | Progress week: one quit card | 2 | 1 ms | 0.6 ms |
| progress-year | Progress year: one quit card | 2 | 1 ms | 0.4 ms |
| progress-year | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress-year | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| progress-year | Count: a Today row drawn | 33 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's week | 17 | 84 ms | 53.8 ms |
| calendar | Widgets: the snapshot | 1 | 1 ms | 1.4 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| calendar | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's week | 17 | 101 ms | 57.9 ms |
| new-habit | Widgets: the snapshot | 1 | 3 ms | 3.0 ms |
| new-habit | Count: a Today row drawn | 67 | 0 ms | 0.1 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| new-habit | Count: Today's list drawn | 16 | 0 ms | 0.0 ms |
| form-parts | Widgets: one habit's week | 17 | 95 ms | 47.6 ms |
| form-parts | Widgets: the snapshot | 1 | 2 ms | 1.5 ms |
| form-parts | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| form-parts | Count: Today's list drawn | 16 | 0 ms | 0.1 ms |
| form-parts | Count: a Today row drawn | 79 | 0 ms | 0.0 ms |
| player | Widgets: one habit's week | 31 | 89 ms | 34.4 ms |
| player | Widgets: the snapshot | 15 | 20 ms | 2.9 ms |
| player | Change: Siri's habit names | 49 | 3 ms | 0.2 ms |
| player | Reminders: plan every alert | 50 | 3 ms | 0.2 ms |
| player | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| player | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| player | Count: the Day sheet's activity drawn | 9 | 0 ms | 0.0 ms |
| player | Count: the Day sheet drawn | 9 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 145 | 595 ms | 6.6 ms |
| day-sheet | Widgets: one habit's week | 18 | 69 ms | 36.2 ms |
| day-sheet | Change: Siri's habit names | 144 | 7 ms | 0.1 ms |
| day-sheet | Widgets: the snapshot | 2 | 2 ms | 0.9 ms |
| day-sheet | Reminders: plan every alert | 2 | 0 ms | 0.2 ms |
| day-sheet | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 162 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 150 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's activity drawn | 198 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 184 | 0 ms | 0.0 ms |
| log-sheet | Habit page: history | 145 | 608 ms | 7.8 ms |
| log-sheet | Widgets: one habit's week | 18 | 66 ms | 31.0 ms |
| log-sheet | Change: Siri's habit names | 144 | 7 ms | 0.1 ms |
| log-sheet | Widgets: the snapshot | 2 | 3 ms | 1.6 ms |
| log-sheet | Reminders: plan every alert | 2 | 0 ms | 0.1 ms |
| log-sheet | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |
| log-sheet | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 182 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 153 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's activity drawn | 201 | 0 ms | 0.0 ms |
| add-screens | Widgets: one habit's week | 17 | 65 ms | 32.3 ms |
| add-screens | Habit page: history | 6 | 43 ms | 14.0 ms |
| add-screens | Widgets: the snapshot | 1 | 3 ms | 2.8 ms |
| add-screens | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| add-screens | Count: Today's list drawn | 27 | 0 ms | 0.0 ms |
| add-screens | Count: a Today row drawn | 84 | 0 ms | 0.0 ms |
| add-screens | Count: the Day sheet drawn | 73 | 0 ms | 0.0 ms |
| add-screens | Count: the Day sheet's activity drawn | 73 | 0 ms | 0.0 ms |
| notes | Widgets: one habit's week | 17 | 76 ms | 38.7 ms |
| notes | Habit page: history | 3 | 20 ms | 8.9 ms |
| notes | Widgets: the snapshot | 3 | 4 ms | 1.7 ms |
| notes | Reminders: plan every alert | 4 | 0 ms | 0.1 ms |
| notes | Change: Siri's habit names | 3 | 0 ms | 0.1 ms |
| notes | Count: Today's list drawn | 9 | 0 ms | 0.0 ms |
| notes | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet's activity drawn | 15 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet drawn | 14 | 0 ms | 0.0 ms |
| typing-control | Widgets: one habit's week | 17 | 71 ms | 40.3 ms |
| typing-control | Widgets: the snapshot | 1 | 1 ms | 1.1 ms |
| typing-control | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| typing-control | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| typing-control | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| widget-guide | Widgets: one habit's week | 17 | 156 ms | 47.2 ms |
| widget-guide | Widgets: the snapshot | 1 | 14 ms | 13.9 ms |
| widget-guide | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| widget-guide | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| widget-guide | Count: a Today row drawn | 27 | 0 ms | 0.0 ms |
| widget-log | Widgets: one habit's week | 56 | 110 ms | 28.1 ms |
| widget-log | Widgets: the snapshot | 40 | 37 ms | 1.6 ms |
| widget-log | Change: Siri's habit names | 84 | 4 ms | 0.1 ms |
| widget-log | Reminders: plan every alert | 77 | 4 ms | 0.2 ms |
| widget-log | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| widget-log | Count: a Today row drawn | 240 | 0 ms | 0.0 ms |
| widget-publish | Widgets: one habit's week | 408 | 407 ms | 26.0 ms |
| widget-publish | Widgets: the snapshot | 24 | 20 ms | 1.4 ms |
| widget-publish | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| widget-publish | Count: Today's list drawn | 7 | 0 ms | 0.0 ms |
| widget-publish | Count: a Today row drawn | 6 | 0 ms | 0.0 ms |
| privacy | Widgets: one habit's week | 17 | 52 ms | 27.9 ms |
| privacy | Widgets: the snapshot | 30 | 36 ms | 2.2 ms |
| privacy | Reminders: plan every alert | 30 | 1 ms | 0.1 ms |
| privacy | Count: Today's list drawn | 43 | 0 ms | 0.0 ms |
| privacy | Count: a Today row drawn | 207 | 0 ms | 0.0 ms |
| lock-keypad | Widgets: one habit's week | 17 | 58 ms | 30.3 ms |
| lock-keypad | Widgets: the snapshot | 1 | 2 ms | 1.6 ms |
| lock-keypad | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| lock-keypad | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| lock-keypad | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

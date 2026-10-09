# claude/exciting-mccarthy-g6vlu5-ci3 @ 89807fb

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37892538257 · 2026-10-09 06:40 UTC
Commit: Notes: the keyboard is asked for until iOS shows it (focus off and on), not trusted to one request or the focus state

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
| Add note: typing | 0.0 | 0 ms | 0 | 10.8 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.7%  closure #1 in AppModel.ensureLoaded() |
| Edit note: typing | 0.7 | 28 ms | 0 | 10.8 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.7%  closure #1 in AppModel.ensureLoaded() |
| Day sheet: entry list scrolling | 0.0 | 0 ms | 0 | 2.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 2.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 0.5 | 23 ms | 0 | 2.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 145.5 | 77 ms | 0 | 2.5 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.6%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Add screen (Water): typing | 1.7 | 28 ms | 0 | 12.1 % (separate profile) | 2.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Add screen (Read): typing | 34.4 | 53 ms | 0 | 12.1 % (separate profile) | 2.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>2.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>1.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: History scrolling | 3.4 | 68 ms | 0 | 10.4 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  static PerfDriver.run(_:store:)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: Progress scrolling | 1.6 | 32 ms | 0 | 10.4 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  static PerfDriver.run(_:store:)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: switching tabs | 22.2 | 49 ms | 0 | 10.4 % (separate profile) | 1.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  static PerfDriver.run(_:store:)<br>1.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 330 ms
- Habit page: longest stall 667 ms
- Day sheet: longest stall 295 ms
- Add note: longest stall 1580 ms
- Note view: longest stall 97 ms
- Edit note (keyboard): longest stall 113 ms
- All Habits: longest stall 556 ms
- Habit page: longest stall 638 ms
- Day sheet (first): longest stall 450 ms
- Day sheet (again): longest stall 297 ms
- All logs: longest stall 145 ms
- Day sheet (for a log): longest stall 263 ms
- Entry editor: longest stall 151 ms
- Edit log (keyboard): longest stall 1179 ms
- Save entry: longest stall 163 ms
- All Habits: longest stall 472 ms
- Habit page (Water): longest stall 407 ms
- Day sheet (Water): longest stall 446 ms
- Add screen (Water): longest stall 913 ms
- All Habits: longest stall 211 ms
- Habit page (Read): longest stall 238 ms
- Day sheet (Read): longest stall 249 ms
- Add screen (Read): longest stall 356 ms
- All Habits: longest stall 318 ms
- Habit page (Call family): longest stall 201 ms
- Day sheet (Call family): longest stall 214 ms
- Add screen (Call family): longest stall 197 ms
- All Habits: longest stall 226 ms
- Habit page (Meds): longest stall 182 ms
- Day sheet (Meds): longest stall 245 ms
- Add screen (Meds): longest stall 208 ms
- All Habits: longest stall 192 ms
- Habit page (Skincare): longest stall 192 ms
- Day sheet (Skincare): longest stall 514 ms
- Add screen (Skincare): longest stall 390 ms
- All Habits: longest stall 157 ms
- Habit page (Smoking): longest stall 167 ms
- Day sheet (Smoking): longest stall 303 ms
- Add screen (Smoking): longest stall 247 ms
- All Habits: longest stall 392 ms
- Habit page: longest stall 395 ms
- Habit page: Notes: longest stall 31 ms
- Habit page: Progress: longest stall 822 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| notes | Widgets: one habit's week | 17 | 69 ms | 37.0 ms |
| notes | Habit page: history | 3 | 16 ms | 7.1 ms |
| notes | Widgets: the snapshot | 4 | 5 ms | 1.8 ms |
| notes | Reminders: plan every alert | 4 | 1 ms | 0.7 ms |
| notes | Change: Siri's habit names | 3 | 1 ms | 0.6 ms |
| notes | Count: Today's list drawn | 9 | 0 ms | 0.3 ms |
| notes | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet drawn | 8 | 0 ms | 0.0 ms |
| notes | Count: the Day sheet's activity drawn | 9 | 0 ms | 0.0 ms |
| day-sheet | Habit page: history | 145 | 776 ms | 13.8 ms |
| day-sheet | Widgets: one habit's week | 18 | 98 ms | 46.4 ms |
| day-sheet | Change: Siri's habit names | 144 | 7 ms | 0.4 ms |
| day-sheet | Widgets: the snapshot | 2 | 3 ms | 2.5 ms |
| day-sheet | Reminders: plan every alert | 2 | 0 ms | 0.2 ms |
| day-sheet | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet drawn | 159 | 0 ms | 0.0 ms |
| day-sheet | Entry editor: whole editor drawn | 193 | 0 ms | 0.0 ms |
| day-sheet | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |
| day-sheet | Count: the Day sheet's activity drawn | 207 | 0 ms | 0.0 ms |
| add-screens | Widgets: one habit's week | 17 | 102 ms | 66.4 ms |
| add-screens | Habit page: history | 6 | 33 ms | 8.7 ms |
| add-screens | Widgets: the snapshot | 1 | 3 ms | 3.0 ms |
| add-screens | Count: Today's list drawn | 27 | 0 ms | 0.1 ms |
| add-screens | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| add-screens | Count: a Today row drawn | 81 | 0 ms | 0.1 ms |
| add-screens | Count: the Day sheet drawn | 67 | 0 ms | 0.0 ms |
| add-screens | Count: the Day sheet's activity drawn | 67 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's week | 17 | 97 ms | 50.8 ms |
| habit-page | Habit page: history | 1 | 7 ms | 6.5 ms |
| habit-page | Widgets: the snapshot | 1 | 3 ms | 3.1 ms |
| habit-page | Habit page: overall record | 1 | 2 ms | 1.9 ms |
| habit-page | Habit page: milestones | 1 | 1 ms | 1.0 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| habit-page | Count: Today's list drawn | 8 | 0 ms | 0.1 ms |
| habit-page | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# claude/pensive-gates-3n4ie8-ci11 @ 7aca590

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38131559049 · 2026-10-11 11:35 UTC
Commit: Current Work 86: container ids keep their rows' own (T9), the sidebar command names itself, onboarding's column, iPad widget sizes in the render check, the iPad's Design Rules and README

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
| Log sheet: typing | 9.7 | 84 ms | 0 | 5.1 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| All logs: scrolling | 0.0 | 0 ms | 0 | 5.1 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Entry editor: typing | 1.4 | 32 ms | 0 | 5.1 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Day sheet: add, edit and exact undo | 71.5 | 56 ms | 0 | 5.1 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.5%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Menu: open and close | 0.3 | 22 ms | 0 | 5.8 % (separate profile) | 0.6%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Progress: scrolling | 58.6 | 105 ms | 1 | 10.9 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.5%  closure #1 in AppModel.ensureLoaded() |
| Progress: period ‹ › and range | 332.2 | 274 ms | 31 | 10.9 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.5%  closure #1 in AppModel.ensureLoaded() |
| Progress: key fold and open | 0.7 | 27 ms | 0 | 10.9 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.5%  closure #1 in AppModel.ensureLoaded() |
| All Habits: scrolling | 3.6 | 68 ms | 0 | 0.0 % (separate profile) | 0.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.0%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.0%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Habit page: History scrolling | 50.6 | 128 ms | 1 | 2.1 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.8%  closure #1 in AppModel.ensureLoaded() |
| Habit page: Progress scrolling | 39.9 | 116 ms | 1 | 2.1 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.8%  closure #1 in AppModel.ensureLoaded() |
| Habit page: switching tabs | 60.3 | 75 ms | 0 | 2.1 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.8%  closure #1 in AppModel.ensureLoaded() |
| Habit form: typing | 111.0 | 1413 ms | 3 | 12.6 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Calendar: month ‹ › | 202.0 | 171 ms | 15 | 8.5 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.5%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- All Habits: longest stall 769 ms
- Habit page: longest stall 5654 ms
- Day sheet (first): longest stall 104 ms
- Day sheet (again): longest stall 402 ms
- Log sheet: longest stall 2001 ms
- Log keyboard dismissal: longest stall 359 ms
- All logs: longest stall 1966 ms
- Day sheet (for a log): longest stall 272 ms
- Entry editor: longest stall 191 ms
- Edit log (keyboard): longest stall 508 ms
- Save entry: longest stall 384 ms
- Progress (first): longest stall 3437 ms
- Progress (again): longest stall 499 ms
- All Habits (first): longest stall 581 ms
- All Habits (again): longest stall 297 ms
- All Habits: longest stall 336 ms
- Habit page: longest stall 796 ms
- Habit page: Notes: longest stall 106 ms
- Habit page: Progress: longest stall 1198 ms
- New Habit (first): longest stall 664 ms
- New Habit (again): longest stall 296 ms
- Habit form (first): longest stall 4105 ms
- Habit form (again): longest stall 463 ms
- Calendar (first): longest stall 1383 ms
- Calendar (again): longest stall 652 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| log-sheet | Habit page: history | 145 | 585 ms | 16.5 ms |
| log-sheet | Widgets: one habit's week | 18 | 120 ms | 75.2 ms |
| log-sheet | Change: Siri's habit names | 144 | 8 ms | 0.3 ms |
| log-sheet | Widgets: the snapshot | 2 | 2 ms | 0.8 ms |
| log-sheet | Reminders: plan every alert | 2 | 1 ms | 0.8 ms |
| log-sheet | Count: Today's list drawn | 15 | 0 ms | 0.0 ms |
| log-sheet | Count: a Today row drawn | 180 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet drawn | 165 | 0 ms | 0.0 ms |
| log-sheet | Count: the Day sheet's activity drawn | 210 | 0 ms | 0.0 ms |
| log-sheet | Entry editor: whole editor drawn | 189 | 0 ms | 0.0 ms |
| menu | Widgets: one habit's week | 17 | 81 ms | 45.4 ms |
| menu | Widgets: the snapshot | 1 | 1 ms | 1.0 ms |
| menu | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| menu | Count: Today's list drawn | 8 | 0 ms | 0.0 ms |
| menu | Count: a Today row drawn | 6 | 0 ms | 0.0 ms |
| progress | Widgets: one habit's week | 17 | 122 ms | 67.2 ms |
| progress | Progress year: whole snapshot | 2 | 53 ms | 32.3 ms |
| progress | Progress year: cards | 2 | 53 ms | 32.2 ms |
| progress | Progress year: one card | 30 | 48 ms | 3.0 ms |
| progress | Progress week: whole snapshot | 2 | 15 ms | 9.0 ms |
| progress | Progress week: cards | 2 | 14 ms | 8.3 ms |
| progress | Progress week: one card | 30 | 11 ms | 7.1 ms |
| progress | Progress month: whole snapshot | 2 | 10 ms | 5.5 ms |
| progress | Progress month: cards | 2 | 10 ms | 5.3 ms |
| progress | Progress month: one card | 30 | 8 ms | 1.1 ms |
| progress | Widgets: the snapshot | 1 | 2 ms | 2.2 ms |
| progress | Progress week: one quit card | 4 | 1 ms | 1.2 ms |
| progress | Progress year: one quit card | 2 | 0 ms | 0.2 ms |
| progress | Progress month: one quit card | 4 | 0 ms | 0.2 ms |
| progress | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| progress | Count: Today's list drawn | 26 | 0 ms | 0.0 ms |
| progress | Count: a Today row drawn | 108 | 0 ms | 0.0 ms |
| all-habits | Widgets: one habit's week | 17 | 146 ms | 95.7 ms |
| all-habits | Widgets: the snapshot | 1 | 1 ms | 1.3 ms |
| all-habits | Count: Today's list drawn | 12 | 0 ms | 0.1 ms |
| all-habits | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| all-habits | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| habit-page | Widgets: one habit's week | 17 | 142 ms | 73.0 ms |
| habit-page | Habit page: overall record | 1 | 19 ms | 19.4 ms |
| habit-page | Habit page: history | 1 | 11 ms | 11.5 ms |
| habit-page | Habit page: milestones | 1 | 8 ms | 8.3 ms |
| habit-page | Widgets: the snapshot | 1 | 6 ms | 5.5 ms |
| habit-page | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| habit-page | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| habit-page | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's week | 17 | 146 ms | 115.3 ms |
| new-habit | Widgets: the snapshot | 1 | 1 ms | 0.9 ms |
| new-habit | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| new-habit | Count: Today's list drawn | 29 | 0 ms | 0.0 ms |
| new-habit | Count: a Today row drawn | 113 | 0 ms | 0.0 ms |
| calendar | Widgets: one habit's week | 17 | 94 ms | 54.6 ms |
| calendar | Widgets: the snapshot | 1 | 1 ms | 1.3 ms |
| calendar | Reminders: plan every alert | 1 | 0 ms | 0.1 ms |
| calendar | Count: Today's list drawn | 12 | 0 ms | 0.0 ms |
| calendar | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

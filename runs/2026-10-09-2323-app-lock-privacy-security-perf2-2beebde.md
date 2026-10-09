# app-lock-privacy-security-perf2 @ 2beebde

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38001150638 · 2026-10-09 23:23 UTC
Commit: Current Work 73.1 and 76: tests close the idea form with its own Cancel, read the one-second Setting things up page in one query, and open the menu only once Account has gone (run 37995167302)

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
| Privacy & Security: scrolling | 0.0 | 0 ms | 0 | 3.1 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| Hide names: widgets published and reminders re-planned | 27.1 | 60 ms | 0 | 3.1 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.4%  closure #1 in AppModel.ensureLoaded() |
| App Lock: setup sheet scrolling | 0.0 | 0 ms | 0 | 12.5 % (separate profile) | 0.1%  HabitRow.row(now:)<br>0.0%  View.onPerfCommand(_:)<br>0.0%  AppSwitchStyle.makeBody(configuration:)<br>0.0%  AppLock.isOn.getter |
| Lock keypad: typing | 3.8 | 62 ms | 0 | 7.6 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.5%  closure #1 in AppModel.ensureLoaded() |
| Lock: the right code opens | 29.0 | 85 ms | 0 | 7.6 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.5%  closure #1 in AppModel.ensureLoaded() |
| Account: scrolling | 0.0 | 0 ms | 0 | 10.5 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.5%  closure #1 in AppModel.ensureLoaded() |
| Backup & Export: scrolling | 0.0 | 0 ms | 0 | 8.1 % (separate profile) | 0.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Welcome: ideas scrolling | 0.0 | 0 ms | 0 | 7.9 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Welcome: Back and forward | 415.3 | 326 ms | 31 | 7.9 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |
| Transfer code: typing | 6.7 | 67 ms | 0 | 7.9 % (separate profile) | 0.3%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.3%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Blank page (control, first): longest stall 308 ms
- Tasks (first): longest stall 255 ms
- Tasks (again): longest stall 129 ms
- Times of Day (first): longest stall 334 ms
- Times of Day (again): longest stall 167 ms
- Day and Week (first): longest stall 314 ms
- Day and Week (again): longest stall 200 ms
- Reminders (first): longest stall 171 ms
- Reminders (again): longest stall 312 ms
- Appearance (first): longest stall 441 ms
- Appearance (again): longest stall 252 ms
- Account (first): longest stall 382 ms
- Account (again): longest stall 237 ms
- Backup & Export (first): longest stall 495 ms
- Backup & Export (again): longest stall 226 ms
- Privacy & Security (first): longest stall 337 ms
- Privacy & Security (again): longest stall 249 ms
- Plus (first): longest stall 180 ms
- Plus (again): longest stall 106 ms
- Help & Feedback (first): longest stall 490 ms
- Help & Feedback (again): longest stall 243 ms
- About (first): longest stall 285 ms
- About (again): longest stall 214 ms
- Blank page (control, again): longest stall 193 ms
- Privacy & Security (first): longest stall 543 ms
- Privacy & Security (again): longest stall 225 ms
- App Lock page (first): longest stall 1515 ms
- App Lock: setup sheet (first): longest stall 569 ms
- App Lock page (again): longest stall 94 ms
- App Lock: setup sheet (again): longest stall 146 ms
- Lock cover with keypad: longest stall 161 ms
- Account (first): longest stall 426 ms
- Account (again): longest stall 135 ms
- Backup & Export → Your Account: longest stall 184 ms
- Backup & Export (first): longest stall 512 ms
- Backup & Export (again): longest stall 271 ms
- Backup & Export → Restore From a Backup: longest stall 152 ms
- Welcome: longest stall 180 ms
- Welcome: included: longest stall 208 ms
- Welcome: build: longest stall 164 ms
- Welcome: quit: longest stall 116 ms
- Welcome: tasks: longest stall 149 ms
- Welcome: days: longest stall 218 ms
- Welcome: firstHabit: longest stall 218 ms
- Welcome: New (Create my own habit): longest stall 308 ms
- Welcome: welcomeBack: longest stall 103 ms
- Welcome: signIn: longest stall 105 ms
- Welcome: restore: longest stall 221 ms
- Welcome: transferCode: longest stall 1034 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| menu-pages | Widgets: one habit's week | 17 | 125 ms | 100.9 ms |
| menu-pages | Widgets: the snapshot | 1 | 2 ms | 2.2 ms |
| menu-pages | Reminders: plan every alert | 3 | 1 ms | 0.8 ms |
| menu-pages | Count: Today's list drawn | 82 | 1 ms | 0.5 ms |
| menu-pages | Count: a Today row drawn | 694 | 0 ms | 0.1 ms |
| privacy | Widgets: one habit's week | 17 | 96 ms | 44.8 ms |
| privacy | Widgets: the snapshot | 29 | 44 ms | 4.9 ms |
| privacy | Reminders: plan every alert | 29 | 2 ms | 0.3 ms |
| privacy | Count: Today's list drawn | 43 | 0 ms | 0.0 ms |
| privacy | Count: a Today row drawn | 471 | 0 ms | 0.0 ms |
| app-lock | Widgets: one habit's week | 17 | 95 ms | 50.6 ms |
| app-lock | Widgets: the snapshot | 1 | 4 ms | 3.5 ms |
| app-lock | Reminders: plan every alert | 1 | 1 ms | 0.8 ms |
| app-lock | Count: Today's list drawn | 13 | 0 ms | 0.1 ms |
| app-lock | Count: a Today row drawn | 78 | 0 ms | 0.0 ms |
| lock-keypad | Widgets: one habit's week | 17 | 118 ms | 84.4 ms |
| lock-keypad | Widgets: the snapshot | 1 | 2 ms | 2.0 ms |
| lock-keypad | Reminders: plan every alert | 1 | 0 ms | 0.3 ms |
| lock-keypad | Count: Today's list drawn | 11 | 0 ms | 0.0 ms |
| lock-keypad | Count: a Today row drawn | 62 | 0 ms | 0.0 ms |
| account | Widgets: one habit's week | 17 | 123 ms | 57.0 ms |
| account | Widgets: the snapshot | 1 | 2 ms | 2.2 ms |
| account | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| account | Count: Today's list drawn | 16 | 0 ms | 0.1 ms |
| account | Count: a Today row drawn | 105 | 0 ms | 0.0 ms |
| backup-page | Widgets: one habit's week | 17 | 114 ms | 60.0 ms |
| backup-page | Widgets: the snapshot | 1 | 3 ms | 3.1 ms |
| backup-page | Reminders: plan every alert | 1 | 3 ms | 2.9 ms |
| backup-page | Count: Today's list drawn | 13 | 0 ms | 0.0 ms |
| backup-page | Count: a Today row drawn | 78 | 0 ms | 0.0 ms |
| onboarding | Widgets: one habit's week | 17 | 102 ms | 48.9 ms |
| onboarding | Widgets: the snapshot | 1 | 3 ms | 3.5 ms |
| onboarding | Reminders: plan every alert | 1 | 0 ms | 0.2 ms |
| onboarding | Count: Today's list drawn | 10 | 0 ms | 0.0 ms |
| onboarding | Count: a Today row drawn | 54 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

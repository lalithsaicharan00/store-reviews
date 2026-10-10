# claude/awesome-newton-pmu4y7-ci3 @ 966b1a6

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38063956093 · 2026-10-10 15:59 UTC
Commit: Plus screens with StoreKit 2 (Current Work 80): the 6th-habit sheet, Make Room, the Plus page, Your Plus, the upgrade, Plus is yours, Plus has ended, the second-device sheet

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
| Plus page: choosing a plan | 0.0 | 0 ms | 0 | 1.7 % (separate profile) | 0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in ReminderScheduler.reconcile(_:now:)<br>0.1%  closure #1 in ReminderScheduler.reconcile(_:now:) |
| 6th-habit sheet: choosing a plan | 0.1 | 18 ms | 0 | 1.7 % (separate profile) | 0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in ReminderScheduler.reconcile(_:now:)<br>0.1%  closure #1 in ReminderScheduler.reconcile(_:now:) |
| Habit form: typing | 102.8 | 676 ms | 3 | 37.1 % (separate profile) | 5.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>5.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>3.9%  partial apply for closure #1 in AppModel.ensureLoaded()<br>3.9%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Plus page (first): longest stall 676 ms
- Plus page (again): longest stall 314 ms
- 6th-habit sheet (first): longest stall 255 ms
- Blank page (control, first): longest stall 220 ms
- Tasks (first): longest stall 316 ms
- Tasks (again): longest stall 346 ms
- Times of Day (first): longest stall 213 ms
- Times of Day (again): longest stall 246 ms
- Day and Week (first): longest stall 605 ms
- Day and Week (again): longest stall 261 ms
- Reminders (first): longest stall 314 ms
- Reminders (again): longest stall 356 ms
- Appearance (first): longest stall 480 ms
- Appearance (again): longest stall 323 ms
- Account (first): longest stall 230 ms
- Account (again): longest stall 165 ms
- Backup & Export (first): longest stall 425 ms
- Backup & Export (again): longest stall 290 ms
- Privacy & Security (first): longest stall 337 ms
- Privacy & Security (again): longest stall 318 ms
- Plus (first): longest stall 355 ms
- Plus (again): longest stall 278 ms
- Help & Feedback (first): longest stall 442 ms
- Help & Feedback (again): longest stall 308 ms
- About (first): longest stall 306 ms
- About (again): longest stall 255 ms
- Blank page (control, again): longest stall 167 ms
- New Habit (first): longest stall 655 ms
- New Habit (again): longest stall 247 ms
- Habit form (first): longest stall 2019 ms
- Habit form (again): longest stall 463 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| plus-page | Widgets: one habit's week | 17 | 129 ms | 70.3 ms |
| plus-page | Widgets: the snapshot | 2 | 8 ms | 4.8 ms |
| plus-page | Reminders: plan every alert | 2 | 1 ms | 0.9 ms |
| plus-page | Count: a Today row drawn | 70 | 1 ms | 0.5 ms |
| plus-page | Count: Today's list drawn | 15 | 0 ms | 0.2 ms |
| plus-page | Change: Siri's habit names | 1 | 0 ms | 0.3 ms |
| menu-pages | Widgets: one habit's week | 17 | 1253 ms | 1211.1 ms |
| menu-pages | Widgets: the snapshot | 1 | 2 ms | 1.9 ms |
| menu-pages | Reminders: plan every alert | 3 | 1 ms | 0.6 ms |
| menu-pages | Count: a Today row drawn | 560 | 0 ms | 0.1 ms |
| menu-pages | Count: Today's list drawn | 81 | 0 ms | 0.0 ms |
| new-habit | Widgets: one habit's week | 17 | 336 ms | 309.9 ms |
| new-habit | Widgets: the snapshot | 1 | 2 ms | 1.8 ms |
| new-habit | Reminders: plan every alert | 1 | 1 ms | 0.6 ms |
| new-habit | Count: a Today row drawn | 115 | 0 ms | 0.0 ms |
| new-habit | Count: Today's list drawn | 18 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# codex/iphone-widgets @ f85cd16

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36860774310 · 2026-10-01 12:44 UTC
Commit: Exercise installed widget next and previous page intents while app stays closed [ios-ci] [ios-widgets] [ios-widgets-validation] [ios-perf]

- Core storage and migrations: success
- Build: success
- UI tests (WidgetUITests/testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks,WidgetSystemUITests/testHomeScreenInstallTapAndColdPersistence,TimerUITests): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 70.522 (70.528) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 261.821 (261.832) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 261.821 (261.838) seconds
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (36.817 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (33.705 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (183.332 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (7.967 seconds).
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 24.8 | 257 ms | 1 | 1.9 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.5%  closure #1 in AppModel.ensureLoaded() |
| Today: +1 and day ‹ › | 106.3 | 109 ms | 1 | 8.3 % (separate profile) | 1.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |
| Widget: durable amount log and publication | 39.6 | 60 ms | 0 | 7.0 % (separate profile) | 1.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  WidgetPublisher.publishNow(_:)<br>1.1%  HabitStore.preparedWidgetSnapshot(now:hidden:) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 | 0.3 % (separate profile) | 0.1%  specialized static PerfDriver.scroll()<br>0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Widgets guide (first): longest stall 338 ms
- Widgets guide (again): longest stall 100 ms

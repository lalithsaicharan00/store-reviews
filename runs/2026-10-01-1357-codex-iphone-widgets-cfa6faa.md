# codex/iphone-widgets @ cfa6faa

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36869216323 · 2026-10-01 13:57 UTC
Commit: Coalesce timeline invalidations after immediate durable snapshots and preserve newest publication errors [ios-ci] [ios-widgets] [ios-widgets-validation] [ios-perf]

- Core storage and migrations: success
- Build: success
- UI tests (WidgetUITests/testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks,WidgetSystemUITests/testHomeScreenInstallTapAndColdPersistence,TimerUITests): success
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 102.544 (102.548) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 297.906 (297.918) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 297.906 (297.920) seconds
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (62.915 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (39.630 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (187.998 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (7.364 seconds).
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 31.0 | 287 ms | 2 | 2.0 % (separate profile) | 0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 125.0 | 222 ms | 2 | 9.7 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in HabitStore.queueEntryChange()<br>0.7%  closure #1 in HabitStore.queueEntryChange() |
| Widget: durable amount log and publication | 11.2 | 79 ms | 0 | 5.1 % (separate profile) | 1.0%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.0%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  thunk for @escaping @callee_guaranteed (@guaranteed CFRunLoopObserverRef?, @unowned CFRunLoopActivity) -> ()<br>0.7%  WidgetPublisher.publishNow(_:) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 | 5.8 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.8%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Widgets guide (first): longest stall 432 ms
- Widgets guide (again): longest stall 162 ms

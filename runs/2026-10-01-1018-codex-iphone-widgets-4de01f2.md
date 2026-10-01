# codex/iphone-widgets @ 4de01f2

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36846388174 · 2026-10-01 10:18 UTC
Commit: Integrate current Integration changes, cache widget projections and repair iPhone UI checks [ios-ci] [ios-widgets] [ios-perf]

- Core storage and migrations: success
- Build: success
- UI tests (WidgetUITests,WidgetSystemUITests,UndoUITests/testStoreCorrectionsRecalculateAndPersist,TimerUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 99.070 (99.075) seconds
	 Executed 2 tests, with 1 test skipped and 1 failure (0 unexpected) in 97.186 (97.187) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 145.925 (145.929) seconds
	 Executed 9 tests, with 1 test skipped and 1 failure (0 unexpected) in 356.354 (356.367) seconds
	 Executed 9 tests, with 1 test skipped and 1 failure (0 unexpected) in 356.354 (356.369) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:45: error: -[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence] : failed - Widget gallery has no Add Widget button
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (53.992 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (45.078 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (14.174 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' failed (44.683 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (100.258 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (22.799 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (17.361 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (5.508 seconds).
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 17.2 | 142 ms | 2 |  | (none above noise) |
| Today: +1 and day ‹ › | 53.8 | 322 ms | 1 |  | (none above noise) |
| Widget: durable amount log and publication | 1.6 | 22 ms | 0 | 6.3 % (separate profile) | 1.9%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.9%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.3%  WidgetPublisher.publish(_:)<br>1.2%  HabitStore.preparedWidgetSnapshot(now:hidden:) |
| Widgets guide: scrolling | 2.5 | 54 ms | 0 | 6.1 % (separate profile) | 0.7%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.7%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Widgets guide (first): longest stall 5124 ms
- Widgets guide (again): longest stall 213 ms

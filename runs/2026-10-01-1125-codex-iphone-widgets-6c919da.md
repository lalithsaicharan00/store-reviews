# codex/iphone-widgets @ 6c919da

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36852454114 · 2026-10-01 11:25 UTC
Commit: Keep widget history accurate across days, expose compact limits, streamline guide and verify cold default-store intents [ios-ci] [ios-widgets] [ios-widgets-recheck] [ios-perf]

- Core storage and migrations: success
- Build: success
- UI tests (WidgetUITests,WidgetSystemUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 1 failure (0 unexpected) in 253.005 (253.012) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 249.548 (249.553) seconds
	 Executed 7 tests, with 1 test skipped and 1 failure (0 unexpected) in 502.553 (502.567) seconds
	 Executed 7 tests, with 1 test skipped and 1 failure (0 unexpected) in 502.553 (502.568) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:68: error: -[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence] : XCTAssertTrue failed - Attributes: Application, 0x116f2d180, pid: 22247, label: 'Habits'
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' failed (147.667 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (192.887 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (22.948 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (19.526 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (8.188 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (5.998 seconds).
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Widget: durable amount log and publication | 24.6 | 51 ms | 0 | 3.8 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  WidgetPublisher.publish(_:)<br>0.9%  HabitStore.preparedWidgetSnapshot(now:hidden:) |
| Widgets guide: scrolling | 0.0 | 0 ms | 0 | 8.9 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.7%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.7%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Widgets guide (first): longest stall 692 ms
- Widgets guide (again): longest stall 182 ms

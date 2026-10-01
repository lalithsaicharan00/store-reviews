# codex/iphone-widgets @ 71b2c06

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36848752573 · 2026-10-01 10:49 UTC
Commit: Protect widget publication during privacy changes and validate actual Plus previews and Home gallery actions [ios-ci] [ios-widgets] [ios-perf]

- Core storage and migrations: success
- Build: success
- UI tests (WidgetUITests,WidgetSystemUITests,UndoUITests/testStoreCorrectionsRecalculateAndPersist,TimerUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 108.687 (108.690) seconds
	 Executed 2 tests, with 1 test skipped and 1 failure (0 unexpected) in 149.201 (149.210) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 176.359 (176.370) seconds
	 Executed 9 tests, with 1 test skipped and 1 failure (0 unexpected) in 450.314 (450.342) seconds
	 Executed 9 tests, with 1 test skipped and 1 failure (0 unexpected) in 450.314 (450.343) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:63: error: -[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence] : XCTAssertTrue failed - Attributes: Application, 0x1153135c0, pid: 25196, label: 'Habits'
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (72.872 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (35.814 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (16.067 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' failed (87.197 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (125.569 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (24.759 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (19.675 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (6.356 seconds).
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 19.4 | 294 ms | 1 | 1.0 % (separate profile) | 0.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.1%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.1%  closure #1 in static PerfDriver.startIfAsked(store:) |
| Today: +1 and day ‹ › | 82.5 | 174 ms | 2 | 5.1 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  HabitRow.row(now:)<br>0.2%  WidgetPublisher.publish(_:) |
| Widget: durable amount log and publication | 16.3 | 40 ms | 0 | 1.5 % (separate profile) | 0.5%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.5%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.3%  WidgetPublisher.publish(_:)<br>0.3%  HabitStore.preparedWidgetSnapshot(now:hidden:) |
| Widgets guide: scrolling | 3.7 | 56 ms | 0 | 7.5 % (separate profile) | 1.4%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.4%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.9%  partial apply for closure #1 in static PerfDriver.startIfAsked(store:)<br>0.9%  closure #1 in static PerfDriver.startIfAsked(store:) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Widgets guide (first): longest stall 467 ms
- Widgets guide (again): longest stall 130 ms

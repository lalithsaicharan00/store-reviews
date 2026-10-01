# codex/iphone-widgets @ a20c12c

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36841407803 · 2026-10-01 09:36 UTC
Commit: Boot one erased iPhone simulator without competing Simulator app startup [ios-ci] [ios-widgets] [ios-perf]

- Core storage and migrations: success
- Build: success
- UI tests (WidgetUITests,WidgetSystemUITests,UndoUITests/testStoreCorrectionsRecalculateAndPersist,TimerUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 135.604 (135.609) seconds
	 Executed 2 tests, with 1 test skipped and 1 failure (0 unexpected) in 49.941 (49.943) seconds
	 Executed 4 tests, with 2 failures (0 unexpected) in 159.530 (159.535) seconds
	 Executed 9 tests, with 1 test skipped and 3 failures (0 unexpected) in 362.081 (362.099) seconds
	 Executed 9 tests, with 1 test skipped and 3 failures (0 unexpected) in 362.081 (362.101) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetSystemUITests.swift:38: error: -[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence] : Failed to not hittable: StaticText, {{90.3, 244.3}, {52.0, 20.3}}, label: 'Habits'
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetUITests.swift:59: error: -[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree] : XCTAssertEqual failed: ("Optional("0")") is not equal to ("Optional("1")")
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetUITests.swift:72: error: -[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable] : XCTAssertTrue failed
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (88.920 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (46.683 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (17.007 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' failed (31.764 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (103.339 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' failed (34.704 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' failed (13.083 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (8.403 seconds).
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: scrolling | 36.2 | 316 ms | 2 |  | (none above noise) |
| Today: +1 and day ‹ › | 185.7 | 314 ms | 2 |  | (none above noise) |
| Widget: durable amount log and publication | 259.0 | 179 ms | 12 | 13.4 % (separate profile) | 9.1%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>9.1%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>8.5%  WidgetPublisher.publish(_:)<br>8.4%  HabitStore.widgetSnapshot(now:hidden:) |
| Widgets guide: scrolling | 7.8 | 88 ms | 0 |  | (none above noise) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Widgets guide (first): longest stall 778 ms
- Widgets guide (again): longest stall 279 ms

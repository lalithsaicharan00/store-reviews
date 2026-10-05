# claude/dreamy-pasteur-3kgdxu @ f60d009

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37363988700 · 2026-10-05 19:59 UTC
Commit: Routine player: one pager slide at a time; taps during a slide move the player at once and the pages follow in one slide when it ends (a slide over a running one slid back half a page at 0.05 s taps)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (FocusPlayerUITests): failure
- Speed tests: success
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 1 failure (0 unexpected) in 465.257 (465.273) seconds
	 Executed 15 tests, with 1 failure (0 unexpected) in 465.257 (465.274) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:407: error: -[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites] : XCTAssertLessThan failed: ("1.8210800886154175") is not less than ("1.8") - Navigation must not wait for the injected 2-second database write
Test Case '-[HabitsUITests.FocusPlayerUITests testBottomRowStaysPutAndOptionsShowEverything]' passed (52.568 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testChecklistPreservesPriorStepsAndQueueCanRevisit]' passed (31.455 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCompactProgressAcrossPeriodsAndTypes]' passed (64.937 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testCountCheckAndUndoStayOnTheCurrentHabit]' passed (22.922 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack]' passed (28.888 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLargeTextKeepsActionsAndChecklistReachable]' passed (22.197 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testLimitIsNotInTheRoutineAndWaitsUnderQuitOrCutDown]' passed (33.981 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testManualTimePausesAndClockCanBeHidden]' passed (37.648 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testNavigationDoesNotWaitForSlowTimerWrites]' failed (25.422 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testOnlyALimitShowsUnderQuitOrCutDownWithoutStart]' passed (21.215 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSavedFocusProgressSurvivesTermination]' passed (29.412 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testSwipeMovesOneHabitAtATime]' passed (15.296 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerDayBoundaryAndExactUndoPersistence]' passed (6.876 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerGoalDoesNotAutoAdvanceAndManualLogIsReachable]' passed (41.041 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testTimerPauseBackgroundAndSkipPreserveTime]' passed (31.399 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Routine player: ‹ › | 13.2 | 74 ms | 0 | 5.3 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  closure #1 in AppModel.ensureLoaded()<br>1.1%  partial apply for closure #1 in AppModel.ensureLoaded() |
| Routine player: fast ‹ › | 15.7 | 81 ms | 0 | 5.3 % (separate profile) | 1.2%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.2%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>1.1%  closure #1 in AppModel.ensureLoaded()<br>1.1%  partial apply for closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Routine player (first): longest stall 500 ms
- Routine player (again): longest stall 198 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| player | Widgets: one habit's month | 18 | 80 ms | 46.9 ms |
| player | Widgets: the snapshot | 2 | 4 ms | 3.7 ms |
| player | Reminders: plan every alert | 50 | 3 ms | 0.1 ms |
| player | Change: Siri's habit names | 49 | 2 ms | 0.1 ms |
| player | Count: Today's list drawn | 11 | 0 ms | 0.3 ms |
| player | Count: a Today row drawn | 80 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

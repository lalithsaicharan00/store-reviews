# claude/server-and-sync @ 02ee25f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36954216032 · 2026-10-02 02:22 UTC
Commit: Speed: Today's rows open one sheet each again, duration rows keep one clock host on every day, the day count redraws alone

- Core storage and migrations: success
- Build: success
- UI tests (TodayUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 8 tests, with 3 failures (0 unexpected) in 277.014 (277.020) seconds
	 Executed 8 tests, with 3 failures (0 unexpected) in 277.014 (277.021) seconds
	 Executed 8 tests, with 3 failures (0 unexpected) in 277.014 (277.022) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayUITests.swift:198: error: -[HabitsUITests.TodayUITests testDoneRowWaitsForThePause] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayUITests.swift:222: error: -[HabitsUITests.TodayUITests testDoneRowStaysInPlace] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/TodayUITests.swift:37: error: -[HabitsUITests.TodayUITests testTodayScreen] : XCTAssertTrue failed
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (31.362 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (84.769 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' failed (18.985 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' failed (16.616 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (11.929 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (92.970 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (11.118 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' failed (9.266 seconds).
```

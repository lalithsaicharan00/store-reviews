# claude/habit-details-ci @ 5e815b9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37141020822 · 2026-10-03 18:04 UTC
Commit: Habit page tests: opening a habit asserts the menu and the Habits list (a tap in the year demo's first seconds landed on Today's row)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (HabitPageUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 6 tests, with 2 failures (0 unexpected) in 859.867 (859.875) seconds
	 Executed 6 tests, with 2 failures (0 unexpected) in 859.867 (859.878) seconds
	 Executed 6 tests, with 2 failures (0 unexpected) in 859.867 (859.880) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:131: error: -[HabitsUITests.HabitPageUITests testHistoryFlows] : XCTAssertTrue failed - Added and closed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/HabitPageUITests.swift:134: error: -[HabitsUITests.HabitPageUITests testHistoryFlows] : Failed to not hittable: Button, {{16.0, 337.7}, {370.0, 60.3}}, identifier: 'habit-day-2026-10-03'
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' failed (133.335 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (56.057 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (288.883 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (119.969 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (222.399 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (39.224 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

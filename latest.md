# claude/pensive-gates-3n4ie8-ci8 @ fc7ec60

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38138209575 · 2026-10-11 16:09 UTC
Commit: Current Work 86: the calendar popover keeps one height as the month changes

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests,LongTextUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 477.478 (477.484) seconds
	 Executed 13 tests, with 2 failures (0 unexpected) in 556.301 (556.313) seconds
	 Executed 13 tests, with 2 failures (0 unexpected) in 556.301 (556.315) seconds
	 Executed 3 tests, with 2 failures (0 unexpected) in 78.823 (78.827) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:125: error: -[HabitsUITests.LongTextUITests testFormWithLongText] : Failed to tap Button (First Match): No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate 'label BEGINSWITH "Build or maintain"'`, given input App element pid: 34797
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:68: error: -[HabitsUITests.LongTextUITests testTodayWithLongText] : XCTAssertTrue failed
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (49.823 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' failed (13.716 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' failed (15.284 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testHabitPageDark]' passed (48.592 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (39.440 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (27.065 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (47.463 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' passed (63.365 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (72.368 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (20.666 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (67.433 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (33.759 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearScrollAndHabitPage]' passed (57.327 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

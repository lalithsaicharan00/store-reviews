# claude/progress-week-cards @ 560df7f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37040359086 · 2026-10-02 17:50 UTC
Commit: Year demo: Swim's pause in the latest weeks, so the first view shows every square

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WeekCardsUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 7 tests, with 1 failure (0 unexpected) in 439.817 (439.843) seconds
	 Executed 7 tests, with 1 failure (0 unexpected) in 439.817 (439.844) seconds
	 Executed 7 tests, with 1 failure (0 unexpected) in 439.817 (439.848) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WeekCardsUITests.swift:32: error: -[HabitsUITests.WeekCardsUITests testWeekCardsDark] : Failed to terminate com.oftenenough.app:28324: Failed to terminate com.oftenenough.app:0
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCards]' passed (61.754 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testMonthCardsDark]' passed (57.368 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsDark]' failed (83.423 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsLight]' passed (99.241 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testWeekCardsWithGroups]' passed (22.156 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCards]' passed (77.724 seconds).
Test Case '-[HabitsUITests.WeekCardsUITests testYearCardsDark]' passed (38.152 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

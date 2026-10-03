# claude/today-edit-mode @ 96a100f

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37118526553 · 2026-10-03 11:22 UTC
Commit: LongText test: say what the name field holds when it isn't cut to 24 letters

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,LongTextUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 3 tests, with 1 failure (0 unexpected) in 80.575 (80.577) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 198.696 (198.701) seconds
	 Executed 8 tests, with 1 failure (0 unexpected) in 279.271 (279.280) seconds
	 Executed 8 tests, with 1 failure (0 unexpected) in 279.271 (279.281) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:135: error: -[HabitsUITests.LongTextUITests testFormWithLongText] : XCTAssertEqual failed: ("XCTWaiterResult(rawValue: 2)") is not equal to ("XCTWaiterResult(rawValue: 1)") - The name is cut to 24 letters; the field holds "Read one more chapter ofthe nightstand "
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (60.946 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (9.638 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (76.551 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (29.519 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (22.042 seconds).
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (21.647 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' failed (24.103 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' passed (34.825 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

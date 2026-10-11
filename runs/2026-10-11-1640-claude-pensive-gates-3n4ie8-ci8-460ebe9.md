# claude/pensive-gates-3n4ie8-ci8 @ 460ebe9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38154445955 · 2026-10-11 16:40 UTC
Commit: Current Work 86: as List / as Columns move into the sidebar's menu group; Today's rows are hidden from VoiceOver under a page

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (LongTextUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 3 tests, with 1 failure (0 unexpected) in 169.247 (169.253) seconds
	 Executed 3 tests, with 1 failure (0 unexpected) in 169.247 (169.254) seconds
	 Executed 3 tests, with 1 failure (0 unexpected) in 169.247 (169.258) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:135: error: -[HabitsUITests.LongTextUITests testFormWithLongText] : XCTAssertEqual failed: ("XCTWaiterResult(rawValue: 2)") is not equal to ("XCTWaiterResult(rawValue: 1)") - The name is cut to 24 letters; the field holds "Read one more chapter of"
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (68.224 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' failed (42.748 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' passed (58.275 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# archive/animations-and-settings-2026-10-01 @ 369834b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36844351018 · 2026-10-01 09:56 UTC
Commit: Animations and Settings checklist: the Progress speed question is answered (not this branch)

- Build: success
- UI tests (LongTextUITests): failure
- Speed tests: skipped

## UI tests
```
	 Executed 3 tests, with 1 failure (0 unexpected) in 105.546 (105.551) seconds
	 Executed 3 tests, with 1 failure (0 unexpected) in 105.546 (105.553) seconds
	 Executed 3 tests, with 1 failure (0 unexpected) in 105.546 (105.556) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:129: error: -[HabitsUITests.LongTextUITests testFormWithLongText] : Asynchronous wait failed: Exceeded timeout of 3 seconds, with unfulfilled expectations: "Expect predicate `BLOCKPREDICATE(0x10628a100)` for object "name-field" TextField".
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (39.936 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' failed (27.842 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' passed (37.767 seconds).
```

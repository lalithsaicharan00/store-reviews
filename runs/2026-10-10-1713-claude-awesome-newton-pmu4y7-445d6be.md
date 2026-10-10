# claude/awesome-newton-pmu4y7 @ 445d6be

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38068020591 · 2026-10-10 17:13 UTC
Commit: Plus screens: the habit form's 6th-habit sheet takes the name when Add is tapped; test for bringing back an archived habit

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (PlusUITests,NewFlowUITests,LongTextUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 261.301 (261.309) seconds
	 Executed 14 tests, with 2 failures (0 unexpected) in 701.228 (701.248) seconds
	 Executed 14 tests, with 2 failures (0 unexpected) in 701.228 (701.250) seconds
	 Executed 3 tests, with 2 failures (0 unexpected) in 211.429 (211.436) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:118: error: -[HabitsUITests.LongTextUITests testTodayWithLongText] : Asynchronous wait failed: Exceeded timeout of 3 seconds, with unfulfilled expectations: "Expect predicate `BLOCKPREDICATE(0x1159e94d0)` for object "section-name-field" TextField".
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/LongTextUITests.swift:135: error: -[HabitsUITests.LongTextUITests testFormWithLongText] : XCTAssertEqual failed: ("XCTWaiterResult(rawValue: 2)") is not equal to ("XCTWaiterResult(rawValue: 1)") - The name is cut to 24 letters; the field holds "Read one more chapter of"
Test Case '-[HabitsUITests.LongTextUITests testChooserShowsEverything]' passed (57.596 seconds).
Test Case '-[HabitsUITests.LongTextUITests testFormWithLongText]' failed (48.502 seconds).
Test Case '-[HabitsUITests.LongTextUITests testTodayWithLongText]' failed (105.330 seconds).
Test Case '-[HabitsUITests.NewFlowUITests testFlow]' passed (228.498 seconds).
Test Case '-[HabitsUITests.PlusUITests testAskToBuyShowsWaiting]' passed (23.453 seconds).
Test Case '-[HabitsUITests.PlusUITests testBringingBackAnArchivedHabit]' passed (26.065 seconds).
Test Case '-[HabitsUITests.PlusUITests testBuyingPlusSavesTheSixthHabit]' passed (34.080 seconds).
Test Case '-[HabitsUITests.PlusUITests testMakeRoomArchivesOneAndGoesAhead]' passed (30.646 seconds).
Test Case '-[HabitsUITests.PlusUITests testOwnerUpgradesAndFamilyMemberPage]' passed (37.817 seconds).
Test Case '-[HabitsUITests.PlusUITests testPlusEndedIsToldOnce]' passed (13.501 seconds).
Test Case '-[HabitsUITests.PlusUITests testPlusPageAndRestoreWithNothingFound]' passed (16.926 seconds).
Test Case '-[HabitsUITests.PlusUITests testPricesThatFailShowTryAgain]' passed (33.571 seconds).
Test Case '-[HabitsUITests.PlusUITests testSecondDeviceSheetOpensThePlusPage]' passed (20.583 seconds).
Test Case '-[HabitsUITests.PlusUITests testSixthHabitSheetOffersBothPlansAndNoNotNow]' passed (24.660 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

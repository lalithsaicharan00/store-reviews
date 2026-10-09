# app-lock-privacy-security @ ed9b772

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37883781520 · 2026-10-09 04:53 UTC
Commit: Current Work 58: Use Face ID again? is asked on the cover before it opens (run 37880056940)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (AppLockUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 2 failures (0 unexpected) in 688.807 (688.818) seconds
	 Executed 12 tests, with 2 failures (0 unexpected) in 688.807 (688.820) seconds
	 Executed 12 tests, with 2 failures (0 unexpected) in 688.807 (688.823) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:243: error: -[HabitsUITests.AppLockUITests testFaceIDChangedAsksForTheCodeAndThenAsks] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:351: error: -[HabitsUITests.AppLockUITests testCancelLeavesUnlockAndTypedTextIsKept] : XCTAssertTrue failed - No Face ID prompt: Emoji | Dictate | Vertical scroll bar, 1 page | Toolbar | Menu | Edit | Filter | New Habit | Often Enough is locked | Unlock | Typing Predictions | Padding-Left | q | w | e
Test Case '-[HabitsUITests.AppLockUITests testALinkOpensBehindTheCoverAndShowsAfterUnlock]' passed (37.421 seconds).
Test Case '-[HabitsUITests.AppLockUITests testAskAgainImmediatelyAndAfterAMinute]' passed (110.661 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancelLeavesUnlockAndTypedTextIsKept]' failed (64.714 seconds).
Test Case '-[HabitsUITests.AppLockUITests testChooseCodeThenUnlockWithIt]' passed (76.423 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDChangedAsksForTheCodeAndThenAsks]' failed (59.412 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeTwentyFourHourReset]' passed (54.096 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeWithFaceID]' passed (34.866 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockOnAndOffAndHideNamesFollows]' passed (95.691 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockRulesAndHiddenNamesEverywhere]' passed (6.534 seconds).
Test Case '-[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit]' passed (77.965 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWidgetChooseLinkOpensHelp]' passed (21.866 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWrongCodesWaitThenTheRightCodeOpens]' passed (49.158 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# app-lock-privacy-security @ 5d7d35c

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37880056940 · 2026-10-09 04:20 UTC
Commit: Current Work 58: the test Face ID panel takes its own taps (run 37875404027)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (AppLockUITests,NewHabitUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 3 failures (0 unexpected) in 647.312 (647.325) seconds
	 Executed 20 tests, with 0 failures (0 unexpected) in 942.293 (942.310) seconds
	 Executed 32 tests, with 3 failures (0 unexpected) in 1589.605 (1589.637) seconds
	 Executed 32 tests, with 3 failures (0 unexpected) in 1589.605 (1589.639) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:213: error: -[HabitsUITests.AppLockUITests testFaceIDChangedAsksForTheCodeAndThenAsks] : XCTAssertTrue failed - Menu | Edit | Filter | New Habit | Edit | checklist | No habits yet | Add something you'd like to do often enough, or start from an idea. | New Habit | Start From an Idea | Restore from a Backup File | How It Works
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:28: error: -[HabitsUITests.AppLockUITests testForgotCodeWithFaceID] : Failed to tap "code-key-1" Button: Find single matching element. Multiple matching elements found for <XCUIElementQuery: 0x106420a50>.
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:322: error: -[HabitsUITests.AppLockUITests testCancelLeavesUnlockAndTypedTextIsKept] : XCTAssertTrue failed - Vertical scroll bar, 1 page | Test Face ID or Passcode | Unlock your habits | Cancel | Succeed | Menu | Edit | Filter | New Habit | Often Enough is locked | Unlock | Edit | checklist | No habits yet | Add something you'd like to do often enough, or start from an idea. | New Habit | Start From an Idea | Restore from a Backup File | How It Works
Test Case '-[HabitsUITests.AppLockUITests testALinkOpensBehindTheCoverAndShowsAfterUnlock]' passed (33.839 seconds).
Test Case '-[HabitsUITests.AppLockUITests testAskAgainImmediatelyAndAfterAMinute]' passed (54.386 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancelLeavesUnlockAndTypedTextIsKept]' failed (70.497 seconds).
Test Case '-[HabitsUITests.AppLockUITests testChooseCodeThenUnlockWithIt]' passed (79.254 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDChangedAsksForTheCodeAndThenAsks]' failed (29.588 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeTwentyFourHourReset]' passed (56.356 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeWithFaceID]' failed (14.801 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockOnAndOffAndHideNamesFollows]' passed (84.785 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockRulesAndHiddenNamesEverywhere]' passed (7.662 seconds).
Test Case '-[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit]' passed (126.626 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWidgetChooseLinkOpensHelp]' passed (16.564 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWrongCodesWaitThenTheRightCodeOpens]' passed (72.953 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (129.164 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (37.417 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (38.149 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (41.062 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (68.462 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (34.731 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (10.800 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (35.376 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (33.851 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (24.782 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (35.733 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (60.799 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (63.411 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (25.704 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (30.500 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (71.939 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (47.766 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (87.977 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (39.262 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (25.409 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

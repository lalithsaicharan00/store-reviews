# app-lock-privacy-security @ a1c29d8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37875404027 · 2026-10-09 03:31 UTC
Commit: Current Work 58: the snapshot's name stripping runs off the main actor (run 37874227531)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (AppLockUITests,WidgetUITests,WidgetSystemUITests,TodayUITests,RemindersUITests,NewHabitUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 8 failures (0 unexpected) in 396.941 (396.951) seconds
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 241.147 (241.153) seconds
	 Executed 20 tests, with 1 failure (0 unexpected) in 979.401 (979.417) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 93.212 (93.217) seconds
	 Executed 52 tests, with 1 test skipped and 9 failures (0 unexpected) in 2279.247 (2279.306) seconds
	 Executed 52 tests, with 1 test skipped and 9 failures (0 unexpected) in 2279.247 (2279.308) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 278.806 (278.811) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 289.740 (289.747) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:103: error: -[HabitsUITests.AppLockUITests testLockOnAndOffAndHideNamesFollows] : XCTAssertTrue failed - Test Face ID or Passcode | Turn on the lock for Often Enough | Cancel | Succeed | Back | Privacy & Security | Vertical scroll bar, 1 page
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:136: error: -[HabitsUITests.AppLockUITests testChooseCodeThenUnlockWithIt] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:203: error: -[HabitsUITests.AppLockUITests testFaceIDChangedAsksForTheCodeAndThenAsks] : XCTAssertTrue failed - Vertical scroll bar, 1 page | Test Face ID | Unlock Often Enough | Cancel | Succeed | Menu | Edit | Filter | New Habit | Often Enough is locked | Use Face ID | Enter your code | 1 of 6 digits entered |   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | Delete | Forgot Code? | Edit | checklist | No habits yet | Add something you'd like to do often enough, or start from an idea. | New Habit | Start From an Idea | Restore from a Backup File | How It Works
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:248: error: -[HabitsUITests.AppLockUITests testForgotCodeWithFaceID] : XCTAssertTrue failed - Vertical scroll bar, 1 page | Test Face ID | Choose a new Often Enough code | Cancel | Succeed | Menu | Edit | Filter | New Habit | Often Enough is locked | Use Face ID | Enter your code | 0 of 6 digits entered |   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | Delete | Forgot Code? | Edit | Cancel | Forgot Your Code
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:267: error: -[HabitsUITests.AppLockUITests testForgotCodeTwentyFourHourReset] : XCTAssertTrue failed - Vertical scroll bar, 1 page | Test Face ID or Passcode | Reset your Often Enough code | Cancel | Succeed | Menu | Edit | Filter | New Habit | Often Enough is locked | Enter your code | 0 of 6 digits entered |   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | Delete | Forgot Code? | Edit | Cancel | Forgot Your Code | checklist
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:300: error: -[HabitsUITests.AppLockUITests testAskAgainImmediatelyAndAfterAMinute] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:322: error: -[HabitsUITests.AppLockUITests testCancelLeavesUnlockAndTypedTextIsKept] : XCTAssertTrue failed - Vertical scroll bar, 1 page | Test Face ID or Passcode | Unlock your habits | Cancel | Succeed | Menu | Edit | Filter | New Habit | Often Enough is locked | Unlock | Edit | checklist | No habits yet | Add something you'd like to do often enough, or start from an idea. | New Habit | Start From an Idea | Restore from a Backup File | How It Works
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:350: error: -[HabitsUITests.AppLockUITests testALinkOpensBehindTheCoverAndShowsAfterUnlock] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/NewHabitUITests.swift:60: error: -[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek] : XCTAssertTrue failed
Test Case '-[HabitsUITests.AppLockUITests testALinkOpensBehindTheCoverAndShowsAfterUnlock]' failed (92.769 seconds).
Test Case '-[HabitsUITests.AppLockUITests testAskAgainImmediatelyAndAfterAMinute]' failed (16.057 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancelLeavesUnlockAndTypedTextIsKept]' failed (19.851 seconds).
Test Case '-[HabitsUITests.AppLockUITests testChooseCodeThenUnlockWithIt]' failed (22.128 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDChangedAsksForTheCodeAndThenAsks]' failed (26.362 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeTwentyFourHourReset]' failed (28.575 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeWithFaceID]' failed (28.456 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockOnAndOffAndHideNamesFollows]' failed (41.359 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockRulesAndHiddenNamesEverywhere]' passed (7.228 seconds).
Test Case '-[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit]' passed (52.265 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWidgetChooseLinkOpensHelp]' passed (18.195 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWrongCodesWaitThenTheRightCodeOpens]' passed (43.697 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (156.892 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (43.890 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (40.444 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (45.359 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (81.895 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (40.410 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (13.676 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (45.228 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (46.948 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (29.867 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (39.214 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (64.620 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (45.638 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (21.740 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (30.036 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' failed (16.569 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (41.186 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (97.047 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (44.201 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (34.540 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (14.430 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (43.608 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (14.982 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (20.192 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (22.841 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (40.779 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (21.596 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (27.395 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (14.648 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (107.883 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (16.186 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

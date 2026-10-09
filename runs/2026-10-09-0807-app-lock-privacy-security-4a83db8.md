# app-lock-privacy-security @ 4a83db8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37896905498 · 2026-10-09 08:07 UTC
Commit: Current Work 58.10–58.11: the user's Backup & Export and account points, recorded before the research (W1)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (AppLockUITests,WidgetUITests,WidgetSystemUITests,TodayUITests,RemindersUITests,NewHabitUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 2 failures (0 unexpected) in 677.529 (677.547) seconds
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 210.487 (210.490) seconds
	 Executed 20 tests, with 3 failures (0 unexpected) in 902.989 (903.007) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 112.720 (112.724) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 286.250 (286.257) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:275: error: -[HabitsUITests.AppLockUITests testForgotCodeWithFaceID] : XCTAssertTrue failed - Vertical scroll bar, 1 page | Menu | Edit | Filter | New Habit | Often Enough is locked | Use Face ID | Enter your code | 0 of 6 digits entered |   | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | Delete | Forgot Code? | Edit | Cancel | Forgot Your Code | checklist | No habits yet | Add something you'd like to do often enough, or start from an idea. | New Habit | Start From an Idea
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:434: error: -[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit] : Failed to tap "Edit Habit" Button: No matches found for first query match sequence: `Descendants matching type Button` -> `Elements matching predicate '"Edit Habit" IN identifiers'`, given input App element pid: 46654
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/NewHabitUITests.swift:60: error: -[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/NewHabitUITests.swift:60: error: -[HabitsUITests.NewHabitUITests testDatesOfTheMonth] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/NewHabitUITests.swift:60: error: -[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps] : XCTAssertTrue failed
Test Case '-[HabitsUITests.AppLockUITests testALinkOpensBehindTheCoverAndShowsAfterUnlock]' passed (41.913 seconds).
Test Case '-[HabitsUITests.AppLockUITests testAskAgainImmediatelyAndAfterAMinute]' passed (51.886 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancelLeavesUnlockAndTypedTextIsKept]' passed (58.685 seconds).
Test Case '-[HabitsUITests.AppLockUITests testChooseCodeThenUnlockWithIt]' passed (99.915 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDChangedAsksForTheCodeAndThenAsks]' passed (107.501 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeTwentyFourHourReset]' passed (67.634 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeWithFaceID]' failed (48.132 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockOnAndOffAndHideNamesFollows]' passed (74.819 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockRulesAndHiddenNamesEverywhere]' passed (8.438 seconds).
Test Case '-[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit]' failed (50.932 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWidgetChooseLinkOpensHelp]' passed (21.524 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWrongCodesWaitThenTheRightCodeOpens]' passed (46.148 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (102.316 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (42.537 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (43.930 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (57.850 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (105.386 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' failed (16.618 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (13.594 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (46.214 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' failed (16.308 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (43.247 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (44.944 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (73.917 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (52.771 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (22.894 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (25.285 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (60.819 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (41.868 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' failed (12.059 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (42.364 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (38.068 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (13.917 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (59.946 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (17.249 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (21.609 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (23.739 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (42.079 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (21.847 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (27.470 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (15.816 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (103.913 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (17.195 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (34.191 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (124.977 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (251.186 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (127.131 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

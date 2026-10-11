# claude/pensive-gates-3n4ie8-ci9 @ fc7ec60

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38136627928 · 2026-10-11 14:28 UTC
Commit: Current Work 86: the calendar popover keeps one height as the month changes

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests,TodayUITests,AppLockUITests/testCancellingSetUpAtEachStepChangesNothing,AppLockUITests/testReminderSaysIsSavedWithTheHabit,DayDetailsUITests/testTimeLogAddViewAndEdit,OnboardingUITests/testHelpAndTheWelcomeAgain,PlusUITests/testSecondDeviceSheetOpensThePlusPage): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 12 tests, with 0 failures (0 unexpected) in 437.198 (437.209) seconds
	 Executed 2 tests, with 2 failures (0 unexpected) in 91.482 (91.488) seconds
	 Executed 25 tests, with 5 failures (0 unexpected) in 944.955 (944.999) seconds
	 Executed 25 tests, with 5 failures (0 unexpected) in 944.955 (945.001) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 291.968 (291.979) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:297: error: -[HabitsUITests.AppLockUITests testCancellingSetUpAtEachStepChangesNothing] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:906: error: -[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit] : Failed to tap "Add" Button: No matches found for Elements matching predicate '"New Habit" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:364: error: -[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit] : XCTAssertTrue failed - The clock row is Finished at
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingUITests.swift:388: error: -[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain] : Failed to tap "menu-about" Button: No matches found for Elements matching predicate '"menu-about" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/PlusUITests.swift:269: error: -[HabitsUITests.PlusUITests testSecondDeviceSheetOpensThePlusPage] : XCTAssertTrue failed - Often Enough | Often Enough | Menu | Edit | Edit | Filter | New Habit | Anytime, 5 left | Anytime | 5 left | Start Anytime routine | Play | Start | Fold Anytime | Water Drop | Drink water | Every day | Mark Drink water done | Bookmark | Read | Every day | Mark Read done | Walk | Walk | Every day | Mark Walk done | brain.head.profile | Meditate | Every day | Mark Meditate done | Medicine | Vitamins | Every day | Mark Vitamins done | Note for the Day | Notes | Note for the Day | Vertical scroll bar, 2 pages | Vertical scroll bar, 2 pages | Toolbar | Previous day | Today, 0 of 5 done. Open calendar | Today, 0 of 5 done. Open calendar | Today | Go Down | 0/5 | Next day | Sheet Grabber | Back | Plus | Plus | One payment, yours forever. | 5 of 5 free habits used | 5 of 5 free habits used | Plus · just you, Unlimited habits, your iPad and Apple Watch, sync through your own iCloud, $24.99 | Selected | Plus · just you | Unlimited habits, your iPad and Apple Watch, sync through your own iCloud | $24.99 | Plus Family · you + 5, Everything in Plus for you and up to 5 people in your Apple family, each with their own habits, $59.99
Test Case '-[HabitsUITests.AppLockUITests testCancellingSetUpAtEachStepChangesNothing]' failed (50.850 seconds).
Test Case '-[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit]' failed (40.632 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit]' failed (48.038 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' failed (56.820 seconds).
Test Case '-[HabitsUITests.PlusUITests testSecondDeviceSheetOpensThePlusPage]' failed (19.449 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddLogFitsAboveTheKeyboard]' passed (15.530 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAddTimeFitsAboveTheKeyboard]' passed (13.076 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAfterLogLineStaysInsideTheRow]' passed (77.048 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testAppLockSetupFitsWithoutScrolling]' passed (25.146 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testDayDetailsKeepsSkipOnScreenWithFourLogsAndANote]' passed (40.508 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testEditLogFitsAboveTheKeyboard]' passed (21.971 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testICloudPageSecondDeviceAndRestoreFit]' passed (47.960 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testLockKeypadFitsAtAccessibilitySizes]' passed (31.903 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testNoteBoxFillsTheRoomAboveSave]' passed (14.105 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testOverallRecordFitsWithoutScrolling]' passed (28.016 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPlusSheetAndPageFit]' passed (43.966 seconds).
Test Case '-[HabitsUITests.SmallScreenUITests testPrivacyCodeSheetsAndReminderSaysFit]' passed (77.966 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (18.238 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (44.749 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (22.099 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (28.184 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (14.747 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (110.176 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (18.332 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (35.444 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

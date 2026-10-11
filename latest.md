# claude/pensive-gates-3n4ie8-ci9 @ c5b1da3

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38131232418 · 2026-10-11 11:41 UTC
Commit: Current Work 86/88: Day details' popover hangs on Today, pointing at its row; iPad tests; iPad speed runs; coming back to the iPhone

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests,TodayUITests,DayDetailsUITests,PlusUITests,OnboardingUITests,AppLockUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 1 failure (0 unexpected) in 290.821 (290.829) seconds
	 Executed 10 tests, with 1 failure (0 unexpected) in 318.836 (318.843) seconds
	 Executed 15 tests, with 1 failure (0 unexpected) in 920.991 (921.002) seconds
	 Executed 21 tests, with 2 failures (0 unexpected) in 966.346 (966.361) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:297: error: -[HabitsUITests.AppLockUITests testCancellingSetUpAtEachStepChangesNothing] : XCTAssertTrue failed
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/AppLockUITests.swift:906: error: -[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit] : Failed to tap "Add" Button: No matches found for Elements matching predicate '"New Habit" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/DayDetailsUITests.swift:364: error: -[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit] : XCTAssertTrue failed - The clock row is Finished at
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingUITests.swift:388: error: -[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain] : Failed to tap "menu-about" Button: No matches found for Elements matching predicate '"menu-about" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/PlusUITests.swift:269: error: -[HabitsUITests.PlusUITests testSecondDeviceSheetOpensThePlusPage] : XCTAssertTrue failed - Often Enough | Often Enough | Menu | Edit | Edit | Filter | New Habit | Anytime, 5 left | Anytime | 5 left | Start Anytime routine | Play | Start | Fold Anytime | Water Drop | Drink water | Every day | Mark Drink water done | Bookmark | Read | Every day | Mark Read done | Walk | Walk | Every day | Mark Walk done | brain.head.profile | Meditate | Every day | Mark Meditate done | Medicine | Vitamins | Every day | Mark Vitamins done | Note for the Day | Notes | Note for the Day | Vertical scroll bar, 2 pages | Vertical scroll bar, 2 pages | Toolbar | Previous day | Today, 0 of 5 done. Open calendar | Today, 0 of 5 done. Open calendar | Today | Go Down | 0/5 | Next day | Sheet Grabber | Back | Plus | Plus | One payment, yours forever. | 5 of 5 free habits used | 5 of 5 free habits used | Plus · just you, Unlimited habits, your iPad and Apple Watch, sync through your own iCloud, $24.99 | Selected | Plus · just you | Unlimited habits, your iPad and Apple Watch, sync through your own iCloud | $24.99 | Plus Family · you + 5, Everything in Plus for you and up to 5 people in your Apple family, each with their own habits, $59.99
Test Case '-[HabitsUITests.AppLockUITests testALinkOpensBehindTheCoverAndShowsAfterUnlock]' passed (36.856 seconds).
Test Case '-[HabitsUITests.AppLockUITests testAppPasscodeWayAndItsReset]' passed (107.246 seconds).
Test Case '-[HabitsUITests.AppLockUITests testAskAgainImmediatelyAndAfterAMinute]' passed (41.851 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancelLeavesUnlockAndTypedTextIsKept]' passed (32.055 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancellingSetUpAtEachStepChangesNothing]' failed (34.546 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDChangedAsksForTheCodeAndThenAsks]' passed (81.428 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDLockedOutIsNotTurnedOff]' passed (29.439 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDOffForTheApp]' passed (76.575 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeTwentyFourHourReset]' passed (55.672 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeWithFaceID]' passed (30.190 seconds).
Test Case '-[HabitsUITests.AppLockUITests testIPhonePasscodeTurnedOff]' passed (35.501 seconds).
Test Case '-[HabitsUITests.AppLockUITests testIPhonePasscodeWay]' passed (55.162 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockOnAndOffAndHideNamesFollows]' passed (102.491 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockRulesAndHiddenNamesEverywhere]' passed (4.944 seconds).
Test Case '-[HabitsUITests.AppLockUITests testNoFaceIDOnThisIPhone]' passed (31.479 seconds).
Test Case '-[HabitsUITests.AppLockUITests testNoPasscodeUsesTheAppPasscodeAlone]' passed (38.108 seconds).
Test Case '-[HabitsUITests.AppLockUITests testOlderLockUpgrades]' passed (39.964 seconds).
Test Case '-[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit]' failed (28.421 seconds).
Test Case '-[HabitsUITests.AppLockUITests testSwitchingWays]' passed (59.637 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWidgetChooseLinkOpensHelp]' passed (11.793 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWrongCodesWaitThenTheRightCodeOpens]' passed (32.990 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testCurrencyAndNoUnitAmounts]' passed (21.241 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (80.265 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen]' passed (251.682 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (113.285 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (121.467 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs]' passed (34.003 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete]' passed (39.661 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMarkADayDoneOnlyOnce]' passed (23.329 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testOlderMultiCheckLogStillCorrects]' passed (21.218 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testPastDayLogKeepsItsDayAndChosenTime]' passed (19.450 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipAddViewEditAndDelete]' passed (32.734 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (31.981 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' passed (68.149 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTickSteps]' passed (21.453 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit]' failed (41.073 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (49.616 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' passed (17.308 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (36.878 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHabitsComeBackFromICloud]' passed (14.831 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' failed (58.931 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (24.010 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' passed (54.728 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (7.233 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' passed (21.213 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (34.087 seconds).
Test Case '-[HabitsUITests.PlusUITests testAskToBuyShowsWaiting]' passed (15.845 seconds).
Test Case '-[HabitsUITests.PlusUITests testBringingBackAnArchivedHabit]' passed (25.626 seconds).
Test Case '-[HabitsUITests.PlusUITests testBuyingPlusSavesTheSixthHabit]' passed (30.971 seconds).
Test Case '-[HabitsUITests.PlusUITests testMakeRoomArchivesOneAndGoesAhead]' passed (27.069 seconds).
Test Case '-[HabitsUITests.PlusUITests testOwnerUpgradesAndFamilyMemberPage]' passed (35.581 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# app-lock-privacy-security-ci4 @ 4a83db8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37896915259 · 2026-10-09 08:04 UTC
Commit: Current Work 58.10–58.11: the user's Backup & Export and account points, recorded before the research (W1)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (OnboardingUITests,AnalyticsUITests,DayDetailsUITests,HabitPageUITests,PlacementUITests,CompletionFeedbackUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 0 failures (0 unexpected) in 1188.121 (1188.136) seconds
	 Executed 37 tests, with 0 failures (0 unexpected) in 2456.902 (2456.947) seconds
	 Executed 37 tests, with 0 failures (0 unexpected) in 2456.902 (2456.949) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 48.328 (48.332) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 223.344 (223.350) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 979.768 (979.779) seconds
Test Case '-[HabitsUITests.AnalyticsUITests testDurableContentFreeTracking]' passed (11.235 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testFailedPersistenceNeverCounts]' passed (6.982 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testUsageConsentIsOptionalAndSeparate]' passed (16.283 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testWelcomeConsentIsOptional]' passed (13.827 seconds).
Test Case '-[HabitsUITests.CompletionFeedbackUITests testCompletionPlaysOnceWhenAHabitBecomesCompleteAndNeverForQuitOrLimits]' passed (10.037 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testCurrencyAndNoUnitAmounts]' passed (50.236 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (208.055 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen]' passed (299.305 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (111.833 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (116.006 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs]' passed (33.873 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete]' passed (45.750 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMarkADayDoneOnlyOnce]' passed (26.746 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testOlderMultiCheckLogStillCorrects]' passed (25.270 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testPastDayLogKeepsItsDayAndChosenTime]' passed (20.674 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipAddViewEditAndDelete]' passed (37.390 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (60.868 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' passed (85.640 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTickSteps]' passed (24.193 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit]' passed (42.283 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (54.664 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (51.738 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFoldByMonthLikeHistory]' passed (46.138 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNoteViewEditAndDelete]' passed (54.635 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (286.051 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (127.043 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (241.676 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (72.541 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (45.281 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (32.558 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (17.577 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNotNowAndHelp]' passed (68.273 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (8.111 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testRestoreFromTheWelcome]' passed (10.275 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipLeadsToAHelpfulToday]' passed (36.799 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' passed (49.751 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (7.304 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

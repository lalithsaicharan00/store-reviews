# app-lock-privacy-security-ci3 @ a1c29d8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37879477882 · 2026-10-09 04:19 UTC
Commit: Current Work 58: the snapshot's name stripping runs off the main actor (run 37874227531)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (OnboardingUITests,AnalyticsUITests,DayDetailsUITests,HabitPageUITests,PlacementUITests,CompletionFeedbackUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 0 failures (0 unexpected) in 1087.640 (1087.660) seconds
	 Executed 37 tests, with 0 failures (0 unexpected) in 2176.805 (2176.846) seconds
	 Executed 37 tests, with 0 failures (0 unexpected) in 2176.805 (2176.848) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 48.378 (48.381) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 192.004 (192.008) seconds
	 Executed 9 tests, with 0 failures (0 unexpected) in 833.704 (833.711) seconds
Test Case '-[HabitsUITests.AnalyticsUITests testDurableContentFreeTracking]' passed (17.091 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testFailedPersistenceNeverCounts]' passed (6.995 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testUsageConsentIsOptionalAndSeparate]' passed (13.088 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testWelcomeConsentIsOptional]' passed (11.204 seconds).
Test Case '-[HabitsUITests.CompletionFeedbackUITests testCompletionPlaysOnceWhenAHabitBecomesCompleteAndNeverForQuitOrLimits]' passed (8.517 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testCurrencyAndNoUnitAmounts]' passed (45.925 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (115.501 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen]' passed (317.958 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (121.982 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (126.360 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs]' passed (36.934 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete]' passed (47.857 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMarkADayDoneOnlyOnce]' passed (26.623 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testOlderMultiCheckLogStillCorrects]' passed (20.330 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testPastDayLogKeepsItsDayAndChosenTime]' passed (20.863 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipAddViewEditAndDelete]' passed (33.261 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (54.275 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' passed (58.707 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTickSteps]' passed (20.134 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit]' passed (40.930 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (47.947 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (38.801 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFoldByMonthLikeHistory]' passed (34.675 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNoteViewEditAndDelete]' passed (51.574 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (257.416 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDark]' passed (107.171 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesPeriodLimitQuit]' passed (206.050 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testSquaresKeyFoldedOnceIsFoldedEverywhere]' passed (55.589 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testYearInPixels]' passed (34.481 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (27.476 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (15.309 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNotNowAndHelp]' passed (56.902 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (6.495 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testRestoreFromTheWelcome]' passed (7.493 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipLeadsToAHelpfulToday]' passed (30.537 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' passed (47.791 seconds).
Test Case '-[HabitsUITests.PlacementUITests testPlacementRules]' passed (6.561 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# claude/repro-fast-nav-50 @ 64b6afe

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37405772056 · 2026-10-06 03:39 UTC
Commit: Habit form: a new habit's or task's dates are the app's today, not the calendar's (one added after midnight, before a 3 AM day start, stayed off Today until 3 AM; Current Work 52); -clock-hour for test launches and a test that runs it every time

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (OnboardingUITests,NewHabitUITests,TasksUITests,SectionHeaderUITests,SyncUITests,AnalyticsUITests,RemindersUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 20 tests, with 0 failures (0 unexpected) in 1280.802 (1280.828) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 158.656 (158.669) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 124.070 (124.074) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 52.361 (52.368) seconds
	 Executed 40 tests, with 1 failure (0 unexpected) in 1944.862 (1944.926) seconds
	 Executed 40 tests, with 1 failure (0 unexpected) in 1944.862 (1944.927) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 235.486 (235.492) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/SyncUITests.swift:79: error: -[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice] : Failed to get matching snapshots: Timed out while evaluating UI query.
Test Case '-[HabitsUITests.AnalyticsUITests testDurableContentFreeTracking]' passed (19.077 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testFailedPersistenceNeverCounts]' passed (11.863 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testUsageConsentIsOptionalAndSeparate]' passed (12.449 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testWelcomeConsentIsOptional]' passed (8.973 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAmountWithReminderRemoved]' passed (154.876 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testAnytimeNeverCombines]' passed (65.939 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCertainDaysReadAsARange]' passed (52.356 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testChecklist]' passed (62.940 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffInTwoTimesOfDay]' passed (129.812 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCheckOffThreeTimesAWeek]' passed (56.622 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCopyChecks]' passed (16.132 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testCustomUnit]' passed (54.124 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testDatesOfTheMonth]' passed (62.423 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testIconSheetClosesOnPick]' passed (37.530 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeAWeeklyTotal]' passed (48.880 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testLimitCanBeTimeAndStaysEditable]' passed (87.302 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testNewTimeOfDayFromTheForm]' passed (58.149 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testOneTimeTask]' passed (27.687 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testQuitDiscard]' passed (32.649 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testReadTwoChaptersAWeek]' passed (73.492 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRemindMeOffHidesTheRest]' passed (47.346 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testRunFiveMilesAndWalkTenThousandSteps]' passed (114.830 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTimeUnit]' passed (56.745 seconds).
Test Case '-[HabitsUITests.NewHabitUITests testTwoCertainDays]' passed (40.967 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (34.870 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (18.445 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNotNowAndHelp]' passed (70.870 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (8.686 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testRestoreFromTheWelcome]' passed (11.272 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipLeadsToAHelpfulToday]' passed (37.290 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' passed (54.052 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (19.357 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (55.762 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (18.448 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (30.503 seconds).
Test Case '-[HabitsUITests.SectionHeaderUITests testHeaders]' passed (30.779 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' failed (62.707 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (65.330 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (84.762 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (8.563 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

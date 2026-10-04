# claude/perf-bisect-v1 @ 2c42b97

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37176343759 · 2026-10-04 05:20 UTC
Commit: Checklists: Next Up 7, 8, 13 and 21 done (18's mental-model part), the row sheet and row layout checklists ticked, the merge recorded (the user's one-time decision; W3 stands)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (AnalyticsUITests,BackupUITests,FormWalkthroughUITests,OnboardingUITests,RemindersUITests,ScheduleUITests,SyncUITests,WidgetSystemUITests,WidgetUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 0 failures (0 unexpected) in 88.224 (88.227) seconds
	 Executed 2 tests, with 1 test skipped and 0 failures (0 unexpected) in 206.422 (206.425) seconds
	 Executed 38 tests, with 1 test skipped and 1 failure (0 unexpected) in 1169.840 (1169.885) seconds
	 Executed 38 tests, with 1 test skipped and 1 failure (0 unexpected) in 1169.840 (1169.886) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 63.923 (63.926) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 73.780 (73.783) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 164.551 (164.555) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 175.935 (175.944) seconds
	 Executed 6 tests, with 1 failure (0 unexpected) in 187.294 (187.300) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 176.181 (176.187) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ScheduleUITests.swift:43: error: -[HabitsUITests.ScheduleUITests testCalendarAndPersistenceRules] : XCTAssertEqual failed: ("Placement failed: Legacy aggregate checks count same-day repetitions") is not equal to ("Placement: all checks passed")
Test Case '-[HabitsUITests.AnalyticsUITests testDurableContentFreeTracking]' passed (34.234 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testFailedPersistenceNeverCounts]' passed (6.763 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testUsageConsentIsOptionalAndSeparate]' passed (12.799 seconds).
Test Case '-[HabitsUITests.AnalyticsUITests testWelcomeConsentIsOptional]' passed (10.127 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' passed (42.358 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (6.810 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (31.588 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (23.221 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (23.022 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (17.248 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (11.192 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (20.742 seconds).
Test Case '-[HabitsUITests.FormWalkthroughUITests testAmountPicksSeveralParts]' passed (38.817 seconds).
Test Case '-[HabitsUITests.FormWalkthroughUITests testCheckOffMorningAndEveningWithReminders]' passed (49.407 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (17.332 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNotNowAndHelp]' passed (65.078 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (7.162 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testRestoreFromTheWelcome]' passed (8.868 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipLeadsToAHelpfulToday]' passed (32.940 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testWelcomeToFirstHabit]' passed (44.555 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (12.350 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (28.607 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (12.322 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (20.501 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testCalendarAndPersistenceRules]' failed (7.443 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testEveryFewDaysAndWeeks]' passed (32.036 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testLargeTextHowOften]' passed (30.303 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testMonthDatesAndShortMonths]' passed (35.364 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testTaskAfterCompletion]' passed (27.182 seconds).
Test Case '-[HabitsUITests.ScheduleUITests testYearlyDateAndLeapDay]' passed (54.966 seconds).
Test Case '-[HabitsUITests.SyncUITests testChangesTravelBetweenThisPhoneAndAnotherDevice]' passed (33.531 seconds).
Test Case '-[HabitsUITests.WidgetSystemUITests testHomeScreenInstallTapAndColdPersistence]' passed (148.218 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (101.560 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (20.525 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (22.884 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (11.027 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (8.555 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

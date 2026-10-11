# claude/pensive-gates-3n4ie8-ci4 @ e67883a

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38179747065 · 2026-10-11 22:51 UTC
Commit: Merge main (the Apple Watch app, Google Drive sync in the core, docs) into the iPad build

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ArrangeUITests,OnboardingUITests,RemindersUITests,TasksUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 357.273 (357.278) seconds
	 Executed 22 tests, with 0 failures (0 unexpected) in 869.486 (869.565) seconds
	 Executed 22 tests, with 0 failures (0 unexpected) in 869.486 (869.568) seconds
	 Executed 3 tests, with 0 failures (0 unexpected) in 127.836 (127.838) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 81.577 (81.580) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 302.801 (302.867) seconds
Test Case '-[HabitsUITests.ArrangeUITests testAddTimeOfDay]' passed (63.324 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testArrangeChecks]' passed (48.504 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testEditArrangesTheDay]' passed (127.713 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testGroupRowBeforeAnyGroup]' passed (28.211 seconds).
Test Case '-[HabitsUITests.ArrangeUITests testHideCompleted]' passed (35.049 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (59.488 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' passed (19.941 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (37.985 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHabitsComeBackFromICloud]' passed (16.868 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' passed (69.278 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (25.818 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' passed (62.852 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (7.374 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' passed (23.167 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (34.501 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (11.928 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' passed (36.454 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (14.448 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (18.747 seconds).
Test Case '-[HabitsUITests.TasksUITests testCreateTaskFromTasksAndEditSurvivesRelaunch]' passed (47.900 seconds).
Test Case '-[HabitsUITests.TasksUITests testEveryTaskAppearsAndCanOpenEdit]' passed (72.608 seconds).
Test Case '-[HabitsUITests.TasksUITests testTaskModelAndPersistence]' passed (7.327 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

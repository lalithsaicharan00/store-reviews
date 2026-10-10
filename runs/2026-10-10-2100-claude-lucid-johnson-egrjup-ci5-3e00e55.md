# claude/lucid-johnson-egrjup-ci5 @ 3e00e55

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38083499890 · 2026-10-10 21:00 UTC
Commit: iCloud sync: Design Rules' iCloud page, What's Built, and what's left for the user in item 81

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetUITests,TimerUITests,RemindersUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 1 failure (0 unexpected) in 632.747 (632.763) seconds
	 Executed 15 tests, with 1 failure (0 unexpected) in 632.747 (632.765) seconds
	 Executed 4 tests, with 1 failure (0 unexpected) in 164.656 (164.661) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 141.864 (141.868) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 326.227 (326.232) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RemindersUITests.swift:13: error: -[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges] : XCTAssertTrue failed - Attributes: Application, 0x10603c280, pid: 32650, label: 'Often Enough'
Test Case '-[HabitsUITests.RemindersUITests testDeniedPermissionOffersSettingsAndEmptyState]' passed (24.725 seconds).
Test Case '-[HabitsUITests.RemindersUITests testPlanningActionsPermissionsFailuresAndClockChanges]' failed (98.583 seconds).
Test Case '-[HabitsUITests.RemindersUITests testRealEmptyPageHasNoUnexpectedAlarmErrorOrPermissionPrompt]' passed (17.682 seconds).
Test Case '-[HabitsUITests.RemindersUITests testSavedRemindersOpenEditableTaskWithoutPermissionPrompt]' passed (23.666 seconds).
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (28.598 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (35.254 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (35.905 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (18.621 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (23.485 seconds).
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' passed (197.309 seconds).
Test Case '-[HabitsUITests.WidgetUITests testGuideAndPrivacyAreFree]' passed (39.168 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLargerTextCountersAndCutDownAreReadable]' passed (38.064 seconds).
Test Case '-[HabitsUITests.WidgetUITests testLongNamesAndUnitsKeepQuickActionVisible]' passed (20.673 seconds).
Test Case '-[HabitsUITests.WidgetUITests testReliabilityUnderBurstsRetriesAndRollover]' passed (21.115 seconds).
Test Case '-[HabitsUITests.WidgetUITests testStorageActionsDayBoundariesPrivacyAndUnlimitedTasks]' passed (9.898 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

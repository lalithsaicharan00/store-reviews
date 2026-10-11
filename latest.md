# apple-watch-ci3 @ c10a427

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38127636567 · 2026-10-11 10:32 UTC
Commit: Apple Watch: final round with iCloud on the Watch (scratch branch run)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ICloudUITests,DayDetailsUITests,WidgetUITests,ProgressUITests,HabitPageUITests,BackupUITests): cancelled
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 0 failures (0 unexpected) in 1004.327 (1004.340) seconds
	 Executed 7 tests, with 0 failures (0 unexpected) in 210.630 (210.637) seconds
Test Case '-[HabitsUITests.BackupUITests testBackupFilesInICloud]' passed (103.481 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (6.913 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverything]' passed (21.996 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (28.973 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreListsICloudAndAFile]' passed (14.985 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreSaysThisIPhone]' passed (21.463 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheICloudPageFromAnEmptyToday]' passed (12.819 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testCurrencyAndNoUnitAmounts]' passed (39.799 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (77.884 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen]' passed (274.664 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (122.270 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (134.074 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs]' passed (40.524 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete]' passed (46.453 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMarkADayDoneOnlyOnce]' passed (27.383 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testOlderMultiCheckLogStillCorrects]' passed (27.262 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testPastDayLogKeepsItsDayAndChosenTime]' passed (32.283 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipAddViewEditAndDelete]' passed (36.924 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (37.961 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' passed (53.551 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTickSteps]' passed (16.409 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit]' passed (36.888 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testHistoryFlows]' passed (42.918 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testMilestonesNoneOneMany]' passed (102.154 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFlows]' passed (38.482 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNotesFoldByMonthLikeHistory]' passed (35.389 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testNoteViewEditAndDelete]' passed (48.581 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testOverallRecordBoxes]' passed (21.978 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPeriodCardSpacing]' passed (172.079 seconds).
Test Case '-[HabitsUITests.HabitPageUITests testPicturesDailyTypes]' passed (275.400 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# day-details-logs-notes-redesign-ci-c @ 6d228b6

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37615472311 · 2026-10-07 12:09 UTC
Commit: Day details fits the iPhone SE: spacing from the window's height, 44-pt rows, the designed first gap

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (FocusPlayerUITests/testFastNavigationNeverSlidesBack,DayDetailsUITests,UndoUITests/testEditAndDeleteOneEntryInDaySheet): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 0 failures (0 unexpected) in 973.448 (973.465) seconds
	 Executed 17 tests, with 0 failures (0 unexpected) in 1048.941 (1048.961) seconds
	 Executed 17 tests, with 0 failures (0 unexpected) in 1048.941 (1048.965) seconds
Test Case '-[HabitsUITests.DayDetailsUITests testCurrencyAndNoUnitAmounts]' passed (69.396 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (88.550 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen]' passed (252.518 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (101.536 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (128.309 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs]' passed (35.857 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete]' passed (42.101 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMarkADayDoneOnlyOnce]' passed (27.206 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testOlderMultiCheckLogStillCorrects]' passed (24.318 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testPastDayLogKeepsItsDayAndChosenTime]' passed (21.587 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipAddViewEditAndDelete]' passed (32.197 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (36.283 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' passed (57.658 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTickSteps]' passed (18.063 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit]' passed (37.868 seconds).
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack]' passed (32.840 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (42.652 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

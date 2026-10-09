# claude/exciting-mccarthy-g6vlu5-ci2 @ 89807fb

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37892535525 · 2026-10-09 06:51 UTC
Commit: Notes: the keyboard is asked for until iOS shows it (focus off and on), not trusted to one request or the focus state

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (DayDetailsUITests,TodayRowSheetUITests,TodayRowLayoutUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 0 failures (0 unexpected) in 1066.851 (1066.865) seconds
	 Executed 25 tests, with 0 failures (0 unexpected) in 1344.093 (1344.116) seconds
	 Executed 25 tests, with 0 failures (0 unexpected) in 1344.093 (1344.117) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 86.530 (86.533) seconds
	 Executed 6 tests, with 0 failures (0 unexpected) in 190.712 (190.716) seconds
Test Case '-[HabitsUITests.DayDetailsUITests testCurrencyAndNoUnitAmounts]' passed (42.597 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindDark]' passed (96.080 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindsAddScreen]' passed (349.096 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testEveryKindShowsItsOwnDay]' passed (127.569 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testHistoryDaysOpenDayDetails]' passed (137.961 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogsRuleAndAllLogs]' passed (36.750 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testLogViewThenEditThenDelete]' passed (44.275 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testMarkADayDoneOnlyOnce]' passed (25.881 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testOlderMultiCheckLogStillCorrects]' passed (23.140 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testPastDayLogKeepsItsDayAndChosenTime]' passed (24.671 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testQuitSlipAddViewEditAndDelete]' passed (31.872 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testSkippedDayKeepsLogsAndNote]' passed (33.473 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTasksReschedule]' passed (43.786 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTickSteps]' passed (16.512 seconds).
Test Case '-[HabitsUITests.DayDetailsUITests testTimeLogAddViewAndEdit]' passed (33.190 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testAfterLogButtonsAndNoteSheet]' passed (25.875 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testOneLineUnderEveryName]' passed (9.109 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testQuitRowSwipeLogsASlip]' passed (16.665 seconds).
Test Case '-[HabitsUITests.TodayRowLayoutUITests testTaskRowOpensItsSheet]' passed (34.881 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testLongPressMenu]' passed (19.532 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testRowOpensDaySheetForEveryKind]' passed (38.156 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetActionsAndDeleteInTheMenu]' passed (36.001 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSheetFollowsTheDayShown]' passed (23.758 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testSwipeActions]' passed (34.690 seconds).
Test Case '-[HabitsUITests.TodayRowSheetUITests testTickTogglesAndPlusAdds]' passed (38.575 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

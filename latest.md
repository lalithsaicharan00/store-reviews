# claude/pensive-gates-3n4ie8-ci13 @ 548aa01

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38165605061 · 2026-10-11 19:43 UTC
Commit: Current Work 86: a page beside the sidebar covers Today as the routine player does: Today stays alive and draws nothing

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (IPadUITests,WidgetUITests/testExtraLargeTodayOnTheIPad): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 1 failure (0 unexpected) in 907.945 (907.987) seconds
	 Executed 16 tests, with 1 failure (0 unexpected) in 960.424 (960.472) seconds
	 Executed 16 tests, with 1 failure (0 unexpected) in 960.424 (960.473) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:96: error: -[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar] : Failed to tap "sidebar-button" Any: No matches found for first query match sequence: `Descendants matching type Any` -> `Elements matching predicate '"sidebar-button" IN identifiers'`, given input App element pid: 62903
Test Case '-[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps]' passed (94.600 seconds).
Test Case '-[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen]' passed (39.765 seconds).
Test Case '-[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands]' passed (89.036 seconds).
Test Case '-[HabitsUITests.IPadUITests testDayDetailsPopoverLogsAndAllLogs]' passed (64.717 seconds).
Test Case '-[HabitsUITests.IPadUITests testHabitsListAndPageSideBySide]' passed (79.273 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp]' passed (41.348 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount]' passed (89.799 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusEndedIsAFormSheet]' passed (20.436 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusOnTheIPad]' passed (43.485 seconds).
Test Case '-[HabitsUITests.IPadUITests testProgressTwoAcrossWithRangeAtTheTop]' passed (37.796 seconds).
Test Case '-[HabitsUITests.IPadUITests testSecondDeviceSheetOnTheIPad]' passed (34.870 seconds).
Test Case '-[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar]' failed (129.318 seconds).
Test Case '-[HabitsUITests.IPadUITests testSheetsAndPopovers]' passed (44.214 seconds).
Test Case '-[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl]' passed (85.039 seconds).
Test Case '-[HabitsUITests.IPadUITests testWelcomeAndEmptyToday]' passed (14.246 seconds).
Test Case '-[HabitsUITests.WidgetUITests testExtraLargeTodayOnTheIPad]' passed (52.479 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

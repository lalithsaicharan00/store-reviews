# claude/pensive-gates-3n4ie8-ci2 @ 548aa01

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38165603132 · 2026-10-11 19:28 UTC
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
	 Executed 15 tests, with 1 failure (0 unexpected) in 778.551 (778.601) seconds
	 Executed 16 tests, with 1 failure (0 unexpected) in 824.858 (824.920) seconds
	 Executed 16 tests, with 1 failure (0 unexpected) in 824.858 (824.922) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:96: error: -[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar] : Failed to tap "sidebar-button" Any: No matches found for first query match sequence: `Descendants matching type Any` -> `Elements matching predicate '"sidebar-button" IN identifiers'`, given input App element pid: 55407
Test Case '-[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps]' passed (90.407 seconds).
Test Case '-[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen]' passed (42.353 seconds).
Test Case '-[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands]' passed (92.703 seconds).
Test Case '-[HabitsUITests.IPadUITests testDayDetailsPopoverLogsAndAllLogs]' passed (52.178 seconds).
Test Case '-[HabitsUITests.IPadUITests testHabitsListAndPageSideBySide]' passed (38.357 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp]' passed (31.528 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount]' passed (86.176 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusEndedIsAFormSheet]' passed (20.924 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusOnTheIPad]' passed (36.985 seconds).
Test Case '-[HabitsUITests.IPadUITests testProgressTwoAcrossWithRangeAtTheTop]' passed (32.352 seconds).
Test Case '-[HabitsUITests.IPadUITests testSecondDeviceSheetOnTheIPad]' passed (30.175 seconds).
Test Case '-[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar]' failed (98.471 seconds).
Test Case '-[HabitsUITests.IPadUITests testSheetsAndPopovers]' passed (37.015 seconds).
Test Case '-[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl]' passed (75.478 seconds).
Test Case '-[HabitsUITests.IPadUITests testWelcomeAndEmptyToday]' passed (13.450 seconds).
Test Case '-[HabitsUITests.WidgetUITests testExtraLargeTodayOnTheIPad]' passed (46.307 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

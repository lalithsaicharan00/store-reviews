# claude/pensive-gates-3n4ie8-ci2 @ cb035ab

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38156983870 · 2026-10-11 17:24 UTC
Commit: Current Work 86: the iPad's Home Screen widget test leaves the Home Screen as it found it, and lets the gallery settle between pages

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (IPadUITests,WidgetUITests/testExtraLargeTodayOnTheIPad): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 1 failure (0 unexpected) in 815.002 (815.036) seconds
	 Executed 16 tests, with 1 failure (0 unexpected) in 857.987 (858.033) seconds
	 Executed 16 tests, with 1 failure (0 unexpected) in 857.987 (858.036) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:335: error: -[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar] : Failed to not hittable: Button, {{400.0, 584.5}, {631.0, 37.5}}, label: 'Morning, Starts 6 AM, All done'
Test Case '-[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps]' passed (127.872 seconds).
Test Case '-[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen]' passed (27.776 seconds).
Test Case '-[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands]' passed (71.866 seconds).
Test Case '-[HabitsUITests.IPadUITests testDayDetailsPopoverLogsAndAllLogs]' passed (64.216 seconds).
Test Case '-[HabitsUITests.IPadUITests testHabitsListAndPageSideBySide]' passed (44.053 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp]' passed (44.879 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount]' passed (85.441 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusEndedIsAFormSheet]' passed (19.351 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusOnTheIPad]' passed (34.621 seconds).
Test Case '-[HabitsUITests.IPadUITests testProgressTwoAcrossWithRangeAtTheTop]' passed (34.087 seconds).
Test Case '-[HabitsUITests.IPadUITests testSecondDeviceSheetOnTheIPad]' passed (31.482 seconds).
Test Case '-[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar]' failed (109.056 seconds).
Test Case '-[HabitsUITests.IPadUITests testSheetsAndPopovers]' passed (38.963 seconds).
Test Case '-[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl]' passed (69.692 seconds).
Test Case '-[HabitsUITests.IPadUITests testWelcomeAndEmptyToday]' passed (11.647 seconds).
Test Case '-[HabitsUITests.WidgetUITests testExtraLargeTodayOnTheIPad]' passed (42.985 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

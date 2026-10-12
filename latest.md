# claude/shared-habit-rules-ci10 @ b122a95

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38225691543 · 2026-10-12 11:10 UTC
Commit: Current Work 92 (checkpoint 2): a log made before the shared rules' copy is built isn't lost

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (IPadUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 1 failure (0 unexpected) in 732.503 (732.525) seconds
	 Executed 15 tests, with 1 failure (0 unexpected) in 732.503 (732.527) seconds
	 Executed 15 tests, with 1 failure (0 unexpected) in 732.503 (732.528) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:213: error: -[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps] : XCTAssertTrue failed - Add log keeps ✕: Often Enough | pad-sidebar | sidebar-hide | Hide Sidebar | menu-today | Today, 9 left | sun.max | Brightness Higher | Today | sidebar-today-left | 9 left | menu-progress | Progress | chart.bar.xaxis | menu-habits | Habits, 17 | checklist | Habits | 17 | menu-tasks | Tasks, 0 | list.bullet | List | Tasks | 0 | menu-timesOfDay | Times of Day | rectangle.split.3x1 | Column View | Vertical scroll bar, 3 pages | _TtGC7SwiftUI29PresentationHosting | chevron.left | Previous day | Today, 6 of 15 done. Open calendar | chevron.down | Go Down | 6/15 | chevron.right | Next day | arrange-button | Edit | filter-button | Filter | New Habit |   | Quit or Cut Down, 2 habits | Quit or Cut Down | Fold Quit or Cut Down | nosign | Stop | Smoking | habit-line | Best 45 days | 12d 11:23:30 | wineglass | Alcohol | Best 47 days | 47d 00:00:30 | Anytime, 2 left | Anytime
Test Case '-[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps]' failed (100.676 seconds).
Test Case '-[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen]' passed (31.865 seconds).
Test Case '-[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands]' passed (67.512 seconds).
Test Case '-[HabitsUITests.IPadUITests testDayDetailsPopoverLogsAndAllLogs]' passed (47.196 seconds).
Test Case '-[HabitsUITests.IPadUITests testHabitsListAndPageSideBySide]' passed (37.926 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp]' passed (38.122 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount]' passed (86.100 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusEndedIsAFormSheet]' passed (21.021 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusOnTheIPad]' passed (33.425 seconds).
Test Case '-[HabitsUITests.IPadUITests testProgressTwoAcrossWithRangeAtTheTop]' passed (28.001 seconds).
Test Case '-[HabitsUITests.IPadUITests testSecondDeviceSheetOnTheIPad]' passed (24.334 seconds).
Test Case '-[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar]' passed (95.006 seconds).
Test Case '-[HabitsUITests.IPadUITests testSheetsAndPopovers]' passed (33.528 seconds).
Test Case '-[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl]' passed (74.264 seconds).
Test Case '-[HabitsUITests.IPadUITests testWelcomeAndEmptyToday]' passed (13.526 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

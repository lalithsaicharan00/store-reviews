# claude/shared-habit-rules-ci35 @ fc19872

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38318013179 · 2026-10-13 00:32 UTC
Commit: Current Work 92 (checkpoint 2): the shared rules are given habits and settings again only when one they read changed; history asks once a month

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (IPadUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 2 failures (0 unexpected) in 892.194 (892.218) seconds
	 Executed 15 tests, with 2 failures (0 unexpected) in 892.194 (892.221) seconds
	 Executed 15 tests, with 2 failures (0 unexpected) in 892.194 (892.225) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:389: error: -[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen] : XCTAssertTrue failed - Timer: Often Enough | pad-sidebar | sidebar-hide | Hide Sidebar | menu-today | Today, 9 left | sun.max | Brightness Higher | Today | sidebar-today-left | 9 left | menu-progress | Progress | chart.bar.xaxis | menu-habits | Habits, 17 | checklist | Habits | 17 | menu-tasks | Tasks, 0 | list.bullet | List | Tasks | 0 | menu-timesOfDay | Times of Day | rectangle.split.3x1 | Column View | menu-dayAndWeek | Day and Week | calendar | Calendar | menu-reminders | Reminders | bell | Notifications | menu-appearance | Appearance | circle.lefthalf.filled | menu-backup | iCloud & Backup | icloud | Icloud | menu-privacy | Privacy & Security | hand.raised | Block | menu-plus | Plus | plus.circle | Add | Vertical scroll bar, 2 pages | _TtGC7SwiftUI32NavigationStackHosting | chevron.left | Previous day | Today, 6 of 15 done. Open calendar | chevron.down | Go Down | 6/15
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:390: error: -[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen] : Failed to get matching snapshot: No matches found for first query match sequence: `Descendants matching type Any` -> `Elements matching predicate '"timer-screen" IN identifiers'`, given input App element pid: 62464
Test Case '-[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps]' passed (89.101 seconds).
Test Case '-[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen]' failed (133.827 seconds).
Test Case '-[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands]' passed (80.431 seconds).
Test Case '-[HabitsUITests.IPadUITests testDayDetailsPopoverLogsAndAllLogs]' passed (46.763 seconds).
Test Case '-[HabitsUITests.IPadUITests testHabitsListAndPageSideBySide]' passed (40.998 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp]' passed (34.566 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount]' passed (96.245 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusEndedIsAFormSheet]' passed (29.442 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusOnTheIPad]' passed (47.474 seconds).
Test Case '-[HabitsUITests.IPadUITests testProgressTwoAcrossWithRangeAtTheTop]' passed (32.604 seconds).
Test Case '-[HabitsUITests.IPadUITests testSecondDeviceSheetOnTheIPad]' passed (30.542 seconds).
Test Case '-[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar]' passed (106.298 seconds).
Test Case '-[HabitsUITests.IPadUITests testSheetsAndPopovers]' passed (31.169 seconds).
Test Case '-[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl]' passed (81.063 seconds).
Test Case '-[HabitsUITests.IPadUITests testWelcomeAndEmptyToday]' passed (11.672 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

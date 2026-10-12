# claude/shared-habit-rules-ci25 @ 7087be7

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38261616733 · 2026-10-12 16:13 UTC
Commit: Merge remote-tracking branch 'origin/main' into claude/shared-habit-rules-switch

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (IPadUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 15 tests, with 3 failures (0 unexpected) in 988.349 (988.382) seconds
	 Executed 15 tests, with 3 failures (0 unexpected) in 988.349 (988.384) seconds
	 Executed 15 tests, with 3 failures (0 unexpected) in 988.349 (988.390) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:262: error: -[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp] : XCTAssertTrue failed - Narrow: the iPhone's sheet with ✕: Often Enough | _TtGC7SwiftUI32NavigationStackHosting | sidebar-button | Show Sidebar | arrange-button | Edit | filter-button | Filter | New Habit | AdditionalDimmingOverlay | Quit or Cut Down, 2 habits | Quit or Cut Down | chevron.right | Fold Quit or Cut Down | nosign | Stop | Smoking | habit-line | Best 45 days | 12d 11:25:04 | wineglass | Alcohol | Best 47 days | 47d 00:02:04 | Anytime, 2 left | Anytime | 2 left | start-Anytime | Start Anytime routine | play.fill | Play | Start | Fold Anytime | book.fill | Bookmark | Read | 12 min/20 min | Streak: Done 6 days in a row | 🔥 | 6 | Start Read timer | phone.fill | Call | Call family | 1/3 this week | Streak: Goal met 4 weeks in a row | 4 wk | checkmark | Add 1 to Call family | drop.fill | Water Drop | Water | 8/8 glasses | Streak: Done 23 days in a row | 23 | Add 1 glass to Water | Morning, Starts 6 AM, All done | Morning | Starts 6 AM | figure.flexibility
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:264: error: -[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp] : Failed to tap "day-close" Button: No matches found for Elements matching predicate '"day-close" IN identifiers' from input {(
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/IPadUITests.swift:87: error: -[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp] : XCTAssertTrue failed - Water opens Day details: Often Enough | _TtGC7SwiftUI32NavigationStackHosting | sidebar-button | Show Sidebar | arrange-button | Edit | filter-button | Filter | New Habit | AdditionalDimmingOverlay | Quit or Cut Down, 2 habits | Quit or Cut Down | chevron.right | Fold Quit or Cut Down | nosign | Stop | Smoking | habit-line | Best 45 days | 12d 11:24:58 | wineglass | Alcohol | Best 47 days | 47d 00:01:58 | Anytime, 2 left | Anytime | 2 left | start-Anytime | Start Anytime routine | play.fill | Play | Start | Fold Anytime | book.fill | Bookmark | Read | 12 min/20 min | Streak: Done 6 days in a row | 🔥 | 6 | Start Read timer | phone.fill | Call | Call family | 1/3 this week | Streak: Goal met 4 weeks in a row | 4 wk | checkmark | Add 1 to Call family | drop.fill | Water Drop | Water | 8/8 glasses | Streak: Done 23 days in a row | 23 | Add 1 glass to Water | Morning, Starts 6 AM, All done | Morning | Starts 6 AM | figure.flexibility
Test Case '-[HabitsUITests.IPadUITests testAddLogInsidePopoverSurvivesRotationAndOutsideTaps]' passed (134.395 seconds).
Test Case '-[HabitsUITests.IPadUITests testArrangeTimerAndPlayerFullScreen]' passed (47.508 seconds).
Test Case '-[HabitsUITests.IPadUITests testColumnsViewAndKeyboardCommands]' passed (85.839 seconds).
Test Case '-[HabitsUITests.IPadUITests testDayDetailsPopoverLogsAndAllLogs]' passed (77.344 seconds).
Test Case '-[HabitsUITests.IPadUITests testHabitsListAndPageSideBySide]' passed (58.213 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowIsTheIPhoneApp]' failed (143.011 seconds).
Test Case '-[HabitsUITests.IPadUITests testNarrowWindowMidEditKeepsTheTypedAmount]' passed (85.940 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusEndedIsAFormSheet]' passed (17.657 seconds).
Test Case '-[HabitsUITests.IPadUITests testPlusOnTheIPad]' passed (39.682 seconds).
Test Case '-[HabitsUITests.IPadUITests testProgressTwoAcrossWithRangeAtTheTop]' passed (30.249 seconds).
Test Case '-[HabitsUITests.IPadUITests testSecondDeviceSheetOnTheIPad]' passed (39.543 seconds).
Test Case '-[HabitsUITests.IPadUITests testSettingsPagesBesideTheSidebar]' passed (109.086 seconds).
Test Case '-[HabitsUITests.IPadUITests testSheetsAndPopovers]' passed (31.730 seconds).
Test Case '-[HabitsUITests.IPadUITests testSidebarTodayColumnAndDayControl]' passed (73.987 seconds).
Test Case '-[HabitsUITests.IPadUITests testWelcomeAndEmptyToday]' passed (14.165 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

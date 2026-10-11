# claude/pensive-gates-3n4ie8-ci3 @ e67883a

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38176813300 · 2026-10-11 22:02 UTC
Commit: Merge main (the Apple Watch app, Google Drive sync in the core, docs) into the iPad build

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TodayUITests,UndoUITests,TimerUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 21 tests, with 0 failures (0 unexpected) in 558.227 (558.243) seconds
	 Executed 21 tests, with 0 failures (0 unexpected) in 558.227 (558.246) seconds
	 Executed 5 tests, with 0 failures (0 unexpected) in 123.034 (123.039) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 181.965 (181.969) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 253.228 (253.234) seconds
Test Case '-[HabitsUITests.TimerUITests testLiveActivityWhileRunning]' passed (35.142 seconds).
Test Case '-[HabitsUITests.TimerUITests testPlayOpensTimerScreenThatClosesWithoutStopping]' passed (29.817 seconds).
Test Case '-[HabitsUITests.TimerUITests testRowTicksBarShowsWhenOutOfSightAndStopKeepsTime]' passed (27.704 seconds).
Test Case '-[HabitsUITests.TimerUITests testScreenCanBeTurnedOff]' passed (11.464 seconds).
Test Case '-[HabitsUITests.TimerUITests testTimerScreenPauseKeepsTimeAndResumes]' passed (18.907 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (19.867 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (40.223 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (16.668 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (21.144 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (11.253 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (103.327 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (11.819 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (28.925 seconds).
Test Case '-[HabitsUITests.UndoUITests testDayControlsAndCalendarOpeningAreExplicit]' passed (27.535 seconds).
Test Case '-[HabitsUITests.UndoUITests testEditAndDeleteOneEntryInDaySheet]' passed (39.317 seconds).
Test Case '-[HabitsUITests.UndoUITests testInlineUndoSurvivesAndIsExact]' passed (25.582 seconds).
Test Case '-[HabitsUITests.UndoUITests testLogManuallyAddsOneLog]' passed (23.673 seconds).
Test Case '-[HabitsUITests.UndoUITests testRoutineUndoStaysVisibleAndLeavesEarlierLogsIntact]' passed (17.628 seconds).
Test Case '-[HabitsUITests.UndoUITests testSkipFromTodayKeepsHistoryOpenAndCanBeUndone]' passed (13.840 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoppingTimerKeepsDaySheetOpenAndSecondsCanBeEdited]' passed (23.416 seconds).
Test Case '-[HabitsUITests.UndoUITests testStoreCorrectionsRecalculateAndPersist]' passed (10.975 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

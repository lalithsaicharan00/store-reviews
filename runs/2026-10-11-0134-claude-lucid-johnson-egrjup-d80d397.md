# claude/lucid-johnson-egrjup @ d80d397

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38099883963 · 2026-10-11 01:34 UTC
Commit: Widgets faster: week and month totals from the per-day index; the widget lock opened for speed work; App Lock's SE test scrolls to App Passcode

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (AppLockUITests): success
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 21 tests, with 0 failures (0 unexpected) in 1189.139 (1189.155) seconds
	 Executed 21 tests, with 0 failures (0 unexpected) in 1189.139 (1189.156) seconds
	 Executed 21 tests, with 0 failures (0 unexpected) in 1189.139 (1189.158) seconds
Test Case '-[HabitsUITests.AppLockUITests testALinkOpensBehindTheCoverAndShowsAfterUnlock]' passed (34.884 seconds).
Test Case '-[HabitsUITests.AppLockUITests testAppPasscodeWayAndItsReset]' passed (146.360 seconds).
Test Case '-[HabitsUITests.AppLockUITests testAskAgainImmediatelyAndAfterAMinute]' passed (49.896 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancelLeavesUnlockAndTypedTextIsKept]' passed (38.739 seconds).
Test Case '-[HabitsUITests.AppLockUITests testCancellingSetUpAtEachStepChangesNothing]' passed (70.259 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDChangedAsksForTheCodeAndThenAsks]' passed (127.546 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDLockedOutIsNotTurnedOff]' passed (50.848 seconds).
Test Case '-[HabitsUITests.AppLockUITests testFaceIDOffForTheApp]' passed (98.139 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeTwentyFourHourReset]' passed (76.883 seconds).
Test Case '-[HabitsUITests.AppLockUITests testForgotCodeWithFaceID]' passed (30.174 seconds).
Test Case '-[HabitsUITests.AppLockUITests testIPhonePasscodeTurnedOff]' passed (36.493 seconds).
Test Case '-[HabitsUITests.AppLockUITests testIPhonePasscodeWay]' passed (55.154 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockOnAndOffAndHideNamesFollows]' passed (105.161 seconds).
Test Case '-[HabitsUITests.AppLockUITests testLockRulesAndHiddenNamesEverywhere]' passed (6.887 seconds).
Test Case '-[HabitsUITests.AppLockUITests testNoFaceIDOnThisIPhone]' passed (33.661 seconds).
Test Case '-[HabitsUITests.AppLockUITests testNoPasscodeUsesTheAppPasscodeAlone]' passed (39.489 seconds).
Test Case '-[HabitsUITests.AppLockUITests testOlderLockUpgrades]' passed (41.190 seconds).
Test Case '-[HabitsUITests.AppLockUITests testReminderSaysIsSavedWithTheHabit]' passed (38.159 seconds).
Test Case '-[HabitsUITests.AppLockUITests testSwitchingWays]' passed (60.642 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWidgetChooseLinkOpensHelp]' passed (13.708 seconds).
Test Case '-[HabitsUITests.AppLockUITests testWrongCodesWaitThenTheRightCodeOpens]' passed (34.868 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

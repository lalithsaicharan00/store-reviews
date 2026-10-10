# claude/awesome-newton-pmu4y7 @ 966b1a6

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38063952336 · 2026-10-10 16:16 UTC
Commit: Plus screens with StoreKit 2 (Current Work 80): the 6th-habit sheet, Make Room, the Plus page, Your Plus, the upgrade, Plus is yours, Plus has ended, the second-device sheet

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (PlusUITests,TodayUITests,PersistenceUITests,OnboardingUITests,BackupUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 10 tests, with 0 failures (0 unexpected) in 371.770 (371.785) seconds
	 Executed 12 tests, with 0 failures (0 unexpected) in 492.717 (493.036) seconds
	 Executed 4 tests, with 0 failures (0 unexpected) in 128.929 (128.932) seconds
	 Executed 42 tests, with 1 failure (0 unexpected) in 1492.447 (1492.803) seconds
	 Executed 42 tests, with 1 failure (0 unexpected) in 1492.447 (1492.805) seconds
	 Executed 8 tests, with 0 failures (0 unexpected) in 264.655 (264.660) seconds
	 Executed 8 tests, with 1 failure (0 unexpected) in 234.376 (234.385) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/PlusUITests.swift:25: error: -[HabitsUITests.PlusUITests testPlusEndedIsToldOnce] : XCTAssertTrue failed - Today
Test Case '-[HabitsUITests.BackupUITests testAccountInTheMenuAndMovingToAnotherDevice]' passed (88.921 seconds).
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountSyncsOnOneDevice]' passed (122.950 seconds).
Test Case '-[HabitsUITests.BackupUITests testBackupIntegrityChecks]' passed (10.209 seconds).
Test Case '-[HabitsUITests.BackupUITests testDeletingTheAccountAndErasingThisPhone]' passed (47.069 seconds).
Test Case '-[HabitsUITests.BackupUITests testErasingEverythingWithoutAnAccount]' passed (22.662 seconds).
Test Case '-[HabitsUITests.BackupUITests testExportAndBackupOpenNativeShareSheet]' passed (30.824 seconds).
Test Case '-[HabitsUITests.BackupUITests testFreeBackupPageAndReinstallWarning]' passed (10.695 seconds).
Test Case '-[HabitsUITests.BackupUITests testICloudWithoutAnAccount]' passed (55.358 seconds).
Test Case '-[HabitsUITests.BackupUITests testPlusBackupAccountAndRestoreSayAllDevices]' passed (43.572 seconds).
Test Case '-[HabitsUITests.BackupUITests testRestoreWithoutAnAccountSaysThisIPhone]' passed (23.014 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (16.022 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (21.421 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testCreateMyOwnHabitIsTheUsualNewFlow]' passed (50.310 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testDataOnThisDeviceComesFirst]' passed (17.689 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testFirstHabitAfterMidnightBeforeTheDayStartShowsOnToday]' passed (36.148 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testHelpAndTheWelcomeAgain]' passed (61.037 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testLargestTextReachesContinue]' passed (25.506 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testMoveFromAnotherDeviceThroughTheServer]' passed (38.525 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNewPersonToFirstHabit]' passed (54.807 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testNoWelcomeInOtherRuns]' passed (6.686 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testReturningWaysBack]' passed (47.550 seconds).
Test Case '-[HabitsUITests.OnboardingUITests testSkipSetupLeadsToAHelpfulToday]' passed (33.511 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testFailedWriteIsTakenBack]' passed (31.691 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testHabitAndTickSurviveRelaunch]' passed (43.523 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testQuickTapsSurviveLeavingTheApp]' passed (42.386 seconds).
Test Case '-[HabitsUITests.PersistenceUITests testUnopenableDatabaseSaysSoAndTakesNoChanges]' passed (11.330 seconds).
Test Case '-[HabitsUITests.PlusUITests testAskToBuyShowsWaiting]' passed (16.399 seconds).
Test Case '-[HabitsUITests.PlusUITests testBuyingPlusSavesTheSixthHabit]' passed (31.391 seconds).
Test Case '-[HabitsUITests.PlusUITests testMakeRoomArchivesOneAndGoesAhead]' passed (28.741 seconds).
Test Case '-[HabitsUITests.PlusUITests testOwnerUpgradesAndFamilyMemberPage]' passed (32.943 seconds).
Test Case '-[HabitsUITests.PlusUITests testPlusEndedIsToldOnce]' failed (43.987 seconds).
Test Case '-[HabitsUITests.PlusUITests testPlusPageAndRestoreWithNothingFound]' passed (20.530 seconds).
Test Case '-[HabitsUITests.PlusUITests testPricesThatFailShowTryAgain]' passed (31.837 seconds).
Test Case '-[HabitsUITests.PlusUITests testSixthHabitSheetOffersBothPlansAndNoNotNow]' passed (28.547 seconds).
Test Case '-[HabitsUITests.TodayUITests testBackToToday]' passed (18.814 seconds).
Test Case '-[HabitsUITests.TodayUITests testDayWeekAndAppearance]' passed (38.787 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowStaysInPlace]' passed (19.605 seconds).
Test Case '-[HabitsUITests.TodayUITests testDoneRowWaitsForThePause]' passed (22.767 seconds).
Test Case '-[HabitsUITests.TodayUITests testFoldAndOpen]' passed (11.804 seconds).
Test Case '-[HabitsUITests.TodayUITests testMenu]' passed (105.315 seconds).
Test Case '-[HabitsUITests.TodayUITests testSettingsChecks]' passed (12.256 seconds).
Test Case '-[HabitsUITests.TodayUITests testTodayScreen]' passed (35.307 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## App crashes
```
### Habits-2026-10-10-161025.ips
EXC_BREAKPOINT SIGTRAP
Trace/BPT trap: 5
  libswiftCore.dylib: _assertionFailure(_:_:file:line:flags:)
  SwiftUICore: specialized EnvironmentValues.subscript.getter
  SwiftUICore: ?
  libswiftCore.dylib: KeyPath._projectReadOnly(from:)
  libswiftCore.dylib: swift_getAtKeyPath
  SwiftUICore: closure #1 in EnvironmentBox.update(property:phase:)
  SwiftUICore: partial apply for closure #1 in EnvironmentBox.update(property:phase:)
  SwiftUICore: closure #1 in ObservationCenter._withObservation<A>(do:)
  SwiftUICore: partial apply for closure #1 in ObservationCenter._withObservation<A>(do:)
  SwiftUICore: <deduplicated_symbol>
  SwiftUICore: EnvironmentBox.update(property:phase:)
  SwiftUICore: static BoxVTable.update(elt:property:phase:)
  SwiftUICore: _DynamicPropertyBuffer.update(container:phase:)
  SwiftUICore: closure #1 in closure #1 in DynamicBody.updateValue()
  SwiftUICore: partial apply for closure #1 in closure #1 in DynamicBody.updateValue()
  SwiftUICore: <deduplicated_symbol>
  SwiftUICore: closure #1 in DynamicBody.updateValue()
  SwiftUICore: DynamicBody.updateValue()
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

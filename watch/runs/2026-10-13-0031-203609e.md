# Watch: claude/shared-habit-rules-ci36 @ 203609e

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38317949104 · 2026-10-13 00:30 UTC
Commit: Current Work 92: the Watch's UI tests on the final code (scratch, safe to delete) [watch-ci]

- Core tests: success
- Watch build: success
- iPhone build with the Watch app: success
- Watch UI tests (WatchLaunchTests,WatchTodayTests,WatchDayDetailsTests,WatchRoutineTests,WatchPlusTests,WatchLogManuallyTests): success
- Screenshots: skipped
- Speed: skipped
- Paired simulators: cancelled

Embedded in the iPhone app: OftenEnoughWatch.app 

## Core tests
```
BackupTest: 20 tests, 0 failures, 0 errors, 5.626 s
CloudStoreTest: 16 tests, 0 failures, 0 errors, 190.864 s
DriveScaleTest: 1 tests, 0 failures, 0 errors, 13.782 s
DriveSyncTest: 22 tests, 0 failures, 0 errors, 38.119 s
DurabilityTest: 11 tests, 0 failures, 0 errors, 18.149 s
GoogleDriveTest: 6 tests, 0 failures, 0 errors, 0.032 s
HabitRepositoryTest: 13 tests, 0 failures, 0 errors, 0.206 s
LiveRulesTest: 2 tests, 0 failures, 0 errors, 0.026 s
LiveSyncTest: 1 tests, 0 failures, 0 errors, 0.196 s
MigrationTest: 16 tests, 0 failures, 0 errors, 0.692 s
PeerSyncTest: 20 tests, 0 failures, 0 errors, 196.462 s
  peer property test: 3000 seeded runs converged
  first fill: 375000 logs (15 years) in 76 parts, biggest part 73 KB, total 5 MB, 45.1 s (made in 23.5 s); Watch database 118 MB; peak heap 149 MB
SyncTest: 13 tests, 0 failures, 0 errors, 3.289 s
  random sync: {entries=25, undone=13, deletedHabits=2, names=3, fieldClocks=16}
```

## Watch UI tests
```
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (69.108 seconds)
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (66.619 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (48.577 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (44.656 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (24.281 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (25.496 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (33.953 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (26.495 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (33.892 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (29.490 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (15.756 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (14.415 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (21.630 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (21.512 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (33.148 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (29.001 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (9.111 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (7.051 seconds)
Test case 'WatchLogManuallyTests.testAmountWithPlusAndMinus()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (26.156 seconds)
Test case 'WatchLogManuallyTests.testAmountWithPlusAndMinus()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (18.479 seconds)
Test case 'WatchLogManuallyTests.testAnAmountThatAsksStartsAtTheLastValue()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (24.353 seconds)
Test case 'WatchLogManuallyTests.testAnAmountThatAsksStartsAtTheLastValue()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (32.444 seconds)
Test case 'WatchLogManuallyTests.testTimeWheels()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (33.535 seconds)
Test case 'WatchLogManuallyTests.testTimeWheels()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (26.687 seconds)
Test case 'WatchPlusTests.testEveryMoment()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (28.230 seconds)
Test case 'WatchPlusTests.testEveryMoment()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (27.052 seconds)
Test case 'WatchPlusTests.testWithoutPlusTheOfferShowsAndRestoreIsThere()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (14.831 seconds)
Test case 'WatchPlusTests.testWithoutPlusTheOfferShowsAndRestoreIsThere()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (11.569 seconds)
Test case 'WatchPlusTests.testWithPlusTodayOpens()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (19.607 seconds)
Test case 'WatchPlusTests.testWithPlusTodayOpens()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (19.963 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (47.017 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (33.453 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (35.376 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (34.598 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (23.906 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (21.499 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (31.745 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (33.735 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (68.755 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (63.213 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (15.590 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (17.008 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (10.736 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (11.710 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (5.174 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (6.405 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (36.772 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (42.105 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (48107)' (26.432 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (48106)' (26.976 seconds)

Failures:
```

## Paired simulators

Paired simulators: setting up
- iPhone 2C572C4D-17FF-4AC0-BA94-4F778D45B594, Watch 41FF62C3-ED09-4199-B5D8-D99BE9F2BB4F, pair CB39EDFF-E210-414B-92E5-BD215D91BC3D
- 188 s: booted the iPhone FAILED or took over 180 s
- 361 s: booted the Watch
- 424 s: activated the pair FAILED or took over 60 s
- 490 s: installed the iPhone app
- 1007 s: the Watch app never arrived from the iPhone in 240 s; installing it directly (the iPhone may refuse to send)
- 1022 s: installed the Watch app directly
- 1094 s: launched the iPhone app FAILED or took over 60 s
- 1102 s: launched the Watch app

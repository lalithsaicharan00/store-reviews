# Watch: claude/shared-habit-rules-ci6 @ c556f19

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38225714613 · 2026-10-12 10:23 UTC
Commit: Current Work 92: the Watch on the shared rules, final round (scratch, safe to delete) [watch-ci]

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
BackupTest: 20 tests, 0 failures, 0 errors, 7.555 s
CloudStoreTest: 16 tests, 0 failures, 0 errors, 186.575 s
DriveScaleTest: 1 tests, 0 failures, 0 errors, 10.749 s
DriveSyncTest: 22 tests, 0 failures, 0 errors, 33.68 s
DurabilityTest: 11 tests, 0 failures, 0 errors, 21.624 s
GoogleDriveTest: 6 tests, 0 failures, 0 errors, 0.056 s
HabitRepositoryTest: 13 tests, 0 failures, 0 errors, 0.197 s
LiveSyncTest: 1 tests, 0 failures, 0 errors, 0.193 s
MigrationTest: 16 tests, 0 failures, 0 errors, 1.056 s
PeerSyncTest: 20 tests, 0 failures, 0 errors, 186.972 s
  peer property test: 3000 seeded runs converged
  first fill: 375000 logs (15 years) in 76 parts, biggest part 73 KB, total 5 MB, 37.3 s (made in 21.7 s); Watch database 118 MB; peak heap 89 MB
SyncTest: 13 tests, 0 failures, 0 errors, 4.216 s
  random sync: {entries=25, undone=13, deletedHabits=2, names=3, fieldClocks=16}
```

## Watch UI tests
```
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (35.442 seconds)
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (33.792 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (53.499 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (48.225 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (41.241 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (47.171 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (29.880 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (28.391 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (31.911 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (34.072 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (21.655 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (23.711 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (34.819 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (31.822 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (41.761 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (38.951 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (7.220 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (7.300 seconds)
Test case 'WatchLogManuallyTests.testAmountWithPlusAndMinus()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (40.766 seconds)
Test case 'WatchLogManuallyTests.testAmountWithPlusAndMinus()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (41.670 seconds)
Test case 'WatchLogManuallyTests.testAnAmountThatAsksStartsAtTheLastValue()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (42.342 seconds)
Test case 'WatchLogManuallyTests.testAnAmountThatAsksStartsAtTheLastValue()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (42.813 seconds)
Test case 'WatchLogManuallyTests.testTimeWheels()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (45.485 seconds)
Test case 'WatchLogManuallyTests.testTimeWheels()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (43.698 seconds)
Test case 'WatchPlusTests.testEveryMoment()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (27.971 seconds)
Test case 'WatchPlusTests.testEveryMoment()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (33.150 seconds)
Test case 'WatchPlusTests.testWithoutPlusTheOfferShowsAndRestoreIsThere()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (14.297 seconds)
Test case 'WatchPlusTests.testWithoutPlusTheOfferShowsAndRestoreIsThere()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (12.355 seconds)
Test case 'WatchPlusTests.testWithPlusTodayOpens()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (20.855 seconds)
Test case 'WatchPlusTests.testWithPlusTodayOpens()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (18.161 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (65.985 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (57.493 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (51.410 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (49.506 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (33.348 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (31.648 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (33.223 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (37.288 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (69.644 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (63.522 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (18.454 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (17.483 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (13.767 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (12.393 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (6.067 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (6.050 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (74.183 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (60.304 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (45373)' (45.188 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (45372)' (63.639 seconds)

Failures:
```

## Paired simulators

Paired simulators: setting up
- iPhone F66D5A74-12C9-4241-88D0-80B31F980F7B, Watch 45653D77-DA50-4A4B-8334-AC632D8A861A, pair 8F50BA47-37EB-4014-B2E3-55576CCA0DE6
- 205 s: booted the iPhone FAILED or took over 180 s
- 516 s: booted the Watch FAILED or took over 300 s
- 599 s: activated the pair FAILED or took over 60 s
- 706 s: installed the iPhone app

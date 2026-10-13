# Watch: claude/shared-habit-rules-ci49 @ ba7940c

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38349268502 · 2026-10-13 06:02 UTC
Commit: Current Work 92: the Watch's UI tests on the shared rules (scratch, safe to delete) [watch-ci]

- Core tests: success
- Watch build: success
- iPhone build with the Watch app: success
- Watch UI tests (WatchLaunchTests,WatchTodayTests,WatchDayDetailsTests,WatchRoutineTests,WatchPlusTests,WatchLogManuallyTests): success
- Screenshots: skipped
- Speed: skipped
- Paired simulators: failure

Embedded in the iPhone app: OftenEnoughWatch.app 

## Core tests
```
BackupTest: 20 tests, 0 failures, 0 errors, 9.578 s
CloudStoreTest: 16 tests, 0 failures, 0 errors, 144.129 s
DriveScaleTest: 1 tests, 0 failures, 0 errors, 9.528 s
DriveSyncTest: 22 tests, 0 failures, 0 errors, 21.997 s
DurabilityTest: 11 tests, 0 failures, 0 errors, 15.671 s
GoogleDriveTest: 6 tests, 0 failures, 0 errors, 0.028 s
HabitRepositoryTest: 13 tests, 0 failures, 0 errors, 0.122 s
LiveRulesTest: 2 tests, 0 failures, 0 errors, 0.018 s
LiveSyncTest: 1 tests, 0 failures, 0 errors, 0.13 s
MigrationTest: 16 tests, 0 failures, 0 errors, 0.566 s
PeerSyncTest: 20 tests, 0 failures, 0 errors, 124.962 s
  peer property test: 3000 seeded runs converged
  first fill: 375000 logs (15 years) in 76 parts, biggest part 73 KB, total 5 MB, 28.8 s (made in 17.2 s); Watch database 118 MB; peak heap 117 MB
SyncTest: 13 tests, 0 failures, 0 errors, 3.001 s
  random sync: {entries=25, undone=13, deletedHabits=2, names=3, fieldClocks=16}
```

## Watch UI tests
```
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (32.350 seconds)
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (29.740 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (32.150 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (29.847 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (20.935 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (22.195 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (28.314 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (21.372 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (18.824 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (19.512 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (11.512 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (11.589 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (18.956 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (16.964 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (26.818 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (24.578 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (4.875 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (4.912 seconds)
Test case 'WatchLogManuallyTests.testAmountWithPlusAndMinus()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (17.903 seconds)
Test case 'WatchLogManuallyTests.testAmountWithPlusAndMinus()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (16.516 seconds)
Test case 'WatchLogManuallyTests.testAnAmountThatAsksStartsAtTheLastValue()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (18.503 seconds)
Test case 'WatchLogManuallyTests.testAnAmountThatAsksStartsAtTheLastValue()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (16.929 seconds)
Test case 'WatchLogManuallyTests.testTimeWheels()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (23.355 seconds)
Test case 'WatchLogManuallyTests.testTimeWheels()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (20.497 seconds)
Test case 'WatchPlusTests.testEveryMoment()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (18.383 seconds)
Test case 'WatchPlusTests.testEveryMoment()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (18.841 seconds)
Test case 'WatchPlusTests.testWithoutPlusTheOfferShowsAndRestoreIsThere()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (11.921 seconds)
Test case 'WatchPlusTests.testWithoutPlusTheOfferShowsAndRestoreIsThere()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (9.947 seconds)
Test case 'WatchPlusTests.testWithPlusTodayOpens()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (14.166 seconds)
Test case 'WatchPlusTests.testWithPlusTodayOpens()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (13.584 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (26.579 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (25.488 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (28.403 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (29.641 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (19.054 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (17.866 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (34.243 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (25.965 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (66.134 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (64.058 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (15.588 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (17.740 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (10.224 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (12.049 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (5.073 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (5.506 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (57.326 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (43.350 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (35338)' (32.178 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (35337)' (53.121 seconds)

Failures:
```

## Paired simulators

Paired simulators: FAILED (waited 360 s)

- iPhone 0B2BAE98-4E69-4983-BBE1-9F2AD279ADEE, Watch 5D859E62-EAEF-4FA9-B93C-FC265BB2C8D4, pair B00DF1C5-D122-436F-B48D-5ECBAB82BFC4
- 185 s: booted the iPhone FAILED or took over 180 s
- 343 s: booted the Watch
- 346 s: activated the pair FAILED or took over 60 s
- 372 s: installed the iPhone app
- 1036 s: the Watch app never arrived from the iPhone in 240 s; installing it directly (the iPhone may refuse to send)
- 1058 s: installed the Watch app directly
- 1131 s: launched the iPhone app FAILED or took over 60 s
- 1156 s: launched the Watch app

iPhone:
```
(the iPhone app wrote nothing)
```
Watch:
```
    0.0 s  watch: waiting for the first fill
  300.3 s  never saw the first fill (Pair water at 1 glass, Pair timer) in 300 s
  300.4 s  # PAIR DONE failed
```
WatchConnectivity on the iPhone (last lines):
```
```
WatchConnectivity on the Watch (last lines):
```
```

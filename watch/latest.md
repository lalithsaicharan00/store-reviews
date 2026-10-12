# Watch: claude/shared-habit-rules-ci6 @ a500f3a

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38216889043 · 2026-10-12 08:19 UTC
Commit: Current Work 92: the Watch on the shared rules (scratch, safe to delete) [watch-ci]

- Core tests: success
- Watch build: success
- iPhone build with the Watch app: success
- Watch UI tests (WatchLaunchTests,WatchTodayTests,WatchDayDetailsTests,WatchRoutineTests,WatchPlusTests,WatchLogManuallyTests): failure
- Screenshots: skipped
- Speed: skipped
- Paired simulators: cancelled

Embedded in the iPhone app: OftenEnoughWatch.app 

## Core tests
```
BackupTest: 20 tests, 0 failures, 0 errors, 9.35 s
CloudStoreTest: 16 tests, 0 failures, 0 errors, 212.566 s
DriveScaleTest: 1 tests, 0 failures, 0 errors, 13.443 s
DriveSyncTest: 22 tests, 0 failures, 0 errors, 37.269 s
DurabilityTest: 11 tests, 0 failures, 0 errors, 23.713 s
GoogleDriveTest: 6 tests, 0 failures, 0 errors, 0.048 s
HabitRepositoryTest: 13 tests, 0 failures, 0 errors, 0.247 s
LiveSyncTest: 1 tests, 0 failures, 0 errors, 0.243 s
MigrationTest: 16 tests, 0 failures, 0 errors, 0.945 s
PeerSyncTest: 20 tests, 0 failures, 0 errors, 221.166 s
  peer property test: 3000 seeded runs converged
  first fill: 375000 logs (15 years) in 76 parts, biggest part 73 KB, total 5 MB, 44.9 s (made in 24.7 s); Watch database 118 MB; peak heap 132 MB
SyncTest: 13 tests, 0 failures, 0 errors, 3.974 s
  random sync: {entries=25, undone=13, deletedHabits=2, names=3, fieldClocks=16}
```

## Watch UI tests
```
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (52.087 seconds)
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (53.556 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (40.626 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (36.072 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (26.569 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (29.699 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (28.929 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (29.165 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (21.979 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (23.288 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (14.368 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (13.691 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (26.495 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (21.255 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (58.204 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (64.710 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (6.348 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (7.031 seconds)
Test case 'WatchLogManuallyTests.testAmountWithPlusAndMinus()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (22.363 seconds)
Test case 'WatchLogManuallyTests.testAmountWithPlusAndMinus()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (19.873 seconds)
Test case 'WatchLogManuallyTests.testAnAmountThatAsksStartsAtTheLastValue()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (43.445 seconds)
Test case 'WatchLogManuallyTests.testAnAmountThatAsksStartsAtTheLastValue()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (34.667 seconds)
Test case 'WatchLogManuallyTests.testTimeWheels()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (45.942 seconds)
Test case 'WatchLogManuallyTests.testTimeWheels()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (43.623 seconds)
Test case 'WatchPlusTests.testEveryMoment()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (25.674 seconds)
Test case 'WatchPlusTests.testEveryMoment()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (28.787 seconds)
Test case 'WatchPlusTests.testWithoutPlusTheOfferShowsAndRestoreIsThere()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (24.953 seconds)
Test case 'WatchPlusTests.testWithoutPlusTheOfferShowsAndRestoreIsThere()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (11.979 seconds)
Test case 'WatchPlusTests.testWithPlusTodayOpens()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (31.673 seconds)
Test case 'WatchPlusTests.testWithPlusTodayOpens()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (49.098 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (39.011 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (38.428 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (46.224 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (42.341 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (29.070 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (27.502 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (37.961 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (44.463 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (65.486 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (64.281 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (16.566 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (18.548 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (11.101 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (12.273 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (7.540 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (6.795 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (40.856 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (41.431 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (49995)' (19.875 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (49996)' (20.371 seconds)

Failures:
testOpensToToday() [Apple Watch Series 10 (42mm)]: WatchLaunchTests.swift:11: XCTAssertTrue failed - Today's day bar
testOpensToToday() [Apple Watch Series 10 (46mm)]: WatchLaunchTests.swift:11: XCTAssertTrue failed - Today's day bar
testOpensWithTheIPhonesSectionsAndWords() [Apple Watch Series 10 (42mm)]: WatchTests.swift:62: failed - the day bar's count (habits, not ticks) not found. On screen: Today | Quit or Cut Down | 0 of 7 done | No smoking | 15 d 22 h
testOpensWithTheIPhonesSectionsAndWords() [Apple Watch Series 10 (46mm)]: WatchTests.swift:62: failed - the day bar's count (habits, not ticks) not found. On screen: Today | Quit or Cut Down | 0 of 7 done | No smoking | 15 d 22 h
testPagesNeverLogAndTheFinishSummarises() [Apple Watch Series 10 (42mm)]: WatchTests.swift:275: XCTAssertTrue failed - Next after Mark done, not Mark done
testPagesNeverLogAndTheFinishSummarises() [Apple Watch Series 10 (46mm)]: WatchTests.swift:275: XCTAssertTrue failed - Next after Mark done, not Mark done
```

## Paired simulators

Paired simulators: setting up
- iPhone 4F0CB2EE-48C0-4D38-A489-3DBDB778BEDF, Watch 822A9CF4-D509-48F8-8EBB-FAFC1B56FBCC, pair 264A9F40-A55E-4A57-A2AF-193BAFDC6307
- 187 s: booted the iPhone FAILED or took over 180 s
- 485 s: booted the Watch
- 492 s: activated the pair FAILED or took over 60 s
- 528 s: installed the iPhone app

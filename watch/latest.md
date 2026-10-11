# Watch: apple-watch @ 6bbf218

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38117770136 · 2026-10-11 06:54 UTC
Commit: Apple Watch CI: the UI test list is the last real one in the message

- Core tests: skipped
- Watch build: success
- iPhone build with the Watch app: success
- Watch UI tests (WatchLaunchTests,WatchTodayTests,WatchDayDetailsTests,WatchLogManuallyTests,WatchRoutineTests,WatchPlusTests): failure
- Screenshots: skipped
- Speed: skipped
- Paired simulators: skipped

Embedded in the iPhone app: OftenEnoughWatch.app 

## Watch UI tests
```
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (47.240 seconds)
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (42.743 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (55.962 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (52.027 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (40.206 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (50.668 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (32.554 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (28.379 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (28.332 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (26.181 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (17.286 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (23.135 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (57.071 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (35.954 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (38.958 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (32.129 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (6.504 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (9.340 seconds)
Test case 'WatchLogManuallyTests.testAmountWithPlusAndMinus()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (46.703 seconds)
Test case 'WatchLogManuallyTests.testAmountWithPlusAndMinus()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (29.619 seconds)
Test case 'WatchLogManuallyTests.testAnAmountThatAsksStartsAtTheLastValue()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (26.490 seconds)
Test case 'WatchLogManuallyTests.testAnAmountThatAsksStartsAtTheLastValue()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (44.986 seconds)
Test case 'WatchLogManuallyTests.testTimeWheels()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (33.031 seconds)
Test case 'WatchLogManuallyTests.testTimeWheels()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (27.288 seconds)
Test case 'WatchPlusTests.testEveryMoment()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (22.683 seconds)
Test case 'WatchPlusTests.testEveryMoment()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (32.651 seconds)
Test case 'WatchPlusTests.testWithoutPlusTheOfferShowsAndRestoreIsThere()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (19.606 seconds)
Test case 'WatchPlusTests.testWithoutPlusTheOfferShowsAndRestoreIsThere()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (14.907 seconds)
Test case 'WatchPlusTests.testWithPlusTodayOpens()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (23.254 seconds)
Test case 'WatchPlusTests.testWithPlusTodayOpens()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (27.442 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (29.927 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (28.416 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (21.575 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (20.742 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (40.921 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (43.199 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (27.745 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (23.202 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (36.757 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (24.529 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (20.499 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (36.392 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (14.533 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (15.285 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (5.797 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (6.791 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (35.079 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (35.639 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (54528)' (81.568 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (54527)' (81.801 seconds)
```

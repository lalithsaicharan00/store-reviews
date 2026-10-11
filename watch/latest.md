# Watch: apple-watch @ c1f45ca

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38119745342 · 2026-10-11 07:21 UTC
Commit: Apple Watch tests: Meditate's line in the iPhone's words; the dialog's Delete; failure lines in the summary

- Core tests: skipped
- Watch build: success
- iPhone build with the Watch app: success
- Watch UI tests (WatchTodayTests,WatchDayDetailsTests,WatchRoutineTests): failure
- Screenshots: skipped
- Speed: skipped
- Paired simulators: skipped

Embedded in the iPhone app: OftenEnoughWatch.app 

## Watch UI tests
```
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (46.382 seconds)
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (35.013 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (44.945 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (39.285 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (22.927 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (24.340 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (29.531 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (23.938 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (29.311 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (24.465 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (38.708 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (27.006 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (24.667 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (34.378 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (32.363 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (32.057 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (36.259 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (23.717 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (36.775 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (15.955 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (38.179 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (35.397 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (19.838 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (21.779 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (25.026 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (22.828 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (22.502 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (15.845 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (11.311 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (11.725 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (5.840 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (8.390 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (32.649 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (31.045 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (28165)' (51.607 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (28164)' (33.808 seconds)

Failures:
```

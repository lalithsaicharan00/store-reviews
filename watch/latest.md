# Watch: apple-watch-ci6 @ f8081ff

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38127606704 · 2026-10-11 09:36 UTC
Commit: Apple Watch: compile BackupFeatures for SHA256Hex, which iCloud's transport uses

- Core tests: skipped
- Watch build: success
- iPhone build with the Watch app: success
- Watch UI tests (WatchLaunchTests,WatchTodayTests,WatchDayDetailsTests): success
- Screenshots: skipped
- Speed: skipped
- Paired simulators: skipped

Embedded in the iPhone app: OftenEnoughWatch.app 

## Watch UI tests
```
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (48.105 seconds)
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (46.273 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (49.476 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (45.401 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (26.331 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (26.456 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (32.675 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (32.091 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (19.725 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (22.343 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (16.106 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (11.924 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (19.459 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (18.045 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (32.183 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (33.392 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (5.218 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (5.673 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (35.383 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (35.981 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (62.035 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (58.704 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (17.674 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (19.811 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (10.858 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (10.724 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (6.562 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (5.918 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (52.332 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (49.907 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (23371)' (31.903 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (23540)' (30.730 seconds)

Failures:
```

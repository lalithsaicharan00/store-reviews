# Watch: apple-watch-ci3 @ 834935c

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38129622827 · 2026-10-11 10:35 UTC
Commit: Apple Watch: Day details tests after the gap below the dial (scratch branch run)

- Core tests: skipped
- Watch build: success
- iPhone build with the Watch app: success
- Watch UI tests (WatchDayDetailsTests,WatchLaunchTests): failure
- Screenshots: skipped
- Speed: skipped
- Paired simulators: skipped

Embedded in the iPhone app: OftenEnoughWatch.app 

## Watch UI tests
```
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27220)' (83.302 seconds)
Test case 'WatchDayDetailsTests.testAmountDialMainActionAndLogs()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27263)' (58.200 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27220)' (63.289 seconds)
Test case 'WatchDayDetailsTests.testChecklistStepsTick()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27263)' (60.458 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27220)' (40.499 seconds)
Test case 'WatchDayDetailsTests.testCheckMarkDoneThenUndo()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27263)' (41.449 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27220)' (42.847 seconds)
Test case 'WatchDayDetailsTests.testDeleteALogAsksFirstAndGoesBackFirst()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27263)' (42.975 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27220)' (28.836 seconds)
Test case 'WatchDayDetailsTests.testLimitAndWeekGoal()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27263)' (28.947 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27220)' (38.899 seconds)
Test case 'WatchDayDetailsTests.testQuitSlipAsksFirst()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27263)' (39.851 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27220)' (34.077 seconds)
Test case 'WatchDayDetailsTests.testSkipAndUndoSkip()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27263)' (36.744 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27220)' (41.424 seconds)
Test case 'WatchDayDetailsTests.testTimerStartsAndPauses()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27263)' (43.267 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27220)' (7.541 seconds)
Test case 'WatchLaunchTests.testOpensToToday()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27263)' (7.612 seconds)

Failures:
testQuitSlipAsksFirst() [Apple Watch Series 10 (42mm)]: WatchTests.swift:188: failed - the run starts again from the slip (H8) not found. On screen:  | Today's logs | No smoking | 0 h 2 min | since Sun, Oct 11, 10:30 AM | Best 44 d 2 h | Slip | 10:30 AM
testQuitSlipAsksFirst() [Apple Watch Series 10 (46mm)]: WatchTests.swift:188: failed - the run starts again from the slip (H8) not found. On screen:  | Today's logs | No smoking | 0 h 2 min | since Sun, Oct 11, 10:30 AM | Best 44 d 2 h | Slip | 10:30 AM
```

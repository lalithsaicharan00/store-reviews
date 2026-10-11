# Watch: apple-watch @ ecfc05a

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38122593671 · 2026-10-11 08:10 UTC
Commit: Apple Watch: a test launch keeps the routine's place in memory; tests scroll to rows off the screen

- Core tests: skipped
- Watch build: success
- iPhone build with the Watch app: success
- Watch UI tests (WatchTodayTests,WatchRoutineTests): failure
- Screenshots: skipped
- Speed: skipped
- Paired simulators: skipped

Embedded in the iPhone app: OftenEnoughWatch.app 

## Watch UI tests
```
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27377)' (41.005 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27285)' (42.842 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27377)' (54.973 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27285)' (43.747 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27377)' (28.914 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27285)' (36.869 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27377)' (26.002 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27285)' (55.041 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27377)' (79.004 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27285)' (67.020 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27377)' (18.038 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27285)' (16.674 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27377)' (11.227 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27285)' (11.435 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27377)' (5.525 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27285)' (5.956 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27377)' (40.171 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27285)' (41.620 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (27377)' (33.478 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (27285)' (32.216 seconds)

Failures:
testACheckTogglesAndDoneRowsSinkAfterThePause() [Apple Watch Series 10 (42mm)]: WatchTests.swift:86: Failed to get matching snapshot: No matches found for Elements matching predicate '"Vitamins" IN identifiers' from input {(     StaticText, label: 'Today',     StaticText, label: 'Morning',     StaticText, label: 'Now',     StaticText, label: '2 left',     StaticText, label: 'Read',     StaticText,
testClosingKeepsTheTimerRunning() [Apple Watch Series 10 (42mm)]: WatchTests.swift:280: failed - Meditate's page not found. On screen: Today | Morning | Now | 3 left | Morning 1/3 | Water | 3/8 glasses | Read | Every day | Vitamins | Every day | Vitamins | Not yet | Today
testPagesNeverLogAndTheFinishSummarises() [Apple Watch Series 10 (42mm)]: WatchTests.swift:263: failed - page 2 not found. On screen: Today | Morning | Now | 3 left | Morning 1/3 | Water | 3/8 glasses | Read | Every day | Vitamins | Every day | Vitamins | Not yet | Today
```

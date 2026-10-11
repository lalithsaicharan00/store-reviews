# Watch: apple-watch @ c038272

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38121219238 · 2026-10-11 07:46 UTC
Commit: Apple Watch: routine list rows named for tests; failure messages read from the result bundle

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
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (30241)' (53.063 seconds)
Test case 'WatchRoutineTests.testClosingKeepsTheTimerRunning()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (30242)' (33.474 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (30241)' (34.897 seconds)
Test case 'WatchRoutineTests.testPagesNeverLogAndTheFinishSummarises()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (30242)' (32.905 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (30241)' (31.013 seconds)
Test case 'WatchRoutineTests.testTheListJumpsWithoutLogging()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (30242)' (27.197 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (30241)' (28.963 seconds)
Test case 'WatchTodayTests.testACheckTogglesAndDoneRowsSinkAfterThePause()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (30242)' (29.315 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (30241)' (26.072 seconds)
Test case 'WatchTodayTests.testAFailedSaveSaysSoAndShowsWhatsSaved()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (30242)' (25.577 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (30241)' (17.373 seconds)
Test case 'WatchTodayTests.testAPlusOneLogsAtOnceAndUndoNamesIt()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (30242)' (17.865 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (30241)' (21.504 seconds)
Test case 'WatchTodayTests.testEmptyAndNothingPlanned()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (30242)' (11.275 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (30241)' (5.465 seconds)
Test case 'WatchTodayTests.testFirstLaunchNeverSaysNoHabits()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (30242)' (6.273 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' failed on 'Watch 42 - OftenEnoughWatchUITests-Runner (30241)' (35.621 seconds)
Test case 'WatchTodayTests.testLimitsTasksSkippedAndPaused()' failed on 'Watch 46 - OftenEnoughWatchUITests-Runner (30242)' (32.708 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 42 - OftenEnoughWatchUITests-Runner (30241)' (36.976 seconds)
Test case 'WatchTodayTests.testOpensWithTheIPhonesSectionsAndWords()' passed on 'Watch 46 - OftenEnoughWatchUITests-Runner (30242)' (35.599 seconds)

Failures:
testACheckTogglesAndDoneRowsSinkAfterThePause() [Apple Watch Series 10 (42mm)]: WatchTests.swift:89: Failed to get matching snapshot: No matches found for Elements matching predicate '"Vitamins" IN identifiers' from input {(     StaticText, label: 'Today',     StaticText, label: 'Morning',     StaticText, label: 'Now',     StaticText, label: '2 left',     StaticText, label: 'Read',     StaticText,
testACheckTogglesAndDoneRowsSinkAfterThePause() [Apple Watch Series 10 (46mm)]: WatchTests.swift:89: Failed to get matching snapshot: No matches found for Elements matching predicate '"Vitamins" IN identifiers' from input {(     StaticText, label: 'Today',     StaticText, label: 'Morning',     StaticText, label: 'Now',     StaticText, label: '2 left',     StaticText, label: 'Water',     StaticText
testAFailedSaveSaysSoAndShowsWhatsSaved() [Apple Watch Series 10 (42mm)]: WatchTests.swift:120: failed - Water back at what's saved not found. On screen: Today | Quit or Cut Down | Anytime | 2 left | No smoking | 15 d 22 h | Water | 0/8 glasses | Read | Every day
testAFailedSaveSaysSoAndShowsWhatsSaved() [Apple Watch Series 10 (46mm)]: WatchTests.swift:120: failed - Water back at what's saved not found. On screen: Today | Quit or Cut Down | Anytime | 2 left | 0 of 7 done | No smoking | 15 d 22 h | Water | 0/8 glasses
testClosingKeepsTheTimerRunning() [Apple Watch Series 10 (42mm)]: WatchTests.swift:276: Failed to tap "routine-close" Button: No matches found for Elements matching predicate '"routine-close" IN identifiers' from input {(     Button, identifier: 'start-morning', label: 'Start Morning',     Button, identifier: 'xmark', label: 'Close',     Button, identifier: 'routine-list', label: 'The routine's ha
testClosingKeepsTheTimerRunning() [Apple Watch Series 10 (46mm)]: WatchTests.swift:276: Failed to tap "routine-close" Button: No matches found for Elements matching predicate '"routine-close" IN identifiers' from input {(     Button, identifier: 'start-anytime', label: 'Start Anytime',     Button, identifier: 'start-morning', label: 'Start Morning',     Button, identifier: 'xmark', label: 'Close',
testLimitsTasksSkippedAndPaused() [Apple Watch Series 10 (42mm)]: WatchTests.swift:112: failed - a skipped habit stays, neutral not found. On screen: Today | Quit or Cut Down | 0 of 5 done | No smoking | 15 d 22 h
testLimitsTasksSkippedAndPaused() [Apple Watch Series 10 (46mm)]: WatchTests.swift:112: failed - a skipped habit stays, neutral not found. On screen: Today | Quit or Cut Down | 0 of 5 done | No smoking | 15 d 22 h
testPagesNeverLogAndTheFinishSummarises() [Apple Watch Series 10 (42mm)]: WatchTests.swift:255: XCTAssertEqual failed: ("Start") is not equal to ("Mark done")
testPagesNeverLogAndTheFinishSummarises() [Apple Watch Series 10 (46mm)]: WatchTests.swift:255: XCTAssertEqual failed: ("Start") is not equal to ("Mark done")
```

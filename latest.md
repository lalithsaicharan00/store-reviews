# claude/shared-habit-rules-diag4 @ eb4e560

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38338893815 · 2026-10-13 04:08 UTC
Commit: Scratch (safe to delete): where testHidePercentages spends its time, shared and Swift rules in turns

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (ProgressUITests/testDiagPercent1Shared,ProgressUITests/testDiagPercent2Swift,ProgressUITests/testDiagPercent3Shared,ProgressUITests/testDiagPercent4Swift): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 4 tests, with 4 failures (0 unexpected) in 373.558 (373.567) seconds
	 Executed 4 tests, with 4 failures (0 unexpected) in 373.558 (373.568) seconds
	 Executed 4 tests, with 4 failures (0 unexpected) in 373.558 (373.570) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:205: error: -[HabitsUITests.ProgressUITests testDiagPercent1Shared] : failed - DIAG shared: launch 66.7, open 12.5, range 1.4, f1-swipes4 19.3, f1-tap 1.0, f1-pagetrue 1.2, f1-record 1.1, b1 2.6, t1-menu 2.1, t1-toggle 3.2, f2-swipes0 7.3, f2-tap 1.7, f2-pagetrue 1.3, f2-record 1.4, b2 3.1, t2-menu 2.0, t2-toggle 3.8, f3-swipes0 4.3, f3-tap 1.2, f3-pagetrue 1.2, f3-record 1.1
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:205: error: -[HabitsUITests.ProgressUITests testDiagPercent2Swift] : failed - DIAG swift: launch 7.0, open 9.3, range 1.3, f1-swipes4 29.2, f1-tap 1.5, f1-pagetrue 1.3, f1-record 1.2, b1 2.5, t1-menu 2.1, t1-toggle 3.5, f2-swipes0 9.0, f2-tap 1.5, f2-pagetrue 1.3, f2-record 1.3, b2 3.0, t2-menu 1.9, t2-toggle 2.9, f3-swipes0 3.3, f3-tap 1.4, f3-pagetrue 1.3, f3-record 1.8
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:205: error: -[HabitsUITests.ProgressUITests testDiagPercent3Shared] : failed - DIAG shared: launch 13.5, open 10.8, range 1.2, f1-swipes4 15.7, f1-tap 1.0, f1-pagetrue 1.2, f1-record 1.1, b1 2.3, t1-menu 1.9, t1-toggle 2.8, f2-swipes0 3.6, f2-tap 0.8, f2-pagetrue 1.3, f2-record 1.3, b2 2.6, t2-menu 1.9, t2-toggle 3.0, f3-swipes0 3.7, f3-tap 0.9, f3-pagetrue 1.3, f3-record 1.3
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/ProgressUITests.swift:205: error: -[HabitsUITests.ProgressUITests testDiagPercent4Swift] : failed - DIAG swift: launch 10.1, open 8.0, range 1.1, f1-swipes4 14.1, f1-tap 1.0, f1-pagetrue 1.3, f1-record 1.1, b1 2.5, t1-menu 2.1, t1-toggle 3.4, f2-swipes0 4.0, f2-tap 1.2, f2-pagetrue 1.1, f2-record 1.1, b2 2.2, t2-menu 1.8, t2-toggle 2.9, f3-swipes0 4.3, f3-tap 1.4, f3-pagetrue 1.2, f3-record 1.2
Test Case '-[HabitsUITests.ProgressUITests testDiagPercent1Shared]' failed (144.019 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDiagPercent2Swift]' failed (88.179 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDiagPercent3Shared]' failed (73.703 seconds).
Test Case '-[HabitsUITests.ProgressUITests testDiagPercent4Swift]' failed (67.657 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

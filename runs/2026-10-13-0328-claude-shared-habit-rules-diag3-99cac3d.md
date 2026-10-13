# claude/shared-habit-rules-diag3 @ 99cac3d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38338710982 · 2026-10-13 03:28 UTC
Commit: Scratch (safe to delete): the Reminders check's seeding, shared and Swift rules in turns

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (RemindersUITests/testDiag1Shared,RemindersUITests/testDiag2Swift,RemindersUITests/testDiag3Shared,RemindersUITests/testDiag4Swift): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 4 tests, with 4 failures (0 unexpected) in 231.879 (231.884) seconds
	 Executed 4 tests, with 4 failures (0 unexpected) in 231.879 (231.885) seconds
	 Executed 4 tests, with 4 failures (0 unexpected) in 231.879 (231.886) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RemindersUITests.swift:21: error: -[HabitsUITests.RemindersUITests testDiag1Shared] : failed - DIAG waited 59 s; Reminders: all checks passed | 100 rules / 38094 entries: plan median 131.7 ms, cold 131.7 ms, content 27.0 ms | basic 1482 ms; actions 151 ms; races 102 ms; seed 57297 ms; performance 57706 ms; calendar 102 ms; clock 19 ms;  | seeds: build 177; snapshot 188; import 52287; load 4638;  SHARED
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RemindersUITests.swift:21: error: -[HabitsUITests.RemindersUITests testDiag2Swift] : failed - DIAG waited 52 s; Reminders: all checks passed | 100 rules / 38094 entries: plan median 129.7 ms, cold 129.7 ms, content 35.8 ms | basic 1548 ms; actions 231 ms; races 71 ms; seed 50289 ms; performance 50729 ms; calendar 60 ms; clock 10 ms;  | seeds: build 157; snapshot 227; import 46777; load 3120;  SWIFT
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RemindersUITests.swift:21: error: -[HabitsUITests.RemindersUITests testDiag3Shared] : failed - DIAG waited 42 s; Reminders: all checks passed | 100 rules / 38094 entries: plan median 105.4 ms, cold 130.2 ms, content 26.2 ms | basic 1416 ms; actions 112 ms; races 86 ms; seed 40699 ms; performance 41068 ms; calendar 45 ms; clock 16 ms;  | seeds: build 135; snapshot 239; import 37228; load 3092;  SHARED
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/RemindersUITests.swift:21: error: -[HabitsUITests.RemindersUITests testDiag4Swift] : failed - DIAG waited 47 s; Reminders: all checks passed | 100 rules / 38094 entries: plan median 108.1 ms, cold 119.7 ms, content 34.9 ms | basic 1346 ms; actions 119 ms; races 66 ms; seed 46278 ms; performance 46658 ms; calendar 34 ms; clock 9 ms;  | seeds: build 132; snapshot 156; import 43391; load 2581;  SWIFT
Test Case '-[HabitsUITests.RemindersUITests testDiag1Shared]' failed (73.290 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDiag2Swift]' failed (58.607 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDiag3Shared]' failed (47.643 seconds).
Test Case '-[HabitsUITests.RemindersUITests testDiag4Swift]' failed (52.339 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

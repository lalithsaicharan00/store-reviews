# claude/repro-fast-nav-50 @ 745f6a7

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37367189762 · 2026-10-05 20:17 UTC
Commit: Reproduction only: keep the fast ‹ › screen recording (the test fails on purpose)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (FocusPlayerUITests/testFastNavigationNeverSlidesBack): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/FocusPlayerUITests.swift:380: error: -[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack] : failed - Reproduction only: fail so the screen recording is kept
Test Case '-[HabitsUITests.FocusPlayerUITests testFastNavigationNeverSlidesBack]' failed (34.440 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# claude/pensive-gates-3n4ie8-ci6 @ 4144c98

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38140558803 · 2026-10-11 13:50 UTC
Commit: Rulebook U30 and T18: what building the iPad taught (Current Work 86)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (TestLaunchIsolationUITests,OnboardingBackupScreenshotUITests): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 5 tests, with 2 failures (0 unexpected) in 318.124 (318.129) seconds
	 Executed 6 tests, with 2 failures (0 unexpected) in 366.267 (366.274) seconds
	 Executed 6 tests, with 2 failures (0 unexpected) in 366.267 (366.276) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingBackupScreenshotUITests.swift:30: error: -[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome] : failed - Skip setup not found
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/OnboardingBackupScreenshotUITests.swift:90: error: -[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome] : XCTAssertTrue failed - Back returns to the ideas
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testA_Welcome]' failed (136.869 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testB_WelcomeBack]' passed (39.262 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testC_WelcomeReplay]' passed (20.894 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testD_ICloudAndBackup]' passed (100.315 seconds).
Test Case '-[HabitsUITests.OnboardingBackupScreenshotUITests testE_PlusAndPrivacy]' passed (20.785 seconds).
Test Case '-[HabitsUITests.TestLaunchIsolationUITests testATestLaunchLeavesThePersonsWidgetsAndSettings]' passed (48.142 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

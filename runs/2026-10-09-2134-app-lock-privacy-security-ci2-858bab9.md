# app-lock-privacy-security-ci2 @ 858bab9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37993601889 · 2026-10-09 21:34 UTC
Commit: Current Work 76: compile fixes (an await outside an autoclosure, Drive's Keychain query computed); Design Rules and Help match the redesign

- Core storage and migrations: success
- Build: failure
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (BackupUITests,SyncUITests,OnboardingBackupScreenshotUITests,OnboardingUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:142:45: error: instance method 'backupFile(info:)' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:143:45: error: instance method 'automaticBackupFile(info:)' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:144:114: error: property 'format' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:144:23: error: property 'format' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:144:43: error: property 'format' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:144:99: error: property 'format' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:145:120: error: property 'size' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:145:30: error: property 'size' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:145:50: error: property 'size' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:145:98: error: property 'size' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:147:43: error: instance method 'restore(file:mode:info:)' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:147:62: error: property 'base64' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:147:77: error: class property 'replace' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:148:41: error: instance method 'backupFile(info:)' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:149:115: error: property 'habits' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:149:23: error: property 'habits' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:149:38: error: property 'habits' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:149:53: error: property 'entries' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:149:69: error: property 'entries' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:149:87: error: property 'changes' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:149:95: error: property 'habitsAdded' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:150:111: error: property 'habits' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:150:127: error: property 'entries' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:150:59: error: property 'habits' is not available due to missing import of defining module 'Core'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:150:82: error: property 'entries' is not available due to missing import of defining module 'Core'
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

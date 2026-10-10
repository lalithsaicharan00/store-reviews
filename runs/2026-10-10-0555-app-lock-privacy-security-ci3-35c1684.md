# app-lock-privacy-security-ci3 @ 35c1684

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38028870041 · 2026-10-10 05:55 UTC
Commit: Current Work 78 and the server move: free accounts sync on one device, and Move to Another Device goes through the server

- Core storage and migrations: success
- Build: failure
- Release build: skipped
- Same-build speed baseline: skipped
- UI tests (SmallScreenUITests): skipped
- Speed tests: skipped
- Speed tests through XCTest: skipped

## Build errors
```
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:133:18: error: type 'C' (aka 'BackupCenter') has no member 'accountHas'
/Users/runner/work/store-reviews/store-reviews/iOS/Habits/Model/BackupCheck.swift:134:19: error: type 'C' (aka 'BackupCenter') has no member 'accountHas'
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

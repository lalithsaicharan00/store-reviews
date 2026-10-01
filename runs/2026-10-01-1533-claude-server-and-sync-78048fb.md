# claude/server-and-sync @ 78048fb

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36883495612 · 2026-10-01 15:33 UTC
Commit: BackupUITests: read the Where row as one element (LabeledContent)

- Build: success
- UI tests (BackupUITests): failure
- Speed tests: skipped

## UI tests
```
	 Executed 3 tests, with 1 failure (1 unexpected) in 120.252 (120.257) seconds
	 Executed 3 tests, with 1 failure (1 unexpected) in 120.252 (120.258) seconds
	 Executed 3 tests, with 1 failure (1 unexpected) in 120.252 (120.259) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/BackupUITests.swift:143: error: -[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer] : failed: caught error: "Error Domain=NSURLErrorDomain Code=-1001 "The request timed out." UserInfo={_kCFStreamErrorCodeKey=-2102, NSUnderlyingError=0x10a053030 {Error Domain=kCFErrorDomainCFNetwork Code=-1001 "(null)" UserInfo={_kCFStreamErrorCodeKey=-2102, _kCFStreamErrorDomainKey=4}}, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <6E5074FC-05C0-4249-8910-D0D1B9CF7355>.<1>, _NSURLErrorRelatedURLSessionTaskErrorKey=(
Test Case '-[HabitsUITests.BackupUITests testAFreeAccountBacksUpToTheServer]' failed (66.739 seconds).
Test Case '-[HabitsUITests.BackupUITests testTheEmptyFirstScreenOffersRestore]' passed (31.173 seconds).
Test Case '-[HabitsUITests.BackupUITests testWithoutAnAccountEverythingStaysOnThePhone]' passed (22.341 seconds).
```

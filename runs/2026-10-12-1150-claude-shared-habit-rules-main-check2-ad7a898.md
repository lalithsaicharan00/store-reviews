# claude/shared-habit-rules-main-check2 @ ad7a898

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38236705492 · 2026-10-12 11:50 UTC
Commit: Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (WidgetUITests/testEveryFamilyAndLayoutAtIPhoneSizes,WidgetSystemUITests/testLockScreenWidgetPickerAvailability): failure
- Speed tests: skipped
- Speed tests through XCTest: skipped

## UI tests
```
	 Executed 2 tests, with 1 test skipped and 1 failure (0 unexpected) in 338.022 (338.037) seconds
	 Executed 2 tests, with 1 test skipped and 1 failure (0 unexpected) in 338.022 (338.038) seconds
/Users/runner/work/store-reviews/store-reviews/iOS/HabitsUITests/WidgetUITests.swift:58: error: -[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes] : Failed to get matching snapshots: Lost connection to the application (pid 64947). (Underlying Error: Couldn’t communicate with a helper application. Try your operation again. If that fails, quit and relaunch the application and try again. connection to service with pid 64947 created from an endpoint)
Test Case '-[HabitsUITests.WidgetUITests testEveryFamilyAndLayoutAtIPhoneSizes]' failed (221.325 seconds).
```

## Release build
```
** BUILD SUCCEEDED **
```

## App crashes
```
### Habits-2026-10-12-114852.ips
EXC_CRASH SIGABRT
Abort trap: 6
  libsystem_kernel.dylib: __pthread_kill
  libsystem_pthread.dylib: pthread_kill
  libsystem_c.dylib: abort
  libc++abi.dylib: __abort_message
  libc++abi.dylib: demangling_terminate_handler()
  libobjc.A.dylib: _objc_terminate()
  Habits: (anonymous namespace)::TerminateHandler::queuedHandler()::'lambda'()::operator()() const
  Habits: void (anonymous namespace)::$_0::operator()<(anonymous namespace)::TerminateHandler::queuedHandler()::'lambda'()>((anonymous namespace)::TerminateHandler::queuedHandler()::'lambda'())
  Habits: (anonymous namespace)::TerminateHandler::queuedHandler()
  Habits: (anonymous namespace)::TerminateHandler::kotlinHandler()
  libc++abi.dylib: std::__terminate(void (*)())
  libc++abi.dylib: __cxa_rethrow
  libobjc.A.dylib: objc_exception_rethrow
  XCTAutomationSupport: +[XCTRuntimeIssueContext captureIssuesWithContext:inScope:]
  XCTAutomationSupport: __90-[XCTElementQuery matchingSnapshotsInSnapshotTree:relatedElements:noMatchesMessage:error:]_block_invoke
  XCTAutomationSupport: __XCTPerformOnMainRunLoop_block_invoke
  CoreFoundation: __CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__
  CoreFoundation: __CFRunLoopDoBlocks
```

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

# claude/perf-bisect-v3 @ 3e20c50

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37172464440 · 2026-10-04 03:07 UTC
Commit: Speed bisect variant v3 (not for merging)

- Core storage and migrations: success
- Build: success
- Release build: success
- Same-build speed baseline: skipped
- UI tests (none): skipped
- Speed tests: success
- Speed tests through XCTest: skipped

## Release build
```
** BUILD SUCCEEDED **
```

## Speed (the app drives itself, no XCTest attached; compare runs, not absolute numbers)

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms | Main thread busy | Most time in the app's own code |
|---|---|---|---|---|---|
| Today: +1 and day ‹ › | 37.3 | 86 ms | 0 | 2.9 % (separate profile) | 0.5%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.5%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.5%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.4%  kotlin::CalledFromNativeGuard::CalledFromNativeGuard(bool) |
| Today: +1 alone | 4.6 | 45 ms | 0 | 2.9 % (separate profile) | 0.5%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.5%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.5%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.4%  kotlin::CalledFromNativeGuard::CalledFromNativeGuard(bool) |
| Today: day ‹ › alone | 35.8 | 102 ms | 1 | 2.9 % (separate profile) | 0.5%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.5%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.5%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.4%  kotlin::CalledFromNativeGuard::CalledFromNativeGuard(bool) |
| Today: Day sheet scrolling | 2.7 | 28 ms | 0 | 2.9 % (separate profile) | 0.5%  kotlin::objc_support::RunLoopSource::perform(void*)<br>0.5%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.5%  kotlin::alloc::RunLoopFinalizerProcessor<kotlin::alloc::AtomicStack<kotlin::alloc::ExtraObjectCell>, kotlin::a<br>0.4%  kotlin::CalledFromNativeGuard::CalledFromNativeGuard(bool) |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Today: a row's Day sheet (first): longest stall 834 ms
- Today: a row's Day sheet (again): longest stall 306 ms
- Today: the note sheet: longest stall 552 ms

Timed work on the main thread (MainThreadMeter.time; the slowest first within each scenario):

| Scenario | What | Times | Total | Longest |
|---|---|---|---|---|
| tap-today | Widgets: one habit's month | 18 | 77 ms | 39.5 ms |
| tap-today | Reminders: plan every alert | 51 | 4 ms | 0.6 ms |
| tap-today | Change: Siri's habit names | 54 | 3 ms | 0.2 ms |
| tap-today | Widgets: the snapshot | 2 | 1 ms | 0.9 ms |
| tap-today | Count: Today's list drawn | 85 | 0 ms | 0.2 ms |
| tap-today | Count: a Today row drawn | 215 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet drawn | 15 | 0 ms | 0.0 ms |
| tap-today | Count: the Day sheet's entries drawn | 6 | 0 ms | 0.0 ms |

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

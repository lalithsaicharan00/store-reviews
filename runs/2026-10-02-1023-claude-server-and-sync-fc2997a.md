# claude/server-and-sync @ fc2997a

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36990445257 · 2026-10-02 10:23 UTC
Commit: Speed runs: 'form-parts' splits the habit form's opening into the form alone, the first keyboard and a later one

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
| Habit form: typing | 25.9 | 98 ms | 0 | 6.3 % (separate profile) | 0.8%  partial apply for specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.8%  specialized thunk for @escaping @isolated(any) @callee_guaranteed @async () -> (@out A)<br>0.6%  partial apply for closure #1 in AppModel.ensureLoaded()<br>0.6%  closure #1 in AppModel.ensureLoaded() |

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Habit form, no keyboard (first): longest stall 562 ms
- Habit form, no keyboard (again): longest stall 239 ms
- Habit form, the launch's first keyboard: longest stall 2082 ms
- Habit form, keyboard again: longest stall 219 ms
- New Habit (first): longest stall 384 ms
- New Habit (again): longest stall 166 ms
- Habit form (first): longest stall 1025 ms
- Habit form (again): longest stall 283 ms

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

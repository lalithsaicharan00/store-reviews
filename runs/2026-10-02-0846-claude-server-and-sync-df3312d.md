# claude/server-and-sync @ df3312d

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36983744562 · 2026-10-02 08:46 UTC
Commit: Speed runs: a blank page pushed like a menu page, the control for 'opening a screen' stalls

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

Timing runs have no profiler attached. Main-thread busy and function names come from separate profiling launches. Command delivery does not invalidate covered screens (30 Sep 2026).

Opening a screen (longest stall in the 1.5 s after the command; under 100 ms feels instant):

- Blank page (control, first): longest stall 807 ms
- Tasks: longest stall 418 ms
- Times of Day: longest stall 184 ms
- Day and Week: longest stall 344 ms
- Reminders: longest stall 275 ms
- Appearance: longest stall 245 ms
- Backup & Export: longest stall 253 ms
- Privacy: longest stall 214 ms
- Plus: longest stall 108 ms
- Help & Feedback: longest stall 380 ms
- About: longest stall 200 ms
- Blank page (control, again): longest stall 118 ms

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

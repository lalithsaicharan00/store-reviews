# claude/server-and-sync @ 5d095bb

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/36986140791 · 2026-10-02 09:31 UTC
Commit: Speed runs: every menu page opens twice (first and again), between the blank-page controls

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

- Blank page (control, first): longest stall 187 ms
- Tasks (first): longest stall 194 ms
- Tasks (again): longest stall 125 ms
- Times of Day (first): longest stall 125 ms
- Times of Day (again): longest stall 107 ms
- Day and Week (first): longest stall 251 ms
- Day and Week (again): longest stall 150 ms
- Reminders (first): longest stall 222 ms
- Reminders (again): longest stall 236 ms
- Appearance (first): longest stall 346 ms
- Appearance (again): longest stall 184 ms
- Backup & Export (first): longest stall 148 ms
- Backup & Export (again): longest stall 231 ms
- Privacy (first): longest stall 141 ms
- Privacy (again): longest stall 167 ms
- Plus (first): longest stall 194 ms
- Plus (again): longest stall 157 ms
- Help & Feedback (first): longest stall 348 ms
- Help & Feedback (again): longest stall 169 ms
- About (first): longest stall 212 ms
- About (again): longest stall 185 ms
- Blank page (control, again): longest stall 197 ms

## Native analytics checks
```
Analytics contract: 101 checks passed; inspected 3 outgoing envelopes. No network requests.
```

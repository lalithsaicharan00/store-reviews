# Easy Undo and Fixing Progress

Written by Claude (Claude Code), 30 September 2026. Build Plan #57.

**Context (the user's words, tidied):** next is easy undo after checking or logging. A snackbar is fine, but there should be several ways to undo. The routine player already shows an undo message; other places don't. Undo doesn't need to be generic: whatever was logged can be undone, and if it was logged by hand it can be changed again. Once someone has logged and moved away from the screen, they need a way to edit that log or today's progress. Research first: how undo should work, where people expect it, whether the habit page needs something (a way to change today's progress? a dedicated space near the top?), all for the best experience. Report back before building.

Research: [Undo and Fixing Progress — What People Expect](<../../../Research/Research Reports/Day Structure and Organization/Undo and Fixing Progress — What People Expect.md>).

| # | Point | State |
|---|---|---|
| U1 | Research how undo should work and where people expect it | [x] 2,677 reviews read, 1,084 on topic |
| U2 | Is a snackbar enough, or several ways? | [x] Several ways; no floating snackbar on Today, an inline Undo on the logged row instead |
| U3 | Undo per log, not generic | [x] Undo removes the exact entry and everything it caused |
| U4 | A way to fix a log after leaving the screen | [x] One Day sheet (entries, add/change/delete, done/not, skip) |
| U5 | Anything on the habit page? A dedicated space up front? | [x] A small "Today" row near the top and a tap on any calendar day, both open the Day sheet; not a large section |
| U6 | Routine player: does it need more undo options or confirmations? | [x] No confirmations; everything else already exists. Only change: a small visible "Undo" under a habit this routine completed (30 Sep, agreed with the user) |
| U7 | Build it | [x] Native Day sheet, shared entries, Today/calendar entry points, inline Undo, routine Undo and slip editing implemented |
| U8 | Meet the performance guide’s timing targets | [ ] Measurement is complete; remaining timing failures are recorded below |

Implementation by Codex, 30 September 2026. The user requested native iOS controls, all changes on
`claude/undo-research`, and performance as the highest priority. No local builds, tests or simulator runs.
`perf-smooth-app` is merged into this branch, including its rules, caches and optimised build settings.
The new forms use the indexed habit/day entries. Entry corrections retain the ID, tracking day and source;
SQLite updates only a live row, so editing never revives a deleted entry. Schema 6 adds a nullable source,
leaving older logs honestly labelled “Source not recorded”.

Validation is through the macOS Actions workflow: existing Today/Timer tests, UndoUITests, Core migration/storage
tests, and the self-driven performance scenarios (including Day sheet, Log sheet, entry editing and exact undo).
Validated code: `f0d9445`, [macOS Actions run 36718621499](https://github.com/lalithsaicharan00/store-reviews/actions/runs/36718621499).

- Performance rules, Core storage/migration tests and iOS build: passed.
- Today, Timer and Undo UI checks: **12 passed, 0 failed**. These cover safe calendar opening, exact persistent
  inline/routine Undo, shared entry editing/deletion, Done/Not done, skip/unskip, timer-stop sheet lifetime,
  seconds editing, stats/reminder restoration and persistence. Model checks also cover travel and daylight-saving bounds.
- All nine performance scenarios completed with native keyboard input and no measurement errors. Timing launches
  run without a profiler; separate launches collect diagnostic samples. Screenshots are in the run’s `ios-review` artifact.
- No local builds, tests, performance scripts or simulator runs were used.

Performance is **not fully signed off**. The Actions speed step verifies complete measurements; its green result
is not a timing-threshold gate. The guide’s targets remain unchanged: under 5 ms/s hitch time, no ≥100 ms freezes,
and openings below 100 ms. The final measurements include:

| Interaction | Hitch time (ms/s) | Longest stall | ≥100 ms freezes |
|---|---:|---:|---:|
| Habit page scrolling | 1.2 | 26 ms | 0 |
| Day entries scrolling | 4.7 | 37 ms | 0 |
| Log entries scrolling | 5.9 | 45 ms | 0 |
| Entry typing from Day | 106.9 | 61 ms | 0 |
| Entry typing from Log | 87.5 | 78 ms | 0 |
| Log input typing | 198.9 | 290 ms | 4 |
| Rapid add/edit/exact undo from Day | 109.7 | 84 ms | 0 |
| Rapid add/edit/exact undo after Log | 74.5 | 164 ms | 1 |

The preceding run (`de4269a`, 36713736531) recorded 323.9/348.0 ms/s and 30/35 freezes in the same rapid-correction
windows. Updating an entry in place and coalescing observation notifications reduced those repeated native list
flushes; memory/index changes are immediate and every database write remains queued in order. Typed drafts isolate
field strings from the surrounding Form. No custom controls, per-screen clocks or full-history copies were added.

Typing, correction hitch ratios and openings still exceed the guide. Day openings measured 331/398 ms on repeat;
entry-editor openings measured 2494 ms with the first keyboard and 530 ms after it. Existing screens also exceed
these targets (see the full run summary). Hosted-runner measurements vary, and the older baseline used a different
profiling/input method, so these results do **not** establish zero regressions or device-level latency. Remaining
performance work must use the actual timing/profile artifacts; do not mark U8 complete from CI status alone.

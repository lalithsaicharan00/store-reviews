# claude/pensive-gates-3n4ie8-perf7 @ 0d913a1 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38146701137 · 2026-10-11 15:34 UTC
Commit: Speed bisect: Columns lists that shrink only after the taps, against growing and shrinking at once [ios-perf-bisect] perf-variants: before=5d1ca265 after=HEAD~1 perf-scenarios: pad-columns perf-rounds: 4 perf-device: iPad Air 11-inch

Variants: `before=5d1ca265 after=HEAD~1` · scenarios: `pad-columns` · rounds: 4

- before: 5d1ca265 Current Work 86: each Columns list holds its own height, so a column that changes redraws only itself
- after: 7a882174 Current Work 86: a Columns list grows at once but shrinks only once the taps stop

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | before | after |
|---|---|---|
| iPad Columns: scrolling sideways | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.1**<br>0.1 (18, 0), 0 (0, 0), 0 (0, 0), 1.9 (44, 0) |
| iPad Columns: scrolling down | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| iPad Columns: +1 and day ‹ › | **598.4**<br>701.5 (1794, 35), 573.4 (444, 39), 598.4 (454, 38) | **629.7**<br>642.1 (479, 42), 617.3 (508, 39), 571.5 (368, 36), 770.5 (713, 46) |

# claude/shared-habit-rules-perf4 @ 31e122b (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38229397046 · 2026-10-12 12:02 UTC
Commit: Current Work 92: speed side by side with main, part 4 (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `widget-publish day-sheet` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: 31e122b9 Current Work 92: speed side by side with main, part 4 (scratch, safe to delete) [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Widget: full publication, every habit's week | **0.0**<br>10 (161, 1), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **3.8**<br>3.9 (69, 0), 3.7 (72, 0), 5.6 (101, 1), 0 (0, 0) |
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **0.9**<br>7 (62, 0), 0.7 (20, 0), 0.7 (23, 0), 1.1 (22, 0) | **1.3**<br>11.9 (90, 0), 0.3 (19, 0), 0.2 (18, 0), 2.4 (22, 0) |
| Day sheet: add, edit and exact undo | **240.9**<br>245.9 (115, 3), 197.2 (94, 0), 235.8 (95, 0), 279.5 (110, 2) | **502.4**<br>497.4 (158, 35), 765.1 (351, 58), 476.5 (193, 37), 507.4 (188, 37) |

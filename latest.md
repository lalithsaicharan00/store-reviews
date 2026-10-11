# claude/pensive-gates-3n4ie8-perf6 @ 462211e (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38138422562 · 2026-10-11 14:17 UTC
Commit: Speed bisect: Day details' add, edit and undo, the iPad build against main on the iPhone, six rounds [ios-perf-bisect] perf-variants: main=bac8a1b5 branch=HEAD~1 perf-scenarios: day-sheet perf-rounds: 6

Variants: `main=bac8a1b5 branch=HEAD~1` · scenarios: `day-sheet` · rounds: 6

- main: bac8a1b5 Current Work 88: coming back to the iPhone after using the iPad, "Use your habits on this iPhone?" (t
- branch: fc7ec608 Current Work 86: the calendar popover keeps one height as the month changes

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **0.6**<br>8.6 (57, 0), 0.6 (23, 0), 3.5 (30, 0), 0.2 (20, 0), 0.6 (23, 0), 0.7 (22, 0) | **2.0**<br>1.7 (30, 0), 2.2 (34, 0), 6.8 (79, 0), 1.9 (34, 0), 4.8 (36, 0), 1.2 (31, 0) |
| Day sheet: add, edit and exact undo | **197.3**<br>572 (4406, 10), 166.5 (110, 1), 195.1 (86, 0), 199.2 (134, 1), 253.2 (104, 3), 195.4 (136, 2) | **207.2**<br>195.5 (104, 1), 177.4 (107, 1), 235.8 (101, 1), 218.8 (120, 1), 280.2 (108, 2), 184.2 (99, 0) |

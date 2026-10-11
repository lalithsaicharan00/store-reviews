# claude/pensive-gates-3n4ie8-perf2 @ 190dea6 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38131506855 · 2026-10-11 12:12 UTC
Commit: Speed bisect: the iPad build against main on the iPhone, side by side, four rounds [ios-perf-bisect] perf-variants: main=bac8a1b5 branch=HEAD~1 perf-scenarios: day-sheet menu perf-rounds: 4

Variants: `main=bac8a1b5 branch=HEAD~1` · scenarios: `day-sheet menu` · rounds: 4

- main: bac8a1b5 Current Work 88: coming back to the iPhone after using the iPad, "Use your habits on this iPhone?" (t
- branch: 7aca590e Current Work 86: container ids keep their rows' own (T9), the sidebar command names itself, onboardin

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **0.2**<br>6.2 (42, 0), 0.2 (20, 0), 0.1 (18, 0), 0 (17, 0) | **1.2**<br>2 (28, 0), 5.7 (41, 0), 0.5 (21, 0), 0 (0, 0) |
| Day sheet: add, edit and exact undo | **151.4**<br>226.6 (121, 3), 155.5 (99, 0), 147.3 (78, 0), 103.3 (71, 0) | **193.2**<br>249.6 (102, 1), 250 (99, 0), 88.7 (62, 0), 136.8 (125, 2) |
| Menu: open and close | **54.2**<br>64.8 (144, 4), 62 (117, 3), 46.5 (164, 2), 28.3 (76, 0) | **54.2**<br>57.4 (124, 4), 90.6 (147, 8), 21.9 (87, 0), 51 (128, 2) |

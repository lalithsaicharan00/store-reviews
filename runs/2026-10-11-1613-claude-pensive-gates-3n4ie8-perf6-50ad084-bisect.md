# claude/pensive-gates-3n4ie8-perf6 @ 50ad084 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38146866448 · 2026-10-11 16:13 UTC
Commit: Speed bisect: Day details and Today's scrolling, the final iPad build against main on the iPhone, six rounds [ios-perf-bisect] perf-variants: main=bac8a1b5 branch=HEAD~1 perf-scenarios: day-sheet scroll-today perf-rounds: 6

Variants: `main=bac8a1b5 branch=HEAD~1` · scenarios: `day-sheet scroll-today` · rounds: 6

- main: bac8a1b5 Current Work 88: coming back to the iPhone after using the iPad, "Use your habits on this iPhone?" (t
- branch: 3f876f91 Current Work 86: the popover-measuring modifiers are nothing at all on the iPhone

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **2.9**<br>13.4 (72, 0), 0 (17, 0), 2.9 (34, 0), 0.4 (23, 0), 2.9 (33, 0), 3.1 (30, 0) | **1.6**<br>4.4 (29, 0), 1.4 (24, 0), 0.2 (18, 0), 2.7 (42, 0), 0.6 (21, 0), 1.9 (26, 0) |
| Day sheet: add, edit and exact undo | **188.4**<br>393.2 (478, 11), 166.9 (108, 1), 182.3 (96, 0), 194.5 (85, 0), 196.6 (84, 0), 148.4 (84, 0) | **226.4**<br>206.8 (120, 2), 274.6 (160, 6), 211.9 (110, 1), 144.5 (95, 0), 240.8 (102, 1), 322.6 (144, 6) |
| Today: scrolling | **11.3**<br>26.9 (343, 1), 7.6 (53, 0), 10.8 (127, 1), 11.8 (113, 1), 16.4 (116, 2), 5.3 (44, 0) | **17.6**<br>6.7 (53, 0), 22.1 (149, 2), 15.8 (116, 1), 8.9 (62, 0), 19.5 (235, 1), 25.7 (136, 3) |

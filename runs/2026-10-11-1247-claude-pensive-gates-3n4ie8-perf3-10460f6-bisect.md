# claude/pensive-gates-3n4ie8-perf3 @ 10460f6 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38131508291 · 2026-10-11 12:47 UTC
Commit: Speed bisect: the iPad build against main on the iPhone, side by side, four rounds [ios-perf-bisect] perf-variants: main=bac8a1b5 branch=HEAD~1 perf-scenarios: progress all-habits perf-rounds: 4

Variants: `main=bac8a1b5 branch=HEAD~1` · scenarios: `progress all-habits` · rounds: 4

- main: bac8a1b5 Current Work 88: coming back to the iPhone after using the iPad, "Use your habits on this iPhone?" (t
- branch: 7aca590e Current Work 86: container ids keep their rows' own (T9), the sidebar command names itself, onboardin

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Progress: scrolling | **3.7**<br>10.9 (52, 0), 0 (0, 0), 5.1 (36, 0), 2.3 (35, 0) | **4.1**<br>4.9 (33, 0), 5.6 (37, 0), 3.3 (40, 0), 1.6 (30, 0) |
| Progress: period ‹ › and range | **106.7**<br>157.2 (163, 9), 68 (107, 1), 133.3 (180, 8), 80.1 (99, 0) | **104.0**<br>177.5 (173, 13), 86.6 (82, 0), 89.6 (147, 3), 118.4 (140, 3) |
| Progress: key fold and open | **0.7**<br>0.7 (28, 0), 0.2 (19, 0), 1.5 (40, 0), 0.7 (28, 0) | **0.5**<br>2.9 (60, 0), 0 (0, 0), 0 (0, 0), 1 (33, 0) |
| All Habits: scrolling | **2.5**<br>3.7 (27, 0), 3.2 (34, 0), 1.3 (25, 0), 1.8 (29, 0) | **3.6**<br>3 (30, 0), 4.1 (34, 0), 10.1 (63, 0), 3.1 (41, 0) |

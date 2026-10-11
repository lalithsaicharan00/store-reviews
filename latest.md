# claude/pensive-gates-3n4ie8-perf @ 6e73601 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38131504505 · 2026-10-11 12:13 UTC
Commit: Speed bisect: the iPad build against main on the iPhone, side by side, four rounds [ios-perf-bisect] perf-variants: main=bac8a1b5 branch=HEAD~1 perf-scenarios: scroll-today tap-today perf-rounds: 4

Variants: `main=bac8a1b5 branch=HEAD~1` · scenarios: `scroll-today tap-today` · rounds: 4

- main: bac8a1b5 Current Work 88: coming back to the iPhone after using the iPad, "Use your habits on this iPhone?" (t
- branch: 7aca590e Current Work 86: container ids keep their rows' own (T9), the sidebar command names itself, onboardin

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Today: scrolling | **10.6**<br>0 (0, 0), 10.7 (102, 1), 10.4 (48, 0), 21.6 (133, 1) | **4.1**<br>0 (0, 0), 0 (0, 0), 11.2 (67, 0), 8.2 (50, 0) |
| Today: +1 and day ‹ › | **48.8**<br>45.4 (75, 0), 71.9 (94, 0), 52.2 (67, 0), 41.9 (56, 0) | **55.4**<br>57.2 (102, 1), 85.5 (308, 2), 50.3 (73, 0), 53.6 (78, 0) |
| Today: +1 alone | **1.3**<br>2.4 (37, 0), 4.8 (59, 0), 0 (0, 0), 0.2 (20, 0) | **0.6**<br>0.6 (26, 0), 7.4 (62, 0), 0.4 (24, 0), 0.5 (24, 0) |
| Today: day ‹ › alone | **47.5**<br>51.7 (119, 2), 66 (105, 1), 38.5 (54, 0), 43.3 (53, 0) | **51.4**<br>31.1 (56, 0), 53 (70, 0), 49.7 (54, 0), 54.4 (77, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **3.7**<br>7.4 (94, 0), 10.2 (71, 0), 0 (0, 0), 0 (0, 0) |

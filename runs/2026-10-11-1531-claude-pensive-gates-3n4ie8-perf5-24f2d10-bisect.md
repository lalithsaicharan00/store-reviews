# claude/pensive-gates-3n4ie8-perf5 @ 24f2d10 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38146864538 · 2026-10-11 15:31 UTC
Commit: Speed bisect: the habit page and Today's taps, the final iPad build against main on the iPhone, six rounds [ios-perf-bisect] perf-variants: main=bac8a1b5 branch=HEAD~1 perf-scenarios: habit-page tap-today perf-rounds: 6

Variants: `main=bac8a1b5 branch=HEAD~1` · scenarios: `habit-page tap-today` · rounds: 6

- main: bac8a1b5 Current Work 88: coming back to the iPhone after using the iPad, "Use your habits on this iPhone?" (t
- branch: 3f876f91 Current Work 86: the popover-measuring modifiers are nothing at all on the iPhone

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Habit page: History scrolling | **5.5**<br>6.5 (67, 0), 4.6 (74, 0), 7.2 (46, 0), 1.5 (40, 0), 7.2 (105, 1), 2.8 (42, 0) | **5.2**<br>6.8 (74, 0), 5.5 (75, 0), 15.9 (190, 1), 3.2 (64, 0), 4.8 (85, 0), 0.9 (31, 0) |
| Habit page: Progress scrolling | **11.7**<br>43.8 (196, 1), 14.9 (128, 1), 8.5 (59, 0), 8.4 (120, 1), 17.7 (219, 1), 6.1 (94, 0) | **10.8**<br>25.7 (196, 1), 19.7 (61, 0), 17.1 (149, 1), 4.5 (60, 0), 4.1 (70, 0), 2 (47, 0) |
| Habit page: switching tabs | **28.0**<br>68.5 (75, 0), 24.4 (50, 0), 46.9 (90, 0), 1.4 (38, 0), 14.3 (43, 0), 31.6 (56, 0) | **10.4**<br>36.5 (71, 0), 17.2 (44, 0), 21.3 (71, 0), 3.7 (35, 0), 0 (0, 0), 2.5 (38, 0) |
| Today: +1 and day ‹ › | **70.7**<br>126.6 (152, 2), 80.9 (102, 1), 94.8 (138, 2), 49.5 (107, 2), 25 (101, 1), 60.4 (118, 1) | **42.5**<br>95.4 (127, 1), 51.2 (113, 1), 37.8 (53, 0), 28.8 (77, 0), 16.3 (52, 0), 47.2 (76, 0) |
| Today: +1 alone | **8.3**<br>18.7 (88, 0), 8.5 (85, 0), 8.2 (89, 0), 0.4 (20, 0), 0.9 (29, 0), 13.1 (86, 0) | **1.6**<br>2.5 (49, 0), 1 (26, 0), 3.4 (35, 0), 2.2 (40, 0), 0.6 (26, 0), 1 (23, 0) |
| Today: day ‹ › alone | **83.0**<br>144.9 (110, 3), 113.1 (93, 0), 134.8 (122, 4), 26.7 (57, 0), 15.4 (37, 0), 52.9 (80, 0) | **66.8**<br>67.3 (68, 0), 66.4 (80, 0), 95.3 (160, 1), 73.2 (90, 0), 25.2 (55, 0), 26 (51, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **0.3**<br>1.4 (37, 0), 0.6 (20, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 1.2 (35, 0) | **0.0**<br>1.6 (31, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |

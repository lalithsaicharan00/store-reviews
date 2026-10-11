# claude/pensive-gates-3n4ie8-perf4 @ d793e7c (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38131509630 · 2026-10-11 11:05 UTC
Commit: Speed bisect: the iPad build against main on the iPhone, side by side, four rounds [ios-perf-bisect] perf-variants: main=bac8a1b5 branch=HEAD~1 perf-scenarios: new-habit habit-page perf-rounds: 4

Variants: `main=bac8a1b5 branch=HEAD~1` · scenarios: `new-habit habit-page` · rounds: 4

- main: bac8a1b5 Current Work 88: coming back to the iPhone after using the iPad, "Use your habits on this iPhone?" (t
- branch: 7aca590e Current Work 86: container ids keep their rows' own (T9), the sidebar command names itself, onboardin

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Habit form: typing | **23.0**<br>37.1 (88, 0), 21.4 (145, 1), 24.6 (130, 1), 14.1 (53, 0) | **22.5**<br>94.4 (457, 3), 23.2 (103, 1), 19.1 (64, 0), 21.9 (79, 0) |
| Habit page: History scrolling | **6.9**<br>20.6 (126, 1), 7.3 (96, 0), 5.1 (87, 0), 6.6 (47, 0) | **7.4**<br>7.7 (117, 1), 7.1 (66, 0), 7.8 (130, 1), 5.3 (63, 0) |
| Habit page: Progress scrolling | **7.0**<br>14 (116, 1), 6 (74, 0), 5.3 (48, 0), 7.9 (48, 0) | **13.8**<br>28.1 (300, 1), 10.2 (106, 1), 17.5 (87, 0), 7.9 (54, 0) |
| Habit page: switching tabs | **26.5**<br>2.6 (48, 0), 35.2 (65, 0), 17.7 (76, 0), 65.2 (84, 0) | **29.4**<br>35.7 (110, 1), 34.4 (53, 0), 0.8 (30, 0), 24.3 (43, 0) |

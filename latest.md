# claude/shared-habit-rules-perf18 @ b1309ea (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38292280118 · 2026-10-12 19:44 UTC
Commit: Current Work 92: speed side by side with main, every strip in one call (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `habit-page progress` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: b1309eaa Current Work 92: speed side by side with main, every strip in one call (scratch, safe to delete) [ios

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Habit page: History scrolling | **3.9**<br>8.4 (90, 0), 4.1 (71, 0), 3.8 (59, 0), 1.9 (45, 0) | **7.4**<br>7.4 (100, 1), 7.4 (112, 1), 12.7 (132, 1), 2.6 (56, 0) |
| Habit page: Progress scrolling | **15.2**<br>27.2 (167, 2), 12.8 (80, 0), 17.5 (94, 0), 4.2 (68, 0) | **11.1**<br>38.6 (250, 1), 6.9 (41, 0), 15.3 (79, 0), 1 (23, 0) |
| Habit page: switching tabs | **10.3**<br>17 (76, 0), 22 (108, 1), 3.7 (43, 0), 1.2 (28, 0) | **4.6**<br>38.1 (65, 0), 6.4 (70, 0), 2.8 (36, 0), 0.9 (28, 0) |
| Progress: scrolling | **19.4**<br>32.4 (217, 2), 19.9 (73, 0), 18.8 (56, 0), 0 (0, 0) | **15.4**<br>17.2 (74, 0), 13.6 (44, 0), 18.3 (58, 0), 7.8 (51, 0) |
| Progress: period ‹ › and range | **152.3**<br>185.6 (163, 11), 152 (196, 5), 152.7 (232, 9), 109.7 (117, 4) | **127.3**<br>144.9 (155, 10), 135.5 (227, 5), 119.2 (169, 6), 90 (110, 1) |
| Progress: key fold and open | **2.0**<br>2.9 (62, 0), 2.8 (61, 0), 1 (32, 0), 1.3 (37, 0) | **1.6**<br>2.6 (56, 0), 0.9 (31, 0), 2.4 (55, 0), 0.7 (28, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 8352 · 1938.2 | 16 · 6248 · 1070.5 |
| Widgets: one habit's week | 136 · 998 · 89.1 | 136 · 1256 · 118.6 |
| Store load: into the app (5593 logs) | 8 · 550 · 89.4 | 8 · 513 · 76.0 |
| Habit page: overall record | 4 · 71 · 49.4 | 4 · 45 · 14.8 |
| Habit page: milestones | 4 · 43 · 16.2 | 4 · 33 · 12.0 |
| Habit page: history | 4 · 36 · 10.9 | 4 · 41 · 11.6 |
| Store load: into the app (0 logs) | 8 · 21 · 5.2 | 8 · 14 · 2.5 |
| Widgets: the snapshot | 8 · 21 · 6.8 | 8 · 24 · 6.8 |
| Reminders: plan every alert | 8 · 4 · 1.8 | 8 · 9 · 5.4 |
| Count: Today's list drawn | 146 · 3 · 0.8 | 149 · 6 · 5.3 |
| Count: a Today row drawn | 1246 · 0 · 0.1 | 1221 · 0 · 0.1 |
| Shared rules: built from every log | – | 32 · 279 · 44.9 |
| Shared rules: habits and settings again | – | 40 · 38 · 6.9 |
| Progress year: whole snapshot | 8 · 187 · 31.4 | 8 · 347 · 54.2 |
| Progress year: cards | 8 · 185 · 31.2 | 8 · 347 · 53.9 |
| Progress year: one card | 120 · 170 · 4.9 | 120 · 328 · 10.3 |
| Progress week: whole snapshot | 8 · 54 · 9.9 | 8 · 51 · 12.1 |
| Progress week: cards | 8 · 52 · 9.6 | 8 · 46 · 11.9 |
| Progress week: one card | 120 · 42 · 8.1 | 120 · 38 · 7.1 |
| Progress month: whole snapshot | 8 · 35 · 7.4 | 8 · 53 · 11.9 |
| Progress month: cards | 8 · 33 · 7.0 | 8 · 53 · 11.6 |
| Progress month: one card | 120 · 24 · 1.4 | 120 · 43 · 2.1 |
| Progress year: one quit card | 8 · 2 · 0.5 | 8 · 3 · 0.6 |
| Progress week: one quit card | 16 · 3 · 0.7 | 16 · 4 · 0.5 |
| Progress month: one quit card | 16 · 1 · 0.3 | 16 · 2 · 0.4 |

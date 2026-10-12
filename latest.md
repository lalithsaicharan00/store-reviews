# claude/shared-habit-rules-perf10 @ e30c345 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38261431401 · 2026-10-12 15:03 UTC
Commit: Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `habit-page progress` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: e30c3457 Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Habit page: History scrolling | **3.9**<br>12.6 (103, 1), 4.6 (72, 0), 3.3 (66, 0), 2.4 (52, 0) | **6.2**<br>17.9 (136, 2), 2.2 (47, 0), 6.7 (97, 0), 5.6 (66, 0) |
| Habit page: Progress scrolling | **8.7**<br>49 (258, 4), 6.3 (43, 0), 11 (69, 0), 4 (43, 0) | **10.2**<br>10.6 (62, 0), 5.1 (40, 0), 9.9 (60, 0), 15.6 (69, 0) |
| Habit page: switching tabs | **8.1**<br>16.1 (84, 0), 14 (177, 1), 2.1 (32, 0), 1 (22, 0) | **2.1**<br>2.6 (34, 0), 1.6 (34, 0), 1.3 (30, 0), 5.8 (50, 0) |
| Progress: scrolling | **11.6**<br>35.8 (149, 3), 9.1 (40, 0), 3.3 (35, 0), 14 (47, 0) | **11.9**<br>32.5 (87, 0), 17.8 (52, 0), 3.9 (28, 0), 5.9 (36, 0) |
| Progress: period ‹ › and range | **107.4**<br>174.5 (189, 13), 111 (128, 4), 103.8 (137, 2), 86 (166, 2) | **124.4**<br>162.2 (252, 7), 113.4 (136, 3), 119 (171, 5), 129.8 (169, 7) |
| Progress: key fold and open | **1.2**<br>0.5 (25, 0), 1.1 (34, 0), 1.6 (42, 0), 1.3 (37, 0) | **0.3**<br>1.5 (40, 0), 0 (0, 0), 0.6 (26, 0), 0.1 (18, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 7317 · 1701.8 | 16 · 6325 · 1221.8 |
| Widgets: one habit's week | 136 · 939 · 126.8 | 136 · 1063 · 125.6 |
| Store load: into the app (5593 logs) | 8 · 632 · 120.0 | 8 · 522 · 92.2 |
| Habit page: milestones | 4 · 42 · 15.2 | 4 · 36 · 11.7 |
| Habit page: overall record | 4 · 44 · 15.2 | 4 · 71 · 21.6 |
| Habit page: history | 4 · 25 · 8.8 | 4 · 69 · 19.3 |
| Store load: into the app (0 logs) | 8 · 22 · 4.7 | 8 · 21 · 6.2 |
| Widgets: the snapshot | 8 · 21 · 5.8 | 8 · 21 · 7.0 |
| Reminders: plan every alert | 8 · 7 · 4.8 | 8 · 7 · 4.8 |
| Count: Today's list drawn | 141 · 0 · 0.2 | 158 · 2 · 1.0 |
| Count: a Today row drawn | 952 · 0 · 0.1 | 980 · 0 · 0.0 |
| Shared rules: built from every log | – | 32 · 290 · 45.8 |
| Shared rules: habits and settings again | – | 40 · 33 · 6.2 |
| Progress year: whole snapshot | 8 · 171 · 34.1 | 8 · 457 · 99.1 |
| Progress year: cards | 8 · 170 · 33.9 | 8 · 457 · 99.0 |
| Progress year: one card | 120 · 160 · 5.6 | 120 · 441 · 13.1 |
| Progress week: whole snapshot | 8 · 55 · 13.2 | 8 · 77 · 19.4 |
| Progress week: cards | 8 · 53 · 12.9 | 8 · 72 · 18.0 |
| Progress week: one card | 120 · 44 · 10.8 | 120 · 64 · 15.5 |
| Progress month: whole snapshot | 8 · 24 · 4.9 | 8 · 76 · 12.0 |
| Progress month: cards | 8 · 24 · 4.7 | 8 · 74 · 11.9 |
| Progress month: one card | 120 · 19 · 0.6 | 120 · 62 · 2.3 |
| Progress week: one quit card | 16 · 3 · 0.6 | 16 · 4 · 0.7 |
| Progress year: one quit card | 8 · 0 · 0.3 | 8 · 1 · 0.4 |
| Progress month: one quit card | 16 · 0 · 0.2 | 16 · 3 · 0.5 |

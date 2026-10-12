# claude/shared-habit-rules-perf15 @ be9c363 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38282620234 · 2026-10-12 18:00 UTC
Commit: Current Work 92: final speed side by side with main, strips in one call (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `habit-page progress` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: be9c3639 Current Work 92: final speed side by side with main, strips in one call (scratch, safe to delete) [io

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Habit page: History scrolling | **4.2**<br>0 (0, 0), 5.7 (84, 0), 8.9 (134, 1), 2.7 (56, 0) | **7.0**<br>18.5 (125, 1), 5.2 (81, 0), 6.3 (95, 0), 7.8 (134, 1) |
| Habit page: Progress scrolling | **4.2**<br>0 (0, 0), 12 (56, 0), 2.8 (29, 0), 5.5 (52, 0) | **16.6**<br>57.5 (248, 5), 29.2 (245, 1), 3.6 (35, 0), 4.1 (42, 0) |
| Habit page: switching tabs | **1.6**<br>0 (0, 0), 2.2 (28, 0), 2 (31, 0), 1.2 (29, 0) | **6.2**<br>12.5 (77, 0), 8.5 (94, 0), 4 (32, 0), 3 (43, 0) |
| Progress: scrolling | **6.0**<br>29.8 (95, 0), 6.3 (32, 0), 5.7 (33, 0), 2 (26, 0) | **10.3**<br>20.2 (65, 0), 17.2 (71, 0), 3.4 (33, 0), 3.1 (26, 0) |
| Progress: period ‹ › and range | **101.7**<br>191 (205, 15), 110.5 (104, 2), 92.9 (121, 2), 87.9 (108, 2) | **120.0**<br>159.7 (166, 8), 134.9 (185, 7), 105 (142, 2), 87.5 (127, 2) |
| Progress: key fold and open | **0.9**<br>18.3 (118, 2), 0.8 (29, 0), 0.8 (29, 0), 0.9 (30, 0) | **0.7**<br>2.6 (57, 0), 0.5 (24, 0), 0.9 (30, 0), 0 (0, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 9471 · 3911.7 | 16 · 5996 · 1339.0 |
| Store load: into the app (5593 logs) | 8 · 589 · 99.2 | 8 · 579 · 110.9 |
| Store load: into the app (0 logs) | 8 · 26 · 8.5 | 8 · 12 · 2.9 |
| Widgets: the snapshot | 9 · 25 · 6.2 | 8 · 26 · 5.8 |
| Reminders: plan every alert | 8 · 3 · 0.8 | 8 · 0 · 0.2 |
| Change: Siri's habit names | 1 · 0 · 0.1 | – |
| Count: Today's list drawn | 138 · 8 · 7.1 | 153 · 6 · 2.0 |
| Count: a Today row drawn | 930 · 0 · 0.0 | 1016 · 0 · 0.0 |
| Widgets: one habit's week | 119 · 1103 · 379.7 | 136 · 1099 · 160.0 |
| Shared rules: built from every log | – | 32 · 317 · 49.3 |
| Habit page: milestones | 3 · 26 · 11.2 | 4 · 63 · 22.9 |
| Habit page: overall record | 3 · 21 · 8.9 | 4 · 70 · 24.0 |
| Habit page: history | 3 · 23 · 10.0 | 4 · 47 · 15.7 |
| Shared rules: habits and settings again | – | 40 · 29 · 4.6 |
| Progress year: whole snapshot | 8 · 164 · 37.1 | 8 · 329 · 58.0 |
| Progress year: cards | 8 · 163 · 36.9 | 8 · 327 · 57.9 |
| Progress year: one card | 120 · 152 · 4.2 | 120 · 315 · 7.5 |
| Progress week: whole snapshot | 8 · 45 · 12.3 | 8 · 61 · 13.4 |
| Progress week: cards | 8 · 39 · 9.0 | 8 · 56 · 12.8 |
| Progress week: one card | 120 · 33 · 7.5 | 120 · 44 · 8.7 |
| Progress month: whole snapshot | 8 · 29 · 9.2 | 8 · 53 · 9.3 |
| Progress month: cards | 8 · 28 · 9.1 | 8 · 49 · 9.1 |
| Progress month: one card | 120 · 22 · 2.1 | 120 · 41 · 1.3 |
| Progress week: one quit card | 16 · 2 · 0.2 | 16 · 4 · 0.6 |
| Progress year: one quit card | 8 · 0 · 0.3 | 8 · 3 · 0.6 |
| Progress month: one quit card | 16 · 1 · 0.2 | 16 · 3 · 0.3 |

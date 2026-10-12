# claude/shared-habit-rules-perf16 @ 5ff7f54 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38290566254 · 2026-10-12 18:59 UTC
Commit: Current Work 92: speed side by side with main, optimised (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `progress-year calendar` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: 5ff7f54e Current Work 92: speed side by side with main, optimised (scratch, safe to delete) [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Progress Year: sideways | **0.0**<br>48.8 (294, 4), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Progress Year: scrolling | **14.3**<br>106.9 (577, 4), 9.4 (56, 0), 16.4 (51, 0), 12.2 (46, 0) | **18.9**<br>56.6 (336, 2), 11.9 (82, 0), 10.1 (58, 0), 25.9 (159, 1) |
| Calendar: month ‹ › | **5.6**<br>10.2 (93, 0), 5.7 (27, 0), 1.4 (22, 0), 5.5 (31, 0) | **4.3**<br>0 (17, 0), 2.1 (32, 0), 6.5 (59, 0), 19.1 (157, 1) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 9907 · 2026.8 | 16 · 3757 · 667.9 |
| Widgets: one habit's week | 136 · 954 · 156.2 | 136 · 860 · 86.5 |
| Store load: into the app (5593 logs) | 8 · 505 · 85.4 | 8 · 383 · 53.0 |
| Progress year: whole snapshot | 4 · 130 · 38.6 | 4 · 188 · 54.5 |
| Progress year: cards | 4 · 129 · 38.1 | 4 · 188 · 54.1 |
| Progress year: one card | 60 · 121 · 9.8 | 60 · 179 · 15.1 |
| Progress week: whole snapshot | 4 · 9 · 4.1 | 4 · 13 · 3.9 |
| Progress week: cards | 4 · 6 · 3.2 | 4 · 13 · 3.7 |
| Store load: into the app (0 logs) | 8 · 20 · 5.8 | 8 · 16 · 9.8 |
| Progress week: one card | 60 · 5 · 0.8 | 60 · 8 · 1.8 |
| Widgets: the snapshot | 8 · 19 · 5.3 | 8 · 27 · 7.6 |
| Progress week: one quit card | 8 · 1 · 0.7 | 8 · 0 · 0.3 |
| Progress year: one quit card | 8 · 1 · 0.4 | 8 · 4 · 0.7 |
| Reminders: plan every alert | 8 · 5 · 1.7 | 8 · 2 · 1.1 |
| Count: Today's list drawn | 98 · 3 · 0.6 | 110 · 0 · 0.1 |
| Count: a Today row drawn | 563 · 0 · 0.0 | 662 · 1 · 0.6 |
| Shared rules: built from every log | – | 32 · 182 · 28.0 |
| Shared rules: habits and settings again | – | 40 · 27 · 9.4 |

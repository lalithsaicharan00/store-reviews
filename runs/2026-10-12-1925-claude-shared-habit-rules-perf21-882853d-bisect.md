# claude/shared-habit-rules-perf21 @ 882853d (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38292290844 · 2026-10-12 19:25 UTC
Commit: Current Work 92: speed side by side with main, every strip in one call (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `progress-year calendar` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: 882853dd Current Work 92: speed side by side with main, every strip in one call (scratch, safe to delete) [ios

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Progress Year: sideways | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0.3 (21, 0) | **0.0**<br>33.8 (525, 1), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Progress Year: scrolling | **9.9**<br>9.7 (68, 0), 9.3 (54, 0), 18.8 (158, 1), 10.2 (40, 0) | **8.5**<br>22.9 (219, 1), 8.6 (55, 0), 8.4 (38, 0), 6.6 (36, 0) |
| Calendar: month ‹ › | **4.9**<br>8.2 (35, 0), 6 (44, 0), 3.8 (72, 0), 1.7 (26, 0) | **5.5**<br>5.2 (28, 0), 13.5 (79, 0), 5.7 (33, 0), 4.2 (30, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 4352 · 724.5 | 16 · 4449 · 865.1 |
| Widgets: one habit's week | 136 · 1220 · 485.2 | 136 · 4592 · 3546.2 |
| Store load: into the app (5593 logs) | 8 · 420 · 63.9 | 8 · 439 · 72.8 |
| Progress year: whole snapshot | 4 · 117 · 31.4 | 4 · 157 · 47.7 |
| Progress year: cards | 4 · 116 · 31.2 | 4 · 154 · 47.5 |
| Progress year: one card | 60 · 110 · 8.2 | 60 · 148 · 10.7 |
| Store load: into the app (0 logs) | 8 · 18 · 3.6 | 8 · 10 · 2.1 |
| Widgets: the snapshot | 8 · 11 · 2.3 | 8 · 19 · 3.9 |
| Progress week: whole snapshot | 4 · 9 · 3.8 | 4 · 10 · 4.0 |
| Progress week: cards | 4 · 6 · 3.3 | 4 · 10 · 3.7 |
| Progress week: one card | 60 · 5 · 1.0 | 60 · 5 · 0.4 |
| Progress year: one quit card | 8 · 3 · 0.3 | 8 · 2 · 0.4 |
| Reminders: plan every alert | 8 · 3 · 0.8 | 8 · 3 · 1.4 |
| Progress week: one quit card | 8 · 1 · 1.1 | 8 · 0 · 0.3 |
| Count: Today's list drawn | 105 · 0 · 0.3 | 104 · 0 · 0.5 |
| Count: a Today row drawn | 543 · 0 · 0.0 | 558 · 0 · 0.0 |
| Shared rules: built from every log | – | 32 · 176 · 22.7 |
| Shared rules: habits and settings again | – | 40 · 22 · 3.4 |

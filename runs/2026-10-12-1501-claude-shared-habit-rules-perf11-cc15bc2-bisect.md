# claude/shared-habit-rules-perf11 @ cc15bc2 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38261434286 · 2026-10-12 15:01 UTC
Commit: Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `progress-year calendar` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: cc15bc2d Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Progress Year: sideways | **0.1**<br>0.1 (19, 0), 0 (0, 0), 0 (0, 0), 30.2 (268, 1) | **0.2**<br>0.6 (26, 0), 0 (0, 0), 0.5 (24, 0), 0 (0, 0) |
| Progress Year: scrolling | **42.8**<br>41.5 (77, 0), 32.4 (90, 0), 44.1 (112, 1), 88.3 (347, 3) | **30.2**<br>35.3 (91, 0), 25.2 (57, 0), 40 (79, 0), 17.1 (78, 0) |
| Calendar: month ‹ › | **22.3**<br>21.7 (70, 0), 22.1 (82, 0), 22.5 (39, 0), 23.9 (160, 1) | **18.5**<br>20.8 (45, 0), 47 (137, 1), 12.3 (45, 0), 16.2 (39, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 7058 · 1239.9 | 16 · 7648 · 1225.2 |
| Widgets: one habit's week | 136 · 3336 · 2118.2 | 136 · 1940 · 705.2 |
| Store load: into the app (5593 logs) | 8 · 634 · 112.4 | 8 · 641 · 107.3 |
| Progress year: whole snapshot | 4 · 158 · 42.4 | 4 · 376 · 113.0 |
| Progress year: cards | 4 · 157 · 42.0 | 4 · 369 · 112.5 |
| Progress year: one card | 60 · 148 · 12.3 | 60 · 355 · 22.2 |
| Widgets: the snapshot | 8 · 18 · 4.7 | 8 · 23 · 5.5 |
| Store load: into the app (0 logs) | 8 · 28 · 6.9 | 8 · 11 · 3.4 |
| Progress week: whole snapshot | 4 · 14 · 7.0 | 4 · 23 · 10.2 |
| Progress week: cards | 4 · 11 · 5.6 | 4 · 22 · 9.6 |
| Progress week: one card | 60 · 6 · 1.2 | 60 · 13 · 0.7 |
| Reminders: plan every alert | 8 · 5 · 1.6 | 8 · 2 · 1.4 |
| Progress year: one quit card | 8 · 2 · 0.5 | 8 · 5 · 1.7 |
| Progress week: one quit card | 8 · 2 · 0.9 | 8 · 3 · 1.2 |
| Count: Today's list drawn | 100 · 1 · 0.6 | 100 · 1 · 0.6 |
| Count: a Today row drawn | 446 · 0 · 0.0 | 378 · 0 · 0.0 |
| Shared rules: built from every log | – | 32 · 324 · 83.9 |
| Shared rules: habits and settings again | – | 40 · 37 · 8.1 |

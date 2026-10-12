# claude/shared-habit-rules-perf16 @ 4d4622c (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38282623205 · 2026-10-12 17:58 UTC
Commit: Current Work 92: final speed side by side with main, strips in one call (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `progress-year calendar` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: 4d4622cc Current Work 92: final speed side by side with main, strips in one call (scratch, safe to delete) [io

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Progress Year: sideways | **0.1**<br>0 (0, 0), 0.1 (18, 0), 0.7 (27, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0.2 (19, 0), 0 (0, 0), 0 (0, 0) |
| Progress Year: scrolling | **26.2**<br>19.3 (58, 0), 20.2 (88, 0), 47.3 (79, 0), 32.3 (120, 1) | **32.3**<br>57.6 (127, 1), 45.2 (66, 0), 12.5 (71, 0), 19.4 (49, 0) |
| Calendar: month ‹ › | **9.7**<br>13.7 (51, 0), 5.7 (30, 0), 4.3 (30, 0), 15.9 (71, 0) | **27.5**<br>30.6 (79, 0), 59.5 (210, 3), 16.9 (42, 0), 24.4 (100, 1) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 10368 · 2411.4 | 16 · 11732 · 3699.9 |
| Widgets: one habit's week | 119 · 860 · 114.5 | 136 · 1105 · 138.2 |
| Store load: into the app (5593 logs) | 8 · 623 · 111.7 | 8 · 547 · 78.5 |
| Progress year: whole snapshot | 4 · 158 · 54.3 | 4 · 250 · 69.1 |
| Progress year: cards | 4 · 157 · 53.9 | 4 · 248 · 68.5 |
| Progress year: one card | 60 · 147 · 15.3 | 60 · 237 · 17.8 |
| Store load: into the app (0 logs) | 8 · 49 · 28.5 | 8 · 27 · 12.5 |
| Widgets: the snapshot | 9 · 29 · 8.1 | 8 · 17 · 6.3 |
| Progress week: whole snapshot | 4 · 15 · 9.1 | 4 · 23 · 12.5 |
| Progress week: cards | 4 · 13 · 7.7 | 4 · 22 · 12.3 |
| Progress year: one quit card | 8 · 3 · 0.8 | 8 · 4 · 0.9 |
| Progress week: one card | 60 · 10 · 3.5 | 60 · 9 · 0.8 |
| Reminders: plan every alert | 8 · 3 · 1.6 | 8 · 0 · 0.4 |
| Progress week: one quit card | 8 · 1 · 0.4 | 8 · 8 · 6.3 |
| Count: Today's list drawn | 96 · 2 · 1.4 | 110 · 5 · 1.2 |
| Count: a Today row drawn | 370 · 0 · 0.1 | 496 · 0 · 0.0 |
| Shared rules: built from every log | – | 32 · 255 · 33.0 |
| Shared rules: habits and settings again | – | 40 · 47 · 12.8 |
| Change: Siri's habit names | 1 · 0 · 0.1 | – |

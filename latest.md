# claude/shared-habit-rules-perf14 @ 3bc5155 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38290560143 · 2026-10-12 19:09 UTC
Commit: Current Work 92: speed side by side with main, optimised (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `scroll-today tap-today` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: 3bc51559 Current Work 92: speed side by side with main, optimised (scratch, safe to delete) [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Today: scrolling | **15.7**<br>30.1 (209, 2), 10.9 (62, 0), 18.5 (101, 1), 12.9 (83, 0) | **24.0**<br>33.3 (303, 2), 25.8 (145, 2), 22.1 (161, 1), 14.7 (81, 0) |
| Today: +1 and day ‹ › | **89.0**<br>112.6 (196, 3), 89.6 (116, 1), 88.4 (87, 0), 70.2 (120, 1) | **71.1**<br>117.6 (103, 2), 55.7 (106, 1), 86.5 (98, 0), 54 (109, 1) |
| Today: +1 alone | **1.5**<br>2.7 (51, 0), 1.5 (34, 0), 1.5 (32, 0), 0.3 (21, 0) | **1.3**<br>4.4 (54, 0), 0 (0, 0), 2.6 (30, 0), 0 (0, 0) |
| Today: day ‹ › alone | **68.5**<br>76.2 (73, 0), 60.9 (67, 0), 48 (51, 0), 85.1 (90, 0) | **56.3**<br>62 (58, 0), 49.4 (69, 0), 65.3 (63, 0), 50.6 (58, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **0.0**<br>22.3 (138, 2), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>4.6 (52, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 8949 · 1970.6 | 16 · 6819 · 1175.0 |
| Widgets: one habit's week | 204 · 1194 · 104.5 | 203 · 1261 · 124.9 |
| Store load: into the app (5593 logs) | 8 · 532 · 91.2 | 8 · 550 · 94.8 |
| Widgets: the snapshot | 76 · 105 · 7.5 | 75 · 116 · 5.9 |
| Store load: into the app (0 logs) | 8 · 40 · 15.2 | 8 · 12 · 2.9 |
| Reminders: plan every alert | 239 · 20 · 0.8 | 239 · 23 · 1.8 |
| Count: Today's list drawn | 402 · 4 · 1.3 | 424 · 4 · 0.9 |
| Count: a Today row drawn | 3043 · 0 · 0.0 | 3240 · 0 · 0.1 |
| Shared rules: built from every log | – | 32 · 216 · 26.0 |
| Shared rules: habits and settings again | – | 48 · 45 · 4.8 |
| Change: Siri's habit names | 231 · 19 · 0.3 | 231 · 17 · 0.2 |
| Count: the Day sheet drawn | 40 · 0 · 0.0 | 37 · 0 · 0.0 |
| Count: the Day sheet's activity drawn | 40 · 0 · 0.0 | 37 · 0 · 0.0 |
| Shared rules: a log added | – | 227 · 16 · 0.3 |

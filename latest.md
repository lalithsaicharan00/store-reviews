# claude/shared-habit-rules-perf8 @ 42b60a8 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38257084474 · 2026-10-12 14:14 UTC
Commit: Current Work 92: Swift rules and shared rules side by side in one build, reads narrowed (scratch, safe to delete) [ios-perf-bisect]

Variants: `swift=HEAD+-swift-rules shared=HEAD` · scenarios: `tap-today scroll-today` · rounds: 4

- swift: 42b60a83 Current Work 92: Swift rules and shared rules side by side in one build, reads narrowed (scratch, saf
- shared: 42b60a83 Current Work 92: Swift rules and shared rules side by side in one build, reads narrowed (scratch, saf

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | swift | shared |
|---|---|---|
| Today: +1 and day ‹ › | **35.1**<br>96.8 (108, 1), 36.1 (97, 0), 34.1 (52, 0), 17.8 (42, 0) | **39.8**<br>53.2 (78, 0), 35.8 (124, 1), 43.9 (125, 1), 14 (67, 0) |
| Today: +1 alone | **0.1**<br>0.2 (19, 0), 2.3 (34, 0), 0 (0, 0), 0 (0, 0) | **1.5**<br>4.8 (37, 0), 2.5 (34, 0), 0.5 (24, 0), 0.5 (20, 0) |
| Today: day ‹ › alone | **30.1**<br>83.3 (83, 0), 29.1 (55, 0), 31.2 (54, 0), 15.7 (44, 0) | **33.9**<br>78.5 (83, 0), 33.4 (62, 0), 34.4 (47, 0), 20.3 (56, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.1**<br>0 (17, 0), 0 (0, 0), 1.4 (38, 0), 0.1 (18, 0) |
| Today: scrolling | **9.5**<br>8.8 (57, 0), 10.2 (91, 0), 11 (113, 1), 3.4 (36, 0) | **5.4**<br>9.6 (71, 0), 5.2 (46, 0), 3.8 (56, 0), 5.6 (56, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | swift | shared |
|---|---|---|
| Store load: read the database | 16 · 5611 · 1198.5 | 16 · 4941 · 1485.4 |
| Widgets: one habit's week | 202 · 820 · 70.0 | 202 · 1024 · 56.7 |
| Store load: into the app (5593 logs) | 8 · 406 · 74.2 | 8 · 374 · 59.1 |
| Widgets: the snapshot | 74 · 85 · 5.2 | 74 · 104 · 7.0 |
| Reminders: plan every alert | 238 · 14 · 1.9 | 237 · 18 · 0.3 |
| Change: Siri's habit names | 230 · 15 · 0.3 | 231 · 16 · 0.3 |
| Store load: into the app (0 logs) | 8 · 7 · 3.6 | 8 · 1 · 0.5 |
| Count: Today's list drawn | 408 · 0 · 0.4 | 411 · 0 · 0.1 |
| Count: a Today row drawn | 2533 · 0 · 0.0 | 2488 · 0 · 0.0 |
| Count: the Day sheet drawn | 40 · 0 · 0.0 | 47 · 0 · 0.0 |
| Count: the Day sheet's activity drawn | 40 · 0 · 0.0 | 47 · 0 · 0.0 |
| Shared rules: built from every log | – | 32 · 244 · 51.5 |
| Shared rules: habits and settings again | – | 48 · 19 · 2.5 |
| Shared rules: a log added | – | 227 · 15 · 0.4 |

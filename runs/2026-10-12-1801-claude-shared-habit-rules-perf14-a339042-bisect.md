# claude/shared-habit-rules-perf14 @ a339042 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38282617709 · 2026-10-12 18:01 UTC
Commit: Current Work 92: final speed side by side with main, strips in one call (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `scroll-today tap-today` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: a3390428 Current Work 92: final speed side by side with main, strips in one call (scratch, safe to delete) [io

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Today: scrolling | **29.0**<br>43.3 (197, 4), 14.8 (149, 1), 80.9 (115, 1), 4.5 (46, 0) | **15.8**<br>18.9 (152, 2), 17.8 (111, 1), 13.8 (100, 0), 9.5 (92, 0) |
| Today: +1 and day ‹ › | **46.6**<br>66.6 (64, 0), 78.7 (80, 0), 26.6 (60, 0), 19.7 (59, 0) | **54.4**<br>60 (77, 0), 74.8 (108, 1), 48.7 (54, 0), 21.7 (40, 0) |
| Today: +1 alone | **0.1**<br>1.2 (33, 0), 0 (0, 0), 0.1 (18, 0), 0.1 (18, 0) | **1.4**<br>2.2 (40, 0), 2.2 (49, 0), 0.6 (26, 0), 0.4 (23, 0) |
| Today: day ‹ › alone | **49.4**<br>88 (123, 1), 54.3 (68, 0), 44.5 (60, 0), 17.1 (50, 0) | **48.4**<br>82.6 (87, 0), 52.7 (79, 0), 44.1 (64, 0), 29.9 (42, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **1.6**<br>5.4 (45, 0), 1.4 (38, 0), 0 (0, 0), 1.8 (43, 0) | **0.0**<br>0.2 (20, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 7409 · 1656.8 | 16 · 7464 · 1547.0 |
| Widgets: one habit's week | 203 · 857 · 78.1 | 202 · 1076 · 89.9 |
| Store load: into the app (5593 logs) | 8 · 453 · 73.2 | 8 · 440 · 74.2 |
| Widgets: the snapshot | 75 · 87 · 4.2 | 74 · 102 · 6.1 |
| Store load: into the app (0 logs) | 8 · 26 · 14.9 | 8 · 11 · 3.1 |
| Count: Today's list drawn | 404 · 1 · 0.7 | 413 · 1 · 0.6 |
| Reminders: plan every alert | 239 · 15 · 0.8 | 239 · 17 · 1.1 |
| Count: a Today row drawn | 2642 · 0 · 0.1 | 2529 · 0 · 0.0 |
| Shared rules: built from every log | – | 32 · 213 · 33.3 |
| Shared rules: habits and settings again | – | 48 · 27 · 3.7 |
| Change: Siri's habit names | 232 · 16 · 0.4 | 232 · 18 · 2.5 |
| Count: the Day sheet drawn | 50 · 0 · 0.0 | 41 · 0 · 0.0 |
| Count: the Day sheet's activity drawn | 50 · 0 · 0.0 | 41 · 0 · 0.0 |
| Shared rules: a log added | – | 228 · 14 · 1.1 |

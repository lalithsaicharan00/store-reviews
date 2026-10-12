# claude/shared-habit-rules-perf17 @ d1862b0 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38282626370 · 2026-10-12 18:13 UTC
Commit: Current Work 92: final speed side by side with main, strips in one call (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `day-sheet widget-publish` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: d1862b07 Current Work 92: final speed side by side with main, strips in one call (scratch, safe to delete) [io

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **5.2**<br>6.7 (36, 0), 23 (104, 1), 2.6 (28, 0), 3.6 (26, 0) | **1.8**<br>2.1 (25, 0), 1.4 (23, 0), 2.7 (23, 0), 1.2 (29, 0) |
| Day sheet: add, edit and exact undo | **257.7**<br>255.6 (114, 2), 259.8 (117, 3), 251.9 (126, 3), 263.1 (114, 2) | **283.2**<br>300.9 (117, 4), 269.5 (111, 4), 265.1 (111, 5), 296.9 (144, 6) |
| Widget: full publication, every habit's week | **0.0**<br>0 (0, 0), 0 (0, 0), 4.8 (91, 0), 0 (0, 0) | **4.5**<br>3.2 (64, 0), 5.8 (106, 1), 0 (0, 0), 8.2 (143, 1) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 6623 · 1258.0 | 16 · 6176 · 1338.1 |
| Habit page: history | 583 · 3436 · 13.9 | 580 · 6654 · 39.6 |
| Widgets: one habit's week | 1720 · 2542 · 101.9 | 1703 · 3579 · 127.2 |
| Store load: into the app (5593 logs) | 8 · 520 · 86.5 | 8 · 529 · 85.0 |
| Change: Siri's habit names | 579 · 49 · 1.4 | 576 · 46 · 2.1 |
| Widgets: the snapshot | 104 · 100 · 5.9 | 103 · 135 · 5.3 |
| Store load: into the app (0 logs) | 8 · 19 · 3.0 | 8 · 8 · 2.2 |
| Reminders: plan every alert | 12 · 9 · 1.7 | 12 · 0 · 0.2 |
| Count: Today's list drawn | 74 · 1 · 0.6 | 78 · 5 · 1.2 |
| Count: the Day sheet drawn | 641 · 0 · 0.1 | 651 · 0 · 0.0 |
| Count: the Day sheet's activity drawn | 834 · 0 · 0.0 | 843 · 0 · 0.0 |
| Count: a Today row drawn | 902 · 0 · 0.0 | 819 · 0 · 0.0 |
| Entry editor: whole editor drawn | 804 · 0 · 0.0 | 796 · 0 · 0.0 |
| Shared rules: built from every log | – | 32 · 248 · 31.2 |
| Shared rules: a log changed | – | 192 · 23 · 0.5 |
| Shared rules: a log removed | – | 192 · 19 · 1.7 |
| Shared rules: habits and settings again | – | 40 · 21 · 2.9 |
| Shared rules: a log added | – | 192 · 13 · 0.4 |

# claude/shared-habit-rules-perf7 @ 1ad38b9 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38257081466 · 2026-10-12 14:14 UTC
Commit: Current Work 92: Swift rules and shared rules side by side in one build, reads narrowed (scratch, safe to delete) [ios-perf-bisect]

Variants: `swift=HEAD+-swift-rules shared=HEAD` · scenarios: `day-sheet widget-publish` · rounds: 4

- swift: 1ad38b96 Current Work 92: Swift rules and shared rules side by side in one build, reads narrowed (scratch, saf
- shared: 1ad38b96 Current Work 92: Swift rules and shared rules side by side in one build, reads narrowed (scratch, saf

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | swift | shared |
|---|---|---|
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **2.0**<br>10.2 (49, 0), 2.8 (25, 0), 0.1 (18, 0), 1.2 (25, 0) | **0.7**<br>0.9 (26, 0), 0.5 (22, 0), 1.2 (34, 0), 0.2 (20, 0) |
| Day sheet: add, edit and exact undo | **239.4**<br>368.2 (217, 9), 262.1 (100, 1), 216.7 (106, 1), 184.7 (112, 1) | **354.0**<br>319.6 (136, 8), 345.8 (123, 10), 362.1 (152, 12), 458.4 (151, 28) |
| Widget: full publication, every habit's week | **3.2**<br>15.3 (185, 1), 0 (0, 0), 6.5 (118, 1), 0 (0, 0) | **1.4**<br>2.8 (47, 0), 0 (0, 0), 0 (0, 0), 3.3 (67, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | swift | shared |
|---|---|---|
| Store load: read the database | 16 · 8294 · 1794.1 | 16 · 7625 · 1392.2 |
| Habit page: history | 583 · 3735 · 27.8 | 577 · 10163 · 67.2 |
| Widgets: one habit's week | 1721 · 2645 · 123.2 | 1652 · 4426 · 94.4 |
| Store load: into the app (5593 logs) | 8 · 547 · 88.6 | 8 · 538 · 79.5 |
| Change: Siri's habit names | 579 · 47 · 0.7 | 573 · 50 · 0.9 |
| Widgets: the snapshot | 105 · 102 · 6.8 | 100 · 218 · 91.8 |
| Store load: into the app (0 logs) | 8 · 11 · 2.9 | 8 · 6 · 1.2 |
| Reminders: plan every alert | 12 · 5 · 1.8 | 13 · 2 · 0.9 |
| Count: Today's list drawn | 78 · 1 · 0.7 | 79 · 1 · 0.5 |
| Count: the Day sheet's activity drawn | 826 · 0 · 0.0 | 854 · 0 · 0.0 |
| Count: a Today row drawn | 783 · 0 · 0.0 | 789 · 0 · 0.0 |
| Count: the Day sheet drawn | 633 · 0 · 0.0 | 661 · 0 · 0.0 |
| Entry editor: whole editor drawn | 791 · 0 · 0.0 | 798 · 0 · 0.0 |
| Shared rules: built from every log | – | 32 · 410 · 49.9 |
| Shared rules: a log changed | – | 191 · 27 · 0.5 |
| Shared rules: a log removed | – | 191 · 23 · 0.9 |
| Shared rules: a log added | – | 191 · 16 · 1.1 |
| Shared rules: habits and settings again | – | 40 · 19 · 2.4 |

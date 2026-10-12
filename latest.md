# claude/shared-habit-rules-perf19 @ 16a976a (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38292285239 · 2026-10-12 19:36 UTC
Commit: Current Work 92: speed side by side with main, every strip in one call (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `day-sheet widget-publish` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: 16a976a8 Current Work 92: speed side by side with main, every strip in one call (scratch, safe to delete) [ios

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **0.3**<br>0.6 (22, 0), 1.7 (40, 0), 0 (0, 0), 0 (0, 0) | **0.8**<br>12.7 (167, 1), 1.5 (27, 0), 0 (0, 0), 0.2 (19, 0) |
| Day sheet: add, edit and exact undo | **197.5**<br>195.8 (92, 0), 242.2 (98, 0), 132.4 (74, 0), 199.2 (88, 0) | **212.3**<br>204.8 (97, 0), 210.1 (113, 1), 236.6 (96, 0), 214.6 (97, 0) |
| Widget: full publication, every habit's week | **0.0**<br>4.5 (84, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 7.6 (123, 1), 0 (0, 0), 0 (0, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 6866 · 1349.1 | 16 · 7720 · 2521.1 |
| Habit page: history | 583 · 2908 · 11.6 | 580 · 5037 · 34.8 |
| Widgets: one habit's week | 1738 · 2315 · 113.7 | 1703 · 2631 · 71.2 |
| Store load: into the app (5593 logs) | 8 · 427 · 68.3 | 8 · 500 · 71.5 |
| Change: Siri's habit names | 579 · 43 · 0.8 | 576 · 41 · 0.4 |
| Widgets: the snapshot | 106 · 90 · 2.7 | 103 · 117 · 6.9 |
| Store load: into the app (0 logs) | 8 · 15 · 2.9 | 8 · 13 · 7.2 |
| Reminders: plan every alert | 12 · 4 · 0.6 | 12 · 5 · 2.7 |
| Count: Today's list drawn | 77 · 0 · 0.5 | 80 · 0 · 0.4 |
| Count: a Today row drawn | 815 · 0 · 0.1 | 883 · 0 · 0.0 |
| Count: the Day sheet drawn | 471 · 0 · 0.0 | 657 · 0 · 0.0 |
| Count: the Day sheet's activity drawn | 666 · 0 · 0.1 | 849 · 0 · 0.0 |
| Entry editor: whole editor drawn | 642 · 0 · 0.0 | 801 · 0 · 0.1 |
| Shared rules: built from every log | – | 32 · 221 · 59.7 |
| Shared rules: a log changed | – | 192 · 19 · 0.4 |
| Shared rules: a log removed | – | 192 · 14 · 0.3 |
| Shared rules: habits and settings again | – | 40 · 24 · 3.9 |
| Shared rules: a log added | – | 192 · 13 · 0.4 |

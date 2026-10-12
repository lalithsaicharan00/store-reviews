# claude/shared-habit-rules-perf12 @ f5a302e (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38261437768 · 2026-10-12 16:26 UTC
Commit: Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `day-sheet widget-publish` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: f5a302e4 Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **1.4**<br>12.1 (87, 0), 2.4 (28, 0), 0.1 (18, 0), 0.4 (21, 0) | **1.1**<br>1.4 (27, 0), 0.3 (21, 0), 1 (21, 0), 1.2 (28, 0) |
| Day sheet: add, edit and exact undo | **178.1**<br>268.6 (166, 5), 165.2 (119, 1), 170.5 (112, 1), 185.6 (98, 0) | **237.6**<br>273.7 (136, 5), 237.4 (105, 2), 157.2 (91, 0), 237.8 (101, 1) |
| Widget: full publication, every habit's week | **0.0**<br>0 (0, 0), 6.4 (114, 1), 0 (17, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 2.8 (58, 0), 0 (0, 0), 0 (0, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 6248 · 1236.5 | 16 · 7015 · 1343.1 |
| Habit page: history | 577 · 2997 · 17.6 | 583 · 6566 · 37.8 |
| Widgets: one habit's week | 1721 · 2434 · 81.6 | 1703 · 3523 · 85.3 |
| Store load: into the app (5593 logs) | 8 · 613 · 144.4 | 8 · 501 · 81.3 |
| Change: Siri's habit names | 573 · 47 · 0.5 | 579 · 39 · 0.3 |
| Widgets: the snapshot | 105 · 98 · 4.3 | 103 · 125 · 5.6 |
| Reminders: plan every alert | 15 · 3 · 1.8 | 12 · 8 · 5.2 |
| Store load: into the app (0 logs) | 8 · 20 · 8.3 | 8 · 7 · 1.6 |
| Count: Today's list drawn | 67 · 1 · 0.7 | 83 · 2 · 0.8 |
| Count: the Day sheet drawn | 619 · 0 · 0.0 | 659 · 0 · 0.0 |
| Count: a Today row drawn | 733 · 0 · 0.0 | 807 · 0 · 0.0 |
| Count: the Day sheet's activity drawn | 812 · 0 · 0.0 | 852 · 0 · 0.0 |
| Entry editor: whole editor drawn | 767 · 0 · 0.0 | 805 · 0 · 0.0 |
| Shared rules: built from every log | – | 32 · 254 · 44.0 |
| Shared rules: a log changed | – | 193 · 19 · 0.5 |
| Shared rules: habits and settings again | – | 40 · 25 · 4.1 |
| Shared rules: a log removed | – | 193 · 15 · 0.2 |
| Shared rules: a log added | – | 193 · 13 · 0.9 |

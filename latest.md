# claude/shared-habit-rules-perf6 @ 02b7285 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38247029430 · 2026-10-12 13:07 UTC
Commit: Current Work 92: the Swift rules and the shared rules side by side in one build, with timed work (scratch, safe to delete) [ios-perf-bisect]

Variants: `swift=HEAD+-swift-rules shared=HEAD` · scenarios: `day-sheet widget-publish` · rounds: 4

- swift: 02b72850 Current Work 92: the Swift rules and the shared rules side by side in one build, with timed work (scr
- shared: 02b72850 Current Work 92: the Swift rules and the shared rules side by side in one build, with timed work (scr

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | swift | shared |
|---|---|---|
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **2.5**<br>4.6 (44, 0), 2.5 (39, 0), 2.5 (22, 0), 0.9 (20, 0) | **2.0**<br>2.8 (27, 0), 1.3 (26, 0), 3.4 (40, 0), 0 (17, 0) |
| Day sheet: add, edit and exact undo | **260.0**<br>266.5 (141, 3), 253.5 (126, 7), 271.7 (136, 5), 128.3 (70, 0) | **466.9**<br>497.5 (209, 38), 527.9 (208, 38), 417.1 (150, 27), 436.2 (240, 30) |
| Widget: full publication, every habit's week | **5.3**<br>4.3 (84, 0), 8.4 (130, 1), 6.4 (115, 1), 0 (0, 0) | **2.6**<br>6.3 (52, 0), 5.3 (98, 0), 0 (0, 0), 0 (0, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | swift | shared |
|---|---|---|
| Store load: read the database | 16 · 6856 · 1973.2 | 16 · 7398 · 2070.1 |
| Habit page: history | 574 · 3503 · 31.1 | 579 · 8924 · 45.6 |
| Widgets: one habit's week | 1704 · 2722 · 82.8 | 1704 · 4031 · 88.6 |
| Store load: into the app (5593 logs) | 8 · 589 · 124.2 | 8 · 625 · 173.8 |
| Store load: into the app (0 logs) | 8 · 119 · 116.4 | 8 · 3 · 2.1 |
| Change: Siri's habit names | 570 · 47 · 1.2 | 576 · 45 · 0.4 |
| Reminders: plan every alert | 15 · 7 · 4.7 | 12 · 10 · 9.3 |
| Widgets: the snapshot | 104 · 95 · 2.5 | 104 · 125 · 5.4 |
| Count: Today's list drawn | 69 · 0 · 0.1 | 287 · 0 · 0.1 |
| Entry editor: whole editor drawn | 779 · 0 · 0.0 | 1184 · 0 · 0.1 |
| Count: the Day sheet's activity drawn | 822 · 0 · 0.0 | 1156 · 0 · 0.0 |
| Count: a Today row drawn | 768 · 0 · 0.0 | 1713 · 0 · 0.0 |
| Count: the Day sheet drawn | 631 · 0 · 0.0 | 1028 · 0 · 0.1 |
| Shared rules: built from every log | – | 32 · 349 · 78.1 |
| Shared rules: a log changed | – | 192 · 25 · 0.4 |
| Shared rules: a log removed | – | 192 · 18 · 0.5 |
| Shared rules: habits and settings again | – | 40 · 19 · 5.3 |
| Shared rules: a log added | – | 192 · 15 · 0.5 |

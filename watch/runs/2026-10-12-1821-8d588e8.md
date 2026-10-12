# Watch: claude/shared-habit-rules-wperf9 @ 8d588e8

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38282635377 · 2026-10-12 18:20 UTC
Commit: Watch speed, final: shared rules against the Swift rules side by side (scratch, safe to delete) [watch-perf]

- Core tests: skipped
- Watch build: success
- iPhone build with the Watch app: skipped
- Watch UI tests (none): skipped
- Screenshots: skipped
- Speed: success
- Paired simulators: skipped

## Speed

| Variant · What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms |
|---|---|---|---|
| shared · Today: scrolling 30 habits | 7.6 | 62 ms | 0 |
| swift · Today: scrolling 30 habits | 1.3 | 32 ms | 0 |
| shared · Today: scrolling 30 habits | 6.2 | 79 ms | 0 |
| swift · Today: scrolling 30 habits | 3.0 | 40 ms | 0 |
| shared · Today: scrolling 30 habits | 2.9 | 32 ms | 0 |
| swift · Today: scrolling 30 habits | 0.0 | 0 ms | 0 |
| shared · Today: scrolling 30 habits | 6.8 | 44 ms | 0 |
| swift · Today: scrolling 30 habits | 3.3 | 57 ms | 0 |
| shared · Routine: paging with the Crown | 3.6 | 53 ms | 0 |
| swift · Routine: paging with the Crown | 1.7 | 25 ms | 0 |
| shared · Routine: paging with the Crown | 0.9 | 23 ms | 0 |
| swift · Routine: paging with the Crown | 0.0 | 0 ms | 0 |
| shared · Routine: paging with the Crown | 2.0 | 33 ms | 0 |
| swift · Routine: paging with the Crown | 0.0 | 0 ms | 0 |
| shared · Routine: paging with the Crown | 5.5 | 40 ms | 0 |
| swift · Routine: paging with the Crown | 0.0 | 0 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- shared · Blank cover (control, first): longest stall 151 ms
- shared · Blank cover (control, again): longest stall 49 ms
- shared · Routine (open): longest stall 250 ms
- swift · Blank cover (control, first): longest stall 191 ms
- swift · Blank cover (control, again): longest stall 57 ms
- swift · Routine (open): longest stall 286 ms
- shared · Blank cover (control, first): longest stall 104 ms
- shared · Blank cover (control, again): longest stall 34 ms
- shared · Routine (open): longest stall 210 ms
- swift · Blank cover (control, first): longest stall 92 ms
- swift · Blank cover (control, again): longest stall 57 ms
- swift · Routine (open): longest stall 316 ms
- shared · Blank cover (control, first): longest stall 73 ms
- shared · Blank cover (control, again): longest stall 38 ms
- shared · Routine (open): longest stall 188 ms
- swift · Blank cover (control, first): longest stall 96 ms
- swift · Blank cover (control, again): longest stall 36 ms
- swift · Routine (open): longest stall 277 ms
- shared · Blank cover (control, first): longest stall 244 ms
- shared · Blank cover (control, again): longest stall 67 ms
- shared · Routine (open): longest stall 257 ms
- swift · Blank cover (control, first): longest stall 83 ms
- swift · Blank cover (control, again): longest stall 55 ms
- swift · Routine (open): longest stall 233 ms
- shared · Launch to a usable Today (round 1 , cold): 856 ms
- swift · Launch to a usable Today (round 1 , cold): 896 ms
- shared · Launch to a usable Today (round 2, warm): 948 ms
- swift · Launch to a usable Today (round 2, warm): 770 ms
- shared · Launch to a usable Today (round 3, warm): 781 ms
- swift · Launch to a usable Today (round 3, warm): 1133 ms
- shared · Launch to a usable Today (round 4, warm): 1187 ms
- swift · Launch to a usable Today (round 4, warm): 1241 ms
- shared · Launch to a usable Today (round 5, warm): 1707 ms
- swift · Launch to a usable Today (round 5, warm): 1025 ms
- shared · Launch to a usable Today (round 6, warm): 1086 ms
- swift · Launch to a usable Today (round 6, warm): 1337 ms
- shared · Launch to a usable Today (round 7, warm): 682 ms
- swift · Launch to a usable Today (round 7, warm): 688 ms
- shared · Launch to a usable Today (round 8, warm): 833 ms
- swift · Launch to a usable Today (round 8, warm): 729 ms

Notes (storage and the first fill):


Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| shared · scroll-today | Store load: read the database | 2 | 489 ms | 446.9 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 98 ms | 25.2 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 63 ms | 62.6 ms |
| shared · scroll-today | Watch Today: plan | 32 | 62 ms | 25.6 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 38 ms | 24.4 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 12 ms | 1.2 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.6 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 3 ms | 2.7 ms |
| shared · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 564 ms | 550.1 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 76 ms | 76.0 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 57 ms | 19.3 ms |
| swift · scroll-today | Watch Today: plan | 32 | 8 ms | 1.4 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.8 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 569 ms | 559.1 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 68 ms | 20.7 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 60 ms | 60.4 ms |
| shared · scroll-today | Watch Today: plan | 32 | 49 ms | 15.2 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 19 ms | 14.2 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 14 ms | 0.9 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.4 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 536 ms | 527.6 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 73 ms | 72.6 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 48 ms | 13.0 ms |
| swift · scroll-today | Watch Today: plan | 32 | 13 ms | 3.8 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 3 ms | 0.9 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · scroll-today | Count: a Today row drawn | 155 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 565 ms | 528.7 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 125 ms | 28.9 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 76 ms | 76.2 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 30 ms | 18.9 ms |
| shared · scroll-today | Watch Today: plan | 31 | 28 ms | 2.6 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 11 ms | 0.6 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 6 ms | 3.3 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 1.2 ms |
| shared · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 506 ms | 485.6 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 66 ms | 66.0 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 58 ms | 21.0 ms |
| swift · scroll-today | Watch Today: plan | 32 | 11 ms | 3.9 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 3 ms | 1.1 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 3 ms | 2.8 ms |
| swift · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 950 ms | 931.2 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 80 ms | 14.1 ms |
| shared · scroll-today | Watch Today: plan | 32 | 75 ms | 39.6 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 63 ms | 63.3 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 44 ms | 38.4 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 13 ms | 0.8 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.4 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| shared · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 547 ms | 539.1 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 66 ms | 66.1 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 52 ms | 18.0 ms |
| swift · scroll-today | Watch Today: plan | 32 | 11 ms | 3.7 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 5 ms | 3.0 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 142 ms | 114.0 ms |
| shared · routine | Widgets: one habit's week | 8 | 34 ms | 18.2 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 15 ms | 15.0 ms |
| shared · routine | Watch Today: plan | 17 | 14 ms | 4.1 ms |
| shared · routine | Shared rules: built from every log | 3 | 13 ms | 8.9 ms |
| shared · routine | Watch Day details: the dial's words | 61 | 11 ms | 4.5 ms |
| shared · routine | Widgets: the snapshot | 2 | 3 ms | 2.2 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 3 ms | 0.6 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 1 ms | 1.2 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a Today row drawn | 53 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 150 ms | 143.8 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 28 ms | 27.5 ms |
| swift · routine | Widgets: one habit's week | 8 | 23 ms | 12.2 ms |
| swift · routine | Watch Today: plan | 17 | 3 ms | 0.9 ms |
| swift · routine | Watch Day details: the dial's words | 2 | 3 ms | 2.4 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| swift · routine | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 165 ms | 138.1 ms |
| shared · routine | Widgets: one habit's week | 8 | 31 ms | 17.6 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 16 ms | 16.1 ms |
| shared · routine | Watch Today: plan | 17 | 13 ms | 4.5 ms |
| shared · routine | Shared rules: built from every log | 3 | 12 ms | 6.5 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 3 ms | 0.7 ms |
| shared · routine | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 1 ms | 1.0 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 233 ms | 223.0 ms |
| swift · routine | Widgets: one habit's week | 8 | 19 ms | 12.0 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 16 ms | 15.8 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 6 ms | 1.5 ms |
| swift · routine | Watch Today: plan | 17 | 3 ms | 0.5 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| swift · routine | Count: a Today row drawn | 53 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 185 ms | 163.3 ms |
| shared · routine | Widgets: one habit's week | 8 | 23 ms | 12.4 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 16 ms | 16.2 ms |
| shared · routine | Shared rules: built from every log | 3 | 13 ms | 8.2 ms |
| shared · routine | Watch Today: plan | 17 | 9 ms | 2.8 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 4 ms | 1.2 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 2 ms | 2.3 ms |
| shared · routine | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 159 ms | 151.9 ms |
| swift · routine | Widgets: one habit's week | 8 | 33 ms | 20.6 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 15 ms | 15.4 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 7 ms | 2.2 ms |
| swift · routine | Watch Today: plan | 17 | 2 ms | 0.3 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · routine | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 386 ms | 359.4 ms |
| shared · routine | Widgets: one habit's week | 16 | 40 ms | 16.1 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 20 ms | 20.3 ms |
| shared · routine | Watch Today: plan | 17 | 12 ms | 4.3 ms |
| shared · routine | Shared rules: built from every log | 3 | 10 ms | 5.6 ms |
| shared · routine | Watch Day details: the dial's words | 61 | 10 ms | 1.4 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 3 ms | 0.7 ms |
| shared · routine | Widgets: the snapshot | 3 | 2 ms | 0.6 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 51 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 157 ms | 134.9 ms |
| swift · routine | Widgets: one habit's week | 8 | 30 ms | 22.1 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 25 ms | 24.6 ms |
| swift · routine | Watch Today: plan | 17 | 3 ms | 0.9 ms |
| swift · routine | Watch Day details: the dial's words | 2 | 2 ms | 1.4 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 1 ms | 1.0 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · routine | Count: a Today row drawn | 23 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 23 ms | 12.0 ms |
| shared · launch | Store load: read the database | 1 | 20 ms | 19.6 ms |
| shared · launch | Shared rules: built from every log | 2 | 10 ms | 8.8 ms |
| shared · launch | Watch Today: plan | 9 | 7 ms | 2.4 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 1.1 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 22 ms | 12.5 ms |
| swift · launch | Store load: read the database | 1 | 19 ms | 18.9 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 31 ms | 15.0 ms |
| shared · launch | Store load: read the database | 1 | 26 ms | 25.7 ms |
| shared · launch | Watch Today: plan | 9 | 7 ms | 1.3 ms |
| shared · launch | Shared rules: built from every log | 2 | 4 ms | 3.6 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.4 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.9 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 30 ms | 17.9 ms |
| swift · launch | Store load: read the database | 1 | 6 ms | 6.0 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 31 ms | 16.8 ms |
| shared · launch | Store load: read the database | 1 | 10 ms | 10.0 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 0.7 ms |
| shared · launch | Shared rules: built from every log | 2 | 4 ms | 3.4 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.9 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 22 ms | 12.9 ms |
| swift · launch | Store load: read the database | 1 | 7 ms | 7.2 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 25 ms | 13.8 ms |
| shared · launch | Store load: read the database | 1 | 21 ms | 21.0 ms |
| shared · launch | Watch Today: plan | 9 | 4 ms | 0.8 ms |
| shared · launch | Shared rules: built from every log | 2 | 3 ms | 3.0 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 39 ms | 23.8 ms |
| swift · launch | Store load: read the database | 1 | 9 ms | 8.5 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 23 ms | 12.8 ms |
| shared · launch | Store load: read the database | 1 | 21 ms | 21.1 ms |
| shared · launch | Watch Today: plan | 9 | 6 ms | 1.4 ms |
| shared · launch | Shared rules: built from every log | 2 | 5 ms | 4.2 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.6 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.7 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 21 ms | 12.5 ms |
| swift · launch | Store load: read the database | 1 | 6 ms | 5.7 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 21 ms | 11.5 ms |
| shared · launch | Store load: read the database | 1 | 7 ms | 6.6 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 0.8 ms |
| shared · launch | Shared rules: built from every log | 2 | 3 ms | 2.2 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.4 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 24 ms | 13.3 ms |
| swift · launch | Store load: read the database | 1 | 6 ms | 6.0 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 26 ms | 13.1 ms |
| shared · launch | Store load: read the database | 1 | 11 ms | 10.6 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 0.8 ms |
| shared · launch | Shared rules: built from every log | 2 | 4 ms | 3.4 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 20 ms | 11.0 ms |
| swift · launch | Store load: read the database | 1 | 7 ms | 6.5 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| swift · launch | Count: a Today row drawn | 4 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 23 ms | 11.5 ms |
| shared · launch | Store load: read the database | 1 | 12 ms | 11.6 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 0.7 ms |
| shared · launch | Shared rules: built from every log | 2 | 3 ms | 3.2 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 19 ms | 11.0 ms |
| swift · launch | Store load: read the database | 1 | 15 ms | 15.4 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |

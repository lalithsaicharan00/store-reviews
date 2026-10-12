| Variant · What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms |
|---|---|---|---|
| shared · Today: scrolling 30 habits | 27.0 | 212 ms | 2 |
| swift · Today: scrolling 30 habits | 2.0 | 31 ms | 0 |
| shared · Today: scrolling 30 habits | 13.0 | 82 ms | 0 |
| swift · Today: scrolling 30 habits | 5.8 | 79 ms | 0 |
| shared · Today: scrolling 30 habits | 12.0 | 81 ms | 0 |
| swift · Today: scrolling 30 habits | 0.0 | 0 ms | 0 |
| shared · Today: scrolling 30 habits | 1.7 | 32 ms | 0 |
| swift · Today: scrolling 30 habits | 1.7 | 37 ms | 0 |
| shared · Routine: paging with the Crown | 1.6 | 27 ms | 0 |
| swift · Routine: paging with the Crown | 0.0 | 0 ms | 0 |
| shared · Routine: paging with the Crown | 1.8 | 33 ms | 0 |
| swift · Routine: paging with the Crown | 0.0 | 0 ms | 0 |
| shared · Routine: paging with the Crown | 0.0 | 17 ms | 0 |
| swift · Routine: paging with the Crown | 0.7 | 23 ms | 0 |
| shared · Routine: paging with the Crown | 1.4 | 28 ms | 0 |
| swift · Routine: paging with the Crown | 0.0 | 0 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- shared · Blank cover (control, first): longest stall 137 ms
- shared · Blank cover (control, again): longest stall 37 ms
- shared · Routine (open): longest stall 188 ms
- swift · Blank cover (control, first): longest stall 98 ms
- swift · Blank cover (control, again): longest stall 26 ms
- swift · Routine (open): longest stall 195 ms
- shared · Blank cover (control, first): longest stall 59 ms
- shared · Blank cover (control, again): longest stall 25 ms
- shared · Routine (open): longest stall 168 ms
- swift · Blank cover (control, first): longest stall 65 ms
- swift · Blank cover (control, again): longest stall 32 ms
- swift · Routine (open): longest stall 174 ms
- shared · Blank cover (control, first): longest stall 66 ms
- shared · Blank cover (control, again): longest stall 37 ms
- shared · Routine (open): longest stall 171 ms
- swift · Blank cover (control, first): longest stall 71 ms
- swift · Blank cover (control, again): longest stall 28 ms
- swift · Routine (open): longest stall 193 ms
- shared · Blank cover (control, first): longest stall 76 ms
- shared · Blank cover (control, again): longest stall 49 ms
- shared · Routine (open): longest stall 224 ms
- swift · Blank cover (control, first): longest stall 83 ms
- swift · Blank cover (control, again): longest stall 38 ms
- swift · Routine (open): longest stall 232 ms
- shared · Launch to a usable Today (round 1 , cold): 697 ms
- swift · Launch to a usable Today (round 1 , cold): 683 ms
- shared · Launch to a usable Today (round 2, warm): 642 ms
- swift · Launch to a usable Today (round 2, warm): 690 ms
- shared · Launch to a usable Today (round 3, warm): 705 ms
- swift · Launch to a usable Today (round 3, warm): 645 ms
- shared · Launch to a usable Today (round 4, warm): 695 ms
- swift · Launch to a usable Today (round 4, warm): 660 ms
- shared · Launch to a usable Today (round 5, warm): 622 ms
- swift · Launch to a usable Today (round 5, warm): 973 ms
- shared · Launch to a usable Today (round 6, warm): 594 ms
- swift · Launch to a usable Today (round 6, warm): 656 ms
- shared · Launch to a usable Today (round 7, warm): 911 ms
- swift · Launch to a usable Today (round 7, warm): 603 ms
- shared · Launch to a usable Today (round 8, warm): 635 ms
- swift · Launch to a usable Today (round 8, warm): 611 ms

Notes (storage and the first fill):


Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| shared · scroll-today | Store load: read the database | 2 | 1266 ms | 1103.1 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 130 ms | 66.1 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 73 ms | 72.6 ms |
| shared · scroll-today | Watch Today: plan | 32 | 58 ms | 7.0 ms |
| shared · scroll-today | Shared rules: built from every log | 1 | 37 ms | 36.7 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 21 ms | 2.6 ms |
| shared · scroll-today | Shared rules: built from every log, off the main thread | 2 | 13 ms | 12.1 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 9 ms | 5.5 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 2 ms | 2.5 ms |
| shared · scroll-today | Count: a Today row drawn | 164 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 889 ms | 876.5 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 109 ms | 108.8 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 72 ms | 23.6 ms |
| swift · scroll-today | Watch Today: plan | 32 | 14 ms | 4.0 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 3 ms | 1.1 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 743 ms | 717.9 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 73 ms | 14.5 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 64 ms | 64.2 ms |
| shared · scroll-today | Watch Today: plan | 32 | 36 ms | 3.5 ms |
| shared · scroll-today | Shared rules: built from every log, off the main thread | 2 | 18 ms | 17.6 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 16 ms | 1.8 ms |
| shared · scroll-today | Shared rules: built from every log | 1 | 8 ms | 8.0 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 5 ms | 2.8 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 868 ms | 855.1 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 64 ms | 63.7 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 52 ms | 14.1 ms |
| swift · scroll-today | Watch Today: plan | 32 | 12 ms | 4.1 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 3 ms | 1.5 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| swift · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 1240 ms | 1214.1 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 66 ms | 66.0 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 56 ms | 17.5 ms |
| shared · scroll-today | Shared rules: built from every log, off the main thread | 2 | 32 ms | 31.7 ms |
| shared · scroll-today | Watch Today: plan | 32 | 29 ms | 2.2 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 12 ms | 1.7 ms |
| shared · scroll-today | Shared rules: built from every log | 1 | 8 ms | 8.3 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.3 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 599 ms | 591.0 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 77 ms | 77.1 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 74 ms | 23.2 ms |
| swift · scroll-today | Watch Today: plan | 32 | 14 ms | 6.0 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 7 ms | 5.0 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · scroll-today | Count: a Today row drawn | 101 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 570 ms | 551.4 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 64 ms | 64.3 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 59 ms | 23.4 ms |
| shared · scroll-today | Watch Today: plan | 32 | 28 ms | 2.3 ms |
| shared · scroll-today | Shared rules: built from every log, off the main thread | 2 | 12 ms | 11.8 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 12 ms | 1.2 ms |
| shared · scroll-today | Shared rules: built from every log | 1 | 5 ms | 4.9 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.2 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| shared · scroll-today | Count: a Today row drawn | 103 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 607 ms | 600.7 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 74 ms | 73.8 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 61 ms | 16.9 ms |
| swift · scroll-today | Watch Today: plan | 32 | 13 ms | 6.5 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 3 ms | 1.1 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 1.1 ms |
| swift · scroll-today | Count: a Today row drawn | 104 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 81 ms | 73.8 ms |
| shared · routine | Widgets: one habit's week | 8 | 23 ms | 9.0 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 14 ms | 13.8 ms |
| shared · routine | Watch Today: plan | 16 | 7 ms | 0.8 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 3 ms | 2.8 ms |
| shared · routine | Shared rules: built from every log | 1 | 3 ms | 2.6 ms |
| shared · routine | Shared rules: built from every log, off the main thread | 2 | 2 ms | 2.3 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 2 ms | 0.3 ms |
| shared · routine | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · routine | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 83 ms | 74.0 ms |
| swift · routine | Widgets: one habit's week | 8 | 17 ms | 9.8 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 13 ms | 13.3 ms |
| swift · routine | Watch Today: plan | 17 | 3 ms | 0.7 ms |
| swift · routine | Watch Day details: the dial's words | 2 | 1 ms | 1.0 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · routine | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 99 ms | 86.8 ms |
| shared · routine | Widgets: one habit's week | 8 | 17 ms | 10.6 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 15 ms | 14.6 ms |
| shared · routine | Watch Today: plan | 17 | 7 ms | 0.6 ms |
| shared · routine | Shared rules: built from every log | 1 | 4 ms | 3.6 ms |
| shared · routine | Shared rules: built from every log, off the main thread | 2 | 3 ms | 2.5 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 2 ms | 0.3 ms |
| shared · routine | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 1 ms | 0.8 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 156 ms | 151.5 ms |
| swift · routine | Widgets: one habit's week | 8 | 26 ms | 17.8 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 23 ms | 23.2 ms |
| swift · routine | Watch Today: plan | 17 | 3 ms | 0.9 ms |
| swift · routine | Watch Day details: the dial's words | 2 | 1 ms | 1.2 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| swift · routine | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 79 ms | 70.9 ms |
| shared · routine | Widgets: one habit's week | 8 | 17 ms | 9.3 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 14 ms | 14.4 ms |
| shared · routine | Watch Today: plan | 17 | 7 ms | 0.7 ms |
| shared · routine | Shared rules: built from every log, off the main thread | 2 | 2 ms | 2.2 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 2 ms | 0.3 ms |
| shared · routine | Shared rules: built from every log | 1 | 2 ms | 2.1 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 1 ms | 1.3 ms |
| shared · routine | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.1 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 12 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 87 ms | 75.6 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 20 ms | 19.9 ms |
| swift · routine | Widgets: one habit's week | 8 | 17 ms | 10.0 ms |
| swift · routine | Watch Today: plan | 17 | 3 ms | 0.8 ms |
| swift · routine | Watch Day details: the dial's words | 2 | 1 ms | 1.0 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · routine | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 88 ms | 78.0 ms |
| shared · routine | Widgets: one habit's week | 8 | 20 ms | 11.9 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 14 ms | 13.8 ms |
| shared · routine | Watch Today: plan | 16 | 7 ms | 0.7 ms |
| shared · routine | Shared rules: built from every log | 1 | 3 ms | 2.5 ms |
| shared · routine | Shared rules: built from every log, off the main thread | 2 | 3 ms | 2.4 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 2 ms | 0.3 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 2 ms | 1.7 ms |
| shared · routine | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a Today row drawn | 11 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 229 ms | 223.3 ms |
| swift · routine | Widgets: one habit's week | 8 | 24 ms | 14.6 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 17 ms | 17.0 ms |
| swift · routine | Watch Today: plan | 17 | 3 ms | 1.1 ms |
| swift · routine | Watch Day details: the dial's words | 2 | 2 ms | 1.6 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| swift · routine | Count: a Today row drawn | 19 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 20 ms | 11.6 ms |
| shared · launch | Store load: read the database | 1 | 8 ms | 8.1 ms |
| shared · launch | Watch Today: plan | 9 | 4 ms | 0.8 ms |
| shared · launch | Shared rules: built from every log | 1 | 2 ms | 2.4 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 1.0 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · launch | Count: a Today row drawn | 5 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 20 ms | 12.4 ms |
| swift · launch | Store load: read the database | 1 | 6 ms | 5.8 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 8 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 20 ms | 10.6 ms |
| shared · launch | Store load: read the database | 1 | 14 ms | 14.4 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 0.8 ms |
| shared · launch | Shared rules: built from every log | 1 | 2 ms | 2.4 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.5 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 4 | 0 ms | 0.0 ms |
| swift · launch | Store load: read the database | 1 | 19 ms | 18.9 ms |
| swift · launch | Widgets: one habit's week | 8 | 17 ms | 8.9 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 6 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 41 ms | 15.9 ms |
| shared · launch | Store load: read the database | 1 | 23 ms | 23.4 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 0.8 ms |
| shared · launch | Shared rules: built from every log | 1 | 2 ms | 2.5 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.2 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 20 ms | 11.9 ms |
| swift · launch | Store load: read the database | 1 | 7 ms | 7.4 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 21 ms | 12.2 ms |
| shared · launch | Store load: read the database | 1 | 20 ms | 20.1 ms |
| shared · launch | Watch Today: plan | 9 | 4 ms | 0.6 ms |
| shared · launch | Shared rules: built from every log | 1 | 3 ms | 2.9 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 7 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 17 ms | 9.8 ms |
| swift · launch | Store load: read the database | 1 | 13 ms | 12.9 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 8 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 20 ms | 10.9 ms |
| shared · launch | Store load: read the database | 1 | 9 ms | 9.1 ms |
| shared · launch | Watch Today: plan | 9 | 4 ms | 0.7 ms |
| shared · launch | Shared rules: built from every log | 1 | 3 ms | 2.6 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 23 ms | 14.6 ms |
| swift · launch | Store load: read the database | 1 | 14 ms | 14.2 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 19 ms | 10.2 ms |
| shared · launch | Store load: read the database | 1 | 10 ms | 9.7 ms |
| shared · launch | Watch Today: plan | 9 | 4 ms | 0.7 ms |
| shared · launch | Shared rules: built from every log | 1 | 2 ms | 2.4 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 21 ms | 12.2 ms |
| swift · launch | Store load: read the database | 1 | 10 ms | 9.9 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.1 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 4 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 21 ms | 11.2 ms |
| shared · launch | Store load: read the database | 1 | 14 ms | 13.7 ms |
| shared · launch | Shared rules: built from every log | 1 | 5 ms | 4.9 ms |
| shared · launch | Watch Today: plan | 9 | 4 ms | 0.6 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.2 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Store load: read the database | 1 | 19 ms | 19.4 ms |
| swift · launch | Widgets: one habit's week | 8 | 18 ms | 10.2 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.1 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| swift · launch | Count: a Today row drawn | 4 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 22 ms | 12.4 ms |
| shared · launch | Store load: read the database | 1 | 7 ms | 7.2 ms |
| shared · launch | Watch Today: plan | 9 | 4 ms | 0.6 ms |
| shared · launch | Shared rules: built from every log | 1 | 2 ms | 2.3 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.4 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 23 ms | 11.7 ms |
| swift · launch | Store load: read the database | 1 | 4 ms | 4.4 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.1 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| swift · launch | Count: a Today row drawn | 4 | 0 ms | 0.0 ms |

| Variant · What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms |
|---|---|---|---|
| shared · Today: scrolling 30 habits | 5.7 | 58 ms | 0 |
| swift · Today: scrolling 30 habits | 1.8 | 38 ms | 0 |
| shared · Today: scrolling 30 habits | 3.4 | 50 ms | 0 |
| swift · Today: scrolling 30 habits | 5.9 | 76 ms | 0 |
| shared · Today: scrolling 30 habits | 12.4 | 61 ms | 0 |
| swift · Today: scrolling 30 habits | 21.2 | 97 ms | 0 |
| shared · Today: scrolling 30 habits | 5.4 | 74 ms | 0 |
| swift · Today: scrolling 30 habits | 5.8 | 74 ms | 0 |
| shared · Routine: paging with the Crown | 5.3 | 67 ms | 0 |
| swift · Routine: paging with the Crown | 4.4 | 44 ms | 0 |
| shared · Routine: paging with the Crown | 2.4 | 28 ms | 0 |
| swift · Routine: paging with the Crown | 3.4 | 30 ms | 0 |
| shared · Routine: paging with the Crown | 0.0 | 0 ms | 0 |
| swift · Routine: paging with the Crown | 10.6 | 37 ms | 0 |
| shared · Routine: paging with the Crown | 3.8 | 38 ms | 0 |
| swift · Routine: paging with the Crown | 6.9 | 34 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- shared · Blank cover (control, first): longest stall 281 ms
- shared · Blank cover (control, again): longest stall 50 ms
- shared · Routine (open): longest stall 356 ms
- swift · Blank cover (control, first): longest stall 138 ms
- swift · Blank cover (control, again): longest stall 61 ms
- swift · Routine (open): longest stall 335 ms
- shared · Blank cover (control, first): longest stall 103 ms
- shared · Blank cover (control, again): longest stall 36 ms
- shared · Routine (open): longest stall 221 ms
- swift · Blank cover (control, first): longest stall 268 ms
- swift · Blank cover (control, again): longest stall 59 ms
- swift · Routine (open): longest stall 302 ms
- shared · Blank cover (control, first): longest stall 161 ms
- shared · Blank cover (control, again): longest stall 38 ms
- shared · Routine (open): longest stall 278 ms
- swift · Blank cover (control, first): longest stall 135 ms
- swift · Blank cover (control, again): longest stall 66 ms
- swift · Routine (open): longest stall 347 ms
- shared · Blank cover (control, first): longest stall 185 ms
- shared · Blank cover (control, again): longest stall 44 ms
- shared · Routine (open): longest stall 453 ms
- swift · Blank cover (control, first): longest stall 107 ms
- swift · Blank cover (control, again): longest stall 38 ms
- swift · Routine (open): longest stall 263 ms
- shared · Launch to a usable Today (round 1 , cold): 1824 ms
- swift · Launch to a usable Today (round 1 , cold): 1026 ms
- shared · Launch to a usable Today (round 2, warm): 960 ms
- swift · Launch to a usable Today (round 2, warm): 1591 ms
- shared · Launch to a usable Today (round 3, warm): 1566 ms
- swift · Launch to a usable Today (round 3, warm): 2968 ms
- shared · Launch to a usable Today (round 4, warm): 1067 ms
- swift · Launch to a usable Today (round 4, warm): 1067 ms
- shared · Launch to a usable Today (round 5, warm): 1604 ms
- swift · Launch to a usable Today (round 5, warm): 1203 ms
- shared · Launch to a usable Today (round 6, warm): 919 ms
- swift · Launch to a usable Today (round 6, warm): 1215 ms
- shared · Launch to a usable Today (round 7, warm): 2050 ms
- swift · Launch to a usable Today (round 7, warm): 1671 ms
- shared · Launch to a usable Today (round 8, warm): 1689 ms
- swift · Launch to a usable Today (round 8, warm): 1216 ms

Notes (storage and the first fill):


Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| shared · scroll-today | Store load: read the database | 2 | 1145 ms | 1063.2 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 169 ms | 32.0 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 80 ms | 80.4 ms |
| shared · scroll-today | Watch Today: plan | 32 | 79 ms | 30.7 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 47 ms | 29.1 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 16 ms | 11.7 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 16 ms | 1.1 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 4 ms | 3.8 ms |
| shared · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 729 ms | 716.8 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 70 ms | 70.0 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 57 ms | 15.5 ms |
| swift · scroll-today | Watch Today: plan | 32 | 11 ms | 4.1 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 3 ms | 1.4 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 1014 ms | 897.9 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 421 ms | 297.5 ms |
| shared · scroll-today | Watch Today: plan | 32 | 96 ms | 35.8 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 95 ms | 94.6 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 75 ms | 39.6 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 19 ms | 2.3 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 5 ms | 1.8 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 2 ms | 2.1 ms |
| shared · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 1322 ms | 1312.9 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 81 ms | 81.0 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 77 ms | 30.0 ms |
| swift · scroll-today | Watch Today: plan | 32 | 14 ms | 4.5 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.5 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 2127 ms | 2095.1 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 396 ms | 257.9 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 97 ms | 96.8 ms |
| shared · scroll-today | Watch Today: plan | 32 | 88 ms | 53.7 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 56 ms | 42.2 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 13 ms | 0.9 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 8 ms | 3.4 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 1064 ms | 1054.0 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 105 ms | 104.6 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 65 ms | 14.6 ms |
| swift · scroll-today | Watch Today: plan | 32 | 14 ms | 5.5 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.9 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| swift · scroll-today | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 1832 ms | 1792.6 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 271 ms | 83.4 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 132 ms | 132.3 ms |
| shared · scroll-today | Watch Today: plan | 32 | 127 ms | 51.0 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 65 ms | 49.5 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 27 ms | 2.0 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 17 ms | 12.5 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 1751 ms | 1743.8 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 209 ms | 208.8 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 58 ms | 14.6 ms |
| swift · scroll-today | Watch Today: plan | 32 | 9 ms | 0.7 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 3 ms | 1.1 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 329 ms | 300.3 ms |
| shared · routine | Widgets: one habit's week | 16 | 54 ms | 14.3 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 33 ms | 33.4 ms |
| shared · routine | Watch Today: plan | 17 | 18 ms | 9.7 ms |
| shared · routine | Shared rules: built from every log | 3 | 17 ms | 8.7 ms |
| shared · routine | Watch Day details: the dial's words | 52 | 12 ms | 4.4 ms |
| shared · routine | Widgets: the snapshot | 3 | 3 ms | 1.2 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 2 ms | 0.3 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a Today row drawn | 50 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 180 ms | 147.9 ms |
| swift · routine | Widgets: one habit's week | 8 | 38 ms | 24.1 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 17 ms | 16.5 ms |
| swift · routine | Watch Today: plan | 17 | 5 ms | 1.0 ms |
| swift · routine | Watch Day details: the dial's words | 6 | 4 ms | 3.0 ms |
| swift · routine | Widgets: the snapshot | 2 | 2 ms | 0.9 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · routine | Count: a Today row drawn | 22 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 37 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 438 ms | 429.9 ms |
| shared · routine | Widgets: one habit's week | 16 | 98 ms | 45.8 ms |
| shared · routine | Watch Today: plan | 17 | 24 ms | 11.5 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 23 ms | 22.6 ms |
| shared · routine | Shared rules: built from every log | 3 | 14 ms | 10.8 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 5 ms | 5.1 ms |
| shared · routine | Widgets: the snapshot | 3 | 3 ms | 1.2 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 3 ms | 0.7 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a Today row drawn | 23 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 267 ms | 247.7 ms |
| swift · routine | Widgets: one habit's week | 8 | 29 ms | 21.5 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 16 ms | 16.0 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 8 ms | 2.9 ms |
| swift · routine | Watch Today: plan | 17 | 3 ms | 0.6 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| swift · routine | Count: a Today row drawn | 41 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 315 ms | 286.6 ms |
| shared · routine | Widgets: one habit's week | 16 | 43 ms | 16.6 ms |
| shared · routine | Watch Today: plan | 17 | 34 ms | 15.5 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 24 ms | 23.9 ms |
| shared · routine | Shared rules: built from every log | 3 | 22 ms | 14.6 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 5 ms | 0.8 ms |
| shared · routine | Widgets: the snapshot | 3 | 3 ms | 2.4 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 3 ms | 2.4 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a Today row drawn | 19 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 138 ms | 130.3 ms |
| swift · routine | Widgets: one habit's week | 8 | 21 ms | 13.7 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 15 ms | 15.2 ms |
| swift · routine | Watch Today: plan | 17 | 8 ms | 3.8 ms |
| swift · routine | Watch Day details: the dial's words | 2 | 3 ms | 2.3 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.9 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · routine | Count: a Today row drawn | 10 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 271 ms | 239.8 ms |
| shared · routine | Widgets: one habit's week | 16 | 93 ms | 18.3 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 34 ms | 33.6 ms |
| shared · routine | Watch Today: plan | 16 | 18 ms | 3.6 ms |
| shared · routine | Shared rules: built from every log | 3 | 16 ms | 7.9 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 4 ms | 1.2 ms |
| shared · routine | Widgets: the snapshot | 3 | 4 ms | 1.8 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 2 ms | 2.0 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 10 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 301 ms | 281.4 ms |
| swift · routine | Widgets: one habit's week | 16 | 25 ms | 11.8 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 17 ms | 16.6 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 11 ms | 4.2 ms |
| swift · routine | Watch Today: plan | 17 | 3 ms | 0.5 ms |
| swift · routine | Widgets: the snapshot | 3 | 1 ms | 0.7 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| swift · routine | Count: a Today row drawn | 23 | 0 ms | 0.0 ms |
| shared · launch | Store load: read the database | 1 | 39 ms | 39.2 ms |
| shared · launch | Widgets: one habit's week | 8 | 35 ms | 18.9 ms |
| shared · launch | Shared rules: built from every log | 2 | 18 ms | 17.3 ms |
| shared · launch | Watch Today: plan | 9 | 9 ms | 1.7 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 7 ms | 3.4 ms |
| shared · launch | Widgets: the snapshot | 2 | 3 ms | 1.9 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 25 ms | 14.4 ms |
| swift · launch | Store load: read the database | 1 | 14 ms | 13.6 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.6 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| swift · launch | Count: a Today row drawn | 4 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 32 ms | 13.7 ms |
| shared · launch | Store load: read the database | 1 | 16 ms | 16.2 ms |
| shared · launch | Watch Today: plan | 9 | 6 ms | 1.1 ms |
| shared · launch | Shared rules: built from every log | 2 | 3 ms | 2.9 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.7 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 4 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 27 ms | 16.4 ms |
| swift · launch | Store load: read the database | 1 | 15 ms | 15.2 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.6 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 19 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 40 ms | 18.3 ms |
| shared · launch | Store load: read the database | 1 | 9 ms | 8.6 ms |
| shared · launch | Watch Today: plan | 9 | 8 ms | 1.5 ms |
| shared · launch | Shared rules: built from every log | 2 | 3 ms | 2.9 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.6 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| shared · launch | Shared rules: a log added | 8 | 1 ms | 0.2 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 32 ms | 17.8 ms |
| swift · launch | Store load: read the database | 1 | 19 ms | 19.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 22 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 35 ms | 15.5 ms |
| shared · launch | Store load: read the database | 1 | 30 ms | 30.0 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 0.8 ms |
| shared · launch | Shared rules: built from every log | 2 | 3 ms | 2.8 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.4 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 32 ms | 19.9 ms |
| swift · launch | Store load: read the database | 1 | 23 ms | 23.1 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.5 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 47 ms | 21.6 ms |
| shared · launch | Store load: read the database | 1 | 12 ms | 12.3 ms |
| shared · launch | Watch Today: plan | 9 | 6 ms | 1.1 ms |
| shared · launch | Widgets: the snapshot | 2 | 5 ms | 3.6 ms |
| shared · launch | Shared rules: built from every log | 2 | 4 ms | 3.3 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.8 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 22 ms | 13.0 ms |
| swift · launch | Store load: read the database | 1 | 21 ms | 21.0 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 5 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 24 ms | 11.4 ms |
| shared · launch | Store load: read the database | 1 | 10 ms | 10.2 ms |
| shared · launch | Watch Today: plan | 9 | 7 ms | 1.5 ms |
| shared · launch | Shared rules: built from every log | 2 | 4 ms | 3.6 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.2 ms |
| shared · launch | Shared rules: a log added | 8 | 1 ms | 0.3 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 28 ms | 20.1 ms |
| swift · launch | Store load: read the database | 1 | 22 ms | 22.3 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.4 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Store load: read the database | 1 | 35 ms | 35.4 ms |
| shared · launch | Widgets: one habit's week | 8 | 31 ms | 16.7 ms |
| shared · launch | Watch Today: plan | 9 | 7 ms | 1.9 ms |
| shared · launch | Shared rules: built from every log | 2 | 7 ms | 6.1 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.6 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 54 ms | 36.5 ms |
| swift · launch | Store load: read the database | 1 | 44 ms | 44.4 ms |
| swift · launch | Watch Today: plan | 9 | 3 ms | 1.8 ms |
| swift · launch | Widgets: the snapshot | 2 | 3 ms | 2.0 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 44 ms | 16.6 ms |
| shared · launch | Store load: read the database | 1 | 24 ms | 24.0 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 0.9 ms |
| shared · launch | Shared rules: built from every log | 2 | 5 ms | 4.1 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| shared · launch | Shared rules: a log added | 8 | 1 ms | 0.2 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 26 ms | 15.2 ms |
| swift · launch | Store load: read the database | 1 | 10 ms | 9.9 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |

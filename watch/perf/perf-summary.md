| Variant · What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms |
|---|---|---|---|
| shared · Today: scrolling 30 habits | 9.9 | 60 ms | 0 |
| swift · Today: scrolling 30 habits | 9.6 | 132 ms | 1 |
| shared · Today: scrolling 30 habits | 5.7 | 73 ms | 0 |
| swift · Today: scrolling 30 habits | 8.0 | 82 ms | 0 |
| shared · Today: scrolling 30 habits | 41.9 | 210 ms | 1 |
| swift · Today: scrolling 30 habits | 13.4 | 134 ms | 1 |
| shared · Today: scrolling 30 habits | 27.9 | 274 ms | 1 |
| swift · Today: scrolling 30 habits | 11.6 | 94 ms | 0 |
| shared · Routine: paging with the Crown | 8.5 | 42 ms | 0 |
| swift · Routine: paging with the Crown | 9.8 | 47 ms | 0 |
| shared · Routine: paging with the Crown | 4.4 | 27 ms | 0 |
| swift · Routine: paging with the Crown | 23.8 | 53 ms | 0 |
| shared · Routine: paging with the Crown | 9.0 | 46 ms | 0 |
| swift · Routine: paging with the Crown | 12.9 | 43 ms | 0 |
| shared · Routine: paging with the Crown | 13.7 | 41 ms | 0 |
| swift · Routine: paging with the Crown | 23.6 | 79 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- shared · Blank cover (control, first): longest stall 287 ms
- shared · Blank cover (control, again): longest stall 62 ms
- shared · Routine (open): longest stall 345 ms
- swift · Blank cover (control, first): longest stall 214 ms
- swift · Blank cover (control, again): longest stall 84 ms
- swift · Routine (open): longest stall 392 ms
- shared · Blank cover (control, first): longest stall 182 ms
- shared · Blank cover (control, again): longest stall 41 ms
- shared · Routine (open): longest stall 228 ms
- swift · Blank cover (control, first): longest stall 335 ms
- swift · Blank cover (control, again): longest stall 127 ms
- swift · Routine (open): longest stall 503 ms
- shared · Blank cover (control, first): longest stall 231 ms
- shared · Blank cover (control, again): longest stall 104 ms
- shared · Routine (open): longest stall 329 ms
- swift · Blank cover (control, first): longest stall 164 ms
- swift · Blank cover (control, again): longest stall 45 ms
- swift · Routine (open): longest stall 308 ms
- shared · Blank cover (control, first): longest stall 189 ms
- shared · Blank cover (control, again): longest stall 58 ms
- shared · Routine (open): longest stall 360 ms
- swift · Blank cover (control, first): longest stall 357 ms
- swift · Blank cover (control, again): longest stall 69 ms
- swift · Routine (open): longest stall 508 ms
- shared · Launch to a usable Today (round 1 , cold): 1937 ms
- swift · Launch to a usable Today (round 1 , cold): 1378 ms
- shared · Launch to a usable Today (round 2, warm): 1680 ms
- swift · Launch to a usable Today (round 2, warm): 1534 ms
- shared · Launch to a usable Today (round 3, warm): 1946 ms
- swift · Launch to a usable Today (round 3, warm): 2208 ms
- shared · Launch to a usable Today (round 4, warm): 2787 ms
- swift · Launch to a usable Today (round 4, warm): 2596 ms
- shared · Launch to a usable Today (round 5, warm): 2053 ms
- swift · Launch to a usable Today (round 5, warm): 2442 ms
- shared · Launch to a usable Today (round 6, warm): 2498 ms
- swift · Launch to a usable Today (round 6, warm): 3810 ms
- shared · Launch to a usable Today (round 7, warm): 1818 ms
- swift · Launch to a usable Today (round 7, warm): 2642 ms
- shared · Launch to a usable Today (round 8, warm): 3229 ms
- swift · Launch to a usable Today (round 8, warm): 1875 ms

Notes (storage and the first fill):


Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| shared · scroll-today | Store load: read the database | 2 | 3228 ms | 2940.4 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 111 ms | 111.1 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 104 ms | 32.7 ms |
| shared · scroll-today | Watch Today: plan | 32 | 53 ms | 13.6 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 36 ms | 30.6 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 34 ms | 20.5 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 17 ms | 1.1 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 3 ms | 3.0 ms |
| shared · scroll-today | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 1084 ms | 1060.1 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 107 ms | 107.0 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 100 ms | 41.2 ms |
| swift · scroll-today | Watch Today: plan | 32 | 18 ms | 7.8 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 12 ms | 9.3 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 2 ms | 2.0 ms |
| swift · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 2315 ms | 2304.4 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 86 ms | 26.2 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 72 ms | 72.1 ms |
| shared · scroll-today | Watch Today: plan | 32 | 48 ms | 13.4 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 16 ms | 12.1 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 14 ms | 1.5 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.7 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 1.1 ms |
| shared · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 2235 ms | 2226.3 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 67 ms | 66.7 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 66 ms | 13.9 ms |
| swift · scroll-today | Watch Today: plan | 31 | 7 ms | 0.6 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 3 ms | 1.1 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 1047 ms | 996.8 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 137 ms | 23.9 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 84 ms | 84.3 ms |
| shared · scroll-today | Watch Today: plan | 32 | 52 ms | 18.5 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 35 ms | 17.1 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 15 ms | 1.1 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 5 ms | 2.6 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| shared · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 1075 ms | 1047.4 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 94 ms | 22.0 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 90 ms | 89.8 ms |
| swift · scroll-today | Watch Today: plan | 32 | 18 ms | 9.0 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 5 ms | 2.4 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| swift · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 3237 ms | 3208.3 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 115 ms | 115.1 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 103 ms | 27.9 ms |
| shared · scroll-today | Watch Today: plan | 31 | 49 ms | 3.3 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 25 ms | 15.5 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 20 ms | 1.6 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 5 ms | 2.3 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| shared · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 1910 ms | 1889.3 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 96 ms | 26.6 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 92 ms | 91.8 ms |
| swift · scroll-today | Watch Today: plan | 31 | 8 ms | 0.5 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 3 ms | 1.1 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| swift · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 502 ms | 470.5 ms |
| shared · routine | Widgets: one habit's week | 16 | 107 ms | 44.5 ms |
| shared · routine | Watch Today: plan | 17 | 32 ms | 20.5 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 27 ms | 27.1 ms |
| shared · routine | Shared rules: built from every log | 3 | 25 ms | 18.3 ms |
| shared · routine | Watch Day details: the dial's words | 61 | 13 ms | 4.6 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 6 ms | 1.4 ms |
| shared · routine | Widgets: the snapshot | 3 | 1 ms | 0.5 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| shared · routine | Shared rules: a log added | 8 | 1 ms | 0.1 ms |
| shared · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 50 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 330 ms | 323.3 ms |
| swift · routine | Widgets: one habit's week | 16 | 35 ms | 19.0 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 20 ms | 20.0 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 13 ms | 6.5 ms |
| swift · routine | Watch Today: plan | 17 | 4 ms | 0.9 ms |
| swift · routine | Widgets: the snapshot | 3 | 1 ms | 0.5 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 1 ms | 1.1 ms |
| swift · routine | Count: a Today row drawn | 51 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 472 ms | 453.8 ms |
| shared · routine | Widgets: one habit's week | 16 | 33 ms | 12.8 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 24 ms | 23.9 ms |
| shared · routine | Watch Today: plan | 17 | 12 ms | 3.6 ms |
| shared · routine | Shared rules: built from every log | 3 | 8 ms | 4.5 ms |
| shared · routine | Watch Day details: the dial's words | 61 | 8 ms | 1.9 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 3 ms | 0.8 ms |
| shared · routine | Widgets: the snapshot | 3 | 2 ms | 1.1 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 67 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 332 ms | 319.4 ms |
| swift · routine | Widgets: one habit's week | 16 | 46 ms | 28.9 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 20 ms | 19.8 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 10 ms | 1.9 ms |
| swift · routine | Watch Today: plan | 17 | 5 ms | 1.3 ms |
| swift · routine | Widgets: the snapshot | 3 | 2 ms | 1.5 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| swift · routine | Count: a Today row drawn | 51 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 172 ms | 154.7 ms |
| shared · routine | Widgets: one habit's week | 8 | 44 ms | 32.2 ms |
| shared · routine | Watch Today: plan | 17 | 29 ms | 14.2 ms |
| shared · routine | Shared rules: built from every log | 3 | 21 ms | 13.4 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 17 ms | 16.9 ms |
| shared · routine | Watch Day details: the dial's words | 61 | 10 ms | 1.9 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 5 ms | 0.8 ms |
| shared · routine | Widgets: the snapshot | 2 | 3 ms | 2.1 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 53 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 671 ms | 622.4 ms |
| swift · routine | Widgets: one habit's week | 16 | 49 ms | 19.8 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 16 ms | 16.4 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 9 ms | 2.3 ms |
| swift · routine | Watch Today: plan | 17 | 8 ms | 3.9 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 2 ms | 2.0 ms |
| swift · routine | Widgets: the snapshot | 3 | 2 ms | 1.0 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| swift · routine | Count: a Today row drawn | 50 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 269 ms | 231.1 ms |
| shared · routine | Widgets: one habit's week | 16 | 69 ms | 28.5 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 30 ms | 30.2 ms |
| shared · routine | Shared rules: built from every log | 3 | 21 ms | 15.4 ms |
| shared · routine | Watch Today: plan | 17 | 17 ms | 4.4 ms |
| shared · routine | Watch Day details: the dial's words | 61 | 15 ms | 6.5 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 5 ms | 1.4 ms |
| shared · routine | Widgets: the snapshot | 3 | 2 ms | 1.0 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 51 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 704 ms | 679.8 ms |
| swift · routine | Widgets: one habit's week | 16 | 68 ms | 37.5 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 35 ms | 35.1 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 27 ms | 18.3 ms |
| swift · routine | Watch Today: plan | 17 | 6 ms | 1.6 ms |
| swift · routine | Widgets: the snapshot | 3 | 2 ms | 0.9 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| swift · routine | Count: a Today row drawn | 51 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 41 ms | 24.2 ms |
| shared · launch | Store load: read the database | 1 | 14 ms | 14.4 ms |
| shared · launch | Watch Today: plan | 9 | 9 ms | 1.9 ms |
| shared · launch | Shared rules: built from every log | 2 | 8 ms | 6.4 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 5 ms | 1.1 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 38 ms | 27.2 ms |
| swift · launch | Store load: read the database | 1 | 19 ms | 19.3 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.9 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 52 ms | 31.2 ms |
| shared · launch | Store load: read the database | 1 | 32 ms | 32.3 ms |
| shared · launch | Watch Today: plan | 9 | 7 ms | 1.2 ms |
| shared · launch | Shared rules: built from every log | 2 | 7 ms | 6.1 ms |
| shared · launch | Widgets: the snapshot | 2 | 3 ms | 1.7 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.6 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 37 ms | 22.6 ms |
| swift · launch | Store load: read the database | 1 | 14 ms | 14.1 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.6 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 29 ms | 15.4 ms |
| shared · launch | Store load: read the database | 1 | 16 ms | 16.4 ms |
| shared · launch | Watch Today: plan | 9 | 6 ms | 1.2 ms |
| shared · launch | Shared rules: built from every log | 2 | 4 ms | 3.8 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.6 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 29 ms | 16.9 ms |
| swift · launch | Store load: read the database | 1 | 21 ms | 21.4 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 31 ms | 14.2 ms |
| shared · launch | Store load: read the database | 1 | 21 ms | 21.5 ms |
| shared · launch | Watch Today: plan | 9 | 8 ms | 1.6 ms |
| shared · launch | Shared rules: built from every log | 2 | 4 ms | 3.5 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 4 ms | 0.8 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 0.9 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 33 ms | 18.6 ms |
| swift · launch | Store load: read the database | 1 | 14 ms | 13.7 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.6 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 39 ms | 22.2 ms |
| shared · launch | Store load: read the database | 1 | 18 ms | 18.1 ms |
| shared · launch | Watch Today: plan | 9 | 6 ms | 1.1 ms |
| shared · launch | Shared rules: built from every log | 2 | 4 ms | 3.1 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.5 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 36 ms | 28.1 ms |
| swift · launch | Store load: read the database | 1 | 32 ms | 32.3 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 29 ms | 14.9 ms |
| shared · launch | Store load: read the database | 1 | 23 ms | 23.5 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 0.8 ms |
| shared · launch | Shared rules: built from every log | 2 | 5 ms | 4.7 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.4 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.5 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 26 ms | 14.4 ms |
| swift · launch | Store load: read the database | 1 | 12 ms | 12.5 ms |
| swift · launch | Widgets: the snapshot | 2 | 2 ms | 1.3 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Store load: read the database | 1 | 43 ms | 43.1 ms |
| shared · launch | Widgets: one habit's week | 8 | 40 ms | 26.1 ms |
| shared · launch | Watch Today: plan | 9 | 8 ms | 1.8 ms |
| shared · launch | Shared rules: built from every log | 2 | 6 ms | 5.7 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.6 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.3 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 1 ms | 1.0 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 44 ms | 27.0 ms |
| swift · launch | Store load: read the database | 1 | 13 ms | 13.0 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 4 ms | 3.8 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 64 ms | 46.8 ms |
| shared · launch | Store load: read the database | 1 | 35 ms | 35.5 ms |
| shared · launch | Watch Today: plan | 9 | 13 ms | 2.5 ms |
| shared · launch | Shared rules: built from every log | 2 | 8 ms | 6.8 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 6 ms | 1.2 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 2 ms | 1.6 ms |
| shared · launch | Shared rules: a log added | 8 | 1 ms | 0.4 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 43 ms | 27.4 ms |
| swift · launch | Store load: read the database | 1 | 21 ms | 20.8 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.8 ms |
| swift · launch | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 1.1 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |

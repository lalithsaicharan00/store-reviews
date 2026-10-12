| Variant · What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms |
|---|---|---|---|
| shared · Today: scrolling 30 habits | 40.4 | 134 ms | 2 |
| swift · Today: scrolling 30 habits | 8.9 | 94 ms | 0 |
| shared · Today: scrolling 30 habits | 19.9 | 81 ms | 0 |
| swift · Today: scrolling 30 habits | 4.4 | 66 ms | 0 |
| shared · Today: scrolling 30 habits | 4.9 | 47 ms | 0 |
| swift · Today: scrolling 30 habits | 8.4 | 85 ms | 0 |
| shared · Today: scrolling 30 habits | 0.2 | 19 ms | 0 |
| swift · Today: scrolling 30 habits | 8.4 | 48 ms | 0 |
| shared · Routine: paging with the Crown | 8.9 | 62 ms | 0 |
| swift · Routine: paging with the Crown | 7.9 | 35 ms | 0 |
| shared · Routine: paging with the Crown | 5.7 | 35 ms | 0 |
| swift · Routine: paging with the Crown | 6.2 | 44 ms | 0 |
| shared · Routine: paging with the Crown | 0.0 | 0 ms | 0 |
| swift · Routine: paging with the Crown | 6.1 | 43 ms | 0 |
| shared · Routine: paging with the Crown | 12.8 | 46 ms | 0 |
| swift · Routine: paging with the Crown | 8.5 | 79 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- shared · Blank cover (control, first): longest stall 283 ms
- shared · Blank cover (control, again): longest stall 43 ms
- shared · Routine (open): longest stall 345 ms
- swift · Blank cover (control, first): longest stall 122 ms
- swift · Blank cover (control, again): longest stall 49 ms
- swift · Routine (open): longest stall 327 ms
- shared · Blank cover (control, first): longest stall 138 ms
- shared · Blank cover (control, again): longest stall 47 ms
- shared · Routine (open): longest stall 311 ms
- swift · Blank cover (control, first): longest stall 144 ms
- swift · Blank cover (control, again): longest stall 49 ms
- swift · Routine (open): longest stall 277 ms
- shared · Blank cover (control, first): longest stall 138 ms
- shared · Blank cover (control, again): longest stall 42 ms
- shared · Routine (open): longest stall 310 ms
- swift · Blank cover (control, first): longest stall 126 ms
- swift · Blank cover (control, again): longest stall 49 ms
- swift · Routine (open): longest stall 324 ms
- shared · Blank cover (control, first): longest stall 277 ms
- shared · Blank cover (control, again): longest stall 80 ms
- shared · Routine (open): longest stall 437 ms
- swift · Blank cover (control, first): longest stall 168 ms
- swift · Blank cover (control, again): longest stall 48 ms
- swift · Routine (open): longest stall 333 ms
- shared · Launch to a usable Today (round 1 , cold): 1056 ms
- swift · Launch to a usable Today (round 1 , cold): 914 ms
- shared · Launch to a usable Today (round 2, warm): 2102 ms
- swift · Launch to a usable Today (round 2, warm): 2163 ms
- shared · Launch to a usable Today (round 3, warm): 1196 ms
- swift · Launch to a usable Today (round 3, warm): 1448 ms
- shared · Launch to a usable Today (round 4, warm): 2910 ms
- swift · Launch to a usable Today (round 4, warm): 1543 ms
- shared · Launch to a usable Today (round 5, warm): 1038 ms
- swift · Launch to a usable Today (round 5, warm): 1107 ms
- shared · Launch to a usable Today (round 6, warm): 1167 ms
- swift · Launch to a usable Today (round 6, warm): 783 ms
- shared · Launch to a usable Today (round 7, warm): 1361 ms
- swift · Launch to a usable Today (round 7, warm): 1770 ms
- shared · Launch to a usable Today (round 8, warm): 814 ms
- swift · Launch to a usable Today (round 8, warm): 1757 ms

Notes (storage and the first fill):

- long stall 963 ms at 1791842413.716; kotlin collection 234: stopped 0.4 ms (after waiting 10.3 ms), then 0.3 ms, took 84.1 ms
- long stall 437 ms at 1791842420.954; kotlin collection 234: stopped 0.4 ms (after waiting 10.3 ms), then 0.3 ms, took 84.1 ms
- long stall 283 ms at 1791842757.859; kotlin collection 81: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 7.9 ms
- long stall 345 ms at 1791842763.509; kotlin collection 82: stopped 0.1 ms (after waiting 0.0 ms), then 0.6 ms, took 8.3 ms
- long stall 327 ms at 1791842798.527; kotlin collection 77: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 1.4 ms
- long stall 311 ms at 1791842840.121; kotlin collection 80: stopped 0.2 ms (after waiting 0.0 ms), then 0.1 ms, took 9.3 ms
- long stall 277 ms at 1791842876.931; kotlin collection 80: stopped 0.1 ms (after waiting 0.0 ms), then 0.2 ms, took 7.8 ms
- long stall 310 ms at 1791842911.215; kotlin collection 79: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 7.9 ms
- long stall 324 ms at 1791842943.523; kotlin collection 78: stopped 0.1 ms (after waiting 0.0 ms), then 0.2 ms, took 9.9 ms
- long stall 277 ms at 1791842981.624; kotlin collection 79: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 12.6 ms
- long stall 437 ms at 1791842987.241; kotlin collection 80: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 15.3 ms
- long stall 333 ms at 1791843020.261; kotlin collection 78: stopped 0.3 ms (after waiting 0.0 ms), then 0.2 ms, took 6.0 ms

Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| shared · scroll-today | Store load: read the database | 2 | 2103 ms | 2053.7 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 217 ms | 216.8 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 162 ms | 36.0 ms |
| shared · scroll-today | Watch Today: plan | 32 | 38 ms | 7.2 ms |
| shared · scroll-today | Shared rules: built from every log, off the main thread | 2 | 18 ms | 17.6 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 16 ms | 3.4 ms |
| shared · scroll-today | Shared rules: built from every log | 1 | 12 ms | 12.3 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 6 ms | 2.7 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 2 ms | 1.8 ms |
| shared · scroll-today | Count: a Today row drawn | 151 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 1944 ms | 1905.6 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 112 ms | 112.3 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 85 ms | 37.1 ms |
| swift · scroll-today | Watch Today: plan | 32 | 20 ms | 7.8 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 5 ms | 2.9 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 2 ms | 2.1 ms |
| swift · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 965 ms | 942.7 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 85 ms | 84.6 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 75 ms | 21.5 ms |
| shared · scroll-today | Watch Today: plan | 32 | 46 ms | 5.3 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 20 ms | 2.2 ms |
| shared · scroll-today | Shared rules: built from every log, off the main thread | 2 | 16 ms | 15.6 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 15 ms | 12.6 ms |
| shared · scroll-today | Shared rules: built from every log | 1 | 9 ms | 9.4 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 1069 ms | 1048.2 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 88 ms | 87.7 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 78 ms | 22.1 ms |
| swift · scroll-today | Watch Today: plan | 32 | 13 ms | 4.0 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.3 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| swift · scroll-today | Count: a Today row drawn | 163 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 1405 ms | 1396.3 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 109 ms | 109.4 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 75 ms | 17.5 ms |
| shared · scroll-today | Shared rules: built from every log, off the main thread | 2 | 42 ms | 41.8 ms |
| shared · scroll-today | Watch Today: plan | 32 | 29 ms | 1.6 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 12 ms | 0.8 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 7 ms | 3.8 ms |
| shared · scroll-today | Shared rules: built from every log | 1 | 3 ms | 3.1 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 1280 ms | 1269.2 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 148 ms | 76.2 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 103 ms | 103.4 ms |
| swift · scroll-today | Watch Today: plan | 32 | 31 ms | 18.5 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 6 ms | 3.7 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| swift · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 1171 ms | 1147.0 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 84 ms | 28.1 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 73 ms | 73.1 ms |
| shared · scroll-today | Watch Today: plan | 32 | 42 ms | 3.5 ms |
| shared · scroll-today | Shared rules: built from every log, off the main thread | 2 | 36 ms | 36.4 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 16 ms | 1.4 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 5 ms | 2.9 ms |
| shared · scroll-today | Shared rules: built from every log | 1 | 4 ms | 3.7 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| shared · scroll-today | Count: a Today row drawn | 101 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 781 ms | 765.1 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 124 ms | 123.5 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 112 ms | 43.0 ms |
| swift · scroll-today | Watch Today: plan | 32 | 28 ms | 16.6 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 10 ms | 7.3 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 2 ms | 1.7 ms |
| swift · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 118 ms | 103.9 ms |
| shared · routine | Widgets: one habit's week | 8 | 34 ms | 20.2 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 26 ms | 25.5 ms |
| shared · routine | Watch Today: plan | 17 | 11 ms | 1.4 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 4 ms | 4.0 ms |
| shared · routine | Shared rules: built from every log, off the main thread | 2 | 3 ms | 3.3 ms |
| shared · routine | Shared rules: built from every log | 1 | 3 ms | 3.4 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 3 ms | 0.7 ms |
| shared · routine | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a Today row drawn | 8 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 331 ms | 312.4 ms |
| swift · routine | Widgets: one habit's week | 16 | 31 ms | 16.6 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 25 ms | 24.7 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 7 ms | 1.5 ms |
| swift · routine | Watch Today: plan | 17 | 5 ms | 1.1 ms |
| swift · routine | Widgets: the snapshot | 3 | 1 ms | 0.5 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| swift · routine | Count: a Today row drawn | 52 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 324 ms | 306.1 ms |
| shared · routine | Widgets: one habit's week | 16 | 86 ms | 35.8 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 21 ms | 20.6 ms |
| shared · routine | Watch Today: plan | 17 | 11 ms | 1.2 ms |
| shared · routine | Watch Day details: the dial's words | 61 | 10 ms | 1.9 ms |
| shared · routine | Shared rules: built from every log, off the main thread | 2 | 6 ms | 5.8 ms |
| shared · routine | Shared rules: built from every log | 1 | 5 ms | 5.0 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 4 ms | 0.6 ms |
| shared · routine | Widgets: the snapshot | 3 | 2 ms | 1.2 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a Today row drawn | 51 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 419 ms | 409.4 ms |
| swift · routine | Widgets: one habit's week | 16 | 52 ms | 24.6 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 30 ms | 30.2 ms |
| swift · routine | Watch Today: plan | 17 | 3 ms | 0.6 ms |
| swift · routine | Watch Day details: the dial's words | 2 | 2 ms | 2.0 ms |
| swift · routine | Widgets: the snapshot | 3 | 2 ms | 0.8 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · routine | Count: a Today row drawn | 22 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 267 ms | 256.9 ms |
| shared · routine | Widgets: one habit's week | 8 | 37 ms | 24.6 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 17 ms | 17.1 ms |
| shared · routine | Shared rules: built from every log, off the main thread | 2 | 8 ms | 8.1 ms |
| shared · routine | Watch Today: plan | 17 | 8 ms | 0.8 ms |
| shared · routine | Shared rules: built from every log | 1 | 3 ms | 3.5 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 2 ms | 0.3 ms |
| shared · routine | Widgets: the snapshot | 2 | 2 ms | 0.8 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 2 ms | 1.4 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 22 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 133 ms | 121.4 ms |
| swift · routine | Widgets: one habit's week | 8 | 35 ms | 27.4 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 15 ms | 15.1 ms |
| swift · routine | Watch Day details: the dial's words | 2 | 6 ms | 6.2 ms |
| swift · routine | Watch Today: plan | 17 | 4 ms | 0.9 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| swift · routine | Count: a Today row drawn | 8 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 242 ms | 226.2 ms |
| shared · routine | Widgets: one habit's week | 16 | 40 ms | 20.3 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 17 ms | 16.5 ms |
| shared · routine | Watch Today: plan | 17 | 14 ms | 3.8 ms |
| shared · routine | Shared rules: built from every log | 1 | 5 ms | 4.7 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 4 ms | 3.6 ms |
| shared · routine | Shared rules: built from every log, off the main thread | 2 | 3 ms | 2.6 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 3 ms | 2.6 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 2 ms | 0.3 ms |
| shared · routine | Widgets: the snapshot | 3 | 2 ms | 1.0 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a Today row drawn | 36 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 168 ms | 154.2 ms |
| swift · routine | Widgets: one habit's week | 8 | 44 ms | 27.1 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 24 ms | 24.4 ms |
| swift · routine | Watch Day details: the dial's words | 16 | 8 ms | 6.0 ms |
| swift · routine | Watch Today: plan | 16 | 3 ms | 0.6 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · routine | Count: a Today row drawn | 10 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 19 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 28 ms | 15.6 ms |
| shared · launch | Store load: read the database | 1 | 22 ms | 21.8 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 1.1 ms |
| shared · launch | Shared rules: built from every log | 1 | 4 ms | 3.7 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.7 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.2 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 30 ms | 15.4 ms |
| swift · launch | Store load: read the database | 1 | 7 ms | 6.9 ms |
| swift · launch | Widgets: the snapshot | 2 | 2 ms | 1.4 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.6 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 33 ms | 18.1 ms |
| shared · launch | Store load: read the database | 1 | 29 ms | 29.0 ms |
| shared · launch | Watch Today: plan | 9 | 8 ms | 1.8 ms |
| shared · launch | Shared rules: built from every log | 1 | 4 ms | 4.0 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.9 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.2 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 1 ms | 1.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 32 ms | 19.4 ms |
| swift · launch | Store load: read the database | 1 | 22 ms | 21.6 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 29 ms | 16.8 ms |
| shared · launch | Store load: read the database | 1 | 24 ms | 24.0 ms |
| shared · launch | Watch Today: plan | 9 | 6 ms | 1.0 ms |
| shared · launch | Shared rules: built from every log | 1 | 3 ms | 3.4 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.5 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 37 ms | 23.2 ms |
| swift · launch | Store load: read the database | 1 | 9 ms | 9.3 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 1.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 36 ms | 25.4 ms |
| shared · launch | Store load: read the database | 1 | 17 ms | 17.2 ms |
| shared · launch | Watch Today: plan | 9 | 10 ms | 3.2 ms |
| shared · launch | Widgets: the snapshot | 2 | 8 ms | 6.3 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 4 ms | 1.1 ms |
| shared · launch | Shared rules: built from every log | 1 | 3 ms | 3.3 ms |
| shared · launch | Shared rules: a log added | 8 | 1 ms | 0.2 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 44 ms | 27.5 ms |
| swift · launch | Store load: read the database | 1 | 33 ms | 33.1 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.8 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.9 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 1.0 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 29 ms | 15.2 ms |
| shared · launch | Store load: read the database | 1 | 23 ms | 23.2 ms |
| shared · launch | Watch Today: plan | 9 | 7 ms | 1.8 ms |
| shared · launch | Shared rules: built from every log | 1 | 6 ms | 6.2 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.5 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.9 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 5 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 44 ms | 28.8 ms |
| swift · launch | Store load: read the database | 1 | 13 ms | 12.9 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 37 ms | 20.5 ms |
| shared · launch | Store load: read the database | 1 | 31 ms | 31.5 ms |
| shared · launch | Shared rules: built from every log | 1 | 6 ms | 5.9 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 0.8 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.3 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 7 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 17 ms | 9.0 ms |
| swift · launch | Store load: read the database | 1 | 7 ms | 6.6 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 4 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 43 ms | 27.2 ms |
| shared · launch | Store load: read the database | 1 | 17 ms | 17.1 ms |
| shared · launch | Watch Today: plan | 9 | 7 ms | 1.8 ms |
| shared · launch | Shared rules: built from every log | 1 | 6 ms | 6.2 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.8 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.2 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.2 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 41 ms | 27.1 ms |
| swift · launch | Store load: read the database | 1 | 9 ms | 8.8 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 32 ms | 19.6 ms |
| shared · launch | Store load: read the database | 1 | 8 ms | 8.0 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 0.8 ms |
| shared · launch | Shared rules: built from every log | 1 | 3 ms | 3.0 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.0 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 8 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 20 ms | 12.2 ms |
| swift · launch | Store load: read the database | 1 | 11 ms | 10.6 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |

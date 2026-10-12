| Variant · What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms |
|---|---|---|---|
| shared · Today: +1 (tap to filled button) | 4.8 | 42 ms | 0 |
| shared · Today: ✓ and Undo | 2.5 | 27 ms | 0 |
| swift · Today: +1 (tap to filled button) | 2.1 | 36 ms | 0 |
| swift · Today: ✓ and Undo | 4.9 | 47 ms | 0 |
| shared · Today: +1 (tap to filled button) | 13.7 | 145 ms | 1 |
| shared · Today: ✓ and Undo | 2.1 | 25 ms | 0 |
| swift · Today: +1 (tap to filled button) | 4.5 | 59 ms | 0 |
| swift · Today: ✓ and Undo | 0.6 | 24 ms | 0 |
| shared · Today: +1 (tap to filled button) | 2.4 | 46 ms | 0 |
| shared · Today: ✓ and Undo | 0.2 | 19 ms | 0 |
| swift · Today: +1 (tap to filled button) | 0.0 | 0 ms | 0 |
| swift · Today: ✓ and Undo | 0.0 | 0 ms | 0 |
| shared · Today: +1 (tap to filled button) | 0.9 | 27 ms | 0 |
| shared · Today: ✓ and Undo | 0.0 | 0 ms | 0 |
| swift · Today: +1 (tap to filled button) | 1.6 | 27 ms | 0 |
| swift · Today: ✓ and Undo | 0.0 | 0 ms | 0 |
| shared · Log manually: turning the Crown | 0.5 | 20 ms | 0 |
| swift · Log manually: turning the Crown | 0.6 | 23 ms | 0 |
| shared · Log manually: turning the Crown | 0.0 | 0 ms | 0 |
| swift · Log manually: turning the Crown | 0.0 | 0 ms | 0 |
| shared · Log manually: turning the Crown | 0.0 | 0 ms | 0 |
| swift · Log manually: turning the Crown | 0.8 | 20 ms | 0 |
| shared · Log manually: turning the Crown | 0.4 | 19 ms | 0 |
| swift · Log manually: turning the Crown | 1.4 | 24 ms | 0 |
| shared · Day details: +1 | 33.3 | 61 ms | 0 |
| swift · Day details: +1 | 30.1 | 65 ms | 0 |
| shared · Day details: +1 | 4.4 | 45 ms | 0 |
| swift · Day details: +1 | 0.3 | 19 ms | 0 |
| shared · Day details: +1 | 60.8 | 71 ms | 0 |
| swift · Day details: +1 | 34.7 | 70 ms | 0 |
| shared · Day details: +1 | 12.3 | 40 ms | 0 |
| swift · Day details: +1 | 1.5 | 21 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- shared · Log manually: longest stall 272 ms
- swift · Log manually: longest stall 204 ms
- shared · Log manually: longest stall 179 ms
- swift · Log manually: longest stall 146 ms
- shared · Log manually: longest stall 158 ms
- swift · Log manually: longest stall 280 ms
- shared · Log manually: longest stall 219 ms
- swift · Log manually: longest stall 253 ms
- shared · Blank page (control, first): longest stall 110 ms
- shared · Blank page (control, again): longest stall 52 ms
- shared · Day details (first): longest stall 78 ms
- shared · Day details (again): longest stall 55 ms
- swift · Blank page (control, first): longest stall 197 ms
- swift · Blank page (control, again): longest stall 64 ms
- swift · Day details (first): longest stall 92 ms
- swift · Day details (again): longest stall 145 ms
- shared · Blank page (control, first): longest stall 94 ms
- shared · Blank page (control, again): longest stall 33 ms
- shared · Day details (first): longest stall 99 ms
- shared · Day details (again): longest stall 55 ms
- swift · Blank page (control, first): longest stall 86 ms
- swift · Blank page (control, again): longest stall 45 ms
- swift · Day details (first): longest stall 198 ms
- swift · Day details (again): longest stall 50 ms
- shared · Blank page (control, first): longest stall 243 ms
- shared · Blank page (control, again): longest stall 59 ms
- shared · Day details (first): longest stall 269 ms
- shared · Day details (again): longest stall 147 ms
- swift · Blank page (control, first): longest stall 125 ms
- swift · Blank page (control, again): longest stall 116 ms
- swift · Day details (first): longest stall 205 ms
- swift · Day details (again): longest stall 184 ms
- shared · Blank page (control, first): longest stall 122 ms
- shared · Blank page (control, again): longest stall 43 ms
- shared · Day details (first): longest stall 83 ms
- shared · Day details (again): longest stall 47 ms
- swift · Blank page (control, first): longest stall 166 ms
- swift · Blank page (control, again): longest stall 70 ms
- swift · Day details (first): longest stall 145 ms
- swift · Day details (again): longest stall 87 ms

Notes (storage and the first fill):

- long stall 272 ms at 1791842497.524; kotlin collection 81: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 1.6 ms
- long stall 280 ms at 1791842631.337; kotlin collection 77: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 18.6 ms
- long stall 253 ms at 1791842689.420; kotlin collection 78: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 19.9 ms
- long stall 269 ms at 1791842899.042; kotlin collection 82: stopped 0.3 ms (after waiting 0.0 ms), then 0.3 ms, took 6.9 ms

Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| shared · tap-today | Store load: read the database | 2 | 541 ms | 403.5 ms |
| shared · tap-today | Widgets: one habit's week | 16 | 96 ms | 61.6 ms |
| shared · tap-today | Watch Today: plan | 69 | 92 ms | 50.0 ms |
| shared · tap-today | Shared rules: built from every log | 1 | 42 ms | 42.1 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 33 ms | 32.5 ms |
| shared · tap-today | Shared rules: habits and settings again | 10 | 24 ms | 19.7 ms |
| shared · tap-today | Shared rules: built from every log, off the main thread | 2 | 20 ms | 19.1 ms |
| shared · tap-today | Shared rules: a log added | 51 | 4 ms | 0.5 ms |
| shared · tap-today | Shared rules: a log removed | 15 | 3 ms | 0.3 ms |
| shared · tap-today | Widgets: the snapshot | 3 | 3 ms | 1.1 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 2 ms | 2.4 ms |
| shared · tap-today | Count: a Today row drawn | 226 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 208 ms | 185.4 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 48 ms | 27.3 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 19 ms | 18.8 ms |
| swift · tap-today | Watch Today: plan | 69 | 15 ms | 1.0 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 1 ms | 0.7 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · tap-today | Count: a Today row drawn | 225 | 0 ms | 0.0 ms |
| shared · tap-today | Store load: read the database | 2 | 434 ms | 403.3 ms |
| shared · tap-today | Widgets: one habit's week | 16 | 72 ms | 26.0 ms |
| shared · tap-today | Watch Today: plan | 69 | 32 ms | 1.9 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 31 ms | 31.2 ms |
| shared · tap-today | Shared rules: built from every log | 1 | 12 ms | 11.7 ms |
| shared · tap-today | Shared rules: built from every log, off the main thread | 2 | 11 ms | 10.7 ms |
| shared · tap-today | Shared rules: habits and settings again | 10 | 5 ms | 0.9 ms |
| shared · tap-today | Shared rules: a log removed | 15 | 4 ms | 1.3 ms |
| shared · tap-today | Shared rules: a log added | 51 | 4 ms | 0.2 ms |
| shared · tap-today | Widgets: the snapshot | 3 | 3 ms | 1.3 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| shared · tap-today | Count: a Today row drawn | 150 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 652 ms | 639.1 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 60 ms | 33.4 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 44 ms | 44.4 ms |
| swift · tap-today | Watch Today: plan | 68 | 13 ms | 0.6 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 2 ms | 1.2 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| swift · tap-today | Count: a Today row drawn | 50 | 0 ms | 0.0 ms |
| shared · tap-today | Store load: read the database | 2 | 211 ms | 187.3 ms |
| shared · tap-today | Widgets: one habit's week | 8 | 51 ms | 30.9 ms |
| shared · tap-today | Watch Today: plan | 69 | 26 ms | 3.7 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 20 ms | 20.3 ms |
| shared · tap-today | Shared rules: built from every log | 1 | 9 ms | 9.2 ms |
| shared · tap-today | Shared rules: built from every log, off the main thread | 2 | 6 ms | 5.9 ms |
| shared · tap-today | Shared rules: habits and settings again | 10 | 5 ms | 1.4 ms |
| shared · tap-today | Shared rules: a log added | 51 | 3 ms | 0.2 ms |
| shared · tap-today | Shared rules: a log removed | 15 | 3 ms | 0.4 ms |
| shared · tap-today | Widgets: the snapshot | 2 | 2 ms | 1.2 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| shared · tap-today | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 164 ms | 146.4 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 38 ms | 22.3 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 17 ms | 17.1 ms |
| swift · tap-today | Watch Today: plan | 69 | 12 ms | 0.9 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 2 ms | 2.1 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 1 ms | 0.8 ms |
| swift · tap-today | Count: a Today row drawn | 49 | 0 ms | 0.0 ms |
| shared · tap-today | Store load: read the database | 2 | 142 ms | 130.6 ms |
| shared · tap-today | Watch Today: plan | 70 | 33 ms | 9.8 ms |
| shared · tap-today | Widgets: one habit's week | 8 | 28 ms | 16.1 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 20 ms | 20.4 ms |
| shared · tap-today | Shared rules: habits and settings again | 10 | 4 ms | 0.8 ms |
| shared · tap-today | Shared rules: built from every log, off the main thread | 2 | 3 ms | 3.0 ms |
| shared · tap-today | Shared rules: a log added | 52 | 3 ms | 0.2 ms |
| shared · tap-today | Shared rules: built from every log | 1 | 3 ms | 2.9 ms |
| shared · tap-today | Shared rules: a log removed | 15 | 3 ms | 0.4 ms |
| shared · tap-today | Widgets: the snapshot | 2 | 2 ms | 1.3 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · tap-today | Count: a Today row drawn | 49 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 471 ms | 446.8 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 31 ms | 15.7 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 28 ms | 28.2 ms |
| swift · tap-today | Watch Today: plan | 69 | 13 ms | 1.0 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 1 ms | 0.4 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| swift · tap-today | Count: a Today row drawn | 124 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 113 ms | 95.0 ms |
| shared · crown | Widgets: one habit's week | 8 | 38 ms | 13.7 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 15 ms | 15.3 ms |
| shared · crown | Watch Today: plan | 13 | 10 ms | 3.9 ms |
| shared · crown | Shared rules: built from every log | 1 | 7 ms | 7.0 ms |
| shared · crown | Shared rules: habits and settings again | 10 | 4 ms | 1.4 ms |
| shared · crown | Shared rules: built from every log, off the main thread | 2 | 3 ms | 2.4 ms |
| shared · crown | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 1 ms | 1.0 ms |
| shared · crown | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: today's logs | 1 | 0 ms | 0.0 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Count: a Today row drawn | 8 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 86 ms | 71.1 ms |
| swift · crown | Widgets: one habit's week | 8 | 20 ms | 12.4 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 14 ms | 14.3 ms |
| swift · crown | Watch Today: plan | 13 | 3 ms | 0.9 ms |
| swift · crown | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.2 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.2 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| swift · crown | Count: a Today row drawn | 19 | 0 ms | 0.0 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 132 ms | 100.9 ms |
| shared · crown | Widgets: one habit's week | 8 | 24 ms | 16.6 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 16 ms | 16.3 ms |
| shared · crown | Watch Today: plan | 13 | 6 ms | 1.1 ms |
| shared · crown | Shared rules: built from every log | 1 | 3 ms | 2.8 ms |
| shared · crown | Shared rules: built from every log, off the main thread | 2 | 3 ms | 2.6 ms |
| shared · crown | Shared rules: habits and settings again | 10 | 2 ms | 0.3 ms |
| shared · crown | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.4 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · crown | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: today's logs | 1 | 0 ms | 0.1 ms |
| shared · crown | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 95 ms | 89.0 ms |
| swift · crown | Widgets: one habit's week | 8 | 24 ms | 14.8 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 17 ms | 16.7 ms |
| swift · crown | Watch Today: plan | 13 | 3 ms | 1.0 ms |
| swift · crown | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.1 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.0 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.0 ms |
| swift · crown | Count: a Today row drawn | 8 | 0 ms | 0.0 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 185 ms | 167.2 ms |
| shared · crown | Widgets: one habit's week | 8 | 20 ms | 12.2 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 16 ms | 15.8 ms |
| shared · crown | Shared rules: built from every log, off the main thread | 2 | 9 ms | 8.4 ms |
| shared · crown | Watch Today: plan | 13 | 6 ms | 0.8 ms |
| shared · crown | Shared rules: built from every log | 1 | 3 ms | 2.7 ms |
| shared · crown | Shared rules: habits and settings again | 10 | 2 ms | 0.3 ms |
| shared · crown | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · crown | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: today's logs | 1 | 0 ms | 0.0 ms |
| shared · crown | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 206 ms | 196.7 ms |
| swift · crown | Widgets: one habit's week | 16 | 23 ms | 11.6 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 16 ms | 15.6 ms |
| swift · crown | Watch Today: plan | 13 | 4 ms | 1.9 ms |
| swift · crown | Widgets: the snapshot | 3 | 1 ms | 0.5 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.2 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.2 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| swift · crown | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 107 ms | 90.3 ms |
| shared · crown | Widgets: one habit's week | 8 | 36 ms | 18.0 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 15 ms | 15.1 ms |
| shared · crown | Watch Today: plan | 13 | 8 ms | 1.1 ms |
| shared · crown | Shared rules: built from every log | 1 | 5 ms | 5.2 ms |
| shared · crown | Shared rules: habits and settings again | 10 | 3 ms | 0.5 ms |
| shared · crown | Shared rules: built from every log, off the main thread | 2 | 3 ms | 3.0 ms |
| shared · crown | Widgets: the snapshot | 2 | 2 ms | 1.2 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.2 ms |
| shared · crown | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: today's logs | 1 | 0 ms | 0.2 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Count: a Today row drawn | 8 | 0 ms | 0.0 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 334 ms | 325.6 ms |
| swift · crown | Widgets: one habit's week | 16 | 39 ms | 17.9 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 27 ms | 26.9 ms |
| swift · crown | Watch Today: plan | 12 | 2 ms | 0.5 ms |
| swift · crown | Widgets: the snapshot | 3 | 2 ms | 0.8 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.2 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.1 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| swift · crown | Count: a Today row drawn | 29 | 0 ms | 0.0 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 261 ms | 240.2 ms |
| shared · day-details | Widgets: one habit's week | 16 | 55 ms | 29.5 ms |
| shared · day-details | Watch Today: plan | 48 | 21 ms | 2.2 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 15 ms | 15.4 ms |
| shared · day-details | Shared rules: built from every log, off the main thread | 2 | 8 ms | 7.4 ms |
| shared · day-details | Watch Day details: the dial's words | 60 | 4 ms | 0.2 ms |
| shared · day-details | Shared rules: built from every log | 1 | 3 ms | 3.5 ms |
| shared · day-details | Watch Day details: streak | 60 | 3 ms | 0.1 ms |
| shared · day-details | Shared rules: habits and settings again | 10 | 3 ms | 0.6 ms |
| shared · day-details | Shared rules: a log added | 37 | 2 ms | 0.2 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| shared · day-details | Widgets: the snapshot | 3 | 2 ms | 0.7 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · day-details | Count: a Today row drawn | 184 | 0 ms | 0.0 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 341 ms | 317.1 ms |
| swift · day-details | Widgets: one habit's week | 16 | 38 ms | 22.3 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 18 ms | 18.2 ms |
| swift · day-details | Watch Today: plan | 48 | 10 ms | 0.9 ms |
| swift · day-details | Watch Day details: the dial's words | 60 | 4 ms | 0.3 ms |
| swift · day-details | Watch Day details: streak | 60 | 3 ms | 0.1 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.5 ms |
| swift · day-details | Widgets: the snapshot | 3 | 1 ms | 0.5 ms |
| swift · day-details | Count: a Today row drawn | 205 | 1 ms | 0.7 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 151 ms | 131.5 ms |
| shared · day-details | Widgets: one habit's week | 16 | 30 ms | 12.8 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 25 ms | 25.4 ms |
| shared · day-details | Watch Today: plan | 47 | 20 ms | 1.7 ms |
| shared · day-details | Shared rules: built from every log | 1 | 5 ms | 4.7 ms |
| shared · day-details | Shared rules: habits and settings again | 10 | 4 ms | 0.7 ms |
| shared · day-details | Shared rules: built from every log, off the main thread | 2 | 3 ms | 2.7 ms |
| shared · day-details | Shared rules: a log added | 37 | 2 ms | 0.2 ms |
| shared · day-details | Watch Day details: the dial's words | 31 | 2 ms | 0.3 ms |
| shared · day-details | Widgets: the snapshot | 3 | 2 ms | 0.8 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| shared · day-details | Watch Day details: streak | 31 | 1 ms | 0.2 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · day-details | Count: a Today row drawn | 50 | 0 ms | 0.0 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 195 ms | 176.1 ms |
| swift · day-details | Widgets: one habit's week | 16 | 33 ms | 13.3 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 16 ms | 16.1 ms |
| swift · day-details | Watch Today: plan | 48 | 10 ms | 0.7 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.2 ms |
| swift · day-details | Watch Day details: the dial's words | 34 | 2 ms | 0.2 ms |
| swift · day-details | Widgets: the snapshot | 3 | 1 ms | 0.7 ms |
| swift · day-details | Watch Day details: streak | 35 | 1 ms | 0.1 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · day-details | Count: a Today row drawn | 53 | 0 ms | 0.0 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 799 ms | 748.9 ms |
| shared · day-details | Widgets: one habit's week | 16 | 44 ms | 18.2 ms |
| shared · day-details | Watch Today: plan | 48 | 39 ms | 9.6 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 35 ms | 35.2 ms |
| shared · day-details | Watch Day details: the dial's words | 60 | 7 ms | 0.9 ms |
| shared · day-details | Shared rules: built from every log, off the main thread | 2 | 6 ms | 5.2 ms |
| shared · day-details | Shared rules: built from every log | 1 | 5 ms | 5.5 ms |
| shared · day-details | Watch Day details: streak | 60 | 4 ms | 0.3 ms |
| shared · day-details | Shared rules: habits and settings again | 10 | 3 ms | 0.7 ms |
| shared · day-details | Shared rules: a log added | 37 | 3 ms | 0.4 ms |
| shared · day-details | Widgets: the snapshot | 3 | 2 ms | 1.1 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| shared · day-details | Count: a Today row drawn | 197 | 0 ms | 0.4 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.1 ms |
| swift · day-details | Store load: read the database | 2 | 392 ms | 370.1 ms |
| swift · day-details | Widgets: one habit's week | 16 | 29 ms | 13.7 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 18 ms | 18.4 ms |
| swift · day-details | Watch Today: plan | 48 | 9 ms | 0.4 ms |
| swift · day-details | Watch Day details: the dial's words | 60 | 3 ms | 0.2 ms |
| swift · day-details | Watch Day details: streak | 60 | 3 ms | 0.1 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.3 ms |
| swift · day-details | Widgets: the snapshot | 3 | 1 ms | 0.4 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| swift · day-details | Count: a Today row drawn | 196 | 0 ms | 0.0 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 297 ms | 283.8 ms |
| shared · day-details | Widgets: one habit's week | 16 | 34 ms | 16.4 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 20 ms | 20.3 ms |
| shared · day-details | Watch Today: plan | 48 | 20 ms | 1.2 ms |
| shared · day-details | Shared rules: built from every log | 1 | 5 ms | 5.2 ms |
| shared · day-details | Shared rules: built from every log, off the main thread | 2 | 3 ms | 3.0 ms |
| shared · day-details | Shared rules: habits and settings again | 10 | 3 ms | 0.6 ms |
| shared · day-details | Shared rules: a log added | 37 | 3 ms | 0.2 ms |
| shared · day-details | Watch Day details: the dial's words | 40 | 3 ms | 0.2 ms |
| shared · day-details | Watch Day details: streak | 40 | 2 ms | 0.2 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| shared · day-details | Widgets: the snapshot | 3 | 1 ms | 0.5 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| shared · day-details | Count: a Today row drawn | 37 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 124 ms | 109.9 ms |
| swift · day-details | Widgets: one habit's week | 8 | 25 ms | 15.2 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 22 ms | 21.7 ms |
| swift · day-details | Watch Today: plan | 48 | 9 ms | 1.2 ms |
| swift · day-details | Widgets: the snapshot | 2 | 2 ms | 0.8 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| swift · day-details | Watch Day details: the dial's words | 31 | 1 ms | 0.2 ms |
| swift · day-details | Watch Day details: streak | 31 | 1 ms | 0.2 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| swift · day-details | Count: a Today row drawn | 49 | 0 ms | 0.0 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |

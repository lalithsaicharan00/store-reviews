# Watch: claude/shared-habit-rules-wperf8 @ 2cdef5a

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38282630442 · 2026-10-12 18:15 UTC
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
| shared · Today: +1 (tap to filled button) | 7.8 | 59 ms | 0 |
| shared · Today: ✓ and Undo | 13.8 | 88 ms | 0 |
| swift · Today: +1 (tap to filled button) | 1.4 | 29 ms | 0 |
| swift · Today: ✓ and Undo | 4.7 | 37 ms | 0 |
| shared · Today: +1 (tap to filled button) | 3.1 | 29 ms | 0 |
| shared · Today: ✓ and Undo | 3.9 | 32 ms | 0 |
| swift · Today: +1 (tap to filled button) | 6.7 | 66 ms | 0 |
| swift · Today: ✓ and Undo | 7.8 | 74 ms | 0 |
| shared · Today: +1 (tap to filled button) | 1.7 | 25 ms | 0 |
| shared · Today: ✓ and Undo | 5.2 | 35 ms | 0 |
| swift · Today: +1 (tap to filled button) | 12.9 | 53 ms | 0 |
| swift · Today: ✓ and Undo | 1.9 | 26 ms | 0 |
| shared · Today: +1 (tap to filled button) | 3.0 | 38 ms | 0 |
| shared · Today: ✓ and Undo | 1.9 | 26 ms | 0 |
| swift · Today: +1 (tap to filled button) | 6.8 | 47 ms | 0 |
| swift · Today: ✓ and Undo | 2.2 | 31 ms | 0 |
| shared · Log manually: turning the Crown | 0.2 | 19 ms | 0 |
| swift · Log manually: turning the Crown | 0.9 | 22 ms | 0 |
| shared · Log manually: turning the Crown | 7.1 | 34 ms | 0 |
| swift · Log manually: turning the Crown | 3.5 | 23 ms | 0 |
| shared · Log manually: turning the Crown | 0.0 | 0 ms | 0 |
| swift · Log manually: turning the Crown | 5.6 | 28 ms | 0 |
| shared · Log manually: turning the Crown | 1.9 | 22 ms | 0 |
| swift · Log manually: turning the Crown | 2.1 | 23 ms | 0 |
| shared · Day details: +1 | 38.9 | 88 ms | 0 |
| swift · Day details: +1 | 8.2 | 37 ms | 0 |
| shared · Day details: +1 | 38.9 | 113 ms | 1 |
| swift · Day details: +1 | 38.9 | 70 ms | 0 |
| shared · Day details: +1 | 22.0 | 60 ms | 0 |
| swift · Day details: +1 | 18.0 | 46 ms | 0 |
| shared · Day details: +1 | 38.9 | 90 ms | 0 |
| swift · Day details: +1 | 2.8 | 28 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- shared · Log manually: longest stall 495 ms
- swift · Log manually: longest stall 174 ms
- shared · Log manually: longest stall 263 ms
- swift · Log manually: longest stall 346 ms
- shared · Log manually: longest stall 209 ms
- swift · Log manually: longest stall 387 ms
- shared · Log manually: longest stall 262 ms
- swift · Log manually: longest stall 310 ms
- shared · Blank page (control, first): longest stall 179 ms
- shared · Blank page (control, again): longest stall 70 ms
- shared · Day details (first): longest stall 246 ms
- shared · Day details (again): longest stall 67 ms
- swift · Blank page (control, first): longest stall 124 ms
- swift · Blank page (control, again): longest stall 65 ms
- swift · Day details (first): longest stall 205 ms
- swift · Day details (again): longest stall 100 ms
- shared · Blank page (control, first): longest stall 155 ms
- shared · Blank page (control, again): longest stall 71 ms
- shared · Day details (first): longest stall 220 ms
- shared · Day details (again): longest stall 146 ms
- swift · Blank page (control, first): longest stall 109 ms
- swift · Blank page (control, again): longest stall 51 ms
- swift · Day details (first): longest stall 136 ms
- swift · Day details (again): longest stall 88 ms
- shared · Blank page (control, first): longest stall 109 ms
- shared · Blank page (control, again): longest stall 34 ms
- shared · Day details (first): longest stall 175 ms
- shared · Day details (again): longest stall 179 ms
- swift · Blank page (control, first): longest stall 208 ms
- swift · Blank page (control, again): longest stall 52 ms
- swift · Day details (first): longest stall 221 ms
- swift · Day details (again): longest stall 90 ms
- shared · Blank page (control, first): longest stall 209 ms
- shared · Blank page (control, again): longest stall 90 ms
- shared · Day details (first): longest stall 232 ms
- shared · Day details (again): longest stall 175 ms
- swift · Blank page (control, first): longest stall 154 ms
- swift · Blank page (control, again): longest stall 75 ms
- swift · Day details (first): longest stall 133 ms
- swift · Day details (again): longest stall 60 ms

Notes (storage and the first fill):


Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| shared · tap-today | Store load: read the database | 2 | 548 ms | 373.0 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 108 ms | 108.3 ms |
| shared · tap-today | Widgets: one habit's week | 16 | 94 ms | 50.6 ms |
| shared · tap-today | Watch Today: plan | 69 | 57 ms | 10.7 ms |
| shared · tap-today | Shared rules: built from every log | 3 | 26 ms | 18.0 ms |
| shared · tap-today | Shared rules: a log added | 51 | 8 ms | 4.8 ms |
| shared · tap-today | Shared rules: a log removed | 15 | 6 ms | 2.8 ms |
| shared · tap-today | Shared rules: habits and settings again | 10 | 5 ms | 2.0 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 3 ms | 2.6 ms |
| shared · tap-today | Widgets: the snapshot | 3 | 2 ms | 1.0 ms |
| shared · tap-today | Count: a Today row drawn | 227 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 407 ms | 394.4 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 66 ms | 30.7 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 34 ms | 33.5 ms |
| swift · tap-today | Watch Today: plan | 58 | 13 ms | 1.4 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 2 ms | 1.0 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · tap-today | Count: a Today row drawn | 183 | 0 ms | 0.0 ms |
| shared · tap-today | Store load: read the database | 2 | 635 ms | 614.8 ms |
| shared · tap-today | Widgets: one habit's week | 16 | 76 ms | 36.3 ms |
| shared · tap-today | Watch Today: plan | 69 | 58 ms | 11.5 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 26 ms | 25.6 ms |
| shared · tap-today | Shared rules: built from every log | 3 | 16 ms | 9.0 ms |
| shared · tap-today | Shared rules: habits and settings again | 10 | 4 ms | 0.9 ms |
| shared · tap-today | Shared rules: a log added | 51 | 3 ms | 0.2 ms |
| shared · tap-today | Shared rules: a log removed | 15 | 3 ms | 0.6 ms |
| shared · tap-today | Widgets: the snapshot | 3 | 2 ms | 0.8 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · tap-today | Count: a Today row drawn | 226 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 449 ms | 440.9 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 147 ms | 92.1 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 53 ms | 53.3 ms |
| swift · tap-today | Watch Today: plan | 69 | 22 ms | 3.6 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 2 ms | 1.3 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · tap-today | Count: a Today row drawn | 225 | 0 ms | 0.0 ms |
| shared · tap-today | Store load: read the database | 2 | 598 ms | 577.4 ms |
| shared · tap-today | Widgets: one habit's week | 16 | 55 ms | 19.7 ms |
| shared · tap-today | Watch Today: plan | 68 | 53 ms | 11.4 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 18 ms | 17.6 ms |
| shared · tap-today | Shared rules: built from every log | 3 | 12 ms | 7.0 ms |
| shared · tap-today | Shared rules: a log added | 51 | 4 ms | 0.3 ms |
| shared · tap-today | Shared rules: habits and settings again | 10 | 4 ms | 0.7 ms |
| shared · tap-today | Shared rules: a log removed | 15 | 3 ms | 0.4 ms |
| shared · tap-today | Widgets: the snapshot | 3 | 2 ms | 1.3 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · tap-today | Count: a Today row drawn | 224 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 294 ms | 283.6 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 37 ms | 20.3 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 28 ms | 28.4 ms |
| swift · tap-today | Watch Today: plan | 68 | 16 ms | 0.6 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 2 ms | 1.4 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · tap-today | Count: a Today row drawn | 225 | 0 ms | 0.0 ms |
| shared · tap-today | Store load: read the database | 2 | 271 ms | 252.7 ms |
| shared · tap-today | Widgets: one habit's week | 8 | 47 ms | 25.6 ms |
| shared · tap-today | Watch Today: plan | 69 | 39 ms | 2.9 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 24 ms | 24.0 ms |
| shared · tap-today | Shared rules: built from every log | 3 | 15 ms | 7.9 ms |
| shared · tap-today | Shared rules: a log added | 51 | 6 ms | 1.0 ms |
| shared · tap-today | Shared rules: a log removed | 15 | 5 ms | 2.3 ms |
| shared · tap-today | Shared rules: habits and settings again | 10 | 3 ms | 0.8 ms |
| shared · tap-today | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · tap-today | Count: a Today row drawn | 52 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 405 ms | 386.6 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 55 ms | 31.4 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 27 ms | 27.1 ms |
| swift · tap-today | Watch Today: plan | 69 | 14 ms | 1.1 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 3 ms | 1.1 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · tap-today | Count: a Today row drawn | 188 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 99 ms | 81.9 ms |
| shared · crown | Widgets: one habit's week | 8 | 42 ms | 28.6 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 17 ms | 16.6 ms |
| shared · crown | Watch Today: plan | 13 | 12 ms | 4.0 ms |
| shared · crown | Shared rules: built from every log | 3 | 10 ms | 5.5 ms |
| shared · crown | Shared rules: habits and settings again | 10 | 3 ms | 0.8 ms |
| shared · crown | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| shared · crown | Shared rules: a log added | 8 | 1 ms | 0.4 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.5 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: today's logs | 1 | 0 ms | 0.1 ms |
| shared · crown | Count: a Today row drawn | 19 | 0 ms | 0.0 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 314 ms | 301.7 ms |
| swift · crown | Widgets: one habit's week | 8 | 35 ms | 25.9 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 23 ms | 22.9 ms |
| swift · crown | Watch Today: plan | 13 | 2 ms | 0.4 ms |
| swift · crown | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.2 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.0 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.0 ms |
| swift · crown | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 240 ms | 227.3 ms |
| shared · crown | Widgets: one habit's week | 16 | 49 ms | 14.6 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 16 ms | 15.8 ms |
| shared · crown | Watch Today: plan | 13 | 12 ms | 4.3 ms |
| shared · crown | Shared rules: built from every log | 3 | 9 ms | 4.6 ms |
| shared · crown | Shared rules: habits and settings again | 10 | 3 ms | 0.5 ms |
| shared · crown | Widgets: the snapshot | 3 | 2 ms | 1.0 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.3 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · crown | Watch Day details: today's logs | 1 | 0 ms | 0.3 ms |
| shared · crown | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.2 ms |
| shared · crown | Count: a Today row drawn | 19 | 0 ms | 0.0 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 323 ms | 312.7 ms |
| swift · crown | Widgets: one habit's week | 16 | 42 ms | 15.8 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 17 ms | 16.5 ms |
| swift · crown | Watch Today: plan | 13 | 3 ms | 0.9 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 1 ms | 1.5 ms |
| swift · crown | Widgets: the snapshot | 3 | 1 ms | 0.4 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.2 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.0 ms |
| swift · crown | Count: a Today row drawn | 29 | 0 ms | 0.0 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 231 ms | 213.7 ms |
| shared · crown | Widgets: one habit's week | 16 | 38 ms | 16.1 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 17 ms | 17.4 ms |
| shared · crown | Watch Today: plan | 13 | 13 ms | 4.1 ms |
| shared · crown | Shared rules: built from every log | 3 | 12 ms | 7.3 ms |
| shared · crown | Shared rules: habits and settings again | 10 | 3 ms | 0.6 ms |
| shared · crown | Widgets: the snapshot | 3 | 2 ms | 0.9 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · crown | Watch Day details: today's logs | 1 | 0 ms | 0.2 ms |
| shared · crown | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.1 ms |
| shared · crown | Count: a Today row drawn | 31 | 0 ms | 0.0 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 99 ms | 92.3 ms |
| swift · crown | Widgets: one habit's week | 8 | 23 ms | 13.8 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 18 ms | 18.2 ms |
| swift · crown | Watch Today: plan | 13 | 6 ms | 2.9 ms |
| swift · crown | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.2 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.2 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.1 ms |
| swift · crown | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 294 ms | 250.5 ms |
| shared · crown | Widgets: one habit's week | 16 | 41 ms | 17.4 ms |
| shared · crown | Watch Today: plan | 13 | 34 ms | 18.1 ms |
| shared · crown | Shared rules: built from every log | 3 | 25 ms | 17.6 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 19 ms | 19.0 ms |
| shared · crown | Watch Day details: today's logs | 1 | 3 ms | 3.4 ms |
| shared · crown | Shared rules: habits and settings again | 10 | 3 ms | 0.6 ms |
| shared · crown | Widgets: the snapshot | 3 | 2 ms | 0.8 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.5 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · crown | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Count: a Today row drawn | 23 | 0 ms | 0.0 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 399 ms | 387.5 ms |
| swift · crown | Widgets: one habit's week | 16 | 37 ms | 19.0 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 26 ms | 25.8 ms |
| swift · crown | Watch Today: plan | 13 | 3 ms | 0.8 ms |
| swift · crown | Widgets: the snapshot | 3 | 2 ms | 0.8 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 1 ms | 1.2 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.0 ms |
| swift · crown | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 181 ms | 162.0 ms |
| shared · day-details | Widgets: one habit's week | 16 | 65 ms | 27.5 ms |
| shared · day-details | Watch Today: plan | 48 | 34 ms | 3.7 ms |
| shared · day-details | Shared rules: built from every log | 3 | 20 ms | 10.4 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 18 ms | 18.4 ms |
| shared · day-details | Watch Day details: the dial's words | 50 | 13 ms | 7.3 ms |
| shared · day-details | Shared rules: a log added | 37 | 4 ms | 0.8 ms |
| shared · day-details | Shared rules: habits and settings again | 10 | 3 ms | 0.9 ms |
| shared · day-details | Watch Day details: streak | 37 | 3 ms | 0.3 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 3 ms | 0.5 ms |
| shared · day-details | Widgets: the snapshot | 3 | 2 ms | 1.2 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| shared · day-details | Count: a Today row drawn | 52 | 0 ms | 0.0 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 438 ms | 424.1 ms |
| swift · day-details | Widgets: one habit's week | 16 | 41 ms | 18.4 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 20 ms | 20.1 ms |
| swift · day-details | Watch Today: plan | 48 | 11 ms | 1.2 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 7 ms | 6.8 ms |
| swift · day-details | Watch Day details: streak | 60 | 2 ms | 0.1 ms |
| swift · day-details | Watch Day details: the dial's words | 60 | 2 ms | 0.1 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.2 ms |
| swift · day-details | Widgets: the snapshot | 3 | 1 ms | 0.6 ms |
| swift · day-details | Count: a Today row drawn | 52 | 0 ms | 0.0 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 246 ms | 224.3 ms |
| shared · day-details | Widgets: one habit's week | 16 | 90 ms | 28.4 ms |
| shared · day-details | Watch Today: plan | 48 | 42 ms | 12.6 ms |
| shared · day-details | Shared rules: built from every log | 3 | 19 ms | 11.9 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 19 ms | 18.9 ms |
| shared · day-details | Watch Day details: the dial's words | 38 | 5 ms | 0.5 ms |
| shared · day-details | Shared rules: habits and settings again | 10 | 4 ms | 1.3 ms |
| shared · day-details | Shared rules: a log added | 37 | 3 ms | 0.4 ms |
| shared · day-details | Widgets: the snapshot | 3 | 3 ms | 1.8 ms |
| shared · day-details | Watch Day details: streak | 31 | 2 ms | 0.2 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.2 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · day-details | Count: a Today row drawn | 52 | 0 ms | 0.0 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 343 ms | 322.6 ms |
| swift · day-details | Widgets: one habit's week | 16 | 85 ms | 54.3 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 23 ms | 22.6 ms |
| swift · day-details | Watch Today: plan | 48 | 11 ms | 1.1 ms |
| swift · day-details | Watch Day details: the dial's words | 60 | 4 ms | 0.2 ms |
| swift · day-details | Watch Day details: streak | 60 | 4 ms | 0.9 ms |
| swift · day-details | Widgets: the snapshot | 3 | 3 ms | 0.9 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 2 ms | 2.4 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.3 ms |
| swift · day-details | Count: a Today row drawn | 205 | 0 ms | 0.0 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 241 ms | 206.6 ms |
| shared · day-details | Widgets: one habit's week | 16 | 62 ms | 19.7 ms |
| shared · day-details | Watch Today: plan | 48 | 31 ms | 4.8 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 25 ms | 24.5 ms |
| shared · day-details | Shared rules: built from every log | 3 | 8 ms | 4.0 ms |
| shared · day-details | Watch Day details: the dial's words | 60 | 5 ms | 0.4 ms |
| shared · day-details | Watch Day details: streak | 60 | 3 ms | 0.2 ms |
| shared · day-details | Shared rules: habits and settings again | 10 | 2 ms | 0.5 ms |
| shared · day-details | Shared rules: a log added | 37 | 2 ms | 0.2 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.2 ms |
| shared · day-details | Widgets: the snapshot | 3 | 2 ms | 0.7 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · day-details | Count: a Today row drawn | 193 | 0 ms | 0.0 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 217 ms | 206.7 ms |
| swift · day-details | Widgets: one habit's week | 16 | 28 ms | 12.7 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 25 ms | 25.1 ms |
| swift · day-details | Watch Today: plan | 48 | 9 ms | 1.0 ms |
| swift · day-details | Watch Day details: the dial's words | 60 | 3 ms | 0.2 ms |
| swift · day-details | Watch Day details: streak | 60 | 2 ms | 0.1 ms |
| swift · day-details | Widgets: the snapshot | 3 | 2 ms | 0.8 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.2 ms |
| swift · day-details | Count: a Today row drawn | 198 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 307 ms | 275.2 ms |
| shared · day-details | Widgets: one habit's week | 16 | 56 ms | 26.0 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 35 ms | 35.1 ms |
| shared · day-details | Watch Today: plan | 48 | 33 ms | 4.8 ms |
| shared · day-details | Shared rules: built from every log | 3 | 16 ms | 10.4 ms |
| shared · day-details | Watch Day details: the dial's words | 60 | 5 ms | 0.4 ms |
| shared · day-details | Watch Day details: streak | 60 | 3 ms | 0.2 ms |
| shared · day-details | Shared rules: a log added | 37 | 3 ms | 0.2 ms |
| shared · day-details | Shared rules: habits and settings again | 10 | 3 ms | 0.5 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 3 ms | 0.3 ms |
| shared · day-details | Widgets: the snapshot | 3 | 2 ms | 1.0 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · day-details | Count: a Today row drawn | 188 | 0 ms | 0.0 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 294 ms | 271.8 ms |
| swift · day-details | Widgets: one habit's week | 8 | 53 ms | 31.8 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 30 ms | 30.0 ms |
| swift · day-details | Watch Today: plan | 48 | 12 ms | 2.2 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 3 ms | 2.9 ms |
| swift · day-details | Widgets: the snapshot | 2 | 2 ms | 1.6 ms |
| swift · day-details | Watch Day details: the dial's words | 31 | 2 ms | 0.3 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| swift · day-details | Watch Day details: streak | 31 | 1 ms | 0.1 ms |
| swift · day-details | Count: a Today row drawn | 49 | 0 ms | 0.0 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |

# Watch: claude/shared-habit-rules-wperf10 @ 52dcf19

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38292294179 · 2026-10-12 19:57 UTC
Commit: Watch speed: shared rules against the Swift rules side by side, every strip in one call (scratch, safe to delete) [watch-perf]

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
| shared · Today: +1 (tap to filled button) | 4.8 | 61 ms | 0 |
| shared · Today: ✓ and Undo | 0.7 | 20 ms | 0 |
| swift · Today: +1 (tap to filled button) | 3.2 | 56 ms | 0 |
| swift · Today: ✓ and Undo | 0.4 | 19 ms | 0 |
| shared · Today: +1 (tap to filled button) | 4.2 | 52 ms | 0 |
| shared · Today: ✓ and Undo | 1.9 | 32 ms | 0 |
| swift · Today: +1 (tap to filled button) | 2.1 | 30 ms | 0 |
| swift · Today: ✓ and Undo | 0.5 | 23 ms | 0 |
| shared · Today: +1 (tap to filled button) | 5.7 | 43 ms | 0 |
| shared · Today: ✓ and Undo | 37.1 | 437 ms | 1 |
| swift · Today: +1 (tap to filled button) | 13.4 | 55 ms | 0 |
| swift · Today: ✓ and Undo | 2.3 | 25 ms | 0 |
| shared · Today: +1 (tap to filled button) | 13.3 | 72 ms | 0 |
| shared · Today: ✓ and Undo | 6.0 | 88 ms | 0 |
| swift · Today: +1 (tap to filled button) | 3.5 | 35 ms | 0 |
| swift · Today: ✓ and Undo | 0.7 | 21 ms | 0 |
| shared · Log manually: turning the Crown | 25.5 | 281 ms | 1 |
| swift · Log manually: turning the Crown | 8.7 | 43 ms | 0 |
| shared · Log manually: turning the Crown | 1.9 | 23 ms | 0 |
| swift · Log manually: turning the Crown | 0.0 | 0 ms | 0 |
| shared · Log manually: turning the Crown | 4.0 | 30 ms | 0 |
| swift · Log manually: turning the Crown | 4.5 | 29 ms | 0 |
| shared · Log manually: turning the Crown | 7.2 | 31 ms | 0 |
| swift · Log manually: turning the Crown | 28.4 | 295 ms | 1 |
| shared · Day details: +1 | 28.5 | 60 ms | 0 |
| swift · Day details: +1 | 52.2 | 66 ms | 0 |
| shared · Day details: +1 | 10.7 | 36 ms | 0 |
| swift · Day details: +1 | 14.6 | 49 ms | 0 |
| shared · Day details: +1 | 3.0 | 25 ms | 0 |
| swift · Day details: +1 | 0.6 | 22 ms | 0 |
| shared · Day details: +1 | 13.1 | 43 ms | 0 |
| swift · Day details: +1 | 0.4 | 19 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- shared · Log manually: longest stall 526 ms
- swift · Log manually: longest stall 290 ms
- shared · Log manually: longest stall 330 ms
- swift · Log manually: longest stall 325 ms
- shared · Log manually: longest stall 233 ms
- swift · Log manually: longest stall 432 ms
- shared · Log manually: longest stall 338 ms
- swift · Log manually: longest stall 358 ms
- shared · Blank page (control, first): longest stall 220 ms
- shared · Blank page (control, again): longest stall 35 ms
- shared · Day details (first): longest stall 140 ms
- shared · Day details (again): longest stall 58 ms
- swift · Blank page (control, first): longest stall 132 ms
- swift · Blank page (control, again): longest stall 63 ms
- swift · Day details (first): longest stall 283 ms
- swift · Day details (again): longest stall 87 ms
- shared · Blank page (control, first): longest stall 148 ms
- shared · Blank page (control, again): longest stall 106 ms
- shared · Day details (first): longest stall 264 ms
- shared · Day details (again): longest stall 79 ms
- swift · Blank page (control, first): longest stall 116 ms
- swift · Blank page (control, again): longest stall 66 ms
- swift · Day details (first): longest stall 67 ms
- swift · Day details (again): longest stall 84 ms
- shared · Blank page (control, first): longest stall 84 ms
- shared · Blank page (control, again): longest stall 33 ms
- shared · Day details (first): longest stall 131 ms
- shared · Day details (again): longest stall 58 ms
- swift · Blank page (control, first): longest stall 92 ms
- swift · Blank page (control, again): longest stall 27 ms
- swift · Day details (first): longest stall 72 ms
- swift · Day details (again): longest stall 41 ms
- shared · Blank page (control, first): longest stall 132 ms
- shared · Blank page (control, again): longest stall 38 ms
- shared · Day details (first): longest stall 244 ms
- shared · Day details (again): longest stall 108 ms
- swift · Blank page (control, first): longest stall 133 ms
- swift · Blank page (control, again): longest stall 37 ms
- swift · Day details (first): longest stall 90 ms
- swift · Day details (again): longest stall 59 ms

Notes (storage and the first fill):


Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| shared · tap-today | Store load: read the database | 2 | 779 ms | 421.7 ms |
| shared · tap-today | Widgets: one habit's week | 16 | 69 ms | 34.9 ms |
| shared · tap-today | Watch Today: plan | 69 | 47 ms | 11.6 ms |
| shared · tap-today | Shared rules: built from every log | 3 | 42 ms | 28.5 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 31 ms | 31.4 ms |
| shared · tap-today | Shared rules: habits and settings again | 10 | 6 ms | 2.2 ms |
| shared · tap-today | Shared rules: a log added | 51 | 3 ms | 0.3 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 3 ms | 2.6 ms |
| shared · tap-today | Widgets: the snapshot | 3 | 2 ms | 1.2 ms |
| shared · tap-today | Shared rules: a log removed | 15 | 2 ms | 0.2 ms |
| shared · tap-today | Count: a Today row drawn | 226 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 296 ms | 279.5 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 61 ms | 26.6 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 35 ms | 34.8 ms |
| swift · tap-today | Watch Today: plan | 69 | 12 ms | 1.1 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 2 ms | 2.3 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 1 ms | 0.6 ms |
| swift · tap-today | Count: a Today row drawn | 226 | 0 ms | 0.0 ms |
| shared · tap-today | Store load: read the database | 2 | 886 ms | 829.6 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 226 ms | 225.8 ms |
| shared · tap-today | Widgets: one habit's week | 16 | 88 ms | 62.1 ms |
| shared · tap-today | Watch Today: plan | 69 | 70 ms | 15.9 ms |
| shared · tap-today | Shared rules: built from every log | 3 | 30 ms | 14.1 ms |
| shared · tap-today | Shared rules: habits and settings again | 10 | 9 ms | 2.1 ms |
| shared · tap-today | Shared rules: a log added | 51 | 3 ms | 0.5 ms |
| shared · tap-today | Widgets: the snapshot | 3 | 3 ms | 1.3 ms |
| shared · tap-today | Shared rules: a log removed | 15 | 3 ms | 0.3 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 1 ms | 1.4 ms |
| shared · tap-today | Count: a Today row drawn | 226 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 277 ms | 269.9 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 45 ms | 24.8 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 31 ms | 31.1 ms |
| swift · tap-today | Watch Today: plan | 69 | 12 ms | 1.0 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 3 ms | 3.0 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 1 ms | 0.6 ms |
| swift · tap-today | Count: a Today row drawn | 226 | 0 ms | 0.0 ms |
| shared · tap-today | Store load: read the database | 2 | 379 ms | 294.6 ms |
| shared · tap-today | Widgets: one habit's week | 12 | 70 ms | 39.0 ms |
| shared · tap-today | Watch Today: plan | 69 | 69 ms | 15.1 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 23 ms | 23.0 ms |
| shared · tap-today | Shared rules: built from every log | 3 | 22 ms | 16.9 ms |
| shared · tap-today | Shared rules: habits and settings again | 10 | 5 ms | 0.8 ms |
| shared · tap-today | Shared rules: a log added | 51 | 4 ms | 0.8 ms |
| shared · tap-today | Shared rules: a log removed | 15 | 3 ms | 0.6 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 3 ms | 3.1 ms |
| shared · tap-today | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| shared · tap-today | Count: a Today row drawn | 226 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 244 ms | 229.8 ms |
| swift · tap-today | Widgets: one habit's week | 14 | 69 ms | 41.4 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 27 ms | 26.6 ms |
| swift · tap-today | Watch Today: plan | 68 | 15 ms | 0.9 ms |
| swift · tap-today | Widgets: the snapshot | 2 | 2 ms | 1.2 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 1 ms | 1.4 ms |
| swift · tap-today | Count: a Today row drawn | 224 | 0 ms | 0.0 ms |
| shared · tap-today | Store load: read the database | 2 | 300 ms | 264.5 ms |
| shared · tap-today | Widgets: one habit's week | 16 | 87 ms | 49.4 ms |
| shared · tap-today | Watch Today: plan | 68 | 30 ms | 4.8 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 25 ms | 24.7 ms |
| shared · tap-today | Shared rules: built from every log | 3 | 21 ms | 14.6 ms |
| shared · tap-today | Shared rules: habits and settings again | 10 | 6 ms | 1.3 ms |
| shared · tap-today | Shared rules: a log removed | 15 | 3 ms | 0.4 ms |
| shared · tap-today | Shared rules: a log added | 51 | 3 ms | 0.1 ms |
| shared · tap-today | Widgets: the snapshot | 3 | 2 ms | 1.1 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 1 ms | 1.1 ms |
| shared · tap-today | Count: a Today row drawn | 171 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 215 ms | 209.6 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 47 ms | 19.2 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 26 ms | 26.0 ms |
| swift · tap-today | Watch Today: plan | 71 | 14 ms | 1.2 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 2 ms | 0.7 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · tap-today | Count: a Today row drawn | 49 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 393 ms | 332.1 ms |
| shared · crown | Widgets: one habit's week | 16 | 108 ms | 57.9 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 23 ms | 23.1 ms |
| shared · crown | Shared rules: built from every log | 3 | 22 ms | 16.0 ms |
| shared · crown | Watch Today: plan | 12 | 10 ms | 1.5 ms |
| shared · crown | Widgets: the snapshot | 3 | 4 ms | 2.0 ms |
| shared · crown | Shared rules: habits and settings again | 10 | 3 ms | 0.8 ms |
| shared · crown | Watch Day details: today's logs | 1 | 1 ms | 1.4 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.4 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · crown | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Count: a Today row drawn | 22 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 347 ms | 339.8 ms |
| swift · crown | Widgets: one habit's week | 16 | 48 ms | 27.5 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 27 ms | 27.2 ms |
| swift · crown | Watch Today: plan | 13 | 5 ms | 1.4 ms |
| swift · crown | Widgets: the snapshot | 3 | 3 ms | 1.9 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.3 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.2 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.2 ms |
| swift · crown | Count: a Today row drawn | 31 | 0 ms | 0.0 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 384 ms | 366.8 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 52 ms | 52.0 ms |
| shared · crown | Widgets: one habit's week | 16 | 41 ms | 17.1 ms |
| shared · crown | Watch Today: plan | 13 | 16 ms | 6.4 ms |
| shared · crown | Shared rules: built from every log | 3 | 13 ms | 5.7 ms |
| shared · crown | Shared rules: habits and settings again | 10 | 4 ms | 1.1 ms |
| shared · crown | Widgets: the snapshot | 3 | 2 ms | 0.7 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.4 ms |
| shared · crown | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · crown | Watch Day details: today's logs | 1 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Count: a Today row drawn | 27 | 0 ms | 0.0 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 279 ms | 244.3 ms |
| swift · crown | Widgets: one habit's week | 16 | 53 ms | 27.3 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 25 ms | 25.3 ms |
| swift · crown | Watch Today: plan | 13 | 5 ms | 1.4 ms |
| swift · crown | Widgets: the snapshot | 3 | 2 ms | 1.0 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.4 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.1 ms |
| swift · crown | Count: a Today row drawn | 22 | 0 ms | 0.0 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 429 ms | 397.1 ms |
| shared · crown | Widgets: one habit's week | 16 | 50 ms | 30.6 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 36 ms | 35.9 ms |
| shared · crown | Shared rules: built from every log | 3 | 9 ms | 4.7 ms |
| shared · crown | Watch Today: plan | 12 | 8 ms | 1.5 ms |
| shared · crown | Shared rules: habits and settings again | 10 | 4 ms | 1.1 ms |
| shared · crown | Widgets: the snapshot | 3 | 4 ms | 3.0 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 1 ms | 1.3 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| shared · crown | Watch Day details: today's logs | 1 | 0 ms | 0.3 ms |
| shared · crown | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Count: a Today row drawn | 28 | 0 ms | 0.0 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 306 ms | 292.0 ms |
| swift · crown | Widgets: one habit's week | 16 | 45 ms | 25.4 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 19 ms | 19.3 ms |
| swift · crown | Watch Today: plan | 12 | 4 ms | 1.3 ms |
| swift · crown | Widgets: the snapshot | 3 | 2 ms | 0.8 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.3 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.2 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| swift · crown | Count: a Today row drawn | 29 | 0 ms | 0.0 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 142 ms | 110.8 ms |
| shared · crown | Widgets: one habit's week | 8 | 45 ms | 26.9 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 20 ms | 20.4 ms |
| shared · crown | Watch Today: plan | 13 | 18 ms | 4.1 ms |
| shared · crown | Shared rules: built from every log | 3 | 13 ms | 7.9 ms |
| shared · crown | Shared rules: habits and settings again | 10 | 6 ms | 1.3 ms |
| shared · crown | Widgets: the snapshot | 2 | 2 ms | 1.0 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 1 ms | 0.6 ms |
| shared · crown | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: today's logs | 1 | 0 ms | 0.4 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 293 ms | 281.6 ms |
| swift · crown | Widgets: one habit's week | 16 | 54 ms | 28.5 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 20 ms | 20.2 ms |
| swift · crown | Watch Today: plan | 13 | 6 ms | 2.4 ms |
| swift · crown | Widgets: the snapshot | 3 | 2 ms | 1.2 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.4 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.1 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| swift · crown | Count: a Today row drawn | 23 | 0 ms | 0.0 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 162 ms | 150.5 ms |
| shared · day-details | Widgets: one habit's week | 8 | 37 ms | 25.0 ms |
| shared · day-details | Watch Today: plan | 48 | 34 ms | 6.7 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 19 ms | 19.2 ms |
| shared · day-details | Shared rules: built from every log | 3 | 9 ms | 5.7 ms |
| shared · day-details | Watch Day details: the dial's words | 60 | 6 ms | 0.6 ms |
| shared · day-details | Shared rules: habits and settings again | 10 | 4 ms | 0.7 ms |
| shared · day-details | Watch Day details: streak | 60 | 4 ms | 0.2 ms |
| shared · day-details | Widgets: the snapshot | 2 | 3 ms | 2.3 ms |
| shared · day-details | Shared rules: a log added | 37 | 2 ms | 0.2 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.3 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · day-details | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 304 ms | 294.6 ms |
| swift · day-details | Widgets: one habit's week | 16 | 61 ms | 36.4 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 22 ms | 21.8 ms |
| swift · day-details | Watch Today: plan | 48 | 13 ms | 0.9 ms |
| swift · day-details | Watch Day details: the dial's words | 60 | 4 ms | 0.3 ms |
| swift · day-details | Watch Day details: streak | 60 | 3 ms | 0.2 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| swift · day-details | Widgets: the snapshot | 3 | 1 ms | 0.5 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · day-details | Count: a Today row drawn | 187 | 0 ms | 0.0 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 270 ms | 243.3 ms |
| shared · day-details | Widgets: one habit's week | 16 | 107 ms | 49.6 ms |
| shared · day-details | Watch Today: plan | 48 | 49 ms | 9.5 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 20 ms | 19.6 ms |
| shared · day-details | Shared rules: built from every log | 3 | 19 ms | 8.8 ms |
| shared · day-details | Watch Day details: the dial's words | 34 | 13 ms | 9.3 ms |
| shared · day-details | Shared rules: habits and settings again | 10 | 8 ms | 1.8 ms |
| shared · day-details | Shared rules: a log added | 37 | 6 ms | 2.4 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.2 ms |
| shared · day-details | Watch Day details: streak | 32 | 2 ms | 0.5 ms |
| shared · day-details | Widgets: the snapshot | 3 | 2 ms | 0.8 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 1 ms | 1.1 ms |
| shared · day-details | Count: a Today row drawn | 65 | 0 ms | 0.0 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 380 ms | 357.5 ms |
| swift · day-details | Widgets: one habit's week | 16 | 46 ms | 18.2 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 34 ms | 33.9 ms |
| swift · day-details | Watch Today: plan | 48 | 11 ms | 2.0 ms |
| swift · day-details | Watch Day details: the dial's words | 46 | 2 ms | 0.2 ms |
| swift · day-details | Widgets: the snapshot | 3 | 2 ms | 1.0 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| swift · day-details | Watch Day details: streak | 46 | 2 ms | 0.1 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| swift · day-details | Count: a Today row drawn | 132 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 391 ms | 379.1 ms |
| shared · day-details | Widgets: one habit's week | 16 | 55 ms | 20.0 ms |
| shared · day-details | Watch Today: plan | 48 | 22 ms | 3.6 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 20 ms | 20.1 ms |
| shared · day-details | Shared rules: built from every log | 3 | 9 ms | 5.4 ms |
| shared · day-details | Shared rules: habits and settings again | 10 | 4 ms | 0.7 ms |
| shared · day-details | Widgets: the snapshot | 3 | 3 ms | 1.9 ms |
| shared · day-details | Shared rules: a log added | 37 | 2 ms | 0.2 ms |
| shared · day-details | Watch Day details: the dial's words | 31 | 2 ms | 0.2 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 1 ms | 0.1 ms |
| shared · day-details | Watch Day details: streak | 31 | 1 ms | 0.1 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · day-details | Count: a Today row drawn | 52 | 0 ms | 0.0 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 230 ms | 218.6 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 30 ms | 29.9 ms |
| swift · day-details | Widgets: one habit's week | 8 | 29 ms | 17.2 ms |
| swift · day-details | Watch Today: plan | 49 | 9 ms | 0.8 ms |
| swift · day-details | Watch Day details: today's logs | 62 | 2 ms | 0.1 ms |
| swift · day-details | Watch Day details: the dial's words | 32 | 1 ms | 0.2 ms |
| swift · day-details | Watch Day details: streak | 32 | 1 ms | 0.1 ms |
| swift · day-details | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · day-details | Count: a Today row drawn | 38 | 0 ms | 0.0 ms |
| swift · day-details | Count: Day details drawn | 62 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 280 ms | 259.8 ms |
| shared · day-details | Widgets: one habit's week | 8 | 43 ms | 23.9 ms |
| shared · day-details | Watch Today: plan | 48 | 27 ms | 4.6 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 25 ms | 25.3 ms |
| shared · day-details | Shared rules: built from every log | 3 | 12 ms | 7.1 ms |
| shared · day-details | Watch Day details: the dial's words | 59 | 5 ms | 0.5 ms |
| shared · day-details | Shared rules: habits and settings again | 10 | 4 ms | 0.9 ms |
| shared · day-details | Watch Day details: streak | 57 | 3 ms | 0.2 ms |
| shared · day-details | Shared rules: a log added | 37 | 3 ms | 0.4 ms |
| shared · day-details | Widgets: the snapshot | 2 | 2 ms | 1.4 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| shared · day-details | Count: a Today row drawn | 58 | 0 ms | 0.0 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 388 ms | 372.8 ms |
| swift · day-details | Widgets: one habit's week | 16 | 48 ms | 26.4 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 20 ms | 20.1 ms |
| swift · day-details | Watch Today: plan | 48 | 12 ms | 2.0 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| swift · day-details | Watch Day details: the dial's words | 31 | 1 ms | 0.2 ms |
| swift · day-details | Widgets: the snapshot | 3 | 1 ms | 0.5 ms |
| swift · day-details | Watch Day details: streak | 31 | 1 ms | 0.1 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| swift · day-details | Count: a Today row drawn | 49 | 0 ms | 0.0 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |

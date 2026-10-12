# Watch: claude/shared-habit-rules-wperf3 @ 1d6a553

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38245456476 · 2026-10-12 13:32 UTC
Commit: Watch speed, shared rules with concurrent marking against the Swift rules, side by side [watch-perf]

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
| shared · Today: +1 (tap to filled button) | 6.6 | 70 ms | 0 |
| shared · Today: ✓ and Undo | 1.6 | 34 ms | 0 |
| swift · Today: +1 (tap to filled button) | 9.7 | 89 ms | 0 |
| swift · Today: ✓ and Undo | 2.0 | 26 ms | 0 |
| shared · Today: +1 (tap to filled button) | 8.3 | 47 ms | 0 |
| shared · Today: ✓ and Undo | 3.8 | 33 ms | 0 |
| swift · Today: +1 (tap to filled button) | 3.1 | 31 ms | 0 |
| swift · Today: ✓ and Undo | 3.3 | 36 ms | 0 |
| shared · Today: +1 (tap to filled button) | 2.4 | 33 ms | 0 |
| shared · Today: ✓ and Undo | 3.0 | 31 ms | 0 |
| swift · Today: +1 (tap to filled button) | 1.9 | 29 ms | 0 |
| swift · Today: ✓ and Undo | 0.2 | 20 ms | 0 |
| shared · Today: +1 (tap to filled button) | 9.6 | 34 ms | 0 |
| shared · Today: ✓ and Undo | 3.7 | 38 ms | 0 |
| swift · Today: +1 (tap to filled button) | 8.0 | 75 ms | 0 |
| swift · Today: ✓ and Undo | 18.4 | 98 ms | 0 |
| shared · Log manually: turning the Crown | 6.0 | 41 ms | 0 |
| swift · Log manually: turning the Crown | 1.8 | 37 ms | 0 |
| shared · Log manually: turning the Crown | 0.6 | 19 ms | 0 |
| swift · Log manually: turning the Crown | 3.7 | 24 ms | 0 |
| shared · Log manually: turning the Crown | 0.0 | 17 ms | 0 |
| swift · Log manually: turning the Crown | 5.6 | 51 ms | 0 |
| shared · Log manually: turning the Crown | 0.0 | 0 ms | 0 |
| swift · Log manually: turning the Crown | 0.2 | 19 ms | 0 |
| shared · Day details: +1 | 11.6 | 66 ms | 0 |
| swift · Day details: +1 | 6.6 | 32 ms | 0 |
| shared · Day details: +1 | 3.2 | 32 ms | 0 |
| swift · Day details: +1 | 3.8 | 31 ms | 0 |
| shared · Day details: +1 | 2.1 | 24 ms | 0 |
| swift · Day details: +1 | 9.6 | 47 ms | 0 |
| shared · Day details: +1 | 2.7 | 35 ms | 0 |
| swift · Day details: +1 | 4.0 | 35 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- shared · Log manually: longest stall 536 ms
- swift · Log manually: longest stall 319 ms
- shared · Log manually: longest stall 103 ms
- swift · Log manually: longest stall 456 ms
- shared · Log manually: longest stall 318 ms
- swift · Log manually: longest stall 499 ms
- shared · Log manually: longest stall 302 ms
- swift · Log manually: longest stall 282 ms
- shared · Blank page (control, first): longest stall 135 ms
- shared · Blank page (control, again): longest stall 54 ms
- shared · Day details (first): longest stall 140 ms
- shared · Day details (again): longest stall 87 ms
- swift · Blank page (control, first): longest stall 109 ms
- swift · Blank page (control, again): longest stall 29 ms
- swift · Day details (first): longest stall 62 ms
- swift · Day details (again): longest stall 71 ms
- shared · Blank page (control, first): longest stall 142 ms
- shared · Blank page (control, again): longest stall 38 ms
- shared · Day details (first): longest stall 126 ms
- shared · Day details (again): longest stall 37 ms
- swift · Blank page (control, first): longest stall 81 ms
- swift · Blank page (control, again): longest stall 22 ms
- swift · Day details (first): longest stall 74 ms
- swift · Day details (again): longest stall 47 ms
- shared · Blank page (control, first): longest stall 141 ms
- shared · Blank page (control, again): longest stall 46 ms
- shared · Day details (first): longest stall 107 ms
- shared · Day details (again): longest stall 66 ms
- swift · Blank page (control, first): longest stall 174 ms
- swift · Blank page (control, again): longest stall 84 ms
- swift · Day details (first): longest stall 165 ms
- swift · Day details (again): longest stall 147 ms
- shared · Blank page (control, first): longest stall 248 ms
- shared · Blank page (control, again): longest stall 37 ms
- shared · Day details (first): longest stall 214 ms
- shared · Day details (again): longest stall 56 ms
- swift · Blank page (control, first): longest stall 61 ms
- swift · Blank page (control, again): longest stall 27 ms
- swift · Day details (first): longest stall 68 ms
- swift · Day details (again): longest stall 126 ms

Notes (storage and the first fill):


Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| shared · tap-today | Store load: read the database | 2 | 365 ms | 274.7 ms |
| shared · tap-today | Widgets: one habit's week | 16 | 82 ms | 34.1 ms |
| shared · tap-today | Watch Today: plan | 69 | 35 ms | 6.4 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 25 ms | 25.2 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 21 ms | 21.4 ms |
| shared · tap-today | Widgets: the snapshot | 3 | 2 ms | 1.2 ms |
| shared · tap-today | Count: a Today row drawn | 230 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 118 ms | 107.2 ms |
| swift · tap-today | Widgets: one habit's week | 8 | 32 ms | 18.3 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 27 ms | 26.9 ms |
| swift · tap-today | Watch Today: plan | 69 | 14 ms | 1.1 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 2 ms | 1.7 ms |
| swift · tap-today | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| swift · tap-today | Count: a Today row drawn | 227 | 0 ms | 0.0 ms |
| shared · tap-today | Store load: read the database | 2 | 404 ms | 364.8 ms |
| shared · tap-today | Widgets: one habit's week | 16 | 99 ms | 45.3 ms |
| shared · tap-today | Watch Today: plan | 69 | 45 ms | 11.9 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 28 ms | 27.8 ms |
| shared · tap-today | Widgets: the snapshot | 3 | 3 ms | 1.9 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| shared · tap-today | Count: a Today row drawn | 232 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 334 ms | 318.8 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 48 ms | 23.4 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 23 ms | 23.3 ms |
| swift · tap-today | Watch Today: plan | 68 | 17 ms | 2.4 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 2 ms | 1.8 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 1 ms | 0.4 ms |
| swift · tap-today | Count: a Today row drawn | 225 | 0 ms | 0.0 ms |
| shared · tap-today | Store load: read the database | 2 | 320 ms | 294.4 ms |
| shared · tap-today | Widgets: one habit's week | 16 | 91 ms | 31.0 ms |
| shared · tap-today | Watch Today: plan | 69 | 37 ms | 1.4 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 24 ms | 23.5 ms |
| shared · tap-today | Widgets: the snapshot | 3 | 3 ms | 1.1 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| shared · tap-today | Count: a Today row drawn | 235 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 256 ms | 238.6 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 55 ms | 31.9 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 17 ms | 16.9 ms |
| swift · tap-today | Watch Today: plan | 69 | 15 ms | 1.6 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 2 ms | 0.8 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 2 ms | 1.9 ms |
| swift · tap-today | Count: a Today row drawn | 225 | 0 ms | 0.0 ms |
| shared · tap-today | Store load: read the database | 2 | 658 ms | 648.2 ms |
| shared · tap-today | Widgets: one habit's week | 16 | 92 ms | 32.3 ms |
| shared · tap-today | Watch Today: plan | 69 | 44 ms | 1.9 ms |
| shared · tap-today | Store load: into the app (1716 logs) | 1 | 34 ms | 34.2 ms |
| shared · tap-today | Widgets: the snapshot | 3 | 4 ms | 2.2 ms |
| shared · tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| shared · tap-today | Count: a Today row drawn | 234 | 0 ms | 0.0 ms |
| swift · tap-today | Store load: read the database | 2 | 323 ms | 308.8 ms |
| swift · tap-today | Widgets: one habit's week | 16 | 41 ms | 26.4 ms |
| swift · tap-today | Store load: into the app (1716 logs) | 1 | 17 ms | 17.2 ms |
| swift · tap-today | Watch Today: plan | 69 | 15 ms | 1.1 ms |
| swift · tap-today | Widgets: the snapshot | 3 | 1 ms | 0.4 ms |
| swift · tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · tap-today | Count: a Today row drawn | 227 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 264 ms | 228.6 ms |
| shared · crown | Widgets: one habit's week | 16 | 91 ms | 32.0 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 24 ms | 23.7 ms |
| shared · crown | Watch Today: plan | 13 | 13 ms | 3.2 ms |
| shared · crown | Widgets: the snapshot | 3 | 2 ms | 1.2 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 2 ms | 1.9 ms |
| shared · crown | Watch Day details: today's logs | 1 | 2 ms | 1.6 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.2 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Count: a Today row drawn | 35 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 308 ms | 285.9 ms |
| swift · crown | Widgets: one habit's week | 16 | 42 ms | 25.5 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 24 ms | 23.6 ms |
| swift · crown | Watch Today: plan | 13 | 4 ms | 1.6 ms |
| swift · crown | Watch Day details: today's logs | 1 | 2 ms | 1.6 ms |
| swift · crown | Widgets: the snapshot | 3 | 1 ms | 0.6 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.3 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.3 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| swift · crown | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 282 ms | 266.1 ms |
| shared · crown | Widgets: one habit's week | 8 | 42 ms | 18.7 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 19 ms | 18.5 ms |
| shared · crown | Watch Today: plan | 13 | 10 ms | 1.9 ms |
| shared · crown | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.2 ms |
| shared · crown | Watch Day details: today's logs | 1 | 0 ms | 0.1 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 167 ms | 156.0 ms |
| swift · crown | Widgets: one habit's week | 8 | 33 ms | 22.8 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 27 ms | 27.1 ms |
| swift · crown | Watch Today: plan | 13 | 4 ms | 1.1 ms |
| swift · crown | Widgets: the snapshot | 2 | 1 ms | 0.9 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 1 ms | 1.1 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.4 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.2 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| swift · crown | Count: a Today row drawn | 19 | 0 ms | 0.0 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 288 ms | 261.9 ms |
| shared · crown | Widgets: one habit's week | 16 | 54 ms | 16.5 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 25 ms | 25.4 ms |
| shared · crown | Watch Today: plan | 13 | 18 ms | 10.6 ms |
| shared · crown | Widgets: the snapshot | 3 | 4 ms | 1.9 ms |
| shared · crown | Watch Day details: today's logs | 1 | 0 ms | 0.4 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.3 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| shared · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| shared · crown | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 248 ms | 233.5 ms |
| swift · crown | Widgets: one habit's week | 8 | 29 ms | 20.8 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 23 ms | 23.2 ms |
| swift · crown | Watch Today: plan | 13 | 10 ms | 6.8 ms |
| swift · crown | Watch Day details: today's logs | 1 | 1 ms | 0.8 ms |
| swift · crown | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 1 ms | 0.5 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| swift · crown | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| shared · crown | Store load: read the database | 2 | 174 ms | 164.0 ms |
| shared · crown | Widgets: one habit's week | 8 | 41 ms | 20.9 ms |
| shared · crown | Store load: into the app (1716 logs) | 1 | 24 ms | 23.5 ms |
| shared · crown | Watch Today: plan | 13 | 15 ms | 7.4 ms |
| shared · crown | Widgets: the snapshot | 2 | 2 ms | 1.2 ms |
| shared · crown | Watch Day details: today's logs | 1 | 1 ms | 0.9 ms |
| shared · crown | Count: Day details drawn | 1 | 1 ms | 0.9 ms |
| shared · crown | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| shared · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.4 ms |
| shared · crown | Watch Day details: streak | 1 | 0 ms | 0.2 ms |
| shared · crown | Count: a Today row drawn | 27 | 0 ms | 0.0 ms |
| swift · crown | Store load: read the database | 2 | 184 ms | 176.8 ms |
| swift · crown | Widgets: one habit's week | 8 | 24 ms | 15.7 ms |
| swift · crown | Store load: into the app (1716 logs) | 1 | 18 ms | 17.5 ms |
| swift · crown | Watch Today: plan | 13 | 3 ms | 1.0 ms |
| swift · crown | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| swift · crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| swift · crown | Watch Day details: the dial's words | 1 | 0 ms | 0.3 ms |
| swift · crown | Watch Day details: today's logs | 1 | 0 ms | 0.1 ms |
| swift · crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| swift · crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| swift · crown | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 261 ms | 251.3 ms |
| shared · day-details | Widgets: one habit's week | 16 | 53 ms | 14.0 ms |
| shared · day-details | Watch Today: plan | 48 | 34 ms | 2.5 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 22 ms | 22.4 ms |
| shared · day-details | Watch Day details: the dial's words | 31 | 3 ms | 0.3 ms |
| shared · day-details | Widgets: the snapshot | 3 | 3 ms | 1.5 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| shared · day-details | Watch Day details: streak | 31 | 2 ms | 0.2 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| shared · day-details | Count: a Today row drawn | 57 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 324 ms | 303.0 ms |
| swift · day-details | Widgets: one habit's week | 16 | 44 ms | 21.8 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 18 ms | 18.4 ms |
| swift · day-details | Watch Today: plan | 48 | 11 ms | 1.1 ms |
| swift · day-details | Watch Day details: the dial's words | 31 | 2 ms | 0.2 ms |
| swift · day-details | Widgets: the snapshot | 3 | 2 ms | 1.2 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| swift · day-details | Watch Day details: streak | 31 | 2 ms | 0.2 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| swift · day-details | Count: a Today row drawn | 52 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 87 ms | 79.0 ms |
| shared · day-details | Widgets: one habit's week | 8 | 26 ms | 11.0 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 24 ms | 24.3 ms |
| shared · day-details | Watch Today: plan | 48 | 24 ms | 1.8 ms |
| shared · day-details | Watch Day details: the dial's words | 31 | 2 ms | 0.3 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| shared · day-details | Widgets: the snapshot | 2 | 2 ms | 1.0 ms |
| shared · day-details | Watch Day details: streak | 31 | 2 ms | 0.2 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| shared · day-details | Count: a Today row drawn | 59 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 399 ms | 391.3 ms |
| swift · day-details | Widgets: one habit's week | 16 | 53 ms | 32.3 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 29 ms | 29.3 ms |
| swift · day-details | Watch Today: plan | 49 | 11 ms | 1.9 ms |
| swift · day-details | Watch Day details: the dial's words | 32 | 2 ms | 0.2 ms |
| swift · day-details | Watch Day details: today's logs | 62 | 2 ms | 0.1 ms |
| swift · day-details | Widgets: the snapshot | 3 | 2 ms | 0.7 ms |
| swift · day-details | Watch Day details: streak | 32 | 1 ms | 0.1 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| swift · day-details | Count: Day details drawn | 62 | 0 ms | 0.0 ms |
| swift · day-details | Count: a Today row drawn | 52 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 652 ms | 607.9 ms |
| shared · day-details | Widgets: one habit's week | 16 | 95 ms | 29.1 ms |
| shared · day-details | Watch Today: plan | 48 | 45 ms | 18.5 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 25 ms | 25.2 ms |
| shared · day-details | Widgets: the snapshot | 3 | 3 ms | 1.5 ms |
| shared · day-details | Watch Day details: the dial's words | 31 | 2 ms | 0.4 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| shared · day-details | Watch Day details: streak | 31 | 1 ms | 0.2 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| shared · day-details | Count: a Today row drawn | 58 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 280 ms | 265.7 ms |
| swift · day-details | Widgets: one habit's week | 16 | 24 ms | 12.5 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 18 ms | 17.6 ms |
| swift · day-details | Watch Today: plan | 48 | 12 ms | 1.0 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| swift · day-details | Watch Day details: the dial's words | 31 | 2 ms | 0.2 ms |
| swift · day-details | Watch Day details: streak | 31 | 1 ms | 0.1 ms |
| swift · day-details | Widgets: the snapshot | 3 | 1 ms | 0.8 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.1 ms |
| swift · day-details | Count: a Today row drawn | 63 | 0 ms | 0.0 ms |
| shared · day-details | Store load: read the database | 2 | 248 ms | 232.5 ms |
| shared · day-details | Widgets: one habit's week | 16 | 55 ms | 18.1 ms |
| shared · day-details | Watch Today: plan | 48 | 39 ms | 9.2 ms |
| shared · day-details | Store load: into the app (1716 logs) | 1 | 19 ms | 18.7 ms |
| shared · day-details | Watch Day details: the dial's words | 31 | 3 ms | 0.2 ms |
| shared · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.3 ms |
| shared · day-details | Watch Day details: streak | 31 | 2 ms | 0.3 ms |
| shared · day-details | Widgets: the snapshot | 3 | 2 ms | 0.6 ms |
| shared · day-details | Store load: into the app (0 logs) | 1 | 1 ms | 1.4 ms |
| shared · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| shared · day-details | Count: a Today row drawn | 76 | 0 ms | 0.0 ms |
| swift · day-details | Store load: read the database | 2 | 124 ms | 114.4 ms |
| swift · day-details | Store load: into the app (1716 logs) | 1 | 29 ms | 28.8 ms |
| swift · day-details | Widgets: one habit's week | 8 | 22 ms | 14.4 ms |
| swift · day-details | Watch Today: plan | 48 | 10 ms | 1.1 ms |
| swift · day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| swift · day-details | Watch Day details: the dial's words | 31 | 2 ms | 0.1 ms |
| swift · day-details | Widgets: the snapshot | 2 | 1 ms | 0.9 ms |
| swift · day-details | Watch Day details: streak | 31 | 1 ms | 0.1 ms |
| swift · day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| swift · day-details | Count: a Today row drawn | 49 | 0 ms | 0.0 ms |

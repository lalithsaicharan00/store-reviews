# Watch: claude/shared-habit-rules-wperf7 @ 4cb9ec0

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38261444136 · 2026-10-12 14:44 UTC
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
| shared · Today: scrolling 30 habits | 10.8 | 51 ms | 0 |
| swift · Today: scrolling 30 habits | 45.8 | 349 ms | 1 |
| shared · Today: scrolling 30 habits | 10.2 | 50 ms | 0 |
| swift · Today: scrolling 30 habits | 17.6 | 179 ms | 1 |
| shared · Today: scrolling 30 habits | 9.7 | 93 ms | 0 |
| swift · Today: scrolling 30 habits | 22.1 | 249 ms | 1 |
| shared · Today: scrolling 30 habits | 7.8 | 97 ms | 0 |
| swift · Today: scrolling 30 habits | 22.1 | 248 ms | 1 |
| shared · Routine: paging with the Crown | 10.2 | 44 ms | 0 |
| swift · Routine: paging with the Crown | 4.4 | 36 ms | 0 |
| shared · Routine: paging with the Crown | 5.7 | 51 ms | 0 |
| swift · Routine: paging with the Crown | 10.2 | 71 ms | 0 |
| shared · Routine: paging with the Crown | 7.7 | 44 ms | 0 |
| swift · Routine: paging with the Crown | 132.1 | 1400 ms | 1 |
| shared · Routine: paging with the Crown | 13.9 | 51 ms | 0 |
| swift · Routine: paging with the Crown | 9.5 | 32 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- shared · Blank cover (control, first): longest stall 236 ms
- shared · Blank cover (control, again): longest stall 90 ms
- shared · Routine (open): longest stall 374 ms
- swift · Blank cover (control, first): longest stall 144 ms
- swift · Blank cover (control, again): longest stall 57 ms
- swift · Routine (open): longest stall 323 ms
- shared · Blank cover (control, first): longest stall 138 ms
- shared · Blank cover (control, again): longest stall 948 ms
- shared · Routine (open): longest stall 387 ms
- swift · Blank cover (control, first): longest stall 298 ms
- swift · Blank cover (control, again): longest stall 80 ms
- swift · Routine (open): longest stall 354 ms
- shared · Blank cover (control, first): longest stall 221 ms
- shared · Blank cover (control, again): longest stall 48 ms
- shared · Routine (open): longest stall 295 ms
- swift · Blank cover (control, first): longest stall 120 ms
- swift · Blank cover (control, again): longest stall 49 ms
- swift · Routine (open): longest stall 279 ms
- shared · Blank cover (control, first): longest stall 203 ms
- shared · Blank cover (control, again): longest stall 70 ms
- shared · Routine (open): longest stall 361 ms
- swift · Blank cover (control, first): longest stall 130 ms
- swift · Blank cover (control, again): longest stall 48 ms
- swift · Routine (open): longest stall 283 ms
- shared · Launch to a usable Today (round 1 , cold): 1610 ms
- swift · Launch to a usable Today (round 1 , cold): 1328 ms
- shared · Launch to a usable Today (round 2, warm): 1243 ms
- swift · Launch to a usable Today (round 2, warm): 1272 ms
- shared · Launch to a usable Today (round 3, warm): 1629 ms
- swift · Launch to a usable Today (round 3, warm): 1221 ms
- shared · Launch to a usable Today (round 4, warm): 1142 ms
- swift · Launch to a usable Today (round 4, warm): 1977 ms
- shared · Launch to a usable Today (round 5, warm): 1342 ms
- swift · Launch to a usable Today (round 5, warm): 1560 ms
- shared · Launch to a usable Today (round 6, warm): 1560 ms
- swift · Launch to a usable Today (round 6, warm): 1185 ms
- shared · Launch to a usable Today (round 7, warm): 1798 ms
- swift · Launch to a usable Today (round 7, warm): 1588 ms
- shared · Launch to a usable Today (round 8, warm): 1060 ms
- swift · Launch to a usable Today (round 8, warm): 1113 ms

Notes (storage and the first fill):


Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| shared · scroll-today | Store load: read the database | 2 | 2973 ms | 2889.8 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 241 ms | 67.4 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 182 ms | 181.8 ms |
| shared · scroll-today | Watch Today: plan | 32 | 72 ms | 29.8 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 47 ms | 28.5 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 18 ms | 2.2 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 6 ms | 2.9 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 4 ms | 3.5 ms |
| shared · scroll-today | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 1672 ms | 1595.0 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 143 ms | 143.5 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 116 ms | 49.1 ms |
| swift · scroll-today | Watch Today: plan | 32 | 23 ms | 9.0 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 6 ms | 2.4 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 4 ms | 3.9 ms |
| swift · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 1020 ms | 985.3 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 192 ms | 37.7 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 110 ms | 110.3 ms |
| shared · scroll-today | Watch Today: plan | 32 | 83 ms | 33.3 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 48 ms | 30.8 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 23 ms | 3.3 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.6 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 961 ms | 950.3 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 88 ms | 88.4 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 76 ms | 19.7 ms |
| swift · scroll-today | Watch Today: plan | 32 | 15 ms | 5.2 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 5 ms | 2.0 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 1.1 ms |
| swift · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 2070 ms | 2049.6 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 172 ms | 63.1 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 77 ms | 77.1 ms |
| shared · scroll-today | Watch Today: plan | 32 | 63 ms | 15.9 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 23 ms | 14.6 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 18 ms | 1.8 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 5 ms | 2.0 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| shared · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 1510 ms | 1499.2 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 131 ms | 131.3 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 89 ms | 27.3 ms |
| swift · scroll-today | Watch Today: plan | 31 | 8 ms | 0.7 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 5 ms | 3.2 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 1317 ms | 1217.0 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 172 ms | 47.1 ms |
| shared · scroll-today | Watch Today: plan | 32 | 117 ms | 44.0 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 92 ms | 92.3 ms |
| shared · scroll-today | Shared rules: built from every log | 3 | 90 ms | 44.6 ms |
| shared · scroll-today | Shared rules: habits and settings again | 32 | 21 ms | 1.7 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 8 ms | 3.2 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 2 ms | 1.8 ms |
| shared · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 2262 ms | 2255.5 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 87 ms | 87.3 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 71 ms | 12.8 ms |
| swift · scroll-today | Watch Today: plan | 32 | 9 ms | 0.7 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.8 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · scroll-today | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 267 ms | 233.8 ms |
| shared · routine | Widgets: one habit's week | 16 | 78 ms | 28.6 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 32 ms | 32.2 ms |
| shared · routine | Watch Day details: the dial's words | 61 | 12 ms | 2.5 ms |
| shared · routine | Shared rules: built from every log | 3 | 12 ms | 7.0 ms |
| shared · routine | Watch Today: plan | 17 | 11 ms | 1.1 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 3 ms | 0.8 ms |
| shared · routine | Widgets: the snapshot | 3 | 2 ms | 0.9 ms |
| shared · routine | Shared rules: a log added | 8 | 1 ms | 0.1 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 434 ms | 409.6 ms |
| swift · routine | Widgets: one habit's week | 16 | 35 ms | 17.1 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 27 ms | 27.3 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 7 ms | 1.4 ms |
| swift · routine | Watch Today: plan | 17 | 3 ms | 0.3 ms |
| swift · routine | Widgets: the snapshot | 3 | 1 ms | 0.4 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · routine | Count: a Today row drawn | 53 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 207 ms | 187.7 ms |
| shared · routine | Widgets: one habit's week | 16 | 66 ms | 27.4 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 22 ms | 22.3 ms |
| shared · routine | Watch Today: plan | 17 | 12 ms | 1.4 ms |
| shared · routine | Watch Day details: the dial's words | 61 | 11 ms | 2.7 ms |
| shared · routine | Shared rules: built from every log | 3 | 8 ms | 3.6 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 3 ms | 0.6 ms |
| shared · routine | Widgets: the snapshot | 3 | 2 ms | 0.7 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 235 ms | 229.2 ms |
| swift · routine | Widgets: one habit's week | 16 | 41 ms | 16.7 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 22 ms | 22.2 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 8 ms | 1.9 ms |
| swift · routine | Widgets: the snapshot | 3 | 5 ms | 2.2 ms |
| swift · routine | Watch Today: plan | 17 | 4 ms | 1.0 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| swift · routine | Count: a Today row drawn | 53 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 393 ms | 313.9 ms |
| shared · routine | Widgets: one habit's week | 16 | 107 ms | 54.6 ms |
| shared · routine | Shared rules: built from every log | 3 | 46 ms | 39.4 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 25 ms | 25.3 ms |
| shared · routine | Watch Today: plan | 16 | 16 ms | 5.9 ms |
| shared · routine | Watch Day details: the dial's words | 61 | 15 ms | 5.2 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 5 ms | 1.3 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 3 ms | 2.6 ms |
| shared · routine | Widgets: the snapshot | 3 | 3 ms | 1.1 ms |
| shared · routine | Shared rules: a log added | 8 | 1 ms | 0.4 ms |
| shared · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 50 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 247 ms | 233.3 ms |
| swift · routine | Widgets: one habit's week | 16 | 30 ms | 15.8 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 17 ms | 17.0 ms |
| swift · routine | Watch Day details: the dial's words | 55 | 9 ms | 1.1 ms |
| swift · routine | Watch Today: plan | 17 | 4 ms | 0.9 ms |
| swift · routine | Widgets: the snapshot | 3 | 1 ms | 0.8 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · routine | Count: a Today row drawn | 51 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 55 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 309 ms | 280.4 ms |
| shared · routine | Widgets: one habit's week | 16 | 52 ms | 22.4 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 20 ms | 20.1 ms |
| shared · routine | Watch Today: plan | 17 | 18 ms | 4.5 ms |
| shared · routine | Watch Day details: the dial's words | 61 | 12 ms | 1.3 ms |
| shared · routine | Shared rules: built from every log | 3 | 7 ms | 4.0 ms |
| shared · routine | Shared rules: habits and settings again | 10 | 3 ms | 0.6 ms |
| shared · routine | Widgets: the snapshot | 3 | 3 ms | 1.9 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| shared · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 51 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 427 ms | 418.3 ms |
| swift · routine | Widgets: one habit's week | 16 | 55 ms | 25.9 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 25 ms | 25.0 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 8 ms | 2.0 ms |
| swift · routine | Watch Today: plan | 17 | 5 ms | 1.9 ms |
| swift · routine | Widgets: the snapshot | 3 | 2 ms | 1.0 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 1 ms | 1.0 ms |
| swift · routine | Count: a Today row drawn | 50 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 42 ms | 30.0 ms |
| shared · launch | Store load: read the database | 1 | 17 ms | 17.3 ms |
| shared · launch | Shared rules: built from every log | 2 | 7 ms | 6.5 ms |
| shared · launch | Watch Today: plan | 9 | 6 ms | 0.9 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.4 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 29 ms | 17.1 ms |
| swift · launch | Store load: read the database | 1 | 12 ms | 11.8 ms |
| swift · launch | Widgets: the snapshot | 2 | 2 ms | 1.0 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 33 ms | 14.9 ms |
| shared · launch | Store load: read the database | 1 | 13 ms | 13.3 ms |
| shared · launch | Watch Today: plan | 9 | 7 ms | 1.6 ms |
| shared · launch | Shared rules: built from every log | 2 | 3 ms | 2.9 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.8 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 35 ms | 20.2 ms |
| swift · launch | Store load: read the database | 1 | 10 ms | 10.3 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 34 ms | 17.2 ms |
| shared · launch | Store load: read the database | 1 | 14 ms | 14.1 ms |
| shared · launch | Shared rules: built from every log | 2 | 8 ms | 7.4 ms |
| shared · launch | Watch Today: plan | 9 | 6 ms | 1.2 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.2 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Store load: read the database | 1 | 103 ms | 102.8 ms |
| swift · launch | Widgets: one habit's week | 8 | 42 ms | 25.4 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 1.0 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 37 ms | 15.8 ms |
| shared · launch | Store load: read the database | 1 | 31 ms | 31.0 ms |
| shared · launch | Watch Today: plan | 9 | 7 ms | 2.3 ms |
| shared · launch | Shared rules: built from every log | 2 | 4 ms | 3.8 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.3 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 51 ms | 36.7 ms |
| swift · launch | Store load: read the database | 1 | 14 ms | 14.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 2 ms | 0.8 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 51 ms | 29.9 ms |
| shared · launch | Store load: read the database | 1 | 16 ms | 15.9 ms |
| shared · launch | Watch Today: plan | 9 | 8 ms | 1.8 ms |
| shared · launch | Shared rules: built from every log | 2 | 5 ms | 3.8 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 4 ms | 0.8 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 27 ms | 13.3 ms |
| swift · launch | Store load: read the database | 1 | 14 ms | 14.1 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.9 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 1.0 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 51 ms | 24.7 ms |
| shared · launch | Store load: read the database | 1 | 11 ms | 10.6 ms |
| shared · launch | Watch Today: plan | 9 | 6 ms | 1.1 ms |
| shared · launch | Shared rules: built from every log | 2 | 4 ms | 3.8 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 2 ms | 0.4 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.0 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 34 ms | 22.6 ms |
| swift · launch | Store load: read the database | 1 | 11 ms | 11.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 4 ms | 3.6 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 46 ms | 29.1 ms |
| shared · launch | Store load: read the database | 1 | 16 ms | 15.9 ms |
| shared · launch | Shared rules: built from every log | 2 | 8 ms | 7.3 ms |
| shared · launch | Watch Today: plan | 9 | 6 ms | 1.7 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.8 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| shared · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 28 ms | 15.5 ms |
| swift · launch | Store load: read the database | 1 | 9 ms | 9.1 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 30 ms | 15.2 ms |
| shared · launch | Store load: read the database | 1 | 12 ms | 11.6 ms |
| shared · launch | Watch Today: plan | 9 | 10 ms | 2.7 ms |
| shared · launch | Shared rules: built from every log | 2 | 4 ms | 3.1 ms |
| shared · launch | Shared rules: habits and settings again | 9 | 4 ms | 0.7 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.2 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| shared · launch | Count: a Today row drawn | 6 | 0 ms | 0.0 ms |
| swift · launch | Store load: read the database | 1 | 35 ms | 35.1 ms |
| swift · launch | Widgets: one habit's week | 8 | 26 ms | 16.5 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.5 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 1.4 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |

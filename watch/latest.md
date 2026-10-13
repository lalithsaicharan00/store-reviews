# Watch: claude/shared-habit-rules-wperf16 @ 7a45300

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38342508127 · 2026-10-13 04:30 UTC
Commit: Watch speed: Swift rules, shared one by one, shared with a row in one call (scratch, safe to delete) [watch-perf]

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
| swift · Today: scrolling 30 habits | 3.0 | 38 ms | 0 |
| one · Today: scrolling 30 habits | 0.0 | 0 ms | 0 |
| batch · Today: scrolling 30 habits | 1.0 | 29 ms | 0 |
| swift · Today: scrolling 30 habits | 7.4 | 57 ms | 0 |
| one · Today: scrolling 30 habits | 3.4 | 28 ms | 0 |
| batch · Today: scrolling 30 habits | 1.7 | 30 ms | 0 |
| swift · Today: scrolling 30 habits | 9.6 | 69 ms | 0 |
| one · Today: scrolling 30 habits | 1.8 | 32 ms | 0 |
| batch · Today: scrolling 30 habits | 4.4 | 28 ms | 0 |
| swift · Today: scrolling 30 habits | 20.3 | 116 ms | 1 |
| one · Today: scrolling 30 habits | 6.0 | 56 ms | 0 |
| batch · Today: scrolling 30 habits | 2.3 | 30 ms | 0 |
| swift · Routine: paging with the Crown | 8.9 | 42 ms | 0 |
| one · Routine: paging with the Crown | 6.9 | 38 ms | 0 |
| batch · Routine: paging with the Crown | 3.4 | 30 ms | 0 |
| swift · Routine: paging with the Crown | 6.2 | 59 ms | 0 |
| one · Routine: paging with the Crown | 3.6 | 32 ms | 0 |
| batch · Routine: paging with the Crown | 0.0 | 0 ms | 0 |
| swift · Routine: paging with the Crown | 0.3 | 21 ms | 0 |
| one · Routine: paging with the Crown | 0.0 | 0 ms | 0 |
| batch · Routine: paging with the Crown | 2.1 | 28 ms | 0 |
| swift · Routine: paging with the Crown | 1.2 | 29 ms | 0 |
| one · Routine: paging with the Crown | 1.1 | 28 ms | 0 |
| batch · Routine: paging with the Crown | 0.0 | 0 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- swift · Blank cover (control, first): longest stall 196 ms
- swift · Blank cover (control, again): longest stall 61 ms
- swift · Routine (open): longest stall 356 ms
- one · Blank cover (control, first): longest stall 176 ms
- one · Blank cover (control, again): longest stall 56 ms
- one · Routine (open): longest stall 299 ms
- batch · Blank cover (control, first): longest stall 172 ms
- batch · Blank cover (control, again): longest stall 94 ms
- batch · Routine (open): longest stall 354 ms
- swift · Blank cover (control, first): longest stall 181 ms
- swift · Blank cover (control, again): longest stall 43 ms
- swift · Routine (open): longest stall 360 ms
- one · Blank cover (control, first): longest stall 167 ms
- one · Blank cover (control, again): longest stall 63 ms
- one · Routine (open): longest stall 306 ms
- batch · Blank cover (control, first): longest stall 86 ms
- batch · Blank cover (control, again): longest stall 31 ms
- batch · Routine (open): longest stall 192 ms
- swift · Blank cover (control, first): longest stall 75 ms
- swift · Blank cover (control, again): longest stall 34 ms
- swift · Routine (open): longest stall 187 ms
- one · Blank cover (control, first): longest stall 73 ms
- one · Blank cover (control, again): longest stall 34 ms
- one · Routine (open): longest stall 185 ms
- batch · Blank cover (control, first): longest stall 75 ms
- batch · Blank cover (control, again): longest stall 32 ms
- batch · Routine (open): longest stall 213 ms
- swift · Blank cover (control, first): longest stall 76 ms
- swift · Blank cover (control, again): longest stall 35 ms
- swift · Routine (open): longest stall 194 ms
- one · Blank cover (control, first): longest stall 116 ms
- one · Blank cover (control, again): longest stall 49 ms
- one · Routine (open): longest stall 240 ms
- batch · Blank cover (control, first): longest stall 101 ms
- batch · Blank cover (control, again): longest stall 60 ms
- batch · Routine (open): longest stall 186 ms
- swift · Launch to a usable Today (round 1 , cold): 1279 ms
- one · Launch to a usable Today (round 1 , cold): 672 ms
- batch · Launch to a usable Today (round 1 , cold): 986 ms
- swift · Launch to a usable Today (round 2, warm): 1007 ms
- one · Launch to a usable Today (round 2, warm): 1020 ms
- batch · Launch to a usable Today (round 2, warm): 1058 ms
- swift · Launch to a usable Today (round 3, warm): 1426 ms
- one · Launch to a usable Today (round 3, warm): 1094 ms
- batch · Launch to a usable Today (round 3, warm): 922 ms
- swift · Launch to a usable Today (round 4, warm): 1433 ms
- one · Launch to a usable Today (round 4, warm): 1060 ms
- batch · Launch to a usable Today (round 4, warm): 941 ms
- swift · Launch to a usable Today (round 5, warm): 1098 ms
- one · Launch to a usable Today (round 5, warm): 1092 ms
- batch · Launch to a usable Today (round 5, warm): 747 ms
- swift · Launch to a usable Today (round 6, warm): 1003 ms
- one · Launch to a usable Today (round 6, warm): 1071 ms
- batch · Launch to a usable Today (round 6, warm): 615 ms
- swift · Launch to a usable Today (round 7, warm): 789 ms
- one · Launch to a usable Today (round 7, warm): 1007 ms
- batch · Launch to a usable Today (round 7, warm): 769 ms
- swift · Launch to a usable Today (round 8, warm): 796 ms
- one · Launch to a usable Today (round 8, warm): 718 ms
- batch · Launch to a usable Today (round 8, warm): 1024 ms

Notes (storage and the first fill):

- long stall 356 ms at 1791865162.406; kotlin collection 79: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 7.1 ms
- long stall 299 ms at 1791865198.609; kotlin collection 81: stopped 0.1 ms (after waiting 0.0 ms), then 0.4 ms, took 7.5 ms
- long stall 354 ms at 1791865232.892; kotlin collection 80: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 6.6 ms
- long stall 360 ms at 1791865267.340; kotlin collection 80: stopped 0.2 ms (after waiting 0.0 ms), then 0.1 ms, took 7.5 ms
- long stall 306 ms at 1791865301.373; kotlin collection 83: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 6.8 ms

Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| swift · scroll-today | Store load: read the database | 2 | 1249 ms | 1177.7 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 74 ms | 73.7 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 72 ms | 26.3 ms |
| swift · scroll-today | Watch Today: plan | 32 | 9 ms | 2.1 ms |
| swift · scroll-today | Watch Today: a row's numbers | 158 | 4 ms | 0.1 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 3 ms | 3.5 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 3 ms | 1.2 ms |
| swift · scroll-today | Count: shared rules' inputs changed: habits | 30 | 0 ms | 0.0 ms |
| swift · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| one · scroll-today | Store load: read the database | 2 | 1601 ms | 1575.2 ms |
| one · scroll-today | Store load: into the app (7320 logs) | 1 | 65 ms | 64.8 ms |
| one · scroll-today | Widgets: one habit's week | 60 | 62 ms | 26.0 ms |
| one · scroll-today | Shared rules: built from every log, off the main thread | 2 | 50 ms | 49.9 ms |
| one · scroll-today | Watch Today: plan | 32 | 34 ms | 3.9 ms |
| one · scroll-today | Shared rules: habits and settings again | 32 | 17 ms | 2.5 ms |
| one · scroll-today | Shared rules: built from every log | 1 | 9 ms | 8.7 ms |
| one · scroll-today | Watch Today: a row's numbers | 158 | 7 ms | 0.1 ms |
| one · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.2 ms |
| one · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| one · scroll-today | Count: shared rules given habits and settings again, changed | 32 | 0 ms | 0.1 ms |
| one · scroll-today | Count: shared rules' inputs changed: habits | 31 | 0 ms | 0.0 ms |
| one · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| batch · scroll-today | Store load: read the database | 2 | 1360 ms | 1339.2 ms |
| batch · scroll-today | Store load: into the app (7320 logs) | 1 | 76 ms | 76.4 ms |
| batch · scroll-today | Widgets: one habit's week | 60 | 64 ms | 13.7 ms |
| batch · scroll-today | Watch Today: plan | 32 | 26 ms | 1.4 ms |
| batch · scroll-today | Shared rules: habits and settings again | 32 | 13 ms | 1.1 ms |
| batch · scroll-today | Shared rules: built from every log, off the main thread | 2 | 11 ms | 11.1 ms |
| batch · scroll-today | Watch Today: a row's numbers | 158 | 9 ms | 0.2 ms |
| batch · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.4 ms |
| batch · scroll-today | Shared rules: built from every log | 1 | 3 ms | 2.7 ms |
| batch · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| batch · scroll-today | Count: shared rules' inputs changed: habits | 30 | 0 ms | 0.0 ms |
| batch · scroll-today | Count: shared rules given habits and settings again, changed | 32 | 0 ms | 0.0 ms |
| batch · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 798 ms | 785.2 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 72 ms | 72.2 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 55 ms | 15.3 ms |
| swift · scroll-today | Watch Today: plan | 32 | 10 ms | 3.8 ms |
| swift · scroll-today | Watch Today: a row's numbers | 157 | 4 ms | 0.1 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 3 ms | 1.1 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · scroll-today | Count: shared rules' inputs changed: habits | 31 | 0 ms | 0.0 ms |
| swift · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| one · scroll-today | Store load: read the database | 2 | 359 ms | 333.9 ms |
| one · scroll-today | Store load: into the app (7320 logs) | 1 | 63 ms | 62.5 ms |
| one · scroll-today | Widgets: one habit's week | 60 | 54 ms | 15.9 ms |
| one · scroll-today | Watch Today: plan | 32 | 30 ms | 2.8 ms |
| one · scroll-today | Shared rules: habits and settings again | 32 | 16 ms | 1.8 ms |
| one · scroll-today | Shared rules: built from every log, off the main thread | 2 | 11 ms | 10.6 ms |
| one · scroll-today | Watch Today: a row's numbers | 159 | 6 ms | 0.1 ms |
| one · scroll-today | Shared rules: built from every log | 1 | 6 ms | 6.0 ms |
| one · scroll-today | Widgets: the snapshot | 3 | 3 ms | 1.2 ms |
| one · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| one · scroll-today | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |
| one · scroll-today | Count: shared rules given habits and settings again, changed | 32 | 0 ms | 0.0 ms |
| one · scroll-today | Count: shared rules' inputs changed: habits | 31 | 0 ms | 0.0 ms |
| batch · scroll-today | Store load: read the database | 2 | 417 ms | 405.9 ms |
| batch · scroll-today | Store load: into the app (7320 logs) | 1 | 65 ms | 65.2 ms |
| batch · scroll-today | Widgets: one habit's week | 60 | 55 ms | 16.4 ms |
| batch · scroll-today | Watch Today: plan | 32 | 28 ms | 2.7 ms |
| batch · scroll-today | Shared rules: habits and settings again | 32 | 12 ms | 1.0 ms |
| batch · scroll-today | Shared rules: built from every log, off the main thread | 2 | 11 ms | 11.1 ms |
| batch · scroll-today | Watch Today: a row's numbers | 155 | 9 ms | 0.3 ms |
| batch · scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.2 ms |
| batch · scroll-today | Shared rules: built from every log | 1 | 3 ms | 3.4 ms |
| batch · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| batch · scroll-today | Count: shared rules' inputs changed: habits | 31 | 0 ms | 0.0 ms |
| batch · scroll-today | Count: shared rules given habits and settings again, changed | 32 | 0 ms | 0.0 ms |
| batch · scroll-today | Count: a Today row drawn | 155 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 462 ms | 456.6 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 83 ms | 82.8 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 47 ms | 11.7 ms |
| swift · scroll-today | Watch Today: plan | 32 | 11 ms | 3.8 ms |
| swift · scroll-today | Watch Today: a row's numbers | 103 | 5 ms | 0.3 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 3 ms | 1.1 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · scroll-today | Count: shared rules' inputs changed: habits | 31 | 0 ms | 0.0 ms |
| swift · scroll-today | Count: a Today row drawn | 103 | 0 ms | 0.0 ms |
| one · scroll-today | Store load: read the database | 2 | 1588 ms | 1546.9 ms |
| one · scroll-today | Widgets: one habit's week | 60 | 90 ms | 24.4 ms |
| one · scroll-today | Store load: into the app (7320 logs) | 1 | 88 ms | 88.4 ms |
| one · scroll-today | Watch Today: plan | 32 | 37 ms | 3.0 ms |
| one · scroll-today | Shared rules: built from every log, off the main thread | 2 | 19 ms | 18.8 ms |
| one · scroll-today | Shared rules: habits and settings again | 32 | 18 ms | 2.1 ms |
| one · scroll-today | Shared rules: built from every log | 1 | 16 ms | 16.0 ms |
| one · scroll-today | Watch Today: a row's numbers | 158 | 9 ms | 0.3 ms |
| one · scroll-today | Widgets: the snapshot | 3 | 7 ms | 2.9 ms |
| one · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| one · scroll-today | Count: shared rules' inputs changed: habits | 31 | 0 ms | 0.0 ms |
| one · scroll-today | Count: shared rules given habits and settings again, changed | 32 | 0 ms | 0.0 ms |
| one · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| batch · scroll-today | Store load: read the database | 2 | 1140 ms | 1120.0 ms |
| batch · scroll-today | Widgets: one habit's week | 60 | 103 ms | 27.7 ms |
| batch · scroll-today | Store load: into the app (7320 logs) | 1 | 71 ms | 71.4 ms |
| batch · scroll-today | Watch Today: plan | 32 | 42 ms | 4.7 ms |
| batch · scroll-today | Shared rules: habits and settings again | 32 | 20 ms | 2.2 ms |
| batch · scroll-today | Shared rules: built from every log, off the main thread | 2 | 19 ms | 19.3 ms |
| batch · scroll-today | Watch Today: a row's numbers | 159 | 13 ms | 0.3 ms |
| batch · scroll-today | Widgets: the snapshot | 3 | 5 ms | 2.1 ms |
| batch · scroll-today | Shared rules: built from every log | 1 | 3 ms | 2.9 ms |
| batch · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| batch · scroll-today | Count: shared rules' inputs changed: habits | 31 | 0 ms | 0.0 ms |
| batch · scroll-today | Count: shared rules given habits and settings again, changed | 32 | 0 ms | 0.0 ms |
| batch · scroll-today | Count: a Today row drawn | 159 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 1211 ms | 1109.2 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 119 ms | 59.2 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 80 ms | 80.3 ms |
| swift · scroll-today | Watch Today: plan | 32 | 19 ms | 6.2 ms |
| swift · scroll-today | Watch Today: a row's numbers | 157 | 6 ms | 0.3 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 4 ms | 2.0 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 4 ms | 3.7 ms |
| swift · scroll-today | Count: shared rules' inputs changed: habits | 31 | 0 ms | 0.0 ms |
| swift · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| one · scroll-today | Store load: read the database | 2 | 1356 ms | 1311.2 ms |
| one · scroll-today | Store load: into the app (7320 logs) | 1 | 114 ms | 113.8 ms |
| one · scroll-today | Widgets: one habit's week | 60 | 92 ms | 46.7 ms |
| one · scroll-today | Watch Today: plan | 32 | 46 ms | 4.0 ms |
| one · scroll-today | Shared rules: built from every log, off the main thread | 2 | 33 ms | 32.4 ms |
| one · scroll-today | Shared rules: habits and settings again | 32 | 23 ms | 2.9 ms |
| one · scroll-today | Shared rules: built from every log | 1 | 12 ms | 12.0 ms |
| one · scroll-today | Watch Today: a row's numbers | 157 | 9 ms | 0.5 ms |
| one · scroll-today | Widgets: the snapshot | 3 | 5 ms | 2.8 ms |
| one · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| one · scroll-today | Count: shared rules' inputs changed: habits | 31 | 0 ms | 0.0 ms |
| one · scroll-today | Count: shared rules given habits and settings again, changed | 32 | 0 ms | 0.0 ms |
| one · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| batch · scroll-today | Store load: read the database | 2 | 1168 ms | 1149.6 ms |
| batch · scroll-today | Store load: into the app (7320 logs) | 1 | 78 ms | 78.3 ms |
| batch · scroll-today | Widgets: one habit's week | 60 | 50 ms | 14.9 ms |
| batch · scroll-today | Watch Today: plan | 32 | 46 ms | 7.4 ms |
| batch · scroll-today | Shared rules: built from every log, off the main thread | 2 | 19 ms | 19.1 ms |
| batch · scroll-today | Shared rules: habits and settings again | 32 | 18 ms | 2.6 ms |
| batch · scroll-today | Watch Today: a row's numbers | 156 | 13 ms | 0.2 ms |
| batch · scroll-today | Widgets: the snapshot | 3 | 5 ms | 2.3 ms |
| batch · scroll-today | Shared rules: built from every log | 1 | 4 ms | 4.4 ms |
| batch · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| batch · scroll-today | Count: shared rules' inputs changed: habits | 31 | 0 ms | 0.0 ms |
| batch · scroll-today | Count: shared rules given habits and settings again, changed | 32 | 0 ms | 0.0 ms |
| batch · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 422 ms | 405.7 ms |
| swift · routine | Widgets: one habit's week | 16 | 40 ms | 16.5 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 26 ms | 26.5 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 9 ms | 3.4 ms |
| swift · routine | Watch Today: plan | 16 | 3 ms | 0.6 ms |
| swift · routine | Watch Today: a row's numbers | 61 | 2 ms | 0.9 ms |
| swift · routine | Widgets: the snapshot | 3 | 2 ms | 0.9 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| swift · routine | Count: shared rules' inputs changed: habits | 9 | 0 ms | 0.3 ms |
| swift · routine | Count: a Today row drawn | 61 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| one · routine | Store load: read the database | 2 | 138 ms | 122.3 ms |
| one · routine | Widgets: one habit's week | 8 | 49 ms | 34.0 ms |
| one · routine | Shared rules: built from every log, off the main thread | 2 | 16 ms | 15.5 ms |
| one · routine | Store load: into the app (1716 logs) | 1 | 15 ms | 15.2 ms |
| one · routine | Watch Day details: the dial's words | 58 | 13 ms | 3.0 ms |
| one · routine | Watch Today: plan | 17 | 12 ms | 3.0 ms |
| one · routine | Shared rules: built from every log | 1 | 7 ms | 6.6 ms |
| one · routine | Shared rules: habits and settings again | 10 | 6 ms | 1.7 ms |
| one · routine | Watch Today: a row's numbers | 51 | 2 ms | 0.1 ms |
| one · routine | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| one · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| one · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| one · routine | Count: shared rules given habits and settings again, changed | 10 | 0 ms | 0.0 ms |
| one · routine | Count: shared rules' inputs changed: habits | 9 | 0 ms | 0.0 ms |
| one · routine | Count: a Today row drawn | 51 | 0 ms | 0.0 ms |
| one · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| batch · routine | Store load: read the database | 2 | 299 ms | 287.4 ms |
| batch · routine | Store load: into the app (1716 logs) | 1 | 30 ms | 30.0 ms |
| batch · routine | Widgets: one habit's week | 8 | 29 ms | 16.8 ms |
| batch · routine | Watch Today: plan | 17 | 20 ms | 3.9 ms |
| batch · routine | Shared rules: habits and settings again | 10 | 8 ms | 2.4 ms |
| batch · routine | Shared rules: built from every log | 1 | 4 ms | 4.3 ms |
| batch · routine | Shared rules: built from every log, off the main thread | 2 | 4 ms | 3.6 ms |
| batch · routine | Watch Day details: the dial's words | 2 | 3 ms | 2.4 ms |
| batch · routine | Watch Today: a row's numbers | 19 | 1 ms | 0.2 ms |
| batch · routine | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| batch · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| batch · routine | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| batch · routine | Count: shared rules' inputs changed: habits | 9 | 0 ms | 0.0 ms |
| batch · routine | Count: shared rules given habits and settings again, changed | 10 | 0 ms | 0.0 ms |
| batch · routine | Count: a Today row drawn | 19 | 0 ms | 0.0 ms |
| batch · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 209 ms | 197.2 ms |
| swift · routine | Widgets: one habit's week | 8 | 25 ms | 17.4 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 16 ms | 15.6 ms |
| swift · routine | Watch Today: plan | 17 | 3 ms | 0.8 ms |
| swift · routine | Watch Day details: the dial's words | 2 | 2 ms | 1.7 ms |
| swift · routine | Watch Today: a row's numbers | 22 | 1 ms | 0.8 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| swift · routine | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| swift · routine | Count: a Today row drawn | 22 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| one · routine | Store load: read the database | 2 | 145 ms | 126.7 ms |
| one · routine | Widgets: one habit's week | 8 | 45 ms | 24.0 ms |
| one · routine | Store load: into the app (1716 logs) | 1 | 30 ms | 30.1 ms |
| one · routine | Watch Today: plan | 17 | 13 ms | 2.5 ms |
| one · routine | Shared rules: built from every log | 1 | 6 ms | 6.4 ms |
| one · routine | Shared rules: habits and settings again | 10 | 6 ms | 1.5 ms |
| one · routine | Shared rules: built from every log, off the main thread | 2 | 3 ms | 2.8 ms |
| one · routine | Watch Today: a row's numbers | 9 | 2 ms | 1.8 ms |
| one · routine | Watch Day details: the dial's words | 2 | 2 ms | 1.6 ms |
| one · routine | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| one · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| one · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| one · routine | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| one · routine | Count: shared rules given habits and settings again, changed | 10 | 0 ms | 0.0 ms |
| one · routine | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| one · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| batch · routine | Store load: read the database | 2 | 208 ms | 196.2 ms |
| batch · routine | Store load: into the app (1716 logs) | 1 | 24 ms | 23.9 ms |
| batch · routine | Widgets: one habit's week | 8 | 18 ms | 9.5 ms |
| batch · routine | Watch Today: plan | 17 | 10 ms | 2.5 ms |
| batch · routine | Shared rules: built from every log, off the main thread | 2 | 7 ms | 7.1 ms |
| batch · routine | Shared rules: habits and settings again | 10 | 5 ms | 1.5 ms |
| batch · routine | Shared rules: built from every log | 1 | 4 ms | 4.4 ms |
| batch · routine | Watch Day details: the dial's words | 2 | 1 ms | 1.3 ms |
| batch · routine | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| batch · routine | Watch Today: a row's numbers | 19 | 1 ms | 0.1 ms |
| batch · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| batch · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| batch · routine | Count: shared rules' inputs changed: habits | 9 | 0 ms | 0.0 ms |
| batch · routine | Count: shared rules given habits and settings again, changed | 10 | 0 ms | 0.0 ms |
| batch · routine | Count: a Today row drawn | 19 | 0 ms | 0.0 ms |
| batch · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 265 ms | 246.4 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 25 ms | 25.4 ms |
| swift · routine | Widgets: one habit's week | 16 | 25 ms | 12.7 ms |
| swift · routine | Watch Today: plan | 17 | 4 ms | 0.9 ms |
| swift · routine | Watch Day details: the dial's words | 2 | 2 ms | 1.4 ms |
| swift · routine | Widgets: the snapshot | 3 | 1 ms | 0.3 ms |
| swift · routine | Watch Today: a row's numbers | 23 | 1 ms | 0.1 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · routine | Count: shared rules' inputs changed: habits | 9 | 0 ms | 0.0 ms |
| swift · routine | Count: a Today row drawn | 23 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| one · routine | Store load: read the database | 2 | 172 ms | 159.0 ms |
| one · routine | Widgets: one habit's week | 8 | 18 ms | 10.7 ms |
| one · routine | Store load: into the app (1716 logs) | 1 | 16 ms | 15.6 ms |
| one · routine | Watch Day details: the dial's words | 61 | 8 ms | 1.0 ms |
| one · routine | Watch Today: plan | 17 | 8 ms | 1.0 ms |
| one · routine | Shared rules: habits and settings again | 10 | 4 ms | 1.2 ms |
| one · routine | Shared rules: built from every log | 1 | 3 ms | 2.9 ms |
| one · routine | Shared rules: built from every log, off the main thread | 2 | 3 ms | 2.5 ms |
| one · routine | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| one · routine | Watch Today: a row's numbers | 20 | 1 ms | 0.1 ms |
| one · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| one · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| one · routine | Count: shared rules' inputs changed: habits | 9 | 0 ms | 0.0 ms |
| one · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| one · routine | Count: shared rules given habits and settings again, changed | 10 | 0 ms | 0.0 ms |
| one · routine | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| batch · routine | Store load: read the database | 2 | 135 ms | 127.5 ms |
| batch · routine | Widgets: one habit's week | 8 | 19 ms | 11.2 ms |
| batch · routine | Store load: into the app (1716 logs) | 1 | 16 ms | 15.9 ms |
| batch · routine | Watch Today: plan | 17 | 8 ms | 0.9 ms |
| batch · routine | Shared rules: habits and settings again | 10 | 4 ms | 1.1 ms |
| batch · routine | Shared rules: built from every log, off the main thread | 2 | 3 ms | 2.8 ms |
| batch · routine | Shared rules: built from every log | 1 | 3 ms | 2.6 ms |
| batch · routine | Watch Day details: the dial's words | 2 | 1 ms | 1.2 ms |
| batch · routine | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| batch · routine | Watch Today: a row's numbers | 19 | 1 ms | 0.1 ms |
| batch · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| batch · routine | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| batch · routine | Count: shared rules given habits and settings again, changed | 10 | 0 ms | 0.0 ms |
| batch · routine | Count: shared rules' inputs changed: habits | 9 | 0 ms | 0.0 ms |
| batch · routine | Count: a Today row drawn | 19 | 0 ms | 0.0 ms |
| batch · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 162 ms | 155.8 ms |
| swift · routine | Widgets: one habit's week | 8 | 17 ms | 10.4 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 16 ms | 15.5 ms |
| swift · routine | Watch Today: plan | 17 | 3 ms | 0.9 ms |
| swift · routine | Watch Day details: the dial's words | 2 | 1 ms | 1.1 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · routine | Watch Today: a row's numbers | 10 | 0 ms | 0.0 ms |
| swift · routine | Count: shared rules' inputs changed: habits | 9 | 0 ms | 0.0 ms |
| swift · routine | Count: a Today row drawn | 10 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| one · routine | Store load: read the database | 2 | 178 ms | 169.0 ms |
| one · routine | Store load: into the app (1716 logs) | 1 | 27 ms | 27.2 ms |
| one · routine | Widgets: one habit's week | 16 | 24 ms | 11.5 ms |
| one · routine | Shared rules: built from every log, off the main thread | 2 | 16 ms | 16.2 ms |
| one · routine | Watch Today: plan | 17 | 6 ms | 0.6 ms |
| one · routine | Shared rules: habits and settings again | 10 | 3 ms | 1.1 ms |
| one · routine | Shared rules: built from every log | 1 | 3 ms | 2.5 ms |
| one · routine | Watch Today: a row's numbers | 53 | 2 ms | 0.4 ms |
| one · routine | Watch Day details: the dial's words | 7 | 2 ms | 1.5 ms |
| one · routine | Widgets: the snapshot | 3 | 1 ms | 0.5 ms |
| one · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| one · routine | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| one · routine | Count: shared rules given habits and settings again, changed | 10 | 0 ms | 0.0 ms |
| one · routine | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| one · routine | Count: a Today row drawn | 53 | 0 ms | 0.0 ms |
| one · routine | Count: a routine page drawn | 7 | 0 ms | 0.0 ms |
| batch · routine | Store load: read the database | 2 | 232 ms | 204.2 ms |
| batch · routine | Widgets: one habit's week | 16 | 34 ms | 17.2 ms |
| batch · routine | Store load: into the app (1716 logs) | 1 | 17 ms | 16.6 ms |
| batch · routine | Watch Today: plan | 17 | 8 ms | 0.9 ms |
| batch · routine | Shared rules: habits and settings again | 10 | 4 ms | 1.6 ms |
| batch · routine | Shared rules: built from every log | 1 | 3 ms | 3.3 ms |
| batch · routine | Shared rules: built from every log, off the main thread | 2 | 3 ms | 2.6 ms |
| batch · routine | Widgets: the snapshot | 3 | 2 ms | 1.0 ms |
| batch · routine | Watch Day details: the dial's words | 2 | 2 ms | 2.1 ms |
| batch · routine | Watch Today: a row's numbers | 23 | 1 ms | 0.1 ms |
| batch · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| batch · routine | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| batch · routine | Count: shared rules given habits and settings again, changed | 10 | 0 ms | 0.0 ms |
| batch · routine | Count: shared rules' inputs changed: habits | 9 | 0 ms | 0.0 ms |
| batch · routine | Count: a Today row drawn | 23 | 0 ms | 0.0 ms |
| batch · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 20 ms | 11.8 ms |
| swift · launch | Store load: read the database | 1 | 7 ms | 7.1 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Watch Today: a row's numbers | 16 | 0 ms | 0.0 ms |
| swift · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| one · launch | Widgets: one habit's week | 8 | 20 ms | 11.1 ms |
| one · launch | Store load: read the database | 1 | 7 ms | 7.1 ms |
| one · launch | Watch Today: plan | 9 | 4 ms | 0.6 ms |
| one · launch | Shared rules: habits and settings again | 9 | 3 ms | 1.1 ms |
| one · launch | Widgets: the snapshot | 2 | 3 ms | 2.1 ms |
| one · launch | Shared rules: built from every log | 1 | 2 ms | 2.4 ms |
| one · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| one · launch | Watch Today: a row's numbers | 5 | 0 ms | 0.1 ms |
| one · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| one · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| one · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| one · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| one · launch | Count: a Today row drawn | 5 | 0 ms | 0.0 ms |
| batch · launch | Widgets: one habit's week | 8 | 21 ms | 11.9 ms |
| batch · launch | Store load: read the database | 1 | 8 ms | 7.5 ms |
| batch · launch | Watch Today: plan | 9 | 4 ms | 0.6 ms |
| batch · launch | Shared rules: habits and settings again | 9 | 3 ms | 1.3 ms |
| batch · launch | Shared rules: built from every log | 1 | 3 ms | 2.6 ms |
| batch · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| batch · launch | Watch Today: a row's numbers | 16 | 1 ms | 0.1 ms |
| batch · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| batch · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| batch · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| batch · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| batch · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| batch · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 21 ms | 12.8 ms |
| swift · launch | Store load: read the database | 1 | 11 ms | 11.0 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Watch Today: a row's numbers | 16 | 0 ms | 0.1 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| one · launch | Widgets: one habit's week | 8 | 21 ms | 12.2 ms |
| one · launch | Store load: read the database | 1 | 6 ms | 6.4 ms |
| one · launch | Watch Today: plan | 9 | 4 ms | 0.7 ms |
| one · launch | Shared rules: habits and settings again | 9 | 3 ms | 1.0 ms |
| one · launch | Shared rules: built from every log | 1 | 2 ms | 2.2 ms |
| one · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| one · launch | Watch Today: a row's numbers | 16 | 0 ms | 0.0 ms |
| one · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| one · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| one · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| one · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| one · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| one · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| batch · launch | Widgets: one habit's week | 8 | 20 ms | 11.8 ms |
| batch · launch | Store load: read the database | 1 | 20 ms | 19.7 ms |
| batch · launch | Watch Today: plan | 9 | 6 ms | 1.2 ms |
| batch · launch | Shared rules: habits and settings again | 9 | 4 ms | 1.8 ms |
| batch · launch | Shared rules: built from every log | 1 | 3 ms | 3.4 ms |
| batch · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| batch · launch | Watch Today: a row's numbers | 16 | 1 ms | 0.1 ms |
| batch · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| batch · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| batch · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| batch · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| batch · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| batch · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 20 ms | 11.9 ms |
| swift · launch | Store load: read the database | 1 | 13 ms | 13.1 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Watch Today: a row's numbers | 16 | 0 ms | 0.0 ms |
| swift · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| one · launch | Widgets: one habit's week | 8 | 20 ms | 11.0 ms |
| one · launch | Store load: read the database | 1 | 8 ms | 8.3 ms |
| one · launch | Watch Today: plan | 9 | 4 ms | 0.7 ms |
| one · launch | Shared rules: habits and settings again | 9 | 4 ms | 1.9 ms |
| one · launch | Shared rules: built from every log | 1 | 3 ms | 3.2 ms |
| one · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| one · launch | Watch Today: a row's numbers | 16 | 0 ms | 0.1 ms |
| one · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| one · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| one · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| one · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| one · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| one · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| batch · launch | Widgets: one habit's week | 8 | 19 ms | 10.9 ms |
| batch · launch | Store load: read the database | 1 | 11 ms | 11.2 ms |
| batch · launch | Watch Today: plan | 9 | 5 ms | 0.9 ms |
| batch · launch | Shared rules: habits and settings again | 9 | 3 ms | 1.2 ms |
| batch · launch | Shared rules: built from every log | 1 | 3 ms | 2.6 ms |
| batch · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| batch · launch | Watch Today: a row's numbers | 16 | 1 ms | 0.1 ms |
| batch · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| batch · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| batch · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| batch · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| batch · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| batch · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 19 ms | 11.5 ms |
| swift · launch | Store load: read the database | 1 | 6 ms | 5.8 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.1 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Watch Today: a row's numbers | 15 | 0 ms | 0.0 ms |
| swift · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| one · launch | Widgets: one habit's week | 8 | 23 ms | 14.2 ms |
| one · launch | Store load: read the database | 1 | 7 ms | 7.0 ms |
| one · launch | Watch Today: plan | 9 | 4 ms | 0.8 ms |
| one · launch | Shared rules: habits and settings again | 9 | 3 ms | 1.2 ms |
| one · launch | Shared rules: built from every log | 1 | 2 ms | 2.5 ms |
| one · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| one · launch | Watch Today: a row's numbers | 16 | 1 ms | 0.1 ms |
| one · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| one · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| one · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| one · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| one · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| one · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| batch · launch | Widgets: one habit's week | 8 | 21 ms | 12.2 ms |
| batch · launch | Store load: read the database | 1 | 10 ms | 9.9 ms |
| batch · launch | Watch Today: plan | 9 | 4 ms | 0.7 ms |
| batch · launch | Shared rules: habits and settings again | 9 | 3 ms | 1.2 ms |
| batch · launch | Shared rules: built from every log | 1 | 3 ms | 2.5 ms |
| batch · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| batch · launch | Watch Today: a row's numbers | 15 | 1 ms | 0.1 ms |
| batch · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| batch · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| batch · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| batch · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| batch · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| batch · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 28 ms | 14.3 ms |
| swift · launch | Store load: read the database | 1 | 7 ms | 7.2 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Watch Today: a row's numbers | 16 | 0 ms | 0.0 ms |
| swift · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| one · launch | Widgets: one habit's week | 8 | 20 ms | 12.1 ms |
| one · launch | Store load: read the database | 1 | 20 ms | 20.2 ms |
| one · launch | Watch Today: plan | 9 | 4 ms | 0.6 ms |
| one · launch | Shared rules: habits and settings again | 9 | 3 ms | 1.2 ms |
| one · launch | Shared rules: built from every log | 1 | 2 ms | 2.5 ms |
| one · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| one · launch | Watch Today: a row's numbers | 16 | 0 ms | 0.1 ms |
| one · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| one · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| one · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| one · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| one · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| one · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| batch · launch | Widgets: one habit's week | 8 | 34 ms | 20.3 ms |
| batch · launch | Store load: read the database | 1 | 19 ms | 19.1 ms |
| batch · launch | Watch Today: plan | 9 | 6 ms | 1.8 ms |
| batch · launch | Shared rules: habits and settings again | 9 | 4 ms | 1.3 ms |
| batch · launch | Shared rules: built from every log | 1 | 3 ms | 2.7 ms |
| batch · launch | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| batch · launch | Watch Today: a row's numbers | 15 | 1 ms | 0.1 ms |
| batch · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| batch · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| batch · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| batch · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| batch · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| batch · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 19 ms | 10.5 ms |
| swift · launch | Store load: read the database | 1 | 10 ms | 10.4 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Watch Today: a row's numbers | 15 | 0 ms | 0.0 ms |
| swift · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| one · launch | Widgets: one habit's week | 8 | 21 ms | 12.3 ms |
| one · launch | Store load: read the database | 1 | 10 ms | 10.5 ms |
| one · launch | Watch Today: plan | 9 | 4 ms | 0.7 ms |
| one · launch | Shared rules: habits and settings again | 9 | 3 ms | 1.1 ms |
| one · launch | Shared rules: built from every log | 1 | 3 ms | 2.6 ms |
| one · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| one · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| one · launch | Watch Today: a row's numbers | 15 | 0 ms | 0.1 ms |
| one · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.2 ms |
| one · launch | Shared rules: a log added | 8 | 0 ms | 0.0 ms |
| one · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| one · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| one · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| batch · launch | Widgets: one habit's week | 8 | 16 ms | 9.2 ms |
| batch · launch | Store load: read the database | 1 | 9 ms | 9.2 ms |
| batch · launch | Watch Today: plan | 9 | 5 ms | 0.7 ms |
| batch · launch | Shared rules: habits and settings again | 9 | 3 ms | 1.1 ms |
| batch · launch | Shared rules: built from every log | 1 | 2 ms | 2.1 ms |
| batch · launch | Widgets: the snapshot | 2 | 2 ms | 1.0 ms |
| batch · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| batch · launch | Watch Today: a row's numbers | 4 | 0 ms | 0.1 ms |
| batch · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| batch · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| batch · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| batch · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| batch · launch | Count: a Today row drawn | 4 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 21 ms | 13.1 ms |
| swift · launch | Store load: read the database | 1 | 7 ms | 6.6 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 1.0 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Watch Today: a row's numbers | 15 | 0 ms | 0.0 ms |
| swift · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| one · launch | Store load: read the database | 1 | 16 ms | 15.6 ms |
| one · launch | Widgets: one habit's week | 8 | 15 ms | 8.1 ms |
| one · launch | Watch Today: plan | 9 | 5 ms | 1.0 ms |
| one · launch | Shared rules: habits and settings again | 9 | 4 ms | 1.6 ms |
| one · launch | Shared rules: built from every log | 1 | 3 ms | 3.5 ms |
| one · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| one · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| one · launch | Watch Today: a row's numbers | 16 | 1 ms | 0.1 ms |
| one · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| one · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| one · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| one · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| one · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| batch · launch | Widgets: one habit's week | 8 | 23 ms | 13.4 ms |
| batch · launch | Store load: read the database | 1 | 8 ms | 7.5 ms |
| batch · launch | Watch Today: plan | 9 | 5 ms | 0.8 ms |
| batch · launch | Shared rules: habits and settings again | 9 | 3 ms | 1.0 ms |
| batch · launch | Shared rules: built from every log | 1 | 2 ms | 2.2 ms |
| batch · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| batch · launch | Watch Today: a row's numbers | 5 | 0 ms | 0.1 ms |
| batch · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| batch · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| batch · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| batch · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| batch · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| batch · launch | Count: a Today row drawn | 5 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 26 ms | 15.3 ms |
| swift · launch | Store load: read the database | 1 | 6 ms | 6.0 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| swift · launch | Watch Today: a row's numbers | 6 | 0 ms | 0.0 ms |
| swift · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| swift · launch | Count: a Today row drawn | 6 | 0 ms | 0.0 ms |
| one · launch | Widgets: one habit's week | 8 | 28 ms | 14.6 ms |
| one · launch | Store load: read the database | 1 | 7 ms | 6.8 ms |
| one · launch | Watch Today: plan | 9 | 5 ms | 0.7 ms |
| one · launch | Shared rules: habits and settings again | 9 | 3 ms | 0.9 ms |
| one · launch | Shared rules: built from every log | 1 | 2 ms | 2.3 ms |
| one · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| one · launch | Shared rules: a log added | 8 | 0 ms | 0.2 ms |
| one · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| one · launch | Watch Today: a row's numbers | 4 | 0 ms | 0.0 ms |
| one · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.1 ms |
| one · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| one · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| one · launch | Count: a Today row drawn | 4 | 0 ms | 0.0 ms |
| batch · launch | Widgets: one habit's week | 8 | 20 ms | 11.0 ms |
| batch · launch | Store load: read the database | 1 | 19 ms | 19.5 ms |
| batch · launch | Watch Today: plan | 9 | 7 ms | 1.4 ms |
| batch · launch | Shared rules: habits and settings again | 9 | 5 ms | 2.2 ms |
| batch · launch | Shared rules: built from every log | 1 | 4 ms | 4.2 ms |
| batch · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| batch · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| batch · launch | Watch Today: a row's numbers | 5 | 0 ms | 0.1 ms |
| batch · launch | Shared rules: built from every log, off the main thread | 1 | 0 ms | 0.3 ms |
| batch · launch | Shared rules: a log added | 8 | 0 ms | 0.1 ms |
| batch · launch | Count: shared rules' inputs changed: habits | 8 | 0 ms | 0.0 ms |
| batch · launch | Count: shared rules given habits and settings again, changed | 9 | 0 ms | 0.0 ms |
| batch · launch | Count: a Today row drawn | 5 | 0 ms | 0.0 ms |

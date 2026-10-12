# Watch: claude/shared-habit-rules-wperf2 @ 147c257

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38245304902 · 2026-10-12 12:17 UTC
Commit: Watch speed, shared rules against the Swift rules, side by side (part 2) [watch-perf]

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
| shared · Today: scrolling 30 habits | 5.3 | 37 ms | 0 |
| swift · Today: scrolling 30 habits | 8.6 | 48 ms | 0 |
| shared · Today: scrolling 30 habits | 13.0 | 94 ms | 0 |
| swift · Today: scrolling 30 habits | 5.2 | 48 ms | 0 |
| shared · Today: scrolling 30 habits | 4.0 | 42 ms | 0 |
| swift · Today: scrolling 30 habits | 0.0 | 0 ms | 0 |
| shared · Today: scrolling 30 habits | 5.1 | 64 ms | 0 |
| swift · Today: scrolling 30 habits | 2.3 | 44 ms | 0 |
| shared · Routine: paging with the Crown | 4.5 | 40 ms | 0 |
| swift · Routine: paging with the Crown | 0.0 | 0 ms | 0 |
| shared · Routine: paging with the Crown | 21.2 | 61 ms | 0 |
| swift · Routine: paging with the Crown | 5.5 | 37 ms | 0 |
| shared · Routine: paging with the Crown | 12.6 | 37 ms | 0 |
| swift · Routine: paging with the Crown | 4.4 | 33 ms | 0 |
| shared · Routine: paging with the Crown | 1.9 | 26 ms | 0 |
| swift · Routine: paging with the Crown | 4.1 | 42 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- shared · Launch to a usable Today (round 1 , cold): 2548 ms
- swift · Launch to a usable Today (round 1 , cold): 2136 ms
- shared · Launch to a usable Today (round 2, warm): 1778 ms
- swift · Launch to a usable Today (round 2, warm): 1352 ms
- shared · Launch to a usable Today (round 3, warm): 1286 ms
- swift · Launch to a usable Today (round 3, warm): 1883 ms
- shared · Launch to a usable Today (round 4, warm): 1250 ms
- swift · Launch to a usable Today (round 4, warm): 1100 ms
- shared · Launch to a usable Today (round 5, warm): 1261 ms
- swift · Launch to a usable Today (round 5, warm): 942 ms
- shared · Launch to a usable Today (round 6, warm): 1278 ms
- swift · Launch to a usable Today (round 6, warm): 1929 ms
- shared · Launch to a usable Today (round 7, warm): 1598 ms
- swift · Launch to a usable Today (round 7, warm): 2435 ms
- shared · Launch to a usable Today (round 8, warm): 1430 ms
- swift · Launch to a usable Today (round 8, warm): 3620 ms
- shared · Blank cover (control, first): longest stall 217 ms
- shared · Blank cover (control, again): longest stall 60 ms
- shared · Routine (open): longest stall 378 ms
- swift · Blank cover (control, first): longest stall 184 ms
- swift · Blank cover (control, again): longest stall 61 ms
- swift · Routine (open): longest stall 237 ms
- shared · Blank cover (control, first): longest stall 188 ms
- shared · Blank cover (control, again): longest stall 89 ms
- shared · Routine (open): longest stall 514 ms
- swift · Blank cover (control, first): longest stall 205 ms
- swift · Blank cover (control, again): longest stall 48 ms
- swift · Routine (open): longest stall 363 ms
- shared · Blank cover (control, first): longest stall 106 ms
- shared · Blank cover (control, again): longest stall 68 ms
- shared · Routine (open): longest stall 256 ms
- swift · Blank cover (control, first): longest stall 173 ms
- swift · Blank cover (control, again): longest stall 70 ms
- swift · Routine (open): longest stall 254 ms
- shared · Blank cover (control, first): longest stall 169 ms
- shared · Blank cover (control, again): longest stall 49 ms
- shared · Routine (open): longest stall 250 ms
- swift · Blank cover (control, first): longest stall 101 ms
- swift · Blank cover (control, again): longest stall 50 ms
- swift · Routine (open): longest stall 250 ms

Notes (storage and the first fill):


Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| shared · launch | Store load: read the database | 1 | 74 ms | 74.4 ms |
| shared · launch | Widgets: one habit's week | 8 | 44 ms | 21.0 ms |
| shared · launch | Watch Today: plan | 9 | 10 ms | 3.5 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 2 ms | 1.8 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| shared · launch | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 31 ms | 20.1 ms |
| swift · launch | Store load: read the database | 1 | 17 ms | 16.8 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 35 ms | 19.5 ms |
| shared · launch | Store load: read the database | 1 | 11 ms | 11.4 ms |
| shared · launch | Watch Today: plan | 9 | 4 ms | 1.7 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| shared · launch | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 32 ms | 19.0 ms |
| swift · launch | Store load: read the database | 1 | 12 ms | 12.1 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.8 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.3 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 31 ms | 12.3 ms |
| shared · launch | Store load: read the database | 1 | 13 ms | 13.2 ms |
| shared · launch | Watch Today: plan | 9 | 4 ms | 0.8 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| shared · launch | Count: a Today row drawn | 22 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 43 ms | 33.4 ms |
| swift · launch | Store load: read the database | 1 | 7 ms | 7.0 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 34 ms | 12.9 ms |
| shared · launch | Store load: read the database | 1 | 18 ms | 18.3 ms |
| shared · launch | Watch Today: plan | 9 | 7 ms | 3.8 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 23 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 35 ms | 20.9 ms |
| swift · launch | Store load: read the database | 1 | 7 ms | 6.7 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 36 ms | 18.2 ms |
| shared · launch | Store load: read the database | 1 | 7 ms | 6.9 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 1.0 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.4 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| shared · launch | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 45 ms | 35.2 ms |
| swift · launch | Store load: read the database | 1 | 13 ms | 13.5 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.4 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 36 ms | 18.1 ms |
| shared · launch | Store load: read the database | 1 | 11 ms | 11.0 ms |
| shared · launch | Watch Today: plan | 9 | 5 ms | 1.1 ms |
| shared · launch | Widgets: the snapshot | 2 | 2 ms | 1.2 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| shared · launch | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 43 ms | 25.4 ms |
| swift · launch | Store load: read the database | 1 | 12 ms | 11.9 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.5 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 1.0 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 29 ms | 15.2 ms |
| shared · launch | Store load: read the database | 1 | 11 ms | 11.3 ms |
| shared · launch | Watch Today: plan | 9 | 4 ms | 1.2 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 35 ms | 19.2 ms |
| swift · launch | Store load: read the database | 1 | 5 ms | 5.4 ms |
| swift · launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.9 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| swift · launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| shared · launch | Widgets: one habit's week | 8 | 51 ms | 27.6 ms |
| shared · launch | Store load: read the database | 1 | 13 ms | 12.8 ms |
| shared · launch | Watch Today: plan | 9 | 7 ms | 1.9 ms |
| shared · launch | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| shared · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · launch | Count: a Today row drawn | 22 | 0 ms | 0.0 ms |
| swift · launch | Widgets: one habit's week | 8 | 24 ms | 15.5 ms |
| swift · launch | Store load: read the database | 1 | 21 ms | 20.7 ms |
| swift · launch | Watch Today: plan | 9 | 2 ms | 0.7 ms |
| swift · launch | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| swift · launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 1207 ms | 1176.6 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 335 ms | 165.6 ms |
| shared · scroll-today | Watch Today: plan | 32 | 99 ms | 59.9 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 87 ms | 86.7 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 6 ms | 2.8 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · scroll-today | Count: a Today row drawn | 191 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 838 ms | 817.8 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 109 ms | 108.6 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 71 ms | 28.4 ms |
| swift · scroll-today | Watch Today: plan | 32 | 17 ms | 7.3 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 4 ms | 2.1 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| swift · scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 937 ms | 898.0 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 249 ms | 30.2 ms |
| shared · scroll-today | Watch Today: plan | 32 | 117 ms | 74.8 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 106 ms | 105.8 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 7 ms | 3.4 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 1.4 ms |
| shared · scroll-today | Count: a Today row drawn | 186 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 527 ms | 511.6 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 86 ms | 24.2 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 73 ms | 73.2 ms |
| swift · scroll-today | Watch Today: plan | 32 | 16 ms | 5.4 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 6 ms | 3.2 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 1.4 ms |
| swift · scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 942 ms | 916.0 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 188 ms | 27.1 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 105 ms | 105.4 ms |
| shared · scroll-today | Watch Today: plan | 32 | 40 ms | 5.1 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 6 ms | 2.5 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| shared · scroll-today | Count: a Today row drawn | 189 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 494 ms | 485.0 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 66 ms | 65.8 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 62 ms | 20.8 ms |
| swift · scroll-today | Watch Today: plan | 32 | 13 ms | 5.4 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 5 ms | 1.9 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| swift · scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| shared · scroll-today | Store load: read the database | 2 | 375 ms | 345.8 ms |
| shared · scroll-today | Widgets: one habit's week | 60 | 112 ms | 17.4 ms |
| shared · scroll-today | Store load: into the app (7320 logs) | 1 | 87 ms | 87.3 ms |
| shared · scroll-today | Watch Today: plan | 32 | 33 ms | 5.2 ms |
| shared · scroll-today | Widgets: the snapshot | 3 | 6 ms | 2.7 ms |
| shared · scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · scroll-today | Count: a Today row drawn | 181 | 0 ms | 0.0 ms |
| swift · scroll-today | Store load: read the database | 2 | 638 ms | 624.3 ms |
| swift · scroll-today | Store load: into the app (7320 logs) | 1 | 85 ms | 84.9 ms |
| swift · scroll-today | Widgets: one habit's week | 60 | 59 ms | 11.3 ms |
| swift · scroll-today | Watch Today: plan | 32 | 13 ms | 4.0 ms |
| swift · scroll-today | Widgets: the snapshot | 3 | 4 ms | 2.4 ms |
| swift · scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 1.1 ms |
| swift · scroll-today | Count: a Today row drawn | 100 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 104 ms | 91.6 ms |
| shared · routine | Widgets: one habit's week | 8 | 38 ms | 16.9 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 16 ms | 16.1 ms |
| shared · routine | Watch Today: plan | 17 | 10 ms | 1.4 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 6 ms | 5.0 ms |
| shared · routine | Widgets: the snapshot | 2 | 1 ms | 1.0 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| shared · routine | Count: a Today row drawn | 23 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 318 ms | 307.3 ms |
| swift · routine | Widgets: one habit's week | 16 | 38 ms | 20.4 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 24 ms | 23.9 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 6 ms | 1.5 ms |
| swift · routine | Watch Today: plan | 17 | 5 ms | 2.0 ms |
| swift · routine | Widgets: the snapshot | 3 | 2 ms | 0.9 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| swift · routine | Count: a Today row drawn | 50 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 197 ms | 185.9 ms |
| shared · routine | Widgets: one habit's week | 8 | 40 ms | 22.4 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 33 ms | 33.1 ms |
| shared · routine | Watch Today: plan | 17 | 15 ms | 1.7 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 12 ms | 12.2 ms |
| shared · routine | Widgets: the snapshot | 2 | 2 ms | 1.2 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| shared · routine | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 172 ms | 160.3 ms |
| swift · routine | Widgets: one habit's week | 8 | 45 ms | 31.9 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 20 ms | 20.0 ms |
| swift · routine | Watch Day details: the dial's words | 61 | 9 ms | 1.5 ms |
| swift · routine | Watch Today: plan | 16 | 4 ms | 0.5 ms |
| swift · routine | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| swift · routine | Count: a Today row drawn | 21 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 474 ms | 453.9 ms |
| shared · routine | Widgets: one habit's week | 16 | 64 ms | 15.4 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 34 ms | 34.0 ms |
| shared · routine | Watch Day details: the dial's words | 61 | 12 ms | 2.1 ms |
| shared · routine | Watch Today: plan | 16 | 10 ms | 2.1 ms |
| shared · routine | Widgets: the snapshot | 3 | 2 ms | 0.8 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| shared · routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| shared · routine | Count: a Today row drawn | 53 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 504 ms | 492.2 ms |
| swift · routine | Widgets: one habit's week | 16 | 39 ms | 21.0 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 19 ms | 18.9 ms |
| swift · routine | Watch Day details: the dial's words | 34 | 5 ms | 1.2 ms |
| swift · routine | Watch Today: plan | 17 | 4 ms | 1.0 ms |
| swift · routine | Widgets: the snapshot | 3 | 1 ms | 0.7 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| swift · routine | Count: a Today row drawn | 46 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 37 | 0 ms | 0.0 ms |
| shared · routine | Store load: read the database | 2 | 144 ms | 126.8 ms |
| shared · routine | Widgets: one habit's week | 8 | 58 ms | 24.9 ms |
| shared · routine | Store load: into the app (1716 logs) | 1 | 26 ms | 25.9 ms |
| shared · routine | Watch Today: plan | 17 | 11 ms | 1.2 ms |
| shared · routine | Watch Day details: the dial's words | 2 | 3 ms | 2.9 ms |
| shared · routine | Widgets: the snapshot | 2 | 2 ms | 1.4 ms |
| shared · routine | Store load: into the app (0 logs) | 1 | 1 ms | 0.6 ms |
| shared · routine | Count: a Today row drawn | 28 | 0 ms | 0.0 ms |
| shared · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| swift · routine | Store load: read the database | 2 | 148 ms | 142.6 ms |
| swift · routine | Widgets: one habit's week | 8 | 28 ms | 18.4 ms |
| swift · routine | Store load: into the app (1716 logs) | 1 | 19 ms | 19.2 ms |
| swift · routine | Watch Today: plan | 17 | 4 ms | 1.1 ms |
| swift · routine | Watch Day details: the dial's words | 2 | 2 ms | 2.3 ms |
| swift · routine | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| swift · routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| swift · routine | Count: a Today row drawn | 9 | 0 ms | 0.0 ms |
| swift · routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |

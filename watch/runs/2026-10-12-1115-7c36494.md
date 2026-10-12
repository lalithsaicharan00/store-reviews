# Watch: claude/shared-habit-rules-ci14 @ 7c36494

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38236472525 · 2026-10-12 11:15 UTC
Commit: Current Work 92: Watch speed on the shared rules (scratch, safe to delete) [watch-perf]

- Core tests: skipped
- Watch build: success
- iPhone build with the Watch app: skipped
- Watch UI tests (none): skipped
- Screenshots: skipped
- Speed: success
- Paired simulators: skipped

## Speed

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms |
|---|---|---|---|
| Today: +1 (tap to filled button) | 11.6 | 91 ms | 0 |
| Today: ✓ and Undo | 11.1 | 51 ms | 0 |
| Today: scrolling 30 habits | 10.5 | 48 ms | 0 |
| Day details: +1 | 38.4 | 65 ms | 0 |
| Log manually: turning the Crown | 16.0 | 186 ms | 1 |
| Routine: paging with the Crown | 10.0 | 50 ms | 0 |
| Today: a 5,000-change batch from the iPhone arrives | 6.8 | 145 ms | 1 |
| Writing the complication snapshot (10 times) | 0.0 | 0 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- Launch to a usable Today (round 1 , cold): 2920 ms
- Launch to a usable Today (round 2, warm): 3441 ms
- Blank page (control, first): longest stall 264 ms
- Blank page (control, again): longest stall 82 ms
- Day details (first): longest stall 170 ms
- Day details (again): longest stall 84 ms
- Log manually: longest stall 266 ms
- Blank cover (control, first): longest stall 203 ms
- Blank cover (control, again): longest stall 42 ms
- Routine (open): longest stall 273 ms

Notes (storage and the first fill):

- first fill on the Watch simulator: 375000 logs (15 years) in 76 parts, biggest 210 KB, 15.3 MB sent; 1135.3 s (Today right after 22.9 s; the stand-in iPhone made it in 547.2 s); Watch database 224 MB; reading it all 27.47 s (375000 logs); reading the Watch's 400 days for Today 2.25 s (27268 logs); peak memory 180 MB

Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| launch | Widgets: one habit's week | 8 | 198 ms | 150.2 ms |
| launch | Store load: read the database | 1 | 89 ms | 89.2 ms |
| launch | Watch Today: plan | 9 | 12 ms | 6.5 ms |
| launch | Store load: into the app (0 logs) | 1 | 3 ms | 3.3 ms |
| launch | Widgets: the snapshot | 2 | 3 ms | 2.0 ms |
| launch | Count: a Today row drawn | 22 | 0 ms | 0.0 ms |
| launch | Widgets: one habit's week | 8 | 67 ms | 46.2 ms |
| launch | Store load: read the database | 1 | 30 ms | 30.0 ms |
| launch | Watch Today: plan | 9 | 9 ms | 3.1 ms |
| launch | Widgets: the snapshot | 2 | 2 ms | 1.0 ms |
| launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| launch | Count: a Today row drawn | 24 | 0 ms | 0.0 ms |
| tap-today | Store load: read the database | 2 | 525 ms | 509.1 ms |
| tap-today | Widgets: one habit's week | 16 | 172 ms | 91.1 ms |
| tap-today | Watch Today: plan | 70 | 58 ms | 10.1 ms |
| tap-today | Store load: into the app (1716 logs) | 1 | 36 ms | 36.5 ms |
| tap-today | Widgets: the snapshot | 3 | 6 ms | 4.6 ms |
| tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| tap-today | Count: a Today row drawn | 233 | 0 ms | 0.0 ms |
| scroll-today | Store load: read the database | 2 | 1075 ms | 1055.2 ms |
| scroll-today | Widgets: one habit's week | 60 | 164 ms | 18.4 ms |
| scroll-today | Store load: into the app (7320 logs) | 1 | 67 ms | 67.5 ms |
| scroll-today | Watch Today: plan | 32 | 35 ms | 2.1 ms |
| scroll-today | Widgets: the snapshot | 3 | 5 ms | 2.5 ms |
| scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| scroll-today | Count: a Today row drawn | 195 | 0 ms | 0.1 ms |
| day-details | Store load: read the database | 2 | 765 ms | 744.7 ms |
| day-details | Widgets: one habit's week | 16 | 141 ms | 58.5 ms |
| day-details | Watch Today: plan | 48 | 49 ms | 20.2 ms |
| day-details | Store load: into the app (1716 logs) | 1 | 33 ms | 32.9 ms |
| day-details | Watch Day details: the dial's words | 60 | 5 ms | 0.2 ms |
| day-details | Watch Day details: streak | 60 | 5 ms | 0.4 ms |
| day-details | Watch Day details: today's logs | 60 | 2 ms | 0.4 ms |
| day-details | Widgets: the snapshot | 3 | 2 ms | 1.1 ms |
| day-details | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| day-details | Count: a Today row drawn | 190 | 0 ms | 0.0 ms |
| crown | Store load: read the database | 2 | 306 ms | 288.5 ms |
| crown | Widgets: one habit's week | 16 | 73 ms | 28.5 ms |
| crown | Store load: into the app (1716 logs) | 1 | 21 ms | 21.3 ms |
| crown | Watch Today: plan | 13 | 12 ms | 3.4 ms |
| crown | Widgets: the snapshot | 3 | 5 ms | 2.9 ms |
| crown | Watch Day details: today's logs | 2 | 1 ms | 1.1 ms |
| crown | Watch Day details: the dial's words | 2 | 1 ms | 0.5 ms |
| crown | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| crown | Watch Day details: streak | 2 | 0 ms | 0.1 ms |
| crown | Count: Day details drawn | 2 | 0 ms | 0.1 ms |
| crown | Count: a Today row drawn | 39 | 0 ms | 0.0 ms |
| routine | Store load: read the database | 2 | 265 ms | 249.5 ms |
| routine | Widgets: one habit's week | 16 | 56 ms | 23.6 ms |
| routine | Store load: into the app (1716 logs) | 1 | 24 ms | 23.9 ms |
| routine | Watch Day details: the dial's words | 61 | 14 ms | 3.9 ms |
| routine | Watch Today: plan | 17 | 10 ms | 1.3 ms |
| routine | Widgets: the snapshot | 3 | 3 ms | 1.7 ms |
| routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| routine | Count: a Today row drawn | 27 | 0 ms | 0.0 ms |
| routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| incoming-batch | Batch: merged into the database | 1 | 5732 ms | 5731.9 ms |
| incoming-batch | Store load: read the database | 3 | 1180 ms | 765.4 ms |
| incoming-batch | Widgets: one habit's week | 24 | 113 ms | 50.9 ms |
| incoming-batch | Store load: into the app (6716 logs) | 1 | 65 ms | 65.1 ms |
| incoming-batch | Store load: into the app (1716 logs) | 1 | 26 ms | 25.7 ms |
| incoming-batch | Watch Today: plan | 12 | 10 ms | 2.4 ms |
| incoming-batch | Widgets: the snapshot | 4 | 2 ms | 0.8 ms |
| incoming-batch | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| incoming-batch | Count: a Today row drawn | 35 | 0 ms | 0.0 ms |
| complication | Store load: read the database | 2 | 308 ms | 292.3 ms |
| complication | Widgets: one habit's week | 10 | 40 ms | 18.8 ms |
| complication | Store load: into the app (1716 logs) | 1 | 23 ms | 23.4 ms |
| complication | Widgets: the snapshot | 12 | 10 ms | 1.2 ms |
| complication | Watch Today: plan | 11 | 9 ms | 2.4 ms |
| complication | Store load: into the app (0 logs) | 1 | 0 ms | 0.2 ms |
| complication | Count: a Today row drawn | 27 | 0 ms | 0.0 ms |
| first-fill-extreme | Store load: read the database | 2 | 419 ms | 404.0 ms |
| first-fill-extreme | Widgets: one habit's week | 16 | 93 ms | 39.6 ms |
| first-fill-extreme | Store load: into the app (1716 logs) | 1 | 52 ms | 52.1 ms |
| first-fill-extreme | Watch Today: plan | 11 | 9 ms | 2.1 ms |
| first-fill-extreme | Widgets: the snapshot | 3 | 3 ms | 1.3 ms |
| first-fill-extreme | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| first-fill-extreme | Count: a Today row drawn | 28 | 0 ms | 0.0 ms |

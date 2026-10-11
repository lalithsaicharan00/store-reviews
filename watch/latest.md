# Watch: apple-watch-ci5 @ 918b7c7

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38128109360 · 2026-10-11 10:26 UTC
Commit: Apple Watch: speed run again on the final code (scratch branch run)

- Core tests: skipped
- Watch build: success
- iPhone build with the Watch app: skipped
- Watch UI tests (none): skipped
- Screenshots: skipped
- Speed: failure
- Paired simulators: skipped

## Speed

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms |
|---|---|---|---|
| Today: +1 (tap to filled button) | 5.0 | 77 ms | 0 |
| Today: ✓ and Undo | 2.5 | 35 ms | 0 |
| Today: scrolling 30 habits | 7.9 | 62 ms | 0 |
| Day details: +1 | 9.4 | 46 ms | 0 |
| Log manually: turning the Crown | 0.0 | 0 ms | 0 |
| Routine: paging with the Crown | 2.4 | 42 ms | 0 |
| Today: a 5,000-change batch from the iPhone arrives | 5.2 | 119 ms | 1 |
| Writing the complication snapshot (10 times) | 0.0 | 0 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- Launch to a usable Today (round 1 , cold): 1735 ms
- Launch to a usable Today (round 2, warm): 1092 ms
- Blank page (control, first): longest stall 174 ms
- Blank page (control, again): longest stall 44 ms
- Day details (first): longest stall 118 ms
- Day details (again): longest stall 46 ms
- Log manually: longest stall 289 ms
- Blank cover (control, first): longest stall 99 ms
- Blank cover (control, again): longest stall 44 ms
- Routine (open): longest stall 226 ms

Notes (storage and the first fill):


Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| launch | Widgets: one habit's week | 8 | 61 ms | 37.5 ms |
| launch | Store load: read the database | 1 | 50 ms | 49.9 ms |
| launch | Watch Today: plan | 9 | 3 ms | 1.4 ms |
| launch | Store load: into the app (0 logs) | 1 | 2 ms | 2.2 ms |
| launch | Widgets: the snapshot | 2 | 2 ms | 1.0 ms |
| launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| launch | Widgets: one habit's week | 8 | 30 ms | 14.4 ms |
| launch | Store load: read the database | 1 | 16 ms | 15.8 ms |
| launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| launch | Watch Today: plan | 9 | 1 ms | 0.2 ms |
| launch | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| tap-today | Store load: read the database | 2 | 209 ms | 196.5 ms |
| tap-today | Widgets: one habit's week | 8 | 23 ms | 14.1 ms |
| tap-today | Store load: into the app (1716 logs) | 1 | 22 ms | 21.7 ms |
| tap-today | Watch Today: plan | 69 | 10 ms | 0.3 ms |
| tap-today | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| tap-today | Count: a Today row drawn | 225 | 0 ms | 0.0 ms |
| scroll-today | Store load: read the database | 2 | 922 ms | 900.7 ms |
| scroll-today | Widgets: one habit's week | 60 | 70 ms | 22.1 ms |
| scroll-today | Store load: into the app (7320 logs) | 1 | 68 ms | 67.9 ms |
| scroll-today | Watch Today: plan | 32 | 12 ms | 4.5 ms |
| scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.3 ms |
| scroll-today | Store load: into the app (0 logs) | 1 | 2 ms | 1.6 ms |
| scroll-today | Count: a Today row drawn | 157 | 0 ms | 0.0 ms |
| day-details | Store load: read the database | 2 | 173 ms | 162.8 ms |
| day-details | Widgets: one habit's week | 8 | 45 ms | 27.4 ms |
| day-details | Store load: into the app (1716 logs) | 1 | 19 ms | 18.6 ms |
| day-details | Watch Today: plan | 48 | 12 ms | 2.2 ms |
| day-details | Watch Day details: the dial's words | 60 | 3 ms | 0.2 ms |
| day-details | Watch Day details: streak | 60 | 2 ms | 0.2 ms |
| day-details | Store load: into the app (0 logs) | 1 | 1 ms | 1.4 ms |
| day-details | Watch Day details: today's logs | 60 | 1 ms | 0.1 ms |
| day-details | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| day-details | Count: a Today row drawn | 190 | 0 ms | 0.0 ms |
| day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| crown | Store load: read the database | 2 | 210 ms | 198.8 ms |
| crown | Widgets: one habit's week | 8 | 24 ms | 16.1 ms |
| crown | Store load: into the app (1716 logs) | 1 | 18 ms | 18.4 ms |
| crown | Watch Today: plan | 13 | 2 ms | 0.4 ms |
| crown | Store load: into the app (0 logs) | 1 | 1 ms | 1.4 ms |
| crown | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| crown | Watch Day details: the dial's words | 1 | 0 ms | 0.2 ms |
| crown | Watch Day details: streak | 1 | 0 ms | 0.1 ms |
| crown | Watch Day details: today's logs | 1 | 0 ms | 0.0 ms |
| crown | Count: a Today row drawn | 43 | 0 ms | 0.0 ms |
| crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| routine | Store load: read the database | 2 | 329 ms | 321.4 ms |
| routine | Widgets: one habit's week | 16 | 29 ms | 15.0 ms |
| routine | Store load: into the app (1716 logs) | 1 | 16 ms | 15.5 ms |
| routine | Watch Day details: the dial's words | 61 | 6 ms | 2.1 ms |
| routine | Watch Today: plan | 16 | 2 ms | 0.2 ms |
| routine | Widgets: the snapshot | 3 | 1 ms | 0.4 ms |
| routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| routine | Count: a Today row drawn | 52 | 0 ms | 0.0 ms |
| routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| incoming-batch | Batch: merged into the database | 1 | 4868 ms | 4867.6 ms |
| incoming-batch | Store load: read the database | 3 | 1050 ms | 685.1 ms |
| incoming-batch | Store load: into the app (6716 logs) | 1 | 70 ms | 70.1 ms |
| incoming-batch | Widgets: one habit's week | 24 | 57 ms | 17.4 ms |
| incoming-batch | Store load: into the app (1716 logs) | 1 | 15 ms | 15.0 ms |
| incoming-batch | Widgets: the snapshot | 5 | 3 ms | 0.5 ms |
| incoming-batch | Watch Today: plan | 13 | 2 ms | 0.9 ms |
| incoming-batch | Store load: into the app (0 logs) | 1 | 0 ms | 0.3 ms |
| incoming-batch | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| complication | Store load: read the database | 2 | 163 ms | 153.4 ms |
| complication | Widgets: one habit's week | 8 | 22 ms | 13.6 ms |
| complication | Store load: into the app (1716 logs) | 1 | 18 ms | 17.6 ms |
| complication | Widgets: the snapshot | 12 | 6 ms | 0.8 ms |
| complication | Watch Today: plan | 11 | 1 ms | 0.2 ms |
| complication | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| complication | Count: a Today row drawn | 23 | 0 ms | 0.0 ms |
| first-fill-extreme | Store load: read the database | 2 | 202 ms | 196.2 ms |
| first-fill-extreme | Widgets: one habit's week | 8 | 19 ms | 11.6 ms |
| first-fill-extreme | Store load: into the app (1716 logs) | 1 | 17 ms | 16.7 ms |
| first-fill-extreme | Watch Today: plan | 11 | 2 ms | 1.2 ms |
| first-fill-extreme | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| first-fill-extreme | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| first-fill-extreme | Count: a Today row drawn | 23 | 0 ms | 0.0 ms |

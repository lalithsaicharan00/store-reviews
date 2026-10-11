# Watch: apple-watch-ci5 @ 5b2fb97

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38126062437 · 2026-10-11 09:20 UTC
Commit: Apple Watch: final speed run on the merged code (scratch branch run)

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
| Today: +1 (tap to filled button) | 3.9 | 50 ms | 0 |
| Today: ✓ and Undo | 1.0 | 26 ms | 0 |
| Today: scrolling 30 habits | 21.4 | 108 ms | 1 |
| Day details: +1 | 37.9 | 66 ms | 0 |
| Log manually: turning the Crown | 12.1 | 81 ms | 0 |
| Routine: paging with the Crown | 6.7 | 45 ms | 0 |
| Today: a 5,000-change batch from the iPhone arrives | 14.8 | 114 ms | 1 |
| Writing the complication snapshot (10 times) | 0.0 | 0 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- Launch to a usable Today (round 1 , cold): 2113 ms
- Launch to a usable Today (round 2, warm): 1815 ms
- Blank page (control, first): longest stall 191 ms
- Blank page (control, again): longest stall 48 ms
- Day details (first): longest stall 175 ms
- Day details (again): longest stall 130 ms
- Log manually: longest stall 260 ms
- Blank cover (control, first): longest stall 232 ms
- Blank cover (control, again): longest stall 102 ms
- Routine (open): longest stall 386 ms

Notes (storage and the first fill):

- first fill on the Watch simulator: 375000 logs (15 years) in 76 parts, biggest 209 KB, 15.3 MB sent; 733.8 s (Today right after 16.1 s; the stand-in iPhone made it in 332.6 s); Watch database 225 MB; reading it all 28.78 s (375000 logs); reading the Watch's 400 days for Today 4.19 s (27268 logs); peak memory 192 MB

Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| launch | Store load: read the database | 1 | 62 ms | 62.4 ms |
| launch | Widgets: one habit's week | 8 | 59 ms | 32.8 ms |
| launch | Store load: into the app (0 logs) | 1 | 4 ms | 3.8 ms |
| launch | Watch Today: plan | 9 | 4 ms | 2.5 ms |
| launch | Widgets: the snapshot | 2 | 1 ms | 0.8 ms |
| launch | Count: a Today row drawn | 15 | 0 ms | 0.0 ms |
| launch | Widgets: one habit's week | 8 | 39 ms | 27.1 ms |
| launch | Store load: read the database | 1 | 16 ms | 15.5 ms |
| launch | Widgets: the snapshot | 2 | 3 ms | 1.7 ms |
| launch | Watch Today: plan | 9 | 2 ms | 0.7 ms |
| launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| tap-today | Store load: read the database | 2 | 206 ms | 195.6 ms |
| tap-today | Widgets: one habit's week | 16 | 52 ms | 19.8 ms |
| tap-today | Store load: into the app (1716 logs) | 1 | 24 ms | 23.7 ms |
| tap-today | Watch Today: plan | 68 | 13 ms | 0.5 ms |
| tap-today | Widgets: the snapshot | 3 | 2 ms | 0.9 ms |
| tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| tap-today | Count: a Today row drawn | 92 | 0 ms | 0.0 ms |
| scroll-today | Store load: read the database | 2 | 1368 ms | 1357.9 ms |
| scroll-today | Store load: into the app (7320 logs) | 1 | 94 ms | 93.8 ms |
| scroll-today | Widgets: one habit's week | 60 | 84 ms | 32.8 ms |
| scroll-today | Watch Today: plan | 32 | 26 ms | 14.2 ms |
| scroll-today | Widgets: the snapshot | 3 | 4 ms | 1.3 ms |
| scroll-today | Store load: into the app (0 logs) | 1 | 1 ms | 1.3 ms |
| scroll-today | Count: a Today row drawn | 158 | 0 ms | 0.0 ms |
| day-details | Store load: read the database | 2 | 318 ms | 300.0 ms |
| day-details | Widgets: one habit's week | 16 | 47 ms | 25.3 ms |
| day-details | Store load: into the app (1716 logs) | 1 | 27 ms | 27.4 ms |
| day-details | Watch Today: plan | 48 | 12 ms | 1.2 ms |
| day-details | Watch Day details: the dial's words | 60 | 3 ms | 0.2 ms |
| day-details | Watch Day details: today's logs | 60 | 3 ms | 0.6 ms |
| day-details | Widgets: the snapshot | 3 | 2 ms | 1.4 ms |
| day-details | Watch Day details: streak | 60 | 2 ms | 0.1 ms |
| day-details | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| day-details | Count: a Today row drawn | 189 | 0 ms | 0.0 ms |
| day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| crown | Store load: read the database | 2 | 238 ms | 222.5 ms |
| crown | Widgets: one habit's week | 16 | 60 ms | 38.2 ms |
| crown | Store load: into the app (1716 logs) | 1 | 17 ms | 17.1 ms |
| crown | Watch Today: plan | 13 | 7 ms | 2.6 ms |
| crown | Widgets: the snapshot | 3 | 2 ms | 0.7 ms |
| crown | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| crown | Watch Day details: streak | 1 | 0 ms | 0.3 ms |
| crown | Watch Day details: the dial's words | 1 | 0 ms | 0.3 ms |
| crown | Watch Day details: today's logs | 1 | 0 ms | 0.0 ms |
| crown | Count: a Today row drawn | 30 | 0 ms | 0.0 ms |
| crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| routine | Widgets: one habit's week | 8 | 265 ms | 246.7 ms |
| routine | Store load: read the database | 2 | 169 ms | 157.1 ms |
| routine | Store load: into the app (1716 logs) | 1 | 27 ms | 26.8 ms |
| routine | Watch Day details: the dial's words | 61 | 10 ms | 2.9 ms |
| routine | Watch Today: plan | 17 | 5 ms | 1.5 ms |
| routine | Widgets: the snapshot | 2 | 2 ms | 1.3 ms |
| routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| routine | Count: a routine page drawn | 61 | 0 ms | 0.0 ms |
| routine | Count: a Today row drawn | 48 | 0 ms | 0.0 ms |
| incoming-batch | Batch: merged into the database | 1 | 2437 ms | 2437.1 ms |
| incoming-batch | Store load: read the database | 3 | 680 ms | 490.1 ms |
| incoming-batch | Widgets: one habit's week | 24 | 134 ms | 70.8 ms |
| incoming-batch | Store load: into the app (6716 logs) | 1 | 61 ms | 61.1 ms |
| incoming-batch | Store load: into the app (1716 logs) | 1 | 18 ms | 17.8 ms |
| incoming-batch | Watch Today: plan | 13 | 3 ms | 1.1 ms |
| incoming-batch | Widgets: the snapshot | 4 | 3 ms | 1.1 ms |
| incoming-batch | Store load: into the app (0 logs) | 1 | 1 ms | 1.1 ms |
| incoming-batch | Count: a Today row drawn | 26 | 0 ms | 0.0 ms |
| complication | Store load: read the database | 2 | 122 ms | 115.1 ms |
| complication | Store load: into the app (1716 logs) | 1 | 21 ms | 21.1 ms |
| complication | Widgets: one habit's week | 8 | 18 ms | 10.5 ms |
| complication | Widgets: the snapshot | 12 | 5 ms | 0.5 ms |
| complication | Watch Today: plan | 11 | 3 ms | 1.7 ms |
| complication | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| complication | Count: a Today row drawn | 23 | 0 ms | 0.0 ms |
| first-fill-extreme | Store load: read the database | 2 | 151 ms | 128.4 ms |
| first-fill-extreme | Widgets: one habit's week | 8 | 26 ms | 16.6 ms |
| first-fill-extreme | Store load: into the app (1716 logs) | 1 | 15 ms | 15.4 ms |
| first-fill-extreme | Watch Today: plan | 11 | 3 ms | 1.5 ms |
| first-fill-extreme | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| first-fill-extreme | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| first-fill-extreme | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |

| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms |
|---|---|---|---|
| Today: +1 (tap to filled button) | 6.1 | 60 ms | 0 |
| Today: ✓ and Undo | 0.0 | 0 ms | 0 |
| Today: scrolling 30 habits | 7.8 | 64 ms | 0 |
| Day details: +1 | 2.0 | 26 ms | 0 |
| Log manually: turning the Crown | 0.0 | 0 ms | 0 |
| Routine: paging with the Crown | 0.3 | 21 ms | 0 |
| Today: a 5,000-change batch from the iPhone arrives | 9.7 | 95 ms | 0 |
| Writing the complication snapshot (10 times) | 0.0 | 0 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- Launch to a usable Today (round 1 , cold): 2309 ms
- Launch to a usable Today (round 2, warm): 1610 ms
- Blank page (control, first): longest stall 118 ms
- Blank page (control, again): longest stall 21 ms
- Day details (first): longest stall 89 ms
- Day details (again): longest stall 32 ms
- Log manually: longest stall 183 ms
- Blank cover (control, first): longest stall 101 ms
- Blank cover (control, again): longest stall 29 ms
- Routine (open): longest stall 221 ms

Notes (storage and the first fill):

- first fill on the Watch simulator: 375000 logs (15 years) in 76 parts, biggest 209 KB, 15.3 MB sent; 644.2 s (Today right after 19.3 s; the stand-in iPhone made it in 288.6 s); Watch database 225 MB; reading it all 22.59 s (375000 logs); reading the Watch's 400 days for Today 1.81 s (27268 logs); peak memory 205 MB

Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| launch | Store load: read the database | 1 | 49 ms | 49.3 ms |
| launch | Widgets: one habit's week | 8 | 41 ms | 23.8 ms |
| launch | Watch Today: plan | 9 | 4 ms | 3.2 ms |
| launch | Store load: into the app (0 logs) | 1 | 2 ms | 2.0 ms |
| launch | Widgets: the snapshot | 2 | 1 ms | 0.6 ms |
| launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| launch | Store load: read the database | 1 | 62 ms | 61.9 ms |
| launch | Widgets: one habit's week | 8 | 23 ms | 10.7 ms |
| launch | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| launch | Count: a Today row drawn | 16 | 0 ms | 0.0 ms |
| tap-today | Store load: read the database | 2 | 226 ms | 217.0 ms |
| tap-today | Widgets: one habit's week | 8 | 38 ms | 22.2 ms |
| tap-today | Store load: into the app (1716 logs) | 1 | 34 ms | 33.5 ms |
| tap-today | Watch Today: plan | 69 | 13 ms | 1.8 ms |
| tap-today | Widgets: the snapshot | 2 | 1 ms | 0.9 ms |
| tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| tap-today | Count: a Today row drawn | 211 | 0 ms | 0.0 ms |
| scroll-today | Store load: read the database | 2 | 1071 ms | 1054.6 ms |
| scroll-today | Store load: into the app (7320 logs) | 1 | 69 ms | 68.8 ms |
| scroll-today | Widgets: one habit's week | 60 | 52 ms | 11.9 ms |
| scroll-today | Watch Today: plan | 32 | 11 ms | 4.0 ms |
| scroll-today | Widgets: the snapshot | 3 | 3 ms | 1.2 ms |
| scroll-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| scroll-today | Count: a Today row drawn | 156 | 0 ms | 0.0 ms |
| day-details | Store load: read the database | 2 | 113 ms | 104.5 ms |
| day-details | Widgets: one habit's week | 8 | 73 ms | 37.8 ms |
| day-details | Store load: into the app (1716 logs) | 1 | 16 ms | 16.1 ms |
| day-details | Watch Today: plan | 49 | 9 ms | 0.6 ms |
| day-details | Watch Day details: today's logs | 62 | 2 ms | 0.1 ms |
| day-details | Widgets: the snapshot | 2 | 2 ms | 0.8 ms |
| day-details | Watch Day details: the dial's words | 32 | 2 ms | 0.2 ms |
| day-details | Watch Day details: streak | 32 | 1 ms | 0.1 ms |
| day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| day-details | Count: Day details drawn | 62 | 0 ms | 0.0 ms |
| day-details | Count: a Today row drawn | 50 | 0 ms | 0.0 ms |
| crown | Store load: read the database | 2 | 99 ms | 82.3 ms |
| crown | Widgets: one habit's week | 8 | 15 ms | 9.2 ms |
| crown | Store load: into the app (1716 logs) | 1 | 15 ms | 15.1 ms |
| crown | Watch Today: plan | 13 | 2 ms | 0.8 ms |
| crown | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| crown | Store load: into the app (0 logs) | 1 | 1 ms | 0.8 ms |
| crown | Watch Day details: today's logs | 1 | 0 ms | 0.1 ms |
| crown | Watch Day details: the dial's words | 1 | 0 ms | 0.1 ms |
| crown | Watch Day details: streak | 1 | 0 ms | 0.0 ms |
| crown | Count: a Today row drawn | 8 | 0 ms | 0.0 ms |
| crown | Count: Day details drawn | 1 | 0 ms | 0.0 ms |
| routine | Store load: read the database | 2 | 106 ms | 95.9 ms |
| routine | Widgets: one habit's week | 8 | 19 ms | 10.8 ms |
| routine | Store load: into the app (1716 logs) | 1 | 15 ms | 14.8 ms |
| routine | Watch Today: plan | 17 | 3 ms | 0.9 ms |
| routine | Watch Day details: the dial's words | 2 | 2 ms | 1.4 ms |
| routine | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| routine | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| routine | Count: a Today row drawn | 11 | 0 ms | 0.0 ms |
| routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| incoming-batch | Batch: merged into the database | 1 | 1928 ms | 1927.9 ms |
| incoming-batch | Store load: read the database | 3 | 347 ms | 266.8 ms |
| incoming-batch | Widgets: one habit's week | 16 | 57 ms | 21.4 ms |
| incoming-batch | Store load: into the app (6716 logs) | 1 | 51 ms | 51.0 ms |
| incoming-batch | Store load: into the app (1716 logs) | 1 | 14 ms | 13.6 ms |
| incoming-batch | Widgets: the snapshot | 4 | 3 ms | 0.9 ms |
| incoming-batch | Watch Today: plan | 13 | 3 ms | 0.8 ms |
| incoming-batch | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| incoming-batch | Count: a Today row drawn | 12 | 0 ms | 0.0 ms |
| complication | Store load: read the database | 2 | 82 ms | 66.2 ms |
| complication | Widgets: one habit's week | 8 | 26 ms | 16.6 ms |
| complication | Store load: into the app (1716 logs) | 1 | 14 ms | 13.6 ms |
| complication | Widgets: the snapshot | 12 | 6 ms | 0.6 ms |
| complication | Watch Today: plan | 11 | 2 ms | 0.8 ms |
| complication | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| complication | Count: a Today row drawn | 7 | 0 ms | 0.0 ms |
| first-fill-extreme | Store load: read the database | 2 | 303 ms | 279.9 ms |
| first-fill-extreme | Widgets: one habit's week | 8 | 17 ms | 10.2 ms |
| first-fill-extreme | Store load: into the app (1716 logs) | 1 | 16 ms | 16.3 ms |
| first-fill-extreme | Watch Today: plan | 11 | 1 ms | 0.2 ms |
| first-fill-extreme | Widgets: the snapshot | 2 | 1 ms | 0.5 ms |
| first-fill-extreme | Store load: into the app (0 logs) | 1 | 1 ms | 0.5 ms |
| first-fill-extreme | Count: a Today row drawn | 20 | 0 ms | 0.0 ms |

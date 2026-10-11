| What | Hitch time (ms/s) | Longest stall | Freezes ≥100 ms |
|---|---|---|---|
| Today: +1 (tap to filled button) | 15.1 | 49 ms | 0 |
| Today: ✓ and Undo | 13.8 | 46 ms | 0 |
| Today: scrolling 30 habits | 9.4 | 67 ms | 0 |
| Day details: +1 | 47.0 | 62 ms | 0 |
| Routine: paging with the Crown | 1.3 | 25 ms | 0 |
| Today: a 5,000-change batch from the iPhone arrives | 4.5 | 100 ms | 1 |
| Writing the complication snapshot (10 times) | 0.0 | 0 ms | 0 |

Targets (Rulebook S): hitch time under 5 ms/s, no freeze of 100 ms or more. Simulator numbers; the Watch has the final word.

Openings (longest stall in the 1.5 s after the command) and launches:

- Launch to a usable Today (round 1 , cold): 2966 ms
- Launch to a usable Today (round 2, warm): 2019 ms
- Day details (first): longest stall 284 ms
- Day details (again): longest stall 78 ms
- Routine (open): longest stall 302 ms

Notes (storage and the first fill):

- first fill on the Watch simulator: 375000 logs (15 years) in 76 parts, biggest 209 KB, 15.3 MB sent; 770.6 s (Today right after 14.9 s; the stand-in iPhone made it in 351.0 s); Watch database 222 MB; reading it all 33.09 s (375000 logs); reading the Watch's 400 days for Today 2.55 s (27268 logs); peak memory 212 MB

Timed work (S2: count, total, longest):

| Scenario | What | Count | Total | Longest |
|---|---|---|---|---|
| launch | Widgets: one habit's week | 8 | 59 ms | 34.0 ms |
| launch | Store load: read the database | 1 | 41 ms | 40.5 ms |
| launch | Store load: into the app (0 logs) | 1 | 3 ms | 2.9 ms |
| launch | Watch Today: plan | 9 | 3 ms | 1.9 ms |
| launch | Widgets: the snapshot | 1 | 1 ms | 0.5 ms |
| launch | Count: a Today row drawn | 35 | 0 ms | 0.0 ms |
| launch | Widgets: one habit's week | 8 | 43 ms | 30.2 ms |
| launch | Store load: read the database | 1 | 11 ms | 10.9 ms |
| launch | Watch Today: plan | 9 | 1 ms | 0.3 ms |
| launch | Widgets: the snapshot | 1 | 1 ms | 0.7 ms |
| launch | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| launch | Count: a Today row drawn | 35 | 0 ms | 0.0 ms |
| tap-today | Store load: read the database | 2 | 264 ms | 249.9 ms |
| tap-today | Widgets: one habit's week | 18 | 89 ms | 58.3 ms |
| tap-today | Store load: into the app (1716 logs) | 1 | 38 ms | 38.0 ms |
| tap-today | Watch Today: plan | 69 | 14 ms | 0.6 ms |
| tap-today | Widgets: the snapshot | 4 | 4 ms | 1.2 ms |
| tap-today | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| tap-today | Count: a Today row drawn | 992 | 0 ms | 0.0 ms |
| scroll-today | Store load: read the database | 2 | 824 ms | 801.9 ms |
| scroll-today | Store load: into the app (7320 logs) | 1 | 72 ms | 72.0 ms |
| scroll-today | Widgets: one habit's week | 60 | 68 ms | 17.4 ms |
| scroll-today | Watch Today: plan | 32 | 9 ms | 0.6 ms |
| scroll-today | Widgets: the snapshot | 2 | 2 ms | 1.1 ms |
| scroll-today | Store load: into the app (0 logs) | 1 | 2 ms | 1.9 ms |
| scroll-today | Count: a Today row drawn | 183 | 0 ms | 0.0 ms |
| day-details | Store load: read the database | 2 | 217 ms | 202.7 ms |
| day-details | Widgets: one habit's week | 17 | 31 ms | 10.9 ms |
| day-details | Store load: into the app (1716 logs) | 1 | 16 ms | 16.5 ms |
| day-details | Watch Today: plan | 44 | 9 ms | 1.1 ms |
| day-details | Watch Day details: the dial's words | 60 | 6 ms | 0.6 ms |
| day-details | Watch Day details: streak | 60 | 3 ms | 0.2 ms |
| day-details | Widgets: the snapshot | 3 | 2 ms | 1.5 ms |
| day-details | Watch Day details: today's logs | 60 | 2 ms | 0.1 ms |
| day-details | Store load: into the app (0 logs) | 1 | 0 ms | 0.5 ms |
| day-details | Count: a Today row drawn | 414 | 0 ms | 0.0 ms |
| day-details | Count: Day details drawn | 60 | 0 ms | 0.0 ms |
| crown | Store load: read the database | 2 | 332 ms | 306.1 ms |
| crown | Widgets: one habit's week | 16 | 60 ms | 32.2 ms |
| crown | Store load: into the app (1716 logs) | 1 | 29 ms | 29.2 ms |
| crown | Watch Today: plan | 12 | 4 ms | 0.9 ms |
| crown | Widgets: the snapshot | 2 | 2 ms | 1.2 ms |
| crown | Store load: into the app (0 logs) | 1 | 1 ms | 0.7 ms |
| crown | Count: a Today row drawn | 66 | 0 ms | 0.1 ms |
| routine | Store load: read the database | 2 | 102 ms | 66.1 ms |
| routine | Widgets: one habit's week | 16 | 36 ms | 15.1 ms |
| routine | Store load: into the app (1716 logs) | 1 | 15 ms | 15.1 ms |
| routine | Watch Today: plan | 13 | 4 ms | 1.3 ms |
| routine | Watch Day details: the dial's words | 2 | 2 ms | 1.7 ms |
| routine | Store load: into the app (0 logs) | 1 | 2 ms | 1.8 ms |
| routine | Widgets: the snapshot | 2 | 1 ms | 0.4 ms |
| routine | Count: a Today row drawn | 163 | 0 ms | 0.0 ms |
| routine | Count: a routine page drawn | 2 | 0 ms | 0.0 ms |
| incoming-batch | Batch: merged into the database | 1 | 4515 ms | 4514.8 ms |
| incoming-batch | Store load: read the database | 3 | 1125 ms | 869.3 ms |
| incoming-batch | Widgets: one habit's week | 24 | 81 ms | 31.7 ms |
| incoming-batch | Store load: into the app (6716 logs) | 1 | 57 ms | 56.9 ms |
| incoming-batch | Store load: into the app (1716 logs) | 1 | 16 ms | 16.5 ms |
| incoming-batch | Watch Today: plan | 13 | 3 ms | 1.1 ms |
| incoming-batch | Widgets: the snapshot | 3 | 2 ms | 0.7 ms |
| incoming-batch | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| incoming-batch | Count: a Today row drawn | 79 | 0 ms | 0.0 ms |
| complication | Store load: read the database | 2 | 250 ms | 242.1 ms |
| complication | Widgets: one habit's week | 16 | 31 ms | 10.4 ms |
| complication | Store load: into the app (1716 logs) | 1 | 16 ms | 15.9 ms |
| complication | Widgets: the snapshot | 12 | 5 ms | 0.5 ms |
| complication | Watch Today: plan | 11 | 1 ms | 0.2 ms |
| complication | Store load: into the app (0 logs) | 1 | 1 ms | 0.9 ms |
| complication | Count: a Today row drawn | 55 | 0 ms | 0.0 ms |
| first-fill-extreme | Store load: read the database | 2 | 92 ms | 80.6 ms |
| first-fill-extreme | Widgets: one habit's week | 16 | 31 ms | 13.8 ms |
| first-fill-extreme | Store load: into the app (1716 logs) | 1 | 15 ms | 14.9 ms |
| first-fill-extreme | Watch Today: plan | 11 | 2 ms | 0.8 ms |
| first-fill-extreme | Widgets: the snapshot | 2 | 1 ms | 0.7 ms |
| first-fill-extreme | Store load: into the app (0 logs) | 1 | 0 ms | 0.4 ms |
| first-fill-extreme | Count: a Today row drawn | 65 | 0 ms | 0.0 ms |

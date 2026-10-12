# claude/shared-habit-rules-perf24 @ a6444ff (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38307045881 · 2026-10-12 21:48 UTC
Commit: Current Work 92: speed side by side with main, all optimisations (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `scroll-today tap-today` · rounds: 6

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: a6444ff3 Current Work 92: speed side by side with main, all optimisations (scratch, safe to delete) [ios-perf-

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Today: scrolling | **16.3**<br>35.6 (142, 1), 12.9 (52, 0), 12.2 (53, 0), 19.7 (167, 1), 19.9 (235, 1), 10.7 (58, 0) | **14.7**<br>17.7 (177, 1), 15 (166, 1), 13.1 (89, 0), 16.5 (99, 0), 14.3 (77, 0), 12.9 (41, 0) |
| Today: +1 and day ‹ › | **46.5**<br>31.1 (96, 0), 68.4 (76, 0), 31 (48, 0), 64.8 (96, 0), 61.6 (140, 1), 31.3 (50, 0) | **50.9**<br>54.3 (75, 0), 52.1 (125, 1), 68.5 (88, 0), 49.7 (59, 0), 31.5 (80, 0), 36.3 (62, 0) |
| Today: +1 alone | **0.9**<br>2 (34, 0), 0.4 (21, 0), 0.3 (20, 0), 0.9 (30, 0), 0.9 (27, 0), 1.3 (33, 0) | **0.8**<br>1.9 (29, 0), 6.9 (53, 0), 0.7 (26, 0), 0.7 (27, 0), 0.8 (24, 0), 0.4 (19, 0) |
| Today: day ‹ › alone | **46.7**<br>91.2 (87, 0), 49.1 (65, 0), 44.2 (48, 0), 34.9 (54, 0), 61.7 (109, 1), 32.4 (42, 0) | **31.6**<br>17 (39, 0), 44.2 (143, 1), 59.6 (62, 0), 30.7 (55, 0), 30.6 (59, 0), 32.6 (53, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **0.1**<br>32.2 (232, 2), 0 (0, 0), 0.1 (18, 0), 1.1 (27, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0.2 (20, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 1.5 (32, 0), 0 (0, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 24 · 9763 · 2220.0 | 24 · 8923 · 1387.7 |
| Widgets: one habit's week | 303 · 1498 · 79.1 | 302 · 1483 · 68.4 |
| Store load: into the app (5593 logs) | 12 · 700 · 75.8 | 12 · 738 · 75.2 |
| Widgets: the snapshot | 111 · 133 · 3.8 | 110 · 175 · 7.0 |
| Store load: into the app (0 logs) | 12 · 27 · 4.5 | 12 · 10 · 1.5 |
| Reminders: plan every alert | 356 · 27 · 1.7 | 354 · 41 · 7.7 |
| Count: Today's list drawn | 612 · 1 · 0.7 | 610 · 4 · 0.7 |
| Count: a Today row drawn | 4744 · 0 · 0.0 | 4557 · 0 · 0.0 |
| Shared rules: built from every log, off the main thread | – | 24 · 165 · 17.6 |
| Shared rules: built from every log | – | 24 · 88 · 11.7 |
| Shared rules: habits and settings again | – | 72 · 60 · 3.0 |
| Change: Siri's habit names | 346 · 24 · 0.4 | 344 · 25 · 0.3 |
| Count: the Day sheet drawn | 78 · 0 · 0.0 | 70 · 0 · 0.0 |
| Count: the Day sheet's activity drawn | 78 · 0 · 0.0 | 70 · 0 · 0.0 |
| Shared rules: a log added | – | 339 · 26 · 1.2 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- shared, scroll-today round 1: long stall 935 ms at 1791839914.278; kotlin collection 232: stopped 0.0 ms (after waiting 10.2 ms), then 0.1 ms, took 25.5 ms
- shared, tap-today round 1: long stall 275 ms at 1791840080.051; kotlin collection 232: stopped 4.5 ms (after waiting 14.4 ms), then 1.2 ms, took 46.4 ms
- shared, tap-today round 1: long stall 514 ms at 1791840080.326; kotlin collection 232: stopped 4.5 ms (after waiting 14.4 ms), then 1.2 ms, took 46.4 ms
- shared, tap-today round 1: long stall 534 ms at 1791840135.977; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 4.5 ms
- shared, tap-today round 1: long stall 302 ms at 1791840141.403; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 4.5 ms
- shared, tap-today round 1: long stall 1999 ms at 1791840142.207; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 4.5 ms
- shared, tap-today round 1: long stall 625 ms at 1791840144.307; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 4.5 ms
- shared, scroll-today round 2: long stall 263 ms at 1791840187.211; kotlin collection 263: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 30.8 ms
- shared, scroll-today round 2: long stall 583 ms at 1791840187.474; kotlin collection 263: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 30.8 ms
- shared, tap-today round 2: long stall 952 ms at 1791840364.672; kotlin collection 234: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 47.3 ms
- shared, tap-today round 2: long stall 779 ms at 1791840420.787; kotlin collection 240: stopped 0.2 ms (after waiting 0.0 ms), then 0.7 ms, took 27.0 ms
- shared, tap-today round 2: long stall 766 ms at 1791840427.090; kotlin collection 240: stopped 0.2 ms (after waiting 0.0 ms), then 0.7 ms, took 27.0 ms
- shared, tap-today round 2: long stall 308 ms at 1791840428.925; kotlin collection 240: stopped 0.2 ms (after waiting 0.0 ms), then 0.7 ms, took 27.0 ms
- shared, scroll-today round 3: long stall 670 ms at 1791840637.373; kotlin collection 230: stopped 0.3 ms (after waiting 11.4 ms), then 0.4 ms, took 49.4 ms
- shared, tap-today round 3: long stall 841 ms at 1791840782.000; kotlin collection 233: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 16.7 ms
- shared, tap-today round 3: long stall 749 ms at 1791840838.083; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 4.8 ms
- shared, tap-today round 3: long stall 305 ms at 1791840840.847; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 4.8 ms
- shared, tap-today round 3: long stall 319 ms at 1791840843.597; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 4.8 ms
- shared, tap-today round 3: long stall 1333 ms at 1791840844.424; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 4.8 ms
- shared, tap-today round 3: long stall 265 ms at 1791840845.757; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 4.8 ms
- shared, tap-today round 3: long stall 577 ms at 1791840846.568; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 4.8 ms
- shared, scroll-today round 4: long stall 268 ms at 1791840872.040; kotlin collection 2: stopped 21.2 ms (after waiting 10.6 ms), then 0.7 ms, took 57.8 ms
- shared, scroll-today round 4: long stall 756 ms at 1791840879.599; kotlin collection 272: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 6.5 ms
- shared, tap-today round 4: long stall 805 ms at 1791840966.674; kotlin collection 270: stopped 0.0 ms (after waiting 0.4 ms), then 0.0 ms, took 28.1 ms
- shared, tap-today round 4: long stall 477 ms at 1791841021.920; kotlin collection 275: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 7.3 ms
- shared, tap-today round 4: long stall 251 ms at 1791841027.366; kotlin collection 276: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 12.4 ms
- shared, tap-today round 4: long stall 705 ms at 1791841028.124; kotlin collection 276: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 12.4 ms
- shared, tap-today round 4: long stall 364 ms at 1791841030.015; kotlin collection 276: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 12.4 ms
- shared, scroll-today round 5: long stall 701 ms at 1791841213.220; kotlin collection 235: stopped 0.2 ms (after waiting 10.3 ms), then 0.0 ms, took 15.8 ms
- shared, tap-today round 5: long stall 883 ms at 1791841360.737; kotlin collection 233: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 9.6 ms
- shared, tap-today round 5: long stall 508 ms at 1791841416.061; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 8.5 ms
- shared, tap-today round 5: long stall 269 ms at 1791841421.562; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 3.6 ms, took 6.6 ms
- shared, tap-today round 5: long stall 674 ms at 1791841422.357; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 3.6 ms, took 6.6 ms
- shared, tap-today round 5: long stall 406 ms at 1791841423.037; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 3.6 ms, took 6.6 ms
- shared, tap-today round 5: long stall 330 ms at 1791841424.288; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 3.6 ms, took 6.6 ms
- shared, scroll-today round 6: long stall 645 ms at 1791841454.173; kotlin collection 300: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.0 ms
- shared, tap-today round 6: long stall 676 ms at 1791841539.276; kotlin collection 268: stopped 0.1 ms (after waiting 0.0 ms), then 0.0 ms, took 11.3 ms
- shared, tap-today round 6: long stall 526 ms at 1791841594.846; kotlin collection 273: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 9.2 ms
- shared, tap-today round 6: long stall 287 ms at 1791841597.544; kotlin collection 274: stopped 0.0 ms (after waiting 0.0 ms), then 1.1 ms, took 12.2 ms
- shared, tap-today round 6: long stall 265 ms at 1791841600.366; kotlin collection 274: stopped 0.0 ms (after waiting 0.0 ms), then 1.1 ms, took 12.2 ms
- shared, tap-today round 6: long stall 678 ms at 1791841601.140; kotlin collection 274: stopped 0.0 ms (after waiting 0.0 ms), then 1.1 ms, took 12.2 ms
- shared, tap-today round 6: long stall 611 ms at 1791841601.821; kotlin collection 274: stopped 0.0 ms (after waiting 0.0 ms), then 1.1 ms, took 12.2 ms
- shared, tap-today round 6: long stall 298 ms at 1791841603.163; kotlin collection 274: stopped 0.0 ms (after waiting 0.0 ms), then 1.1 ms, took 12.2 ms

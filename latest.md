# claude/shared-habit-rules-perf30 @ 28a840c (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38329426726 · 2026-10-13 04:19 UTC
Commit: Current Work 92: speed side by side with main after the untracked refresh (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ac462364 shared=HEAD` · scenarios: `day-sheet widget-publish` · rounds: 4

- main: ac462364 Current Work 93: say which widgets are free and which are Plus in the store screenshots, the website 
- shared: 28a840c4 Current Work 92: speed side by side with main after the untracked refresh (scratch, safe to delete) [

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **1.4**<br>4 (44, 0), 0.9 (23, 0), 1.5 (32, 0), 1.2 (26, 0) | **2.6**<br>3 (26, 0), 0.9 (25, 0), 7 (61, 0), 2.2 (31, 0) |
| Day sheet: add, edit and exact undo | **163.4**<br>124.3 (74, 0), 159.7 (99, 0), 232.4 (118, 3), 167.1 (98, 0) | **163.2**<br>161.4 (105, 1), 165.1 (115, 1), 150.5 (106, 1), 239.1 (104, 1) |
| Widget: full publication, every habit's week | **0.8**<br>1.5 (28, 0), 0 (0, 0), 0 (0, 0), 6.3 (107, 1) | **1.3**<br>0.9 (31, 0), 0.6 (23, 0), 1.7 (33, 0), 5.1 (94, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 5927 · 1207.1 | 16 · 5132 · 872.1 |
| Habit page: history | 583 · 2825 · 23.5 | 580 · 3363 · 29.9 |
| Widgets: one habit's week | 1738 · 5635 · 3074.4 | 1703 · 8700 · 4377.8 |
| Store load: into the app (5594 logs) | 8 · 523 · 105.1 | 8 · 483 · 99.9 |
| Change: Siri's habit names | 579 · 37 · 0.3 | 576 · 40 · 0.5 |
| Widgets: the snapshot | 106 · 102 · 3.7 | 103 · 130 · 3.8 |
| Store load: into the app (0 logs) | 8 · 23 · 7.1 | 8 · 29 · 12.1 |
| Reminders: plan every alert | 12 · 3 · 0.8 | 11 · 11 · 3.2 |
| Count: Today's list drawn | 67 · 4 · 1.6 | 71 · 4 · 1.9 |
| Count: a Today row drawn | 663 · 0 · 0.0 | 663 · 0 · 0.0 |
| Count: the Day sheet drawn | 630 · 0 · 0.0 | 635 · 0 · 0.0 |
| Count: the Day sheet's activity drawn | 823 · 0 · 0.0 | 827 · 0 · 0.0 |
| Entry editor: whole editor drawn | 781 · 0 · 0.0 | 777 · 0 · 0.0 |
| Shared rules: built from every log, off the main thread | – | 16 · 172 · 55.4 |
| Shared rules: built from every log | – | 16 · 92 · 19.2 |
| Shared rules: habits and settings again | – | 40 · 35 · 7.7 |
| Shared rules: a log changed | – | 192 · 23 · 0.5 |
| Shared rules: a log added | – | 192 · 16 · 2.3 |
| Shared rules: a log removed | – | 192 · 15 · 0.7 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- shared, day-sheet round 1: long stall 409 ms at 1791864179.896; kotlin no collection yet
- shared, day-sheet round 1: long stall 998 ms at 1791864190.937; kotlin collection 245: stopped 5.0 ms (after waiting 10.0 ms), then 0.0 ms, took 49.5 ms
- shared, day-sheet round 1: long stall 591 ms at 1791864200.394; kotlin collection 246: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 14.9 ms
- shared, day-sheet round 1: long stall 597 ms at 1791864201.946; kotlin collection 246: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 14.9 ms
- shared, day-sheet round 1: long stall 503 ms at 1791864203.461; kotlin collection 246: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 14.9 ms
- shared, day-sheet round 1: long stall 329 ms at 1791864210.838; kotlin collection 247: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 10.0 ms
- shared, day-sheet round 1: long stall 321 ms at 1791864213.955; kotlin collection 247: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 10.0 ms
- shared, day-sheet round 1: long stall 1997 ms at 1791864214.276; kotlin collection 247: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 10.0 ms
- shared, day-sheet round 1: long stall 290 ms at 1791864231.503; kotlin collection 249: stopped 0.3 ms (after waiting 0.0 ms), then 0.1 ms, took 16.6 ms
- shared, widget-publish round 1: long stall 2434 ms at 1791864345.389; kotlin collection 260: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.9 ms
- shared, day-sheet round 2: long stall 552 ms at 1791864388.995; kotlin collection 246: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.7 ms
- shared, day-sheet round 2: long stall 524 ms at 1791864398.059; kotlin collection 246: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.7 ms
- shared, day-sheet round 2: long stall 581 ms at 1791864399.595; kotlin collection 247: stopped 0.2 ms (after waiting 0.0 ms), then 0.3 ms, took 18.8 ms
- shared, day-sheet round 2: long stall 463 ms at 1791864401.146; kotlin collection 247: stopped 0.2 ms (after waiting 0.0 ms), then 0.3 ms, took 18.8 ms
- shared, day-sheet round 2: long stall 255 ms at 1791864404.019; kotlin collection 247: stopped 0.2 ms (after waiting 0.0 ms), then 0.3 ms, took 18.8 ms
- shared, day-sheet round 2: long stall 495 ms at 1791864408.797; kotlin collection 248: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 14.9 ms
- shared, day-sheet round 2: long stall 1246 ms at 1791864411.920; kotlin collection 248: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 14.9 ms
- shared, widget-publish round 2: long stall 858 ms at 1791864550.942; kotlin collection 268: stopped 0.0 ms (after waiting 10.2 ms), then 0.0 ms, took 53.6 ms
- shared, day-sheet round 3: long stall 5850 ms at 1791864716.845; kotlin collection 237: stopped 0.0 ms (after waiting 10.0 ms), then 0.1 ms, took 38.8 ms
- shared, day-sheet round 3: long stall 617 ms at 1791864731.125; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.7 ms, took 17.9 ms
- shared, day-sheet round 3: long stall 916 ms at 1791864732.629; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.7 ms, took 17.9 ms
- shared, day-sheet round 3: long stall 670 ms at 1791864734.221; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.7 ms, took 17.9 ms
- shared, day-sheet round 3: long stall 273 ms at 1791864736.990; kotlin collection 239: stopped 0.1 ms (after waiting 0.0 ms), then 0.9 ms, took 27.5 ms
- shared, day-sheet round 3: long stall 319 ms at 1791864741.596; kotlin collection 239: stopped 0.1 ms (after waiting 0.0 ms), then 0.9 ms, took 27.5 ms
- shared, day-sheet round 3: long stall 1927 ms at 1791864744.703; kotlin collection 239: stopped 0.1 ms (after waiting 0.0 ms), then 0.9 ms, took 27.5 ms
- shared, widget-publish round 3: long stall 406 ms at 1791864852.178; kotlin collection 1: stopped 0.1 ms (after waiting 11.0 ms), then 0.0 ms, took 60.6 ms
- shared, widget-publish round 3: long stall 1402 ms at 1791864866.196; kotlin collection 241: stopped 0.1 ms (after waiting 10.2 ms), then 0.0 ms, took 50.5 ms
- shared, day-sheet round 4: long stall 288 ms at 1791864908.023; kotlin collection 275: stopped 0.0 ms (after waiting 10.0 ms), then 0.1 ms, took 26.2 ms
- shared, day-sheet round 4: long stall 498 ms at 1791864908.311; kotlin collection 275: stopped 0.0 ms (after waiting 10.0 ms), then 0.1 ms, took 26.2 ms
- shared, day-sheet round 4: long stall 524 ms at 1791864917.389; kotlin collection 275: stopped 0.0 ms (after waiting 10.0 ms), then 0.1 ms, took 26.2 ms
- shared, day-sheet round 4: long stall 451 ms at 1791864918.912; kotlin collection 276: stopped 1.3 ms (after waiting 0.0 ms), then 0.5 ms, took 34.0 ms
- shared, day-sheet round 4: long stall 479 ms at 1791864920.451; kotlin collection 276: stopped 1.3 ms (after waiting 0.0 ms), then 0.5 ms, took 34.0 ms
- shared, day-sheet round 4: long stall 1799 ms at 1791864931.059; kotlin collection 277: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 8.4 ms
- shared, widget-publish round 4: long stall 250 ms at 1791865067.778; kotlin collection 270: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 8.5 ms
- shared, widget-publish round 4: long stall 694 ms at 1791865068.029; kotlin collection 270: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 8.5 ms

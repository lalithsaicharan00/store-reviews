# claude/shared-habit-rules-perf28 @ e0b7590 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38317938498 · 2026-10-12 23:27 UTC
Commit: Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `scroll-today tap-today` · rounds: 6

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: e0b7590d Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Today: scrolling | **12.9**<br>21.2 (121, 1), 7.1 (44, 0), 10.7 (81, 0), 4.4 (34, 0), 15.1 (116, 1), 23.5 (144, 2) | **7.2**<br>17.4 (95, 0), 5 (32, 0), 7 (47, 0), 7 (38, 0), 7.4 (42, 0), 17.1 (120, 1) |
| Today: +1 and day ‹ › | **28.4**<br>42.3 (59, 0), 28 (44, 0), 28.8 (131, 1), 33.8 (60, 0), 22.9 (52, 0), 17.9 (67, 0) | **21.3**<br>15.7 (53, 0), 26.9 (56, 0), 13.1 (54, 0), 11.5 (71, 0), 34 (81, 0), 52.5 (107, 1) |
| Today: +1 alone | **0.3**<br>2.9 (50, 0), 0.1 (19, 0), 0.3 (21, 0), 0 (17, 0), 0.3 (22, 0), 0.8 (26, 0) | **0.6**<br>0 (0, 0), 0.6 (24, 0), 1.7 (38, 0), 0.2 (19, 0), 1.6 (30, 0), 0.6 (25, 0) |
| Today: day ‹ › alone | **22.3**<br>44.4 (66, 0), 16.5 (49, 0), 11.8 (47, 0), 21 (50, 0), 23.6 (45, 0), 29 (68, 0) | **26.4**<br>26.6 (55, 0), 26.2 (51, 0), 16.7 (46, 0), 64.4 (72, 0), 22.1 (38, 0), 36.7 (79, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **1.1**<br>0 (0, 0), 0.1 (18, 0), 2.4 (32, 0), 2.3 (44, 0), 2.1 (39, 0), 0 (0, 0) | **0.0**<br>3.2 (64, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 24 · 7809 · 1358.5 | 24 · 6206 · 1045.0 |
| Widgets: one habit's week | 301 · 1368 · 97.0 | 305 · 1332 · 73.6 |
| Store load: into the app (5593 logs) | 12 · 651 · 78.3 | 12 · 652 · 74.6 |
| Store load: into the app (0 logs) | 12 · 24 · 4.4 | 12 · 18 · 3.8 |
| Widgets: the snapshot | 109 · 124 · 5.5 | 113 · 156 · 5.1 |
| Reminders: plan every alert | 357 · 26 · 0.8 | 357 · 33 · 1.2 |
| Count: Today's list drawn | 618 · 0 · 0.5 | 606 · 1 · 0.9 |
| Count: a Today row drawn | 4756 · 0 · 0.0 | 4592 · 0 · 0.0 |
| Shared rules: built from every log, off the main thread | – | 24 · 167 · 23.1 |
| Shared rules: built from every log | – | 24 · 93 · 15.6 |
| Shared rules: habits and settings again | – | 72 · 75 · 19.9 |
| Change: Siri's habit names | 347 · 21 · 0.3 | 346 · 21 · 0.3 |
| Count: the Day sheet drawn | 82 · 0 · 0.0 | 81 · 0 · 0.0 |
| Count: the Day sheet's activity drawn | 82 · 0 · 0.0 | 81 · 0 · 0.0 |
| Shared rules: a log added | – | 340 · 23 · 1.7 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- shared, scroll-today round 1: long stall 438 ms at 1791846001.585; kotlin collection 138: stopped 2.0 ms (after waiting 10.0 ms), then 0.0 ms, took 249.8 ms
- shared, scroll-today round 1: long stall 1289 ms at 1791846016.953; kotlin collection 257: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 35.4 ms
- shared, tap-today round 1: long stall 577 ms at 1791846171.081; kotlin collection 234: stopped 0.0 ms (after waiting 9.0 ms), then 0.1 ms, took 13.5 ms
- shared, tap-today round 1: long stall 500 ms at 1791846226.850; kotlin collection 239: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 13.1 ms
- shared, tap-today round 1: long stall 256 ms at 1791846229.578; kotlin collection 240: stopped 2.2 ms (after waiting 0.0 ms), then 0.5 ms, took 9.7 ms
- shared, tap-today round 1: long stall 366 ms at 1791846232.349; kotlin collection 240: stopped 2.2 ms (after waiting 0.0 ms), then 0.5 ms, took 9.7 ms
- shared, tap-today round 1: long stall 886 ms at 1791846233.220; kotlin collection 240: stopped 2.2 ms (after waiting 0.0 ms), then 0.5 ms, took 9.7 ms
- shared, tap-today round 1: long stall 341 ms at 1791846234.107; kotlin collection 240: stopped 2.2 ms (after waiting 0.0 ms), then 0.5 ms, took 9.7 ms
- shared, tap-today round 1: long stall 315 ms at 1791846235.117; kotlin collection 240: stopped 2.2 ms (after waiting 0.0 ms), then 0.5 ms, took 9.7 ms
- shared, scroll-today round 2: long stall 449 ms at 1791846263.750; kotlin collection 288: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.8 ms
- shared, tap-today round 2: long stall 734 ms at 1791846376.139; kotlin collection 262: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 14.6 ms
- shared, tap-today round 2: long stall 445 ms at 1791846431.982; kotlin collection 267: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 3.9 ms
- shared, tap-today round 2: long stall 600 ms at 1791846438.120; kotlin collection 268: stopped 0.0 ms (after waiting 0.0 ms), then 3.7 ms, took 14.3 ms
- shared, tap-today round 2: long stall 377 ms at 1791846438.963; kotlin collection 268: stopped 0.0 ms (after waiting 0.0 ms), then 3.7 ms, took 14.3 ms
- shared, tap-today round 2: long stall 251 ms at 1791846440.092; kotlin collection 268: stopped 0.0 ms (after waiting 0.0 ms), then 3.7 ms, took 14.3 ms
- shared, scroll-today round 3: long stall 489 ms at 1791846614.747; kotlin collection 277: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.1 ms
- shared, tap-today round 3: long stall 482 ms at 1791846746.125; kotlin collection 264: stopped 0.0 ms (after waiting 0.1 ms), then 0.0 ms, took 18.4 ms
- shared, tap-today round 3: long stall 376 ms at 1791846801.113; kotlin collection 269: stopped 0.0 ms (after waiting 0.0 ms), then 0.5 ms, took 6.9 ms
- shared, tap-today round 3: long stall 517 ms at 1791846807.387; kotlin collection 270: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 4.8 ms
- shared, scroll-today round 4: long stall 487 ms at 1791846837.712; kotlin collection 288: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.3 ms
- shared, tap-today round 4: long stall 489 ms at 1791846911.899; kotlin collection 284: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.9 ms
- shared, tap-today round 4: long stall 891 ms at 1791846967.259; kotlin collection 289: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 10.0 ms
- shared, tap-today round 4: long stall 430 ms at 1791846970.060; kotlin collection 290: stopped 0.1 ms (after waiting 0.0 ms), then 7.3 ms, took 39.7 ms
- shared, tap-today round 4: long stall 438 ms at 1791846972.769; kotlin collection 290: stopped 0.1 ms (after waiting 0.0 ms), then 7.3 ms, took 39.7 ms
- shared, tap-today round 4: long stall 1640 ms at 1791846973.704; kotlin collection 290: stopped 0.1 ms (after waiting 0.0 ms), then 7.3 ms, took 39.7 ms
- shared, tap-today round 4: long stall 262 ms at 1791846975.437; kotlin collection 290: stopped 0.1 ms (after waiting 0.0 ms), then 7.3 ms, took 39.7 ms
- shared, tap-today round 4: long stall 525 ms at 1791846975.699; kotlin collection 290: stopped 0.1 ms (after waiting 0.0 ms), then 7.3 ms, took 39.7 ms
- shared, scroll-today round 5: long stall 288 ms at 1791847146.336; kotlin collection 262: stopped 0.0 ms (after waiting 1.1 ms), then 0.0 ms, took 36.8 ms
- shared, scroll-today round 5: long stall 401 ms at 1791847146.625; kotlin collection 262: stopped 0.0 ms (after waiting 1.1 ms), then 0.0 ms, took 36.8 ms
- shared, tap-today round 5: long stall 879 ms at 1791847287.384; kotlin collection 255: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 12.2 ms
- shared, tap-today round 5: long stall 532 ms at 1791847343.237; kotlin collection 261: stopped 0.1 ms (after waiting 0.0 ms), then 0.8 ms, took 12.3 ms
- shared, tap-today round 5: long stall 661 ms at 1791847349.498; kotlin collection 261: stopped 0.1 ms (after waiting 0.0 ms), then 0.8 ms, took 12.3 ms
- shared, tap-today round 5: long stall 503 ms at 1791847350.163; kotlin collection 261: stopped 0.1 ms (after waiting 0.0 ms), then 0.8 ms, took 12.3 ms
- shared, tap-today round 5: long stall 302 ms at 1791847351.404; kotlin collection 261: stopped 0.1 ms (after waiting 0.0 ms), then 0.8 ms, took 12.3 ms
- shared, scroll-today round 6: long stall 771 ms at 1791847382.298; kotlin collection 278: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 4.8 ms
- shared, tap-today round 6: long stall 832 ms at 1791847474.642; kotlin collection 238: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 35.3 ms
- shared, tap-today round 6: long stall 530 ms at 1791847530.196; kotlin collection 244: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 4.6 ms
- shared, tap-today round 6: long stall 253 ms at 1791847535.770; kotlin collection 244: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 4.6 ms
- shared, tap-today round 6: long stall 1194 ms at 1791847536.517; kotlin collection 244: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 4.6 ms
- shared, tap-today round 6: long stall 273 ms at 1791847538.458; kotlin collection 244: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 4.6 ms

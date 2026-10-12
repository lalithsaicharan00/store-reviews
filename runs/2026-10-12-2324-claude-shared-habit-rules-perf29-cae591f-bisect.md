# claude/shared-habit-rules-perf29 @ cae591f (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38317940829 · 2026-10-12 23:24 UTC
Commit: Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `progress-year calendar` · rounds: 6

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: cae591f6 Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Progress Year: sideways | **0.0**<br>0 (0, 0), 14.7 (226, 1), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0.5 (24, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Progress Year: scrolling | **23.9**<br>490.7 (7037, 1), 18.2 (64, 0), 31.3 (66, 0), 29.5 (131, 1), 3.2 (34, 0), 0.8 (28, 0) | **14.6**<br>31.5 (75, 0), 38.1 (85, 0), 11.9 (43, 0), 17.2 (59, 0), 0 (17, 0), 0.7 (25, 0) |
| Calendar: month ‹ › | **4.4**<br>13.7 (142, 1), 12.6 (118, 1), 3.9 (40, 0), 0 (17, 0), 4.9 (84, 0), 2.6 (23, 0) | **7.2**<br>14.7 (136, 1), 6.8 (88, 0), 7.6 (32, 0), 0.3 (21, 0), 1.3 (21, 0), 8 (46, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 24 · 7247 · 981.4 | 24 · 5479 · 954.1 |
| Widgets: one habit's week | 204 · 1396 · 143.8 | 204 · 1376 · 274.9 |
| Store load: into the app (5593 logs) | 12 · 800 · 135.3 | 12 · 614 · 69.9 |
| Progress year: whole snapshot | 6 · 218 · 51.0 | 6 · 147 · 28.3 |
| Progress year: cards | 6 · 215 · 49.5 | 6 · 144 · 27.5 |
| Progress year: one card | 90 · 204 · 14.3 | 90 · 136 · 7.8 |
| Progress week: whole snapshot | 6 · 10 · 3.1 | 6 · 12 · 3.7 |
| Progress week: cards | 6 · 9 · 2.9 | 6 · 10 · 3.4 |
| Widgets: the snapshot | 12 · 28 · 7.7 | 12 · 33 · 4.1 |
| Store load: into the app (0 logs) | 12 · 21 · 4.2 | 12 · 14 · 2.3 |
| Progress week: one card | 90 · 6 · 0.3 | 90 · 7 · 0.7 |
| Reminders: plan every alert | 12 · 2 · 1.0 | 12 · 5 · 4.2 |
| Progress week: one quit card | 12 · 2 · 0.7 | 12 · 1 · 0.4 |
| Progress year: one quit card | 12 · 4 · 0.5 | 12 · 4 · 0.5 |
| Count: Today's list drawn | 150 · 0 · 0.3 | 150 · 2 · 0.9 |
| Count: a Today row drawn | 883 · 0 · 0.1 | 766 · 0 · 0.0 |
| Shared rules: built from every log | – | 24 · 114 · 30.1 |
| Shared rules: built from every log, off the main thread | – | 24 · 120 · 15.8 |
| Shared rules: habits and settings again | – | 60 · 35 · 3.5 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- shared, progress-year round 1: long stall 295 ms at 1791846252.806; kotlin collection 1: stopped 0.1 ms (after waiting 10.0 ms), then 0.0 ms, took 62.0 ms
- shared, progress-year round 1: long stall 1099 ms at 1791846264.707; kotlin collection 248: stopped 0.1 ms (after waiting 0.0 ms), then 0.0 ms, took 18.9 ms
- shared, progress-year round 1: long stall 275 ms at 1791846265.852; kotlin collection 248: stopped 0.1 ms (after waiting 0.0 ms), then 0.0 ms, took 18.9 ms
- shared, progress-year round 1: long stall 1907 ms at 1791846275.054; kotlin collection 249: stopped 0.2 ms (after waiting 0.0 ms), then 0.5 ms, took 22.5 ms
- shared, calendar round 1: long stall 1038 ms at 1791846394.443; kotlin collection 234: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.1 ms
- shared, calendar round 1: long stall 588 ms at 1791846403.914; kotlin collection 235: stopped 0.1 ms (after waiting 0.0 ms), then 0.6 ms, took 31.3 ms
- shared, calendar round 1: long stall 331 ms at 1791846406.683; kotlin collection 235: stopped 0.1 ms (after waiting 0.0 ms), then 0.6 ms, took 31.3 ms
- shared, progress-year round 2: long stall 737 ms at 1791846439.535; kotlin collection 274: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.6 ms
- shared, progress-year round 2: long stall 1015 ms at 1791846448.922; kotlin collection 275: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 14.9 ms
- shared, progress-year round 2: long stall 287 ms at 1791846451.774; kotlin collection 275: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 14.9 ms
- shared, progress-year round 2: long stall 359 ms at 1791846483.681; kotlin collection 278: stopped 0.1 ms (after waiting 0.0 ms), then 0.4 ms, took 14.9 ms
- shared, calendar round 2: long stall 732 ms at 1791846579.503; kotlin collection 263: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.6 ms
- shared, calendar round 2: long stall 665 ms at 1791846588.953; kotlin collection 264: stopped 0.1 ms (after waiting 0.0 ms), then 0.2 ms, took 21.7 ms
- shared, calendar round 2: long stall 283 ms at 1791846591.777; kotlin collection 264: stopped 0.1 ms (after waiting 0.0 ms), then 0.2 ms, took 21.7 ms
- shared, progress-year round 3: long stall 852 ms at 1791846755.157; kotlin collection 235: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 17.6 ms
- shared, progress-year round 3: long stall 630 ms at 1791846764.860; kotlin collection 236: stopped 0.1 ms (after waiting 0.0 ms), then 0.4 ms, took 17.3 ms
- shared, progress-year round 3: long stall 332 ms at 1791846799.475; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 6.0 ms
- shared, calendar round 3: long stall 577 ms at 1791846868.553; kotlin collection 265: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 26.4 ms
- shared, calendar round 3: long stall 572 ms at 1791846877.866; kotlin collection 265: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 26.4 ms
- shared, progress-year round 4: long stall 611 ms at 1791846910.386; kotlin collection 289: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.7 ms
- shared, progress-year round 4: long stall 662 ms at 1791846919.774; kotlin collection 290: stopped 0.0 ms (after waiting 0.1 ms), then 0.6 ms, took 15.9 ms
- shared, calendar round 4: long stall 333 ms at 1791847028.031; kotlin no collection yet
- shared, calendar round 4: long stall 665 ms at 1791847034.026; kotlin collection 268: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 19.6 ms
- shared, calendar round 4: long stall 296 ms at 1791847043.561; kotlin collection 268: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 19.6 ms
- shared, progress-year round 5: long stall 468 ms at 1791847175.168; kotlin collection 264: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 14.2 ms
- shared, progress-year round 5: long stall 396 ms at 1791847184.183; kotlin collection 264: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 14.2 ms
- shared, calendar round 5: long stall 526 ms at 1791847272.396; kotlin collection 276: stopped 0.0 ms (after waiting 2.4 ms), then 0.0 ms, took 8.8 ms
- shared, calendar round 5: long stall 263 ms at 1791847281.786; kotlin collection 276: stopped 0.0 ms (after waiting 2.4 ms), then 0.0 ms, took 8.8 ms
- shared, progress-year round 6: long stall 454 ms at 1791847318.202; kotlin collection 292: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.6 ms
- shared, calendar round 6: long stall 500 ms at 1791847422.756; kotlin collection 269: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.4 ms
- shared, calendar round 6: long stall 286 ms at 1791847431.859; kotlin collection 269: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.4 ms

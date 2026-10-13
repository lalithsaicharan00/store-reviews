# claude/shared-habit-rules-perf36 @ fe82fc6 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38379219482 · 2026-10-13 10:39 UTC
Commit: Current Work 92: the menu and Progress side by side with main (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ac462364 shared=HEAD` · scenarios: `menu progress` · rounds: 6

- main: ac462364 Current Work 93: say which widgets are free and which are Plus in the store screenshots, the website 
- shared: fe82fc68 Current Work 92: the menu and Progress side by side with main (scratch, safe to delete) [ios-perf-bis

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Menu: open and close | **45.6**<br>67.2 (216, 4), 59.1 (141, 3), 32.5 (117, 1), 40.6 (228, 1), 50.6 (111, 1), 37.2 (150, 1) | **45.2**<br>71.8 (324, 2), 95 (363, 7), 46.4 (128, 1), 44.1 (186, 2), 32.9 (96, 0), 35.7 (111, 1) |
| Progress: scrolling | **5.1**<br>117.6 (657, 4), 7 (44, 0), 0.2 (20, 0), 3.2 (32, 0), 1.5 (28, 0), 25.5 (66, 0) | **1.2**<br>14.9 (52, 0), 1.1 (30, 0), 1.4 (36, 0), 1 (31, 0), 4.5 (32, 0), 0.4 (22, 0) |
| Progress: period ‹ › and range | **114.0**<br>221.7 (625, 11), 111 (141, 4), 80.2 (238, 1), 116.9 (136, 5), 73.3 (98, 0), 145.2 (153, 8) | **82.3**<br>130.5 (136, 6), 132.7 (273, 5), 75.9 (106, 1), 67.6 (110, 1), 88.8 (114, 2), 68.4 (98, 0) |
| Progress: key fold and open | **0.2**<br>0 (0, 0), 0.2 (20, 0), 0.3 (22, 0), 0.2 (19, 0), 0.6 (25, 0), 0.4 (22, 0) | **0.2**<br>24.5 (382, 1), 0 (0, 0), 0.2 (20, 0), 0.9 (30, 0), 0 (0, 0), 0.2 (20, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 24 · 11236 · 3312.2 | 24 · 7482 · 906.4 |
| Widgets: one habit's week | 204 · 1415 · 153.5 | 204 · 1238 · 139.1 |
| Store load: into the app (5594 logs) | 12 · 766 · 89.3 | 12 · 852 · 197.7 |
| Store load: into the app (0 logs) | 12 · 25 · 6.6 | 12 · 21 · 4.9 |
| Count: Today's list drawn | 198 · 1 · 1.0 | 217 · 4 · 1.2 |
| Widgets: the snapshot | 12 · 21 · 4.0 | 12 · 27 · 3.4 |
| Reminders: plan every alert | 12 · 3 · 1.1 | 12 · 3 · 1.0 |
| Count: a Today row drawn | 687 · 0 · 0.0 | 789 · 0 · 0.0 |
| Shared rules: built from every log | – | 24 · 116 · 28.6 |
| Shared rules: built from every log, off the main thread | – | 24 · 159 · 17.6 |
| Shared rules: habits and settings again | – | 60 · 46 · 7.8 |
| Count: shared rules' inputs changed: habits | – | 204 · 0 · 0.0 |
| Count: shared rules given habits and settings again, changed | – | 60 · 0 · 0.0 |
| Count: habits set | – | 216 · 0 · 0.0 |
| Count: settings set | – | 72 · 0 · 0.0 |
| Count: timers set | – | 24 · 0 · 0.0 |
| Count: logs changed, announced | – | 24 · 0 · 0.0 |
| Count: logs changed, every habit marked | – | 24 · 0 · 0.0 |
| Progress year: whole snapshot | 12 · 268 · 46.8 | 12 · 234 · 27.2 |
| Progress year: cards | 12 · 265 · 46.5 | 12 · 232 · 27.1 |
| Progress year: one card | 180 · 250 · 9.1 | 180 · 220 · 6.6 |
| Progress week: whole snapshot | 12 · 80 · 16.9 | 12 · 73 · 12.3 |
| Progress week: cards | 12 · 76 · 16.6 | 12 · 69 · 12.1 |
| Progress week: one card | 180 · 63 · 13.6 | 180 · 58 · 9.0 |
| Progress month: whole snapshot | 12 · 36 · 4.9 | 12 · 33 · 3.5 |
| Progress month: cards | 12 · 34 · 4.8 | 12 · 29 · 3.3 |
| Progress month: one card | 180 · 26 · 1.1 | 180 · 23 · 0.5 |
| Progress week: one quit card | 24 · 3 · 0.8 | 24 · 4 · 0.6 |
| Progress year: one quit card | 12 · 1 · 0.5 | 12 · 1 · 0.3 |
| Progress month: one quit card | 24 · 0 · 0.2 | 24 · 1 · 0.3 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- shared, menu round 1: long stall 266 ms at 1791886539.838; kotlin no collection yet
- shared, menu round 1: long stall 1733 ms at 1791886553.748; kotlin collection 234: stopped 0.1 ms (after waiting 107.6 ms), then 0.6 ms, took 190.6 ms
- shared, menu round 1: long stall 324 ms at 1791886564.297; kotlin collection 235: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 24.0 ms
- shared, progress round 1: long stall 905 ms at 1791886702.129; kotlin collection 245: stopped 0.0 ms (after waiting 0.0 ms), then 5.7 ms, took 26.1 ms
- shared, progress round 1: long stall 797 ms at 1791886711.491; kotlin collection 246: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 22.3 ms
- shared, progress round 1: long stall 382 ms at 1791886754.856; kotlin collection 250: stopped 0.3 ms (after waiting 0.0 ms), then 0.1 ms, took 17.7 ms
- shared, menu round 2: long stall 829 ms at 1791886786.004; kotlin collection 236: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 40.6 ms
- shared, menu round 2: long stall 363 ms at 1791886795.754; kotlin collection 237: stopped 0.1 ms (after waiting 0.0 ms), then 0.2 ms, took 12.0 ms
- shared, progress round 2: long stall 821 ms at 1791886884.157; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 29.0 ms
- shared, progress round 2: long stall 342 ms at 1791886893.477; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 29.0 ms
- shared, progress round 2: long stall 285 ms at 1791886893.820; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 29.0 ms
- shared, progress round 2: long stall 273 ms at 1791886920.071; kotlin collection 240: stopped 0.1 ms (after waiting 0.0 ms), then 0.1 ms, took 10.8 ms
- shared, menu round 3: long stall 308 ms at 1791887078.339; kotlin collection 256: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 14.2 ms
- shared, progress round 3: long stall 545 ms at 1791887203.803; kotlin collection 235: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 18.2 ms
- shared, progress round 3: long stall 476 ms at 1791887213.270; kotlin collection 235: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 18.2 ms
- shared, menu round 4: long stall 518 ms at 1791887274.689; kotlin collection 290: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.5 ms
- shared, progress round 4: long stall 626 ms at 1791887351.282; kotlin collection 263: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 6.8 ms
- shared, progress round 4: long stall 420 ms at 1791887360.781; kotlin collection 263: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 6.8 ms
- shared, menu round 5: long stall 586 ms at 1791887555.823; kotlin collection 234: stopped 0.1 ms (after waiting 0.0 ms), then 0.0 ms, took 18.7 ms
- shared, progress round 5: long stall 457 ms at 1791887672.379; kotlin collection 263: stopped 0.0 ms (after waiting 0.1 ms), then 0.0 ms, took 4.2 ms
- shared, progress round 5: long stall 548 ms at 1791887681.429; kotlin collection 264: stopped 0.0 ms (after waiting 0.0 ms), then 4.7 ms, took 33.7 ms
- shared, progress round 5: long stall 419 ms at 1791887684.267; kotlin collection 265: stopped 0.0 ms (after waiting 0.0 ms), then 0.8 ms, took 19.3 ms
- shared, menu round 6: long stall 260 ms at 1791887739.467; kotlin no collection yet
- shared, menu round 6: long stall 618 ms at 1791887747.035; kotlin collection 272: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 26.5 ms
- shared, progress round 6: long stall 332 ms at 1791887832.580; kotlin collection 264: stopped 0.0 ms (after waiting 0.8 ms), then 0.0 ms, took 15.7 ms
- shared, progress round 6: long stall 502 ms at 1791887841.363; kotlin collection 264: stopped 0.0 ms (after waiting 0.8 ms), then 0.0 ms, took 15.7 ms

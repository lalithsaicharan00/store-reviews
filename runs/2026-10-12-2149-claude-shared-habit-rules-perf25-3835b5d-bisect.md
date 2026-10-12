# claude/shared-habit-rules-perf25 @ 3835b5d (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38307049012 · 2026-10-12 21:49 UTC
Commit: Current Work 92: speed side by side with main, all optimisations (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `progress-year calendar` · rounds: 6

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: 3835b5d0 Current Work 92: speed side by side with main, all optimisations (scratch, safe to delete) [ios-perf-

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Progress Year: sideways | **0.0**<br>0 (0, 0), 12.4 (78, 0), 0.3 (21, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.2**<br>74.4 (718, 2), 0 (0, 0), 0 (0, 0), 0.5 (25, 0), 0 (0, 0), 0.6 (26, 0) |
| Progress Year: scrolling | **17.5**<br>17.1 (83, 0), 26.2 (60, 0), 23.9 (72, 0), 13.8 (77, 0), 17.9 (62, 0), 11.7 (69, 0) | **22.6**<br>58.3 (124, 1), 17 (59, 0), 41.1 (77, 0), 24.6 (70, 0), 20.6 (50, 0), 13.9 (61, 0) |
| Calendar: month ‹ › | **18.1**<br>7.1 (30, 0), 13.9 (96, 0), 43.3 (118, 1), 22.7 (46, 0), 22.2 (38, 0), 9 (32, 0) | **12.2**<br>32.5 (60, 0), 29.2 (68, 0), 13 (62, 0), 9.9 (98, 0), 11.3 (37, 0), 9.2 (40, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 24 · 10238 · 1914.1 | 24 · 11041 · 1990.5 |
| Widgets: one habit's week | 204 · 1205 · 87.2 | 204 · 1352 · 97.5 |
| Store load: into the app (5593 logs) | 12 · 748 · 75.9 | 12 · 881 · 181.3 |
| Progress year: whole snapshot | 6 · 217 · 43.6 | 6 · 194 · 40.9 |
| Progress year: cards | 6 · 212 · 43.0 | 6 · 191 · 40.1 |
| Progress year: one card | 90 · 200 · 14.2 | 90 · 179 · 14.3 |
| Store load: into the app (0 logs) | 12 · 35 · 7.7 | 12 · 15 · 3.1 |
| Progress week: whole snapshot | 6 · 11 · 2.6 | 6 · 25 · 11.0 |
| Widgets: the snapshot | 12 · 22 · 3.0 | 12 · 32 · 9.0 |
| Progress week: cards | 6 · 10 · 1.9 | 6 · 22 · 8.9 |
| Progress week: one card | 90 · 6 · 0.3 | 90 · 13 · 2.3 |
| Reminders: plan every alert | 12 · 5 · 1.6 | 12 · 5 · 1.3 |
| Progress year: one quit card | 12 · 5 · 0.7 | 12 · 4 · 0.8 |
| Progress week: one quit card | 12 · 1 · 0.5 | 12 · 5 · 2.6 |
| Count: Today's list drawn | 150 · 4 · 1.3 | 152 · 7 · 2.0 |
| Count: a Today row drawn | 867 · 0 · 0.0 | 781 · 0 · 0.0 |
| Shared rules: built from every log, off the main thread | – | 24 · 165 · 22.8 |
| Shared rules: built from every log | – | 24 · 167 · 29.3 |
| Shared rules: habits and settings again | – | 60 · 63 · 6.0 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- shared, progress-year round 1: long stall 1523 ms at 1791840351.648; kotlin collection 237: stopped 0.0 ms (after waiting 10.0 ms), then 0.1 ms, took 470.6 ms
- shared, progress-year round 1: long stall 1221 ms at 1791840362.187; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 0.6 ms, took 18.0 ms
- shared, progress-year round 1: long stall 431 ms at 1791840363.721; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 0.6 ms, took 18.0 ms
- shared, progress-year round 1: long stall 283 ms at 1791840364.152; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 0.6 ms, took 18.0 ms
- shared, progress-year round 1: long stall 523 ms at 1791840364.898; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 0.6 ms, took 18.0 ms
- shared, progress-year round 1: long stall 295 ms at 1791840380.533; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 10.2 ms
- shared, progress-year round 1: long stall 718 ms at 1791840381.002; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 10.2 ms
- shared, progress-year round 1: long stall 1437 ms at 1791840397.115; kotlin collection 241: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 56.5 ms
- shared, progress-year round 1: long stall 345 ms at 1791840399.479; kotlin collection 241: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 56.5 ms
- shared, calendar round 1: long stall 886 ms at 1791840537.702; kotlin collection 241: stopped 0.1 ms (after waiting 0.0 ms), then 0.0 ms, took 36.6 ms
- shared, calendar round 1: long stall 446 ms at 1791840547.412; kotlin collection 242: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 19.3 ms
- shared, calendar round 1: long stall 330 ms at 1791840550.181; kotlin collection 242: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 19.3 ms
- shared, progress-year round 2: long stall 647 ms at 1791840590.064; kotlin collection 235: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 43.6 ms
- shared, progress-year round 2: long stall 1047 ms at 1791840599.501; kotlin collection 236: stopped 0.1 ms (after waiting 0.0 ms), then 0.1 ms, took 10.7 ms
- shared, progress-year round 2: long stall 486 ms at 1791840600.972; kotlin collection 236: stopped 0.1 ms (after waiting 0.0 ms), then 0.1 ms, took 10.7 ms
- shared, progress-year round 2: long stall 424 ms at 1791840602.345; kotlin collection 236: stopped 0.1 ms (after waiting 0.0 ms), then 0.1 ms, took 10.7 ms
- shared, progress-year round 2: long stall 314 ms at 1791840634.326; kotlin collection 239: stopped 0.2 ms (after waiting 0.0 ms), then 0.6 ms, took 57.0 ms
- shared, calendar round 2: long stall 273 ms at 1791840718.752; kotlin no collection yet
- shared, calendar round 2: long stall 1077 ms at 1791840737.061; kotlin collection 237: stopped 10.6 ms (after waiting 11.9 ms), then 0.0 ms, took 71.9 ms
- shared, calendar round 2: long stall 667 ms at 1791840746.911; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 1.7 ms, took 20.2 ms
- shared, calendar round 2: long stall 441 ms at 1791840749.703; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 1.7 ms, took 20.2 ms
- shared, progress-year round 3: long stall 649 ms at 1791840931.513; kotlin collection 238: stopped 1.1 ms (after waiting 10.3 ms), then 0.0 ms, took 34.5 ms
- shared, progress-year round 3: long stall 446 ms at 1791840940.607; kotlin collection 238: stopped 1.1 ms (after waiting 10.3 ms), then 0.0 ms, took 34.5 ms
- shared, progress-year round 3: long stall 648 ms at 1791840975.319; kotlin collection 242: stopped 0.2 ms (after waiting 0.0 ms), then 0.2 ms, took 27.8 ms
- shared, calendar round 3: long stall 1131 ms at 1791841062.924; kotlin collection 233: stopped 0.1 ms (after waiting 10.7 ms), then 0.5 ms, took 49.2 ms
- shared, calendar round 3: long stall 658 ms at 1791841072.970; kotlin collection 234: stopped 0.5 ms (after waiting 0.0 ms), then 0.9 ms, took 27.1 ms
- shared, calendar round 3: long stall 367 ms at 1791841075.830; kotlin collection 234: stopped 0.5 ms (after waiting 0.0 ms), then 0.9 ms, took 27.1 ms
- shared, progress-year round 4: long stall 679 ms at 1791841107.429; kotlin collection 281: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.7 ms
- shared, progress-year round 4: long stall 824 ms at 1791841116.615; kotlin collection 281: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.7 ms
- shared, progress-year round 4: long stall 286 ms at 1791841118.127; kotlin collection 282: stopped 0.6 ms (after waiting 0.0 ms), then 4.4 ms, took 42.4 ms
- shared, progress-year round 4: long stall 343 ms at 1791841151.236; kotlin collection 285: stopped 0.1 ms (after waiting 0.0 ms), then 0.1 ms, took 21.7 ms
- shared, calendar round 4: long stall 661 ms at 1791841235.821; kotlin collection 275: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 5.4 ms
- shared, calendar round 4: long stall 444 ms at 1791841245.272; kotlin collection 275: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 5.4 ms
- shared, calendar round 4: long stall 260 ms at 1791841248.087; kotlin collection 276: stopped 0.0 ms (after waiting 0.0 ms), then 0.6 ms, took 17.8 ms
- shared, progress-year round 5: long stall 262 ms at 1791841390.531; kotlin no collection yet
- shared, progress-year round 5: long stall 727 ms at 1791841403.287; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 5.2 ms
- shared, progress-year round 5: long stall 437 ms at 1791841412.545; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 5.2 ms
- shared, progress-year round 5: long stall 271 ms at 1791841412.982; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 5.2 ms
- shared, progress-year round 5: long stall 250 ms at 1791841415.515; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 0.9 ms, took 15.1 ms
- shared, calendar round 5: long stall 814 ms at 1791841521.925; kotlin collection 246: stopped 0.0 ms (after waiting 10.4 ms), then 0.0 ms, took 26.9 ms
- shared, calendar round 5: long stall 561 ms at 1791841531.269; kotlin collection 246: stopped 0.0 ms (after waiting 10.4 ms), then 0.0 ms, took 26.9 ms
- shared, calendar round 5: long stall 349 ms at 1791841534.146; kotlin collection 247: stopped 0.1 ms (after waiting 0.0 ms), then 1.2 ms, took 36.7 ms
- shared, progress-year round 6: long stall 380 ms at 1791841563.694; kotlin collection 288: stopped 0.0 ms (after waiting 3.8 ms), then 0.0 ms, took 11.5 ms
- shared, progress-year round 6: long stall 616 ms at 1791841572.483; kotlin collection 288: stopped 0.0 ms (after waiting 3.8 ms), then 0.0 ms, took 11.5 ms
- shared, progress-year round 6: long stall 318 ms at 1791841574.072; kotlin collection 289: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 14.2 ms
- shared, calendar round 6: long stall 927 ms at 1791841688.206; kotlin collection 265: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.1 ms
- shared, calendar round 6: long stall 474 ms at 1791841697.685; kotlin collection 265: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.1 ms

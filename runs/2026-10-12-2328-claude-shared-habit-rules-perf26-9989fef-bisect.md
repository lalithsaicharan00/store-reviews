# claude/shared-habit-rules-perf26 @ 9989fef (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38317933563 · 2026-10-12 23:28 UTC
Commit: Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `habit-page progress` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: 9989fef9 Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Habit page: History scrolling | **9.6**<br>12.9 (99, 0), 8.3 (105, 1), 10.9 (115, 1), 7.1 (123, 1) | **5.4**<br>5.1 (58, 0), 5.7 (80, 0), 4.8 (74, 0), 6.9 (105, 1) |
| Habit page: Progress scrolling | **9.0**<br>46.8 (497, 1), 11.7 (51, 0), 6.3 (64, 0), 5.3 (38, 0) | **5.0**<br>5 (42, 0), 4.5 (31, 0), 10.4 (57, 0), 5.1 (42, 0) |
| Habit page: switching tabs | **6.0**<br>12.8 (109, 1), 1.8 (30, 0), 9.7 (37, 0), 2.3 (28, 0) | **3.0**<br>7.6 (49, 0), 2.8 (35, 0), 2.4 (31, 0), 3.3 (29, 0) |
| Progress: scrolling | **9.4**<br>12.6 (54, 0), 8 (37, 0), 5.6 (100, 1), 10.8 (48, 0) | **10.7**<br>4.5 (31, 0), 6.4 (42, 0), 20.2 (78, 0), 14.9 (60, 0) |
| Progress: period ‹ › and range | **143.9**<br>151.8 (335, 5), 136 (150, 6), 63.4 (102, 1), 198.3 (232, 13) | **133.2**<br>130.4 (222, 5), 135 (161, 8), 131.3 (196, 6), 171.1 (183, 13) |
| Progress: key fold and open | **0.9**<br>0.8 (29, 0), 0.7 (27, 0), 2.7 (55, 0), 0.9 (31, 0) | **1.5**<br>1.3 (37, 0), 1 (32, 0), 1.7 (43, 0), 3 (63, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 8781 · 1464.2 | 16 · 9741 · 2201.4 |
| Widgets: one habit's week | 136 · 1233 · 181.0 | 136 · 1005 · 144.7 |
| Store load: into the app (5593 logs) | 8 · 633 · 100.2 | 8 · 707 · 156.9 |
| Store load: into the app (0 logs) | 8 · 38 · 18.3 | 8 · 20 · 9.0 |
| Habit page: overall record | 4 · 33 · 13.1 | 4 · 47 · 17.5 |
| Habit page: history | 4 · 36 · 12.1 | 4 · 26 · 8.7 |
| Habit page: milestones | 4 · 39 · 17.2 | 4 · 33 · 9.3 |
| Widgets: the snapshot | 8 · 19 · 4.8 | 8 · 26 · 5.2 |
| Count: Today's list drawn | 135 · 4 · 0.8 | 157 · 4 · 3.3 |
| Reminders: plan every alert | 8 · 3 · 0.9 | 8 · 4 · 1.1 |
| Count: a Today row drawn | 1141 · 0 · 0.0 | 1335 · 0 · 0.0 |
| Shared rules: built from every log | – | 16 · 89 · 27.1 |
| Shared rules: built from every log, off the main thread | – | 16 · 136 · 29.3 |
| Shared rules: habits and settings again | – | 40 · 39 · 6.2 |
| Progress year: whole snapshot | 8 · 208 · 52.2 | 8 · 205 · 35.2 |
| Progress year: cards | 8 · 206 · 51.9 | 8 · 204 · 34.9 |
| Progress year: one card | 120 · 192 · 5.4 | 120 · 190 · 6.5 |
| Progress week: whole snapshot | 8 · 69 · 19.3 | 8 · 84 · 22.3 |
| Progress week: cards | 8 · 67 · 18.8 | 8 · 77 · 18.7 |
| Progress week: one card | 120 · 50 · 11.6 | 120 · 58 · 14.5 |
| Progress month: whole snapshot | 8 · 40 · 8.6 | 8 · 28 · 6.8 |
| Progress month: cards | 8 · 40 · 8.4 | 8 · 27 · 6.7 |
| Progress month: one card | 120 · 29 · 1.9 | 120 · 21 · 0.7 |
| Progress week: one quit card | 16 · 4 · 1.4 | 16 · 7 · 1.9 |
| Progress year: one quit card | 8 · 1 · 0.5 | 8 · 3 · 0.7 |
| Progress month: one quit card | 16 · 1 · 0.5 | 16 · 1 · 0.3 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- shared, habit-page round 1: long stall 1373 ms at 1791846419.969; kotlin collection 240: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 12.4 ms
- shared, habit-page round 1: long stall 462 ms at 1791846430.097; kotlin collection 241: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 19.3 ms
- shared, habit-page round 1: long stall 623 ms at 1791846431.657; kotlin collection 241: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 19.3 ms
- shared, habit-page round 1: long stall 285 ms at 1791846449.945; kotlin collection 243: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 18.7 ms
- shared, progress round 1: long stall 986 ms at 1791846607.704; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 15.0 ms
- shared, progress round 1: long stall 762 ms at 1791846617.295; kotlin collection 240: stopped 0.0 ms (after waiting 0.0 ms), then 0.5 ms, took 21.8 ms
- shared, progress round 1: long stall 255 ms at 1791846618.980; kotlin collection 240: stopped 0.0 ms (after waiting 0.0 ms), then 0.5 ms, took 21.8 ms
- shared, progress round 1: long stall 430 ms at 1791846620.107; kotlin collection 240: stopped 0.0 ms (after waiting 0.0 ms), then 0.5 ms, took 21.8 ms
- shared, habit-page round 2: long stall 289 ms at 1791846681.528; kotlin no collection yet
- shared, habit-page round 2: long stall 335 ms at 1791846696.843; kotlin collection 237: stopped 0.1 ms (after waiting 230.3 ms), then 0.0 ms, took 267.8 ms
- shared, habit-page round 2: long stall 496 ms at 1791846697.178; kotlin collection 237: stopped 0.1 ms (after waiting 230.3 ms), then 0.0 ms, took 267.8 ms
- shared, habit-page round 2: long stall 707 ms at 1791846706.632; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 0.7 ms, took 36.6 ms
- shared, habit-page round 2: long stall 673 ms at 1791846708.157; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 0.7 ms, took 36.6 ms
- shared, progress round 2: long stall 731 ms at 1791846877.168; kotlin collection 236: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 18.9 ms
- shared, progress round 2: long stall 663 ms at 1791846886.627; kotlin collection 237: stopped 0.1 ms (after waiting 0.0 ms), then 0.4 ms, took 27.5 ms
- shared, habit-page round 3: long stall 976 ms at 1791847139.486; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 20.9 ms
- shared, habit-page round 3: long stall 451 ms at 1791847148.944; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 20.9 ms
- shared, habit-page round 3: long stall 611 ms at 1791847150.493; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 1.0 ms, took 76.3 ms
- shared, habit-page round 3: long stall 255 ms at 1791847167.209; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 1.9 ms, took 29.2 ms
- shared, progress round 3: long stall 1167 ms at 1791847314.886; kotlin collection 236: stopped 9.3 ms (after waiting 10.1 ms), then 0.0 ms, took 81.3 ms
- shared, progress round 3: long stall 702 ms at 1791847324.941; kotlin collection 237: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 13.5 ms
- shared, progress round 3: long stall 331 ms at 1791847326.456; kotlin collection 237: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 13.5 ms
- shared, habit-page round 4: long stall 359 ms at 1791847394.025; kotlin collection 264: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 15.4 ms
- shared, habit-page round 4: long stall 383 ms at 1791847402.945; kotlin collection 264: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 15.4 ms
- shared, habit-page round 4: long stall 552 ms at 1791847404.449; kotlin collection 265: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 10.7 ms
- shared, progress round 4: long stall 979 ms at 1791847571.941; kotlin collection 236: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 8.9 ms
- shared, progress round 4: long stall 885 ms at 1791847581.422; kotlin collection 237: stopped 0.2 ms (after waiting 0.0 ms), then 0.4 ms, took 12.7 ms
- shared, progress round 4: long stall 301 ms at 1791847583.033; kotlin collection 237: stopped 0.2 ms (after waiting 0.0 ms), then 0.4 ms, took 12.7 ms
- shared, progress round 4: long stall 251 ms at 1791847584.425; kotlin collection 237: stopped 0.2 ms (after waiting 0.0 ms), then 0.4 ms, took 12.7 ms

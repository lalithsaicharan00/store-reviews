# claude/shared-habit-rules-perf22 @ 76b5916 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38307040055 · 2026-10-12 21:42 UTC
Commit: Current Work 92: speed side by side with main, all optimisations (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `habit-page progress` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: 76b59161 Current Work 92: speed side by side with main, all optimisations (scratch, safe to delete) [ios-perf-

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Habit page: History scrolling | **3.8**<br>2.2 (49, 0), 5.9 (84, 0), 4.2 (79, 0), 3.3 (66, 0) | **4.8**<br>4.8 (88, 0), 4.9 (78, 0), 3.3 (51, 0), 8.5 (135, 1) |
| Habit page: Progress scrolling | **10.6**<br>17.5 (96, 0), 14.7 (56, 0), 6.5 (61, 0), 4.4 (65, 0) | **10.1**<br>13.2 (128, 1), 8.6 (44, 0), 11.7 (80, 0), 1.9 (32, 0) |
| Habit page: switching tabs | **4.8**<br>8.6 (56, 0), 20.3 (122, 1), 1.1 (30, 0), 0.1 (19, 0) | **0.9**<br>0.6 (25, 0), 6.2 (53, 0), 1.2 (27, 0), 0.6 (23, 0) |
| Progress: scrolling | **8.0**<br>8.5 (48, 0), 4.4 (34, 0), 12.6 (46, 0), 7.4 (36, 0) | **11.0**<br>6.5 (39, 0), 12.4 (90, 0), 13.9 (75, 0), 9.6 (58, 0) |
| Progress: period ‹ › and range | **145.3**<br>172.9 (169, 12), 180.2 (191, 14), 117.8 (146, 5), 100.4 (143, 2) | **144.7**<br>131.7 (178, 6), 157.7 (212, 11), 205.5 (222, 16), 105.7 (188, 3) |
| Progress: key fold and open | **0.7**<br>0.9 (30, 0), 1.7 (42, 0), 0.5 (24, 0), 0.5 (24, 0) | **3.2**<br>23.9 (201, 1), 2 (48, 0), 4.4 (85, 0), 1.1 (34, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 8850 · 2161.5 | 16 · 5211 · 883.8 |
| Widgets: one habit's week | 136 · 972 · 159.3 | 136 · 910 · 93.4 |
| Store load: into the app (5593 logs) | 8 · 573 · 94.2 | 8 · 572 · 92.6 |
| Habit page: milestones | 4 · 34 · 10.7 | 4 · 38 · 11.4 |
| Habit page: overall record | 4 · 36 · 12.7 | 4 · 49 · 14.0 |
| Habit page: history | 4 · 26 · 7.8 | 4 · 33 · 11.6 |
| Store load: into the app (0 logs) | 8 · 24 · 5.1 | 8 · 14 · 5.0 |
| Widgets: the snapshot | 8 · 20 · 7.2 | 8 · 20 · 4.3 |
| Reminders: plan every alert | 8 · 2 · 0.8 | 8 · 4 · 1.1 |
| Count: Today's list drawn | 143 · 2 · 0.5 | 152 · 3 · 1.2 |
| Count: a Today row drawn | 1252 · 0 · 0.1 | 1236 · 0 · 0.0 |
| Shared rules: built from every log, off the main thread | – | 16 · 201 · 86.9 |
| Shared rules: built from every log | – | 16 · 66 · 13.9 |
| Shared rules: habits and settings again | – | 40 · 29 · 3.0 |
| Progress year: whole snapshot | 8 · 186 · 38.1 | 8 · 223 · 39.0 |
| Progress year: cards | 8 · 186 · 38.0 | 8 · 222 · 38.7 |
| Progress year: one card | 120 · 173 · 5.3 | 120 · 205 · 5.0 |
| Progress week: whole snapshot | 8 · 66 · 24.4 | 8 · 72 · 16.9 |
| Progress week: cards | 8 · 60 · 19.8 | 8 · 69 · 16.1 |
| Progress week: one card | 120 · 48 · 9.4 | 120 · 56 · 10.8 |
| Progress month: whole snapshot | 8 · 31 · 6.9 | 8 · 36 · 7.0 |
| Progress month: cards | 8 · 30 · 6.8 | 8 · 33 · 6.8 |
| Progress month: one card | 120 · 23 · 0.9 | 120 · 24 · 1.0 |
| Progress week: one quit card | 16 · 5 · 1.7 | 16 · 4 · 0.6 |
| Progress year: one quit card | 8 · 0 · 0.3 | 8 · 2 · 0.5 |
| Progress month: one quit card | 16 · 1 · 0.5 | 16 · 4 · 0.5 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- shared, habit-page round 1: long stall 287 ms at 1791840047.499; kotlin collection 228: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 95.4 ms
- shared, habit-page round 1: long stall 526 ms at 1791840047.785; kotlin collection 228: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 95.4 ms
- shared, habit-page round 1: long stall 517 ms at 1791840056.751; kotlin collection 228: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 95.4 ms
- shared, habit-page round 1: long stall 503 ms at 1791840058.288; kotlin collection 229: stopped 0.2 ms (after waiting 0.0 ms), then 0.4 ms, took 16.2 ms
- shared, progress round 1: long stall 837 ms at 1791840226.696; kotlin collection 234: stopped 0.4 ms (after waiting 21.4 ms), then 0.0 ms, took 41.8 ms
- shared, progress round 1: long stall 737 ms at 1791840236.459; kotlin collection 235: stopped 0.0 ms (after waiting 0.0 ms), then 0.7 ms, took 32.5 ms
- shared, progress round 1: long stall 273 ms at 1791840238.021; kotlin collection 235: stopped 0.0 ms (after waiting 0.0 ms), then 0.7 ms, took 32.5 ms
- shared, habit-page round 2: long stall 287 ms at 1791840298.837; kotlin collection 2: stopped 0.0 ms (after waiting 10.0 ms), then 12.3 ms, took 44.8 ms
- shared, habit-page round 2: long stall 1243 ms at 1791840311.102; kotlin collection 240: stopped 0.1 ms (after waiting 0.0 ms), then 0.0 ms, took 7.0 ms
- shared, habit-page round 2: long stall 501 ms at 1791840321.290; kotlin collection 241: stopped 0.1 ms (after waiting 0.0 ms), then 0.4 ms, took 13.1 ms
- shared, habit-page round 2: long stall 559 ms at 1791840322.833; kotlin collection 241: stopped 0.1 ms (after waiting 0.0 ms), then 0.4 ms, took 13.1 ms
- shared, habit-page round 2: long stall 281 ms at 1791840341.059; kotlin collection 243: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 19.8 ms
- shared, progress round 2: long stall 253 ms at 1791840529.127; kotlin no collection yet
- shared, progress round 2: long stall 725 ms at 1791840546.451; kotlin collection 260: stopped 0.2 ms (after waiting 61.6 ms), then 0.0 ms, took 70.0 ms
- shared, progress round 2: long stall 587 ms at 1791840555.920; kotlin collection 261: stopped 0.1 ms (after waiting 0.0 ms), then 2.1 ms, took 21.2 ms
- shared, progress round 2: long stall 297 ms at 1791840557.520; kotlin collection 261: stopped 0.1 ms (after waiting 0.0 ms), then 2.1 ms, took 21.2 ms
- shared, habit-page round 3: long stall 825 ms at 1791840819.274; kotlin collection 265: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 10.8 ms
- shared, habit-page round 3: long stall 661 ms at 1791840828.977; kotlin collection 266: stopped 0.2 ms (after waiting 0.0 ms), then 0.7 ms, took 35.0 ms
- shared, habit-page round 3: long stall 574 ms at 1791840830.525; kotlin collection 266: stopped 0.2 ms (after waiting 0.0 ms), then 0.7 ms, took 35.0 ms
- shared, habit-page round 3: long stall 269 ms at 1791840847.237; kotlin collection 267: stopped 0.4 ms (after waiting 0.0 ms), then 2.6 ms, took 42.2 ms
- shared, habit-page round 3: long stall 253 ms at 1791840848.800; kotlin collection 267: stopped 0.4 ms (after waiting 0.0 ms), then 2.6 ms, took 42.2 ms
- shared, progress round 3: long stall 253 ms at 1791840984.317; kotlin collection 2: stopped 0.2 ms (after waiting 11.0 ms), then 1.6 ms, took 21.9 ms
- shared, progress round 3: long stall 892 ms at 1791840996.273; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 21.8 ms
- shared, progress round 3: long stall 630 ms at 1791841006.003; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 8.3 ms
- shared, habit-page round 4: long stall 725 ms at 1791841072.429; kotlin collection 274: stopped 0.1 ms (after waiting 0.0 ms), then 0.1 ms, took 11.6 ms
- shared, habit-page round 4: long stall 269 ms at 1791841081.892; kotlin collection 274: stopped 0.1 ms (after waiting 0.0 ms), then 0.1 ms, took 11.6 ms
- shared, habit-page round 4: long stall 498 ms at 1791841083.273; kotlin collection 275: stopped 0.3 ms (after waiting 0.0 ms), then 1.2 ms, took 44.1 ms
- shared, progress round 4: long stall 525 ms at 1791841231.915; kotlin collection 264: stopped 0.0 ms (after waiting 1.2 ms), then 0.0 ms, took 5.6 ms
- shared, progress round 4: long stall 571 ms at 1791841241.291; kotlin collection 264: stopped 0.0 ms (after waiting 1.2 ms), then 0.0 ms, took 5.6 ms

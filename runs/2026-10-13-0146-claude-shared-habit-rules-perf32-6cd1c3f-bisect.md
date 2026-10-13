# claude/shared-habit-rules-perf32 @ 6cd1c3f (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38329425137 · 2026-10-13 01:46 UTC
Commit: Current Work 92: speed side by side with main after the untracked refresh (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ac462364 shared=HEAD` · scenarios: `habit-page progress` · rounds: 4

- main: ac462364 Current Work 93: say which widgets are free and which are Plus in the store screenshots, the website 
- shared: 6cd1c3f9 Current Work 92: speed side by side with main after the untracked refresh (scratch, safe to delete) [

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Habit page: History scrolling | **6.5**<br>8.7 (66, 0), 6.4 (80, 0), 4.8 (64, 0), 6.6 (87, 0) | **5.7**<br>6.7 (94, 0), 6.2 (90, 0), 5.2 (81, 0), 3.2 (45, 0) |
| Habit page: Progress scrolling | **14.4**<br>36.2 (198, 2), 22 (131, 1), 5.1 (48, 0), 6.8 (45, 0) | **5.6**<br>14.4 (93, 0), 8.7 (49, 0), 2.6 (52, 0), 1.5 (32, 0) |
| Habit page: switching tabs | **4.3**<br>6.8 (71, 0), 48.3 (69, 0), 1.7 (29, 0), 1.8 (36, 0) | **4.1**<br>5.5 (38, 0), 2.7 (30, 0), 20.2 (56, 0), 0.6 (26, 0) |
| Progress: scrolling | **6.2**<br>17.6 (44, 0), 4.9 (41, 0), 7.5 (34, 0), 1 (22, 0) | **4.5**<br>7.6 (37, 0), 28.6 (158, 1), 1.3 (22, 0), 0.4 (23, 0) |
| Progress: period ‹ › and range | **113.2**<br>149.5 (240, 7), 114 (122, 2), 112.3 (183, 3), 96.5 (98, 0) | **122.8**<br>193.7 (262, 13), 165.2 (240, 10), 80.3 (150, 2), 74.8 (88, 0) |
| Progress: key fold and open | **1.0**<br>1.2 (35, 0), 1.5 (40, 0), 0.8 (29, 0), 0.2 (20, 0) | **1.2**<br>2.6 (47, 0), 0.8 (30, 0), 0.1 (18, 0), 1.6 (42, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 7133 · 1635.5 | 16 · 6265 · 981.2 |
| Widgets: one habit's week | 136 · 1001 · 136.7 | 136 · 1079 · 175.3 |
| Store load: into the app (5594 logs) | 8 · 597 · 105.6 | 8 · 516 · 100.9 |
| Habit page: overall record | 4 · 49 · 18.6 | 4 · 32 · 11.2 |
| Habit page: milestones | 4 · 34 · 13.4 | 4 · 40 · 12.4 |
| Habit page: history | 4 · 34 · 9.9 | 4 · 28 · 9.3 |
| Store load: into the app (0 logs) | 8 · 24 · 4.0 | 8 · 13 · 3.6 |
| Widgets: the snapshot | 8 · 14 · 2.6 | 8 · 20 · 3.7 |
| Reminders: plan every alert | 8 · 4 · 0.9 | 8 · 9 · 4.9 |
| Count: Today's list drawn | 138 · 0 · 0.2 | 142 · 3 · 2.7 |
| Count: a Today row drawn | 459 · 0 · 0.0 | 507 · 0 · 0.0 |
| Shared rules: built from every log | – | 16 · 143 · 67.9 |
| Shared rules: built from every log, off the main thread | – | 16 · 96 · 17.6 |
| Shared rules: habits and settings again | – | 40 · 33 · 4.2 |
| Progress year: whole snapshot | 8 · 165 · 30.1 | 8 · 196 · 37.5 |
| Progress year: cards | 8 · 164 · 29.9 | 8 · 193 · 37.1 |
| Progress year: one card | 120 · 151 · 3.7 | 120 · 181 · 5.7 |
| Progress week: whole snapshot | 8 · 56 · 12.6 | 8 · 68 · 18.6 |
| Progress week: cards | 8 · 53 · 12.3 | 8 · 65 · 17.5 |
| Progress week: one card | 120 · 43 · 10.0 | 120 · 52 · 13.6 |
| Progress month: whole snapshot | 8 · 31 · 5.3 | 8 · 24 · 4.9 |
| Progress month: cards | 8 · 28 · 5.2 | 8 · 23 · 4.8 |
| Progress month: one card | 120 · 21 · 0.8 | 120 · 19 · 0.9 |
| Progress week: one quit card | 16 · 3 · 0.5 | 16 · 5 · 1.4 |
| Progress year: one quit card | 8 · 2 · 0.6 | 8 · 2 · 0.6 |
| Progress month: one quit card | 16 · 1 · 0.5 | 16 · 0 · 0.2 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- shared, habit-page round 1: long stall 826 ms at 1791854747.127; kotlin collection 238: stopped 4.9 ms (after waiting 14.7 ms), then 0.0 ms, took 38.9 ms
- shared, habit-page round 1: long stall 412 ms at 1791854756.551; kotlin collection 239: stopped 0.0 ms (after waiting 10.0 ms), then 1.7 ms, took 24.7 ms
- shared, habit-page round 1: long stall 572 ms at 1791854758.060; kotlin collection 240: stopped 0.4 ms (after waiting 0.0 ms), then 2.3 ms, took 35.2 ms
- shared, progress round 1: long stall 775 ms at 1791854942.889; kotlin collection 241: stopped 0.6 ms (after waiting 10.0 ms), then 0.0 ms, took 14.9 ms
- shared, progress round 1: long stall 682 ms at 1791854952.543; kotlin collection 242: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 21.6 ms
- shared, progress round 1: long stall 262 ms at 1791854972.092; kotlin collection 243: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 10.1 ms
- shared, habit-page round 2: long stall 856 ms at 1791855026.807; kotlin collection 234: stopped 2.6 ms (after waiting 14.0 ms), then 0.2 ms, took 21.7 ms
- shared, habit-page round 2: long stall 565 ms at 1791855036.646; kotlin collection 235: stopped 0.1 ms (after waiting 0.0 ms), then 0.8 ms, took 25.4 ms
- shared, habit-page round 2: long stall 548 ms at 1791855038.225; kotlin collection 235: stopped 0.1 ms (after waiting 0.0 ms), then 0.8 ms, took 25.4 ms
- shared, progress round 2: long stall 1035 ms at 1791855210.017; kotlin collection 237: stopped 0.0 ms (after waiting 10.0 ms), then 3.5 ms, took 64.6 ms
- shared, progress round 2: long stall 606 ms at 1791855219.551; kotlin collection 238: stopped 0.2 ms (after waiting 0.0 ms), then 0.5 ms, took 97.4 ms
- shared, habit-page round 3: long stall 899 ms at 1791855466.518; kotlin collection 248: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 58.0 ms
- shared, habit-page round 3: long stall 395 ms at 1791855476.403; kotlin collection 249: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 13.3 ms
- shared, habit-page round 3: long stall 411 ms at 1791855477.967; kotlin collection 249: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 13.3 ms
- shared, habit-page round 3: long stall 254 ms at 1791855496.271; kotlin collection 251: stopped 0.1 ms (after waiting 0.0 ms), then 0.2 ms, took 7.2 ms
- shared, progress round 3: long stall 441 ms at 1791855630.291; kotlin collection 253: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.1 ms
- shared, progress round 3: long stall 431 ms at 1791855639.543; kotlin collection 253: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.1 ms
- shared, progress round 3: long stall 259 ms at 1791855642.299; kotlin collection 254: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 8.0 ms
- shared, habit-page round 4: long stall 647 ms at 1791855703.299; kotlin collection 281: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 5.0 ms
- shared, habit-page round 4: long stall 374 ms at 1791855712.659; kotlin collection 281: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 5.0 ms
- shared, habit-page round 4: long stall 421 ms at 1791855714.242; kotlin collection 282: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 12.5 ms
- shared, progress round 4: long stall 1119 ms at 1791855868.818; kotlin collection 260: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 5.4 ms
- shared, progress round 4: long stall 882 ms at 1791855878.547; kotlin collection 261: stopped 0.2 ms (after waiting 0.0 ms), then 0.2 ms, took 16.4 ms

# claude/shared-habit-rules-perf33 @ 29e0ba0 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38329426542 · 2026-10-13 03:33 UTC
Commit: Current Work 92: speed side by side with main after the untracked refresh (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ac462364 shared=HEAD` · scenarios: `progress-year calendar` · rounds: 6

- main: ac462364 Current Work 93: say which widgets are free and which are Plus in the store screenshots, the website 
- shared: 29e0ba09 Current Work 92: speed side by side with main after the untracked refresh (scratch, safe to delete) [

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Progress Year: sideways | **0.0**<br>2.1 (41, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 4.2 (80, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Progress Year: scrolling | **20.4**<br>131.4 (558, 6), 22.7 (93, 0), 22.5 (53, 0), 8.5 (42, 0), 11.9 (76, 0), 18.2 (46, 0) | **7.4**<br>5.4 (33, 0), 4.1 (57, 0), 8.9 (36, 0), 18 (52, 0), 16.7 (55, 0), 5.9 (41, 0) |
| Calendar: month ‹ › | **4.3**<br>5.7 (40, 0), 25.8 (41, 0), 8.2 (46, 0), 2.9 (26, 0), 1.9 (24, 0), 2.5 (27, 0) | **4.5**<br>3.9 (30, 0), 12.3 (64, 0), 7.8 (40, 0), 2.2 (24, 0), 5 (35, 0), 3 (39, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 24 · 8502 · 1173.2 | 24 · 7950 · 1036.4 |
| Widgets: one habit's week | 204 · 1184 · 150.0 | 204 · 1135 · 108.9 |
| Store load: into the app (5594 logs) | 12 · 875 · 155.5 | 12 · 741 · 79.7 |
| Progress year: whole snapshot | 6 · 213 · 43.3 | 6 · 175 · 38.6 |
| Progress year: cards | 6 · 213 · 43.1 | 6 · 172 · 38.1 |
| Progress year: one card | 90 · 199 · 8.9 | 90 · 160 · 10.0 |
| Widgets: the snapshot | 12 · 25 · 5.7 | 12 · 33 · 8.5 |
| Store load: into the app (0 logs) | 12 · 23 · 5.3 | 12 · 15 · 3.9 |
| Progress week: whole snapshot | 6 · 16 · 4.0 | 6 · 20 · 6.9 |
| Progress week: cards | 6 · 16 · 3.8 | 6 · 17 · 6.1 |
| Progress week: one card | 90 · 8 · 0.5 | 90 · 11 · 2.9 |
| Progress year: one quit card | 12 · 2 · 0.4 | 12 · 5 · 0.9 |
| Reminders: plan every alert | 12 · 4 · 1.8 | 12 · 4 · 2.2 |
| Progress week: one quit card | 12 · 2 · 0.5 | 12 · 2 · 0.7 |
| Count: Today's list drawn | 144 · 0 · 0.2 | 152 · 0 · 0.5 |
| Count: a Today row drawn | 303 · 0 · 0.0 | 354 · 0 · 0.0 |
| Shared rules: built from every log, off the main thread | – | 24 · 248 · 58.8 |
| Shared rules: built from every log | – | 24 · 121 · 37.1 |
| Shared rules: habits and settings again | – | 60 · 39 · 4.3 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- shared, progress-year round 1: long stall 665 ms at 1791861075.392; kotlin collection 233: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 44.3 ms
- shared, progress-year round 1: long stall 532 ms at 1791861084.954; kotlin collection 234: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 11.1 ms
- shared, progress-year round 1: long stall 294 ms at 1791861119.624; kotlin collection 237: stopped 0.1 ms (after waiting 0.0 ms), then 0.1 ms, took 5.6 ms
- shared, calendar round 1: long stall 711 ms at 1791861199.728; kotlin collection 238: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 24.1 ms
- shared, calendar round 1: long stall 404 ms at 1791861209.321; kotlin collection 238: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 24.1 ms
- shared, calendar round 1: long stall 334 ms at 1791861212.097; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 1.0 ms, took 13.6 ms
- shared, progress-year round 2: long stall 322 ms at 1791861246.458; kotlin collection 228: stopped 0.0 ms (after waiting 0.0 ms), then 1.2 ms, took 17.7 ms
- shared, progress-year round 2: long stall 659 ms at 1791861255.354; kotlin collection 228: stopped 0.0 ms (after waiting 0.0 ms), then 1.2 ms, took 17.7 ms
- shared, calendar round 2: long stall 765 ms at 1791861372.887; kotlin collection 234: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 45.4 ms
- shared, calendar round 2: long stall 426 ms at 1791861382.286; kotlin collection 234: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 45.4 ms
- shared, calendar round 2: long stall 260 ms at 1791861385.055; kotlin collection 235: stopped 0.0 ms (after waiting 0.0 ms), then 37.2 ms, took 70.9 ms
- shared, progress-year round 3: long stall 691 ms at 1791861575.902; kotlin collection 232: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 20.7 ms
- shared, progress-year round 3: long stall 783 ms at 1791861585.423; kotlin collection 233: stopped 0.7 ms (after waiting 0.0 ms), then 0.4 ms, took 14.3 ms
- shared, progress-year round 3: long stall 294 ms at 1791861587.050; kotlin collection 233: stopped 0.7 ms (after waiting 0.0 ms), then 0.4 ms, took 14.3 ms
- shared, calendar round 3: long stall 560 ms at 1791861691.867; kotlin collection 234: stopped 0.0 ms (after waiting 9.7 ms), then 0.1 ms, took 15.2 ms
- shared, calendar round 3: long stall 356 ms at 1791861701.293; kotlin collection 234: stopped 0.0 ms (after waiting 9.7 ms), then 0.1 ms, took 15.2 ms
- shared, progress-year round 4: long stall 476 ms at 1791861731.160; kotlin collection 284: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.9 ms
- shared, progress-year round 4: long stall 257 ms at 1791861740.351; kotlin collection 284: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.9 ms
- shared, calendar round 4: long stall 770 ms at 1791861865.776; kotlin collection 240: stopped 0.0 ms (after waiting 10.1 ms), then 0.1 ms, took 27.1 ms
- shared, calendar round 4: long stall 495 ms at 1791861875.286; kotlin collection 240: stopped 0.0 ms (after waiting 10.1 ms), then 0.1 ms, took 27.1 ms
- shared, calendar round 4: long stall 306 ms at 1791861878.121; kotlin collection 241: stopped 0.0 ms (after waiting 0.0 ms), then 12.9 ms, took 48.9 ms
- shared, progress-year round 5: long stall 998 ms at 1791862032.615; kotlin collection 246: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 38.7 ms
- shared, progress-year round 5: long stall 876 ms at 1791862042.288; kotlin collection 247: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 29.6 ms
- shared, progress-year round 5: long stall 463 ms at 1791862076.889; kotlin collection 250: stopped 0.2 ms (after waiting 0.0 ms), then 0.1 ms, took 9.5 ms
- shared, calendar round 5: long stall 362 ms at 1791862158.576; kotlin collection 233: stopped 0.0 ms (after waiting 0.0 ms), then 2.1 ms, took 44.6 ms
- shared, calendar round 5: long stall 357 ms at 1791862167.477; kotlin collection 233: stopped 0.0 ms (after waiting 0.0 ms), then 2.1 ms, took 44.6 ms
- shared, calendar round 5: long stall 275 ms at 1791862170.282; kotlin collection 234: stopped 0.1 ms (after waiting 0.0 ms), then 5.3 ms, took 22.3 ms
- shared, progress-year round 6: long stall 674 ms at 1791862199.245; kotlin collection 291: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 16.2 ms
- shared, progress-year round 6: long stall 522 ms at 1791862208.372; kotlin collection 291: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 16.2 ms
- shared, progress-year round 6: long stall 325 ms at 1791862243.134; kotlin collection 295: stopped 0.1 ms (after waiting 0.0 ms), then 0.0 ms, took 6.4 ms
- shared, calendar round 6: long stall 689 ms at 1791862327.852; kotlin collection 238: stopped 2.3 ms (after waiting 10.2 ms), then 0.1 ms, took 20.4 ms
- shared, calendar round 6: long stall 445 ms at 1791862337.287; kotlin collection 238: stopped 2.3 ms (after waiting 10.2 ms), then 0.1 ms, took 20.4 ms

# claude/shared-habit-rules-perf31 @ 59164a4 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38329425418 · 2026-10-13 01:49 UTC
Commit: Current Work 92: speed side by side with main after the untracked refresh (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ac462364 shared=HEAD` · scenarios: `scroll-today tap-today` · rounds: 6

- main: ac462364 Current Work 93: say which widgets are free and which are Plus in the store screenshots, the website 
- shared: 59164a43 Current Work 92: speed side by side with main after the untracked refresh (scratch, safe to delete) [

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Today: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Today: +1 and day ‹ › | **51.0**<br>146.3 (512, 6), 66.3 (77, 0), 29.1 (64, 0), 75.7 (140, 2), 35.6 (81, 0), 12.5 (48, 0) | **26.8**<br>52.9 (112, 1), 39.4 (81, 0), 19.4 (56, 0), 29.3 (56, 0), 24.3 (60, 0), 19.2 (54, 0) |
| Today: +1 alone | **0.2**<br>22.3 (91, 0), 1.8 (29, 0), 0 (0, 0), 0.2 (18, 0), 0.3 (21, 0), 0.1 (18, 0) | **0.2**<br>3.7 (52, 0), 1 (32, 0), 0 (0, 0), 0.1 (18, 0), 0.3 (19, 0), 0.1 (18, 0) |
| Today: day ‹ › alone | **35.1**<br>140.8 (130, 2), 25.2 (50, 0), 45 (57, 0), 46.3 (104, 1), 16.5 (48, 0), 23.8 (81, 0) | **45.2**<br>50.6 (56, 0), 39.8 (62, 0), 15.6 (40, 0), 24.1 (59, 0), 75.8 (84, 0), 65.3 (102, 1) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **0.0**<br>0.8 (26, 0), 0 (0, 0), 0.3 (22, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.3**<br>10.9 (92, 0), 0.6 (25, 0), 0 (0, 0), 3.1 (42, 0), 0.1 (18, 0), 0 (0, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 24 · 21782 · 12937.0 | 24 · 7841 · 1258.8 |
| Widgets: one habit's week | 304 · 1422 · 116.4 | 302 · 1328 · 105.0 |
| Store load: into the app (5594 logs) | 12 · 743 · 108.5 | 12 · 725 · 113.7 |
| Store load: into the app (0 logs) | 12 · 21 · 3.8 | 12 · 17 · 5.0 |
| Widgets: the snapshot | 112 · 138 · 5.8 | 110 · 158 · 6.5 |
| Count: Today's list drawn | 596 · 2 · 0.7 | 607 · 0 · 0.4 |
| Reminders: plan every alert | 353 · 25 · 1.8 | 355 · 29 · 1.8 |
| Count: a Today row drawn | 2377 · 0 · 0.1 | 2450 · 0 · 0.1 |
| Shared rules: built from every log, off the main thread | – | 24 · 178 · 28.8 |
| Shared rules: habits and settings again | – | 72 · 62 · 7.8 |
| Shared rules: built from every log | – | 24 · 125 · 32.7 |
| Change: Siri's habit names | 345 · 27 · 0.8 | 345 · 22 · 0.3 |
| Count: the Day sheet drawn | 67 · 0 · 0.0 | 74 · 0 · 0.0 |
| Count: the Day sheet's activity drawn | 67 · 0 · 0.0 | 74 · 0 · 0.0 |
| Shared rules: a log added | – | 339 · 23 · 0.5 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- shared, scroll-today round 1: long stall 373 ms at 1791854523.345; kotlin collection 2: stopped 0.1 ms (after waiting 10.1 ms), then 0.6 ms, took 25.9 ms
- shared, scroll-today round 1: long stall 1457 ms at 1791854538.513; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 27.3 ms
- shared, tap-today round 1: long stall 305 ms at 1791854732.385; kotlin collection 232: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 25.5 ms
- shared, tap-today round 1: long stall 590 ms at 1791854732.690; kotlin collection 232: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 25.5 ms
- shared, tap-today round 1: long stall 655 ms at 1791854788.847; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 0.9 ms, took 12.4 ms
- shared, tap-today round 1: long stall 310 ms at 1791854794.343; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 0.9 ms, took 12.4 ms
- shared, tap-today round 1: long stall 967 ms at 1791854795.156; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 0.9 ms, took 12.4 ms
- shared, tap-today round 1: long stall 472 ms at 1791854796.124; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 0.9 ms, took 12.4 ms
- shared, tap-today round 1: long stall 625 ms at 1791854797.040; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 0.9 ms, took 12.4 ms
- shared, tap-today round 1: long stall 349 ms at 1791854797.685; kotlin collection 238: stopped 0.1 ms (after waiting 0.0 ms), then 0.9 ms, took 12.4 ms
- shared, scroll-today round 2: long stall 634 ms at 1791854834.159; kotlin collection 234: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 6.2 ms
- shared, tap-today round 2: long stall 670 ms at 1791854904.160; kotlin collection 233: stopped 0.4 ms (after waiting 10.0 ms), then 0.2 ms, took 29.5 ms
- shared, tap-today round 2: long stall 459 ms at 1791854959.311; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 5.9 ms
- shared, tap-today round 2: long stall 289 ms at 1791854962.106; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 5.4 ms
- shared, tap-today round 2: long stall 294 ms at 1791854964.893; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 5.4 ms
- shared, tap-today round 2: long stall 1252 ms at 1791854965.690; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 5.4 ms
- shared, tap-today round 2: long stall 361 ms at 1791854967.592; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 5.4 ms
- shared, scroll-today round 3: long stall 596 ms at 1791855185.285; kotlin collection 233: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 25.1 ms
- shared, tap-today round 3: long stall 542 ms at 1791855331.514; kotlin collection 231: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 13.8 ms
- shared, tap-today round 3: long stall 442 ms at 1791855386.834; kotlin collection 236: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.8 ms
- shared, tap-today round 3: long stall 406 ms at 1791855393.107; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 3.4 ms
- shared, scroll-today round 4: long stall 434 ms at 1791855422.805; kotlin collection 275: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.9 ms
- shared, tap-today round 4: long stall 333 ms at 1791855472.436; kotlin collection 255: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 3.5 ms
- shared, tap-today round 4: long stall 561 ms at 1791855527.756; kotlin collection 261: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 8.5 ms
- shared, tap-today round 4: long stall 324 ms at 1791855530.615; kotlin collection 262: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 5.2 ms
- shared, tap-today round 4: long stall 273 ms at 1791855533.292; kotlin collection 262: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 5.2 ms
- shared, tap-today round 4: long stall 651 ms at 1791855534.073; kotlin collection 262: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 5.2 ms
- shared, tap-today round 4: long stall 454 ms at 1791855534.730; kotlin collection 262: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 5.2 ms
- shared, tap-today round 4: long stall 307 ms at 1791855535.924; kotlin collection 262: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 5.2 ms
- shared, scroll-today round 5: long stall 554 ms at 1791855692.928; kotlin collection 256: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 10.3 ms
- shared, tap-today round 5: long stall 620 ms at 1791855816.026; kotlin collection 238: stopped 0.0 ms (after waiting 4.9 ms), then 0.0 ms, took 7.9 ms
- shared, tap-today round 5: long stall 649 ms at 1791855871.432; kotlin collection 243: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 4.3 ms
- shared, tap-today round 5: long stall 338 ms at 1791855874.109; kotlin collection 244: stopped 0.3 ms (after waiting 0.0 ms), then 0.8 ms, took 24.6 ms
- shared, tap-today round 5: long stall 482 ms at 1791855876.819; kotlin collection 244: stopped 0.3 ms (after waiting 0.0 ms), then 0.8 ms, took 24.6 ms
- shared, tap-today round 5: long stall 1282 ms at 1791855877.823; kotlin collection 244: stopped 0.3 ms (after waiting 0.0 ms), then 0.8 ms, took 24.6 ms
- shared, tap-today round 5: long stall 474 ms at 1791855879.705; kotlin collection 244: stopped 0.3 ms (after waiting 0.0 ms), then 0.8 ms, took 24.6 ms
- shared, scroll-today round 6: long stall 516 ms at 1791855907.060; kotlin collection 290: stopped 0.0 ms (after waiting 0.3 ms), then 0.0 ms, took 15.3 ms
- shared, tap-today round 6: long stall 598 ms at 1791855958.928; kotlin collection 234: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 25.7 ms
- shared, tap-today round 6: long stall 644 ms at 1791856014.155; kotlin collection 239: stopped 0.1 ms (after waiting 0.0 ms), then 0.8 ms, took 11.4 ms
- shared, tap-today round 6: long stall 262 ms at 1791856016.940; kotlin collection 240: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 4.4 ms
- shared, tap-today round 6: long stall 376 ms at 1791856019.692; kotlin collection 240: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 4.4 ms
- shared, tap-today round 6: long stall 1264 ms at 1791856020.540; kotlin collection 240: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 4.4 ms
- shared, tap-today round 6: long stall 499 ms at 1791856022.290; kotlin collection 240: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 4.4 ms

# claude/shared-habit-rules-perf27 @ fdcf710 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38317935766 · 2026-10-12 23:19 UTC
Commit: Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `day-sheet widget-publish` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: fdcf7107 Current Work 92: final speed side by side with main (scratch, safe to delete) [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **0.9**<br>5.5 (39, 0), 0 (0, 0), 1.8 (24, 0), 0 (0, 0) | **1.9**<br>4.5 (34, 0), 1 (20, 0), 0.3 (20, 0), 2.8 (29, 0) |
| Day sheet: add, edit and exact undo | **184.8**<br>222.2 (322, 7), 98.7 (84, 0), 170.1 (112, 2), 199.5 (103, 1) | **242.8**<br>256.9 (127, 3), 269.9 (123, 3), 228.7 (93, 0), 209.1 (100, 0) |
| Widget: full publication, every habit's week | **0.0**<br>17 (240, 1), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **1.5**<br>0 (0, 0), 3 (64, 0), 0 (0, 0), 9 (153, 1) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 6235 · 1599.0 | 16 · 6976 · 1264.4 |
| Habit page: history | 571 · 2968 · 19.0 | 580 · 3794 · 25.3 |
| Widgets: one habit's week | 1721 · 2519 · 85.8 | 1721 · 2707 · 108.2 |
| Store load: into the app (5593 logs) | 8 · 467 · 72.2 | 8 · 595 · 118.6 |
| Change: Siri's habit names | 567 · 42 · 0.5 | 576 · 44 · 0.6 |
| Store load: into the app (0 logs) | 8 · 23 · 9.1 | 8 · 9 · 3.0 |
| Widgets: the snapshot | 105 · 98 · 4.0 | 105 · 127 · 5.5 |
| Reminders: plan every alert | 17 · 6 · 1.2 | 12 · 6 · 1.5 |
| Count: Today's list drawn | 68 · 3 · 1.3 | 85 · 2 · 1.0 |
| Count: a Today row drawn | 840 · 0 · 0.0 | 947 · 0 · 0.0 |
| Count: the Day sheet drawn | 451 · 0 · 0.0 | 641 · 0 · 0.0 |
| Count: the Day sheet's activity drawn | 643 · 0 · 0.0 | 833 · 0 · 0.0 |
| Entry editor: whole editor drawn | 620 · 0 · 0.0 | 795 · 0 · 0.4 |
| Shared rules: built from every log, off the main thread | – | 16 · 124 · 18.4 |
| Shared rules: built from every log | – | 16 · 78 · 16.6 |
| Shared rules: a log changed | – | 192 · 27 · 0.5 |
| Shared rules: a log removed | – | 192 · 17 · 0.4 |
| Shared rules: a log added | – | 192 · 14 · 0.6 |
| Shared rules: habits and settings again | – | 40 · 32 · 3.2 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- shared, day-sheet round 1: long stall 328 ms at 1791846228.882; kotlin collection 230: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 360.7 ms
- shared, day-sheet round 1: long stall 812 ms at 1791846229.257; kotlin collection 232: stopped 0.1 ms (after waiting 10.8 ms), then 0.0 ms, took 27.3 ms
- shared, day-sheet round 1: long stall 409 ms at 1791846238.581; kotlin collection 232: stopped 0.1 ms (after waiting 10.8 ms), then 0.0 ms, took 27.3 ms
- shared, day-sheet round 1: long stall 666 ms at 1791846240.189; kotlin collection 233: stopped 2.0 ms (after waiting 0.0 ms), then 1.4 ms, took 52.0 ms
- shared, day-sheet round 1: long stall 983 ms at 1791846241.681; kotlin collection 233: stopped 2.0 ms (after waiting 0.0 ms), then 1.4 ms, took 52.0 ms
- shared, day-sheet round 1: long stall 393 ms at 1791846244.557; kotlin collection 233: stopped 2.0 ms (after waiting 0.0 ms), then 1.4 ms, took 52.0 ms
- shared, day-sheet round 1: long stall 460 ms at 1791846249.172; kotlin collection 234: stopped 0.0 ms (after waiting 0.0 ms), then 0.5 ms, took 16.4 ms
- shared, day-sheet round 1: long stall 251 ms at 1791846250.723; kotlin collection 234: stopped 0.0 ms (after waiting 0.0 ms), then 0.5 ms, took 16.4 ms
- shared, day-sheet round 1: long stall 1694 ms at 1791846252.227; kotlin collection 234: stopped 0.0 ms (after waiting 0.0 ms), then 0.5 ms, took 16.4 ms
- shared, day-sheet round 1: long stall 278 ms at 1791846269.250; kotlin collection 236: stopped 0.1 ms (after waiting 0.0 ms), then 0.2 ms, took 16.1 ms
- shared, widget-publish round 1: long stall 1049 ms at 1791846374.129; kotlin collection 240: stopped 0.0 ms (after waiting 10.0 ms), then 0.1 ms, took 30.3 ms
- shared, day-sheet round 2: long stall 811 ms at 1791846423.434; kotlin collection 236: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 40.3 ms
- shared, day-sheet round 2: long stall 700 ms at 1791846432.742; kotlin collection 237: stopped 0.1 ms (after waiting 0.0 ms), then 0.8 ms, took 23.2 ms
- shared, day-sheet round 2: long stall 814 ms at 1791846434.322; kotlin collection 237: stopped 0.1 ms (after waiting 0.0 ms), then 0.8 ms, took 23.2 ms
- shared, day-sheet round 2: long stall 585 ms at 1791846435.927; kotlin collection 237: stopped 0.1 ms (after waiting 0.0 ms), then 0.8 ms, took 23.2 ms
- shared, day-sheet round 2: long stall 319 ms at 1791846438.639; kotlin collection 237: stopped 0.1 ms (after waiting 0.0 ms), then 0.8 ms, took 23.2 ms
- shared, day-sheet round 2: long stall 288 ms at 1791846443.324; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.5 ms, took 14.4 ms
- shared, day-sheet round 2: long stall 1170 ms at 1791846446.358; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.5 ms, took 14.4 ms
- shared, widget-publish round 2: long stall 258 ms at 1791846572.797; kotlin no collection yet
- shared, widget-publish round 2: long stall 624 ms at 1791846585.567; kotlin collection 254: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 119.7 ms
- shared, day-sheet round 3: long stall 790 ms at 1791846786.351; kotlin collection 236: stopped 0.0 ms (after waiting 5.0 ms), then 0.0 ms, took 46.4 ms
- shared, day-sheet round 3: long stall 472 ms at 1791846796.032; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 14.0 ms
- shared, day-sheet round 3: long stall 392 ms at 1791846797.622; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 14.0 ms
- shared, day-sheet round 3: long stall 369 ms at 1791846799.202; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 14.0 ms
- shared, day-sheet round 3: long stall 282 ms at 1791846806.657; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.5 ms, took 7.6 ms
- shared, day-sheet round 3: long stall 913 ms at 1791846809.755; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.5 ms, took 7.6 ms
- shared, widget-publish round 3: long stall 515 ms at 1791846908.420; kotlin collection 236: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 14.9 ms
- shared, day-sheet round 4: long stall 788 ms at 1791846950.742; kotlin collection 236: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 15.0 ms
- shared, day-sheet round 4: long stall 869 ms at 1791846960.475; kotlin collection 237: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 26.8 ms
- shared, day-sheet round 4: long stall 879 ms at 1791846962.089; kotlin collection 237: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 26.8 ms
- shared, day-sheet round 4: long stall 603 ms at 1791846963.673; kotlin collection 237: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 26.8 ms
- shared, day-sheet round 4: long stall 381 ms at 1791846966.441; kotlin collection 237: stopped 0.1 ms (after waiting 0.0 ms), then 0.5 ms, took 26.8 ms
- shared, day-sheet round 4: long stall 519 ms at 1791846971.122; kotlin collection 238: stopped 1.4 ms (after waiting 0.0 ms), then 0.6 ms, took 20.7 ms
- shared, day-sheet round 4: long stall 267 ms at 1791846972.641; kotlin collection 238: stopped 1.4 ms (after waiting 0.0 ms), then 0.6 ms, took 20.7 ms
- shared, day-sheet round 4: long stall 2131 ms at 1791846974.173; kotlin collection 238: stopped 1.4 ms (after waiting 0.0 ms), then 0.6 ms, took 20.7 ms
- shared, day-sheet round 4: long stall 337 ms at 1791846991.570; kotlin collection 240: stopped 0.1 ms (after waiting 0.0 ms), then 0.2 ms, took 10.9 ms
- shared, widget-publish round 4: long stall 823 ms at 1791847117.973; kotlin collection 251: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 25.6 ms

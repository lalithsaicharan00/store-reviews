# claude/shared-habit-rules-perf23 @ 679e47f (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38307043549 · 2026-10-12 21:37 UTC
Commit: Current Work 92: speed side by side with main, all optimisations (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `day-sheet widget-publish` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: 679e47ff Current Work 92: speed side by side with main, all optimisations (scratch, safe to delete) [ios-perf-

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **0.9**<br>3.9 (32, 0), 0.1 (18, 0), 1.7 (26, 0), 0.1 (19, 0) | **0.6**<br>1.9 (34, 0), 0 (17, 0), 1.2 (23, 0), 0 (17, 0) |
| Day sheet: add, edit and exact undo | **234.8**<br>268.3 (99, 0), 242.4 (101, 1), 227.1 (99, 0), 146 (103, 1) | **255.1**<br>255.4 (132, 4), 163.6 (113, 4), 371.6 (123, 14), 254.7 (99, 0) |
| Widget: full publication, every habit's week | **0.0**<br>0 (0, 0), 0 (0, 0), 5.5 (100, 1), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 11062 · 1834.7 | 16 · 11521 · 3739.3 |
| Habit page: history | 583 · 3205 · 13.1 | 580 · 4207 · 30.5 |
| Widgets: one habit's week | 1704 · 2874 · 137.9 | 1721 · 2697 · 96.2 |
| Store load: into the app (5593 logs) | 8 · 544 · 82.4 | 8 · 558 · 88.5 |
| Store load: into the app (0 logs) | 8 · 35 · 16.1 | 8 · 13 · 6.4 |
| Change: Siri's habit names | 579 · 44 · 0.3 | 576 · 43 · 0.4 |
| Widgets: the snapshot | 104 · 106 · 3.7 | 105 · 125 · 3.7 |
| Reminders: plan every alert | 12 · 6 · 0.7 | 12 · 6 · 2.2 |
| Count: Today's list drawn | 70 · 2 · 0.7 | 80 · 3 · 0.8 |
| Count: a Today row drawn | 799 · 0 · 0.0 | 915 · 0 · 0.0 |
| Count: the Day sheet drawn | 628 · 0 · 0.0 | 625 · 0 · 0.0 |
| Count: the Day sheet's activity drawn | 822 · 0 · 0.0 | 818 · 0 · 0.0 |
| Entry editor: whole editor drawn | 785 · 0 · 0.0 | 794 · 0 · 0.0 |
| Shared rules: built from every log, off the main thread | – | 16 · 549 · 302.3 |
| Shared rules: built from every log | – | 16 · 84 · 25.2 |
| Shared rules: a log added | – | 192 · 18 · 3.9 |
| Shared rules: a log changed | – | 192 · 23 · 0.5 |
| Shared rules: a log removed | – | 192 · 17 · 0.5 |
| Shared rules: habits and settings again | – | 40 · 34 · 3.1 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- shared, day-sheet round 1: long stall 290 ms at 1791839985.117; kotlin collection 235: stopped 0.1 ms (after waiting 0.0 ms), then 0.0 ms, took 29.2 ms
- shared, day-sheet round 1: long stall 501 ms at 1791839985.408; kotlin collection 235: stopped 0.1 ms (after waiting 0.0 ms), then 0.0 ms, took 29.2 ms
- shared, day-sheet round 1: long stall 517 ms at 1791839994.836; kotlin collection 236: stopped 0.0 ms (after waiting 0.0 ms), then 0.6 ms, took 11.2 ms
- shared, day-sheet round 1: long stall 530 ms at 1791839996.433; kotlin collection 236: stopped 0.0 ms (after waiting 0.0 ms), then 0.6 ms, took 11.2 ms
- shared, day-sheet round 1: long stall 401 ms at 1791839997.963; kotlin collection 236: stopped 0.0 ms (after waiting 0.0 ms), then 0.6 ms, took 11.2 ms
- shared, day-sheet round 1: long stall 314 ms at 1791840000.752; kotlin collection 236: stopped 0.0 ms (after waiting 0.0 ms), then 0.6 ms, took 11.2 ms
- shared, day-sheet round 1: long stall 313 ms at 1791840005.412; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.6 ms, took 11.5 ms
- shared, day-sheet round 1: long stall 1166 ms at 1791840008.579; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.6 ms, took 11.5 ms
- shared, widget-publish round 1: long stall 649 ms at 1791840129.901; kotlin collection 237: stopped 5.0 ms (after waiting 12.1 ms), then 0.0 ms, took 22.7 ms
- shared, day-sheet round 2: long stall 490 ms at 1791840171.507; kotlin collection 227: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 45.2 ms
- shared, day-sheet round 2: long stall 296 ms at 1791840180.706; kotlin collection 227: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 45.2 ms
- shared, day-sheet round 2: long stall 451 ms at 1791840182.067; kotlin collection 228: stopped 0.2 ms (after waiting 0.0 ms), then 0.8 ms, took 22.0 ms
- shared, day-sheet round 2: long stall 327 ms at 1791840183.572; kotlin collection 228: stopped 0.2 ms (after waiting 0.0 ms), then 0.8 ms, took 22.0 ms
- shared, day-sheet round 2: long stall 1272 ms at 1791840194.078; kotlin collection 229: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 8.1 ms
- shared, widget-publish round 2: long stall 717 ms at 1791840369.253; kotlin collection 265: stopped 0.5 ms (after waiting 128.7 ms), then 0.0 ms, took 245.4 ms
- shared, day-sheet round 3: long stall 849 ms at 1791840589.162; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 0.1 ms, took 12.7 ms
- shared, day-sheet round 3: long stall 521 ms at 1791840599.029; kotlin collection 240: stopped 0.1 ms (after waiting 0.0 ms), then 1.6 ms, took 25.7 ms
- shared, day-sheet round 3: long stall 573 ms at 1791840600.578; kotlin collection 240: stopped 0.1 ms (after waiting 0.0 ms), then 1.6 ms, took 25.7 ms
- shared, day-sheet round 3: long stall 399 ms at 1791840602.152; kotlin collection 240: stopped 0.1 ms (after waiting 0.0 ms), then 1.6 ms, took 25.7 ms
- shared, day-sheet round 3: long stall 301 ms at 1791840604.983; kotlin collection 240: stopped 0.1 ms (after waiting 0.0 ms), then 1.6 ms, took 25.7 ms
- shared, day-sheet round 3: long stall 282 ms at 1791840609.734; kotlin collection 241: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 9.5 ms
- shared, day-sheet round 3: long stall 880 ms at 1791840612.939; kotlin collection 241: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 9.5 ms
- shared, widget-publish round 3: long stall 330 ms at 1791840780.209; kotlin collection 252: stopped 0.7 ms (after waiting 10.1 ms), then 0.3 ms, took 19.6 ms
- shared, widget-publish round 3: long stall 620 ms at 1791840780.540; kotlin collection 252: stopped 0.7 ms (after waiting 10.1 ms), then 0.3 ms, took 19.6 ms
- shared, day-sheet round 4: long stall 776 ms at 1791840823.902; kotlin collection 261: stopped 0.1 ms (after waiting 10.2 ms), then 0.0 ms, took 37.7 ms
- shared, day-sheet round 4: long stall 484 ms at 1791840833.491; kotlin collection 261: stopped 0.1 ms (after waiting 10.2 ms), then 0.0 ms, took 37.7 ms
- shared, day-sheet round 4: long stall 490 ms at 1791840835.033; kotlin collection 262: stopped 0.0 ms (after waiting 0.0 ms), then 2.9 ms, took 11.3 ms
- shared, day-sheet round 4: long stall 489 ms at 1791840836.534; kotlin collection 262: stopped 0.0 ms (after waiting 0.0 ms), then 2.9 ms, took 11.3 ms
- shared, day-sheet round 4: long stall 282 ms at 1791840844.061; kotlin collection 263: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 7.9 ms
- shared, day-sheet round 4: long stall 861 ms at 1791840847.202; kotlin collection 263: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 7.9 ms
- shared, widget-publish round 4: long stall 972 ms at 1791840980.351; kotlin collection 275: stopped 0.1 ms (after waiting 0.0 ms), then 0.1 ms, took 11.2 ms

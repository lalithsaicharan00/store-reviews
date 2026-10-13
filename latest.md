# claude/shared-habit-rules-perf35 @ bc85687 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38363372540 · 2026-10-13 08:17 UTC
Commit: Current Work 92: launch and Progress, shared rules against the Swift rules in one build (scratch, safe to delete) [ios-perf-bisect]

Variants: `swift=HEAD+-swift-rules shared=HEAD` · scenarios: `launch progress` · rounds: 6

- swift: bc85687a Current Work 92: launch and Progress, shared rules against the Swift rules in one build (scratch, saf
- shared: bc85687a Current Work 92: launch and Progress, shared rules against the Swift rules in one build (scratch, saf

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | swift | shared |
|---|---|---|
| Launch: the first 8 seconds | **44.8**<br>51.8 (762, 4), 39.2 (886, 1), 49.4 (991, 2), 40.1 (733, 1), 62 (830, 2), 35 (583, 1) | **47.8**<br>42.8 (792, 3), 63.3 (874, 5), 52.7 (809, 2), 77.1 (1255, 2), 35.1 (645, 1), 39.3 (658, 2) |
| Progress: scrolling | **14.9**<br>13.5 (45, 0), 31 (274, 1), 15.3 (43, 0), 18.1 (56, 0), 6.8 (40, 0), 14.5 (67, 0) | **6.0**<br>16.1 (42, 0), 21.9 (86, 0), 8 (33, 0), 0.7 (25, 0), 3.9 (30, 0), 2 (33, 0) |
| Progress: period ‹ › and range | **138.1**<br>127.2 (197, 6), 144.7 (185, 6), 155.6 (170, 9), 146.3 (220, 6), 131.5 (125, 5), 106.8 (151, 4) | **134.8**<br>222.1 (246, 18), 122.3 (170, 4), 112.4 (136, 4), 147.4 (145, 8), 107.2 (119, 1), 154.4 (292, 8) |
| Progress: key fold and open | **1.6**<br>14.1 (77, 0), 0.3 (21, 0), 0.9 (30, 0), 0.4 (23, 0), 2.2 (51, 0), 2.3 (53, 0) | **1.2**<br>1.4 (39, 0), 1.2 (35, 0), 2.1 (50, 0), 0.9 (31, 0), 1.2 (36, 0), 0.7 (27, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | swift | shared |
|---|---|---|
| Store load: read the database | 24 · 9160 · 1440.4 | 24 · 9026 · 2227.6 |
| Widgets: one habit's week | 204 · 1427 · 113.1 | 204 · 1594 · 152.6 |
| Store load: into the app (5594 logs) | 12 · 841 · 100.0 | 12 · 767 · 81.5 |
| Store load: into the app (0 logs) | 12 · 27 · 4.7 | 12 · 16 · 3.5 |
| Widgets: the snapshot | 12 · 19 · 3.5 | 12 · 32 · 6.7 |
| Reminders: plan every alert | 12 · 5 · 1.1 | 12 · 2 · 0.7 |
| Count: Today's list drawn | 208 · 0 · 0.4 | 199 · 0 · 0.0 |
| Count: shared rules' inputs changed: habits | 204 · 2 · 0.6 | 204 · 2 · 1.0 |
| Count: habits set | 216 · 0 · 0.0 | 216 · 0 · 0.0 |
| Count: settings set | 72 · 0 · 0.0 | 72 · 0 · 0.0 |
| Count: timers set | 24 · 0 · 0.0 | 24 · 0 · 0.0 |
| Count: logs changed, announced | 24 · 0 · 0.0 | 24 · 0 · 0.0 |
| Count: logs changed, every habit marked | 24 · 0 · 0.0 | 24 · 0 · 0.0 |
| Count: a Today row drawn | 747 · 0 · 0.0 | 687 · 0 · 0.0 |
| Shared rules: built from every log, off the main thread | – | 24 · 191 · 46.2 |
| Shared rules: built from every log | – | 24 · 99 · 17.0 |
| Shared rules: habits and settings again | – | 60 · 60 · 7.5 |
| Count: shared rules given habits and settings again, changed | – | 60 · 0 · 0.0 |
| Progress year: whole snapshot | 12 · 286 · 34.2 | 12 · 274 · 33.5 |
| Progress year: cards | 12 · 285 · 34.0 | 12 · 273 · 33.4 |
| Progress year: one card | 180 · 265 · 5.7 | 180 · 254 · 6.0 |
| Progress week: whole snapshot | 12 · 92 · 14.2 | 12 · 77 · 10.4 |
| Progress week: cards | 12 · 86 · 14.0 | 12 · 71 · 10.1 |
| Progress week: one card | 180 · 72 · 12.2 | 180 · 59 · 8.6 |
| Progress month: whole snapshot | 12 · 60 · 11.0 | 12 · 53 · 9.4 |
| Progress month: cards | 12 · 59 · 10.7 | 12 · 50 · 9.0 |
| Progress month: one card | 180 · 41 · 0.9 | 180 · 37 · 1.1 |
| Progress week: one quit card | 24 · 5 · 0.6 | 24 · 5 · 0.7 |
| Progress year: one quit card | 12 · 3 · 0.5 | 12 · 3 · 0.5 |
| Progress month: one quit card | 24 · 0 · 0.3 | 24 · 3 · 0.3 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- swift, launch round 1: long stall 323 ms at 1791878113.823; kotlin no collection yet
- swift, launch round 1: long stall 384 ms at 1791878134.369; kotlin collection 249: stopped 0.1 ms (after waiting 10.1 ms), then 5.6 ms, took 45.3 ms
- swift, launch round 1: long stall 761 ms at 1791878134.753; kotlin collection 249: stopped 0.1 ms (after waiting 10.1 ms), then 5.6 ms, took 45.3 ms
- shared, launch round 1: long stall 792 ms at 1791878170.023; kotlin collection 235: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 25.5 ms
- swift, progress round 1: long stall 727 ms at 1791878199.078; kotlin collection 235: stopped 0.1 ms (after waiting 10.0 ms), then 0.0 ms, took 29.4 ms
- swift, progress round 1: long stall 2626 ms at 1791878208.728; kotlin collection 236: stopped 0.0 ms (after waiting 0.0 ms), then 0.5 ms, took 18.8 ms
- shared, progress round 1: long stall 296 ms at 1791878273.468; kotlin collection 1: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 10.0 ms
- shared, progress round 1: long stall 809 ms at 1791878285.451; kotlin collection 234: stopped 0.0 ms (after waiting 24.6 ms), then 0.0 ms, took 39.1 ms
- shared, progress round 1: long stall 782 ms at 1791878294.861; kotlin collection 235: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 15.7 ms
- shared, progress round 1: long stall 254 ms at 1791878297.798; kotlin collection 235: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 15.7 ms
- shared, launch round 2: long stall 303 ms at 1791878371.318; kotlin collection 1: stopped 0.7 ms (after waiting 10.6 ms), then 0.0 ms, took 45.9 ms
- shared, launch round 2: long stall 482 ms at 1791878389.337; kotlin collection 258: stopped 42.7 ms (after waiting 10.0 ms), then 0.2 ms, took 61.5 ms
- shared, launch round 2: long stall 874 ms at 1791878389.819; kotlin collection 258: stopped 42.7 ms (after waiting 10.0 ms), then 0.2 ms, took 61.5 ms
- swift, launch round 2: long stall 886 ms at 1791878420.059; kotlin collection 236: stopped 25.1 ms (after waiting 10.4 ms), then 0.0 ms, took 43.3 ms
- shared, progress round 2: long stall 762 ms at 1791878447.729; kotlin collection 234: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 31.1 ms
- shared, progress round 2: long stall 1092 ms at 1791878457.461; kotlin collection 235: stopped 0.4 ms (after waiting 0.0 ms), then 0.7 ms, took 28.1 ms
- swift, progress round 2: long stall 698 ms at 1791878530.841; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 5.4 ms, took 24.6 ms
- swift, progress round 2: long stall 330 ms at 1791878540.387; kotlin collection 239: stopped 0.0 ms (after waiting 0.0 ms), then 5.4 ms, took 24.6 ms
- swift, progress round 2: long stall 255 ms at 1791878540.718; kotlin collection 240: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 6.2 ms
- swift, progress round 2: long stall 330 ms at 1791878541.968; kotlin collection 240: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 6.2 ms
- swift, progress round 2: long stall 274 ms at 1791878553.107; kotlin collection 241: stopped 0.0 ms (after waiting 0.0 ms), then 0.7 ms, took 7.4 ms
- swift, launch round 3: long stall 991 ms at 1791878617.189; kotlin collection 237: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 43.1 ms
- shared, launch round 3: long stall 809 ms at 1791878648.773; kotlin collection 252: stopped 0.1 ms (after waiting 0.0 ms), then 0.0 ms, took 4.8 ms
- swift, progress round 3: long stall 1071 ms at 1791878691.788; kotlin collection 239: stopped 0.1 ms (after waiting 10.0 ms), then 0.0 ms, took 298.9 ms
- swift, progress round 3: long stall 584 ms at 1791878701.703; kotlin collection 240: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 12.7 ms
- swift, progress round 3: long stall 518 ms at 1791878702.287; kotlin collection 240: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 12.7 ms
- swift, progress round 3: long stall 422 ms at 1791878703.235; kotlin collection 240: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 12.7 ms
- shared, progress round 3: long stall 1562 ms at 1791878760.107; kotlin collection 1: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 45.9 ms
- shared, progress round 3: long stall 534 ms at 1791878766.708; kotlin collection 284: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.8 ms
- shared, progress round 3: long stall 597 ms at 1791878775.867; kotlin collection 284: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.8 ms
- shared, progress round 3: long stall 312 ms at 1791878778.742; kotlin collection 285: stopped 0.0 ms (after waiting 0.0 ms), then 3.5 ms, took 15.2 ms
- shared, launch round 4: long stall 302 ms at 1791878839.055; kotlin collection 1: stopped 0.1 ms (after waiting 10.0 ms), then 0.0 ms, took 16.9 ms
- shared, launch round 4: long stall 1255 ms at 1791878847.967; kotlin collection 260: stopped 0.3 ms (after waiting 12.2 ms), then 0.0 ms, took 29.1 ms
- swift, launch round 4: long stall 733 ms at 1791878875.764; kotlin collection 274: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 5.0 ms
- shared, progress round 4: long stall 263 ms at 1791878893.012; kotlin collection 1: stopped 0.1 ms (after waiting 10.1 ms), then 0.0 ms, took 51.8 ms
- shared, progress round 4: long stall 663 ms at 1791878900.139; kotlin collection 273: stopped 0.1 ms (after waiting 1.6 ms), then 0.1 ms, took 15.3 ms
- shared, progress round 4: long stall 1014 ms at 1791878909.263; kotlin collection 274: stopped 0.0 ms (after waiting 0.0 ms), then 0.4 ms, took 10.9 ms
- swift, progress round 4: long stall 812 ms at 1791878980.626; kotlin collection 240: stopped 0.0 ms (after waiting 10.0 ms), then 0.0 ms, took 35.9 ms
- swift, progress round 4: long stall 893 ms at 1791878990.009; kotlin collection 241: stopped 0.7 ms (after waiting 0.0 ms), then 0.3 ms, took 29.7 ms
- swift, progress round 4: long stall 299 ms at 1791878991.647; kotlin collection 241: stopped 0.7 ms (after waiting 0.0 ms), then 0.3 ms, took 29.7 ms
- swift, launch round 5: long stall 331 ms at 1791879049.737; kotlin no collection yet
- swift, launch round 5: long stall 830 ms at 1791879057.813; kotlin collection 277: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.8 ms
- shared, launch round 5: long stall 645 ms at 1791879081.705; kotlin collection 277: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 14.3 ms
- swift, progress round 5: long stall 290 ms at 1791879110.089; kotlin collection 241: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 29.3 ms
- swift, progress round 5: long stall 437 ms at 1791879110.379; kotlin collection 241: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 29.3 ms
- swift, progress round 5: long stall 791 ms at 1791879119.375; kotlin collection 242: stopped 0.1 ms (after waiting 0.0 ms), then 0.8 ms, took 20.3 ms
- swift, progress round 5: long stall 302 ms at 1791879120.975; kotlin collection 242: stopped 0.1 ms (after waiting 0.0 ms), then 0.8 ms, took 20.3 ms
- shared, progress round 5: long stall 694 ms at 1791879186.330; kotlin collection 280: stopped 0.0 ms (after waiting 1.1 ms), then 0.0 ms, took 9.9 ms
- shared, progress round 5: long stall 745 ms at 1791879195.857; kotlin collection 281: stopped 0.1 ms (after waiting 0.0 ms), then 2.5 ms, took 22.0 ms
- shared, progress round 5: long stall 259 ms at 1791879197.497; kotlin collection 281: stopped 0.1 ms (after waiting 0.0 ms), then 2.5 ms, took 22.0 ms
- shared, launch round 6: long stall 658 ms at 1791879266.614; kotlin collection 235: stopped 10.7 ms (after waiting 34.9 ms), then 0.0 ms, took 64.9 ms
- swift, launch round 6: long stall 583 ms at 1791879287.592; kotlin collection 283: stopped 0.0 ms (after waiting 4.0 ms), then 0.0 ms, took 7.5 ms
- shared, progress round 6: long stall 606 ms at 1791879309.291; kotlin collection 267: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 14.6 ms
- shared, progress round 6: long stall 488 ms at 1791879318.801; kotlin collection 268: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 7.7 ms
- shared, progress round 6: long stall 292 ms at 1791879349.099; kotlin collection 271: stopped 0.1 ms (after waiting 0.0 ms), then 0.1 ms, took 25.2 ms
- swift, progress round 6: long stall 255 ms at 1791879382.186; kotlin collection 292: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.5 ms
- swift, progress round 6: long stall 472 ms at 1791879382.442; kotlin collection 292: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.5 ms
- swift, progress round 6: long stall 658 ms at 1791879391.450; kotlin collection 292: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 4.5 ms
- swift, progress round 6: long stall 251 ms at 1791879393.042; kotlin collection 293: stopped 0.1 ms (after waiting 0.0 ms), then 0.3 ms, took 23.1 ms

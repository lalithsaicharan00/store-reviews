# claude/exciting-mccarthy-g6vlu5 @ e8d9d3f (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37788595991 · 2026-10-08 14:56 UTC
Commit: Current Work 49: speed bisect of the +1 tap across c9909e6..e3afd6c [ios-perf-bisect]

Variants: `base=396c40e sound=3530e98 week=a3d33bf redesign=84d42ef main=e3afd6c` · scenarios: `tap-today` · rounds: 3

- base: 396c40e3 After-log line: one layout instead of ViewThatFits (it measured three layouts each time the line appe
- sound: 3530e980 Checklists: limits under Quit or Cut Down (14) and Notes month cards (46) tested and completed; 18, 2
- week: a3d33bf1 TodayRowSheetUITests: a week count's Day sheet offers Add a check, not Mark done (Current Work 54; fo
- redesign: 84d42ef6 Current Work 59–63: the last rerun passed (37639195688); merged into main
- main: e3afd6c6 Widgets: a tap changes the whole card at once and the app saves it behind; locked (Current Work 64-66

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | base | sound | week | redesign | main |
|---|---|---|---|---|---|
| Today: +1 and day ‹ › | **54.5**<br>54.5 (103, 1), 50.4 (53, 0), 71.8 (82, 0) | **53.1**<br>47.5 (86, 0), 112.2 (121, 2), 53.1 (68, 0) | **55.4**<br>96 (137, 2), 47.6 (62, 0), 55.4 (177, 1) | **57.0**<br>66.1 (118, 1), 57 (66, 0), 28.7 (57, 0) | **115.6**<br>115.6 (80, 0), 56.6 (56, 0), 122.4 (90, 0) |
| Today: +1 alone | **3.6**<br>2.2 (36, 0), 3.6 (34, 0), 7.1 (70, 0) | **2.6**<br>5 (60, 0), 2.6 (35, 0), 0.7 (28, 0) | **1.1**<br>0.8 (27, 0), 3.1 (47, 0), 1.1 (30, 0) | **1.2**<br>0.8 (29, 0), 2 (40, 0), 1.2 (27, 0) | **1.1**<br>10.2 (83, 0), 0.7 (27, 0), 1.1 (24, 0) |
| Today: day ‹ › alone | **59.4**<br>59.4 (70, 0), 155 (132, 4), 45 (57, 0) | **65.5**<br>51.4 (61, 0), 65.5 (70, 0), 94.6 (117, 1) | **62.9**<br>62.7 (79, 0), 62.9 (70, 0), 64.6 (114, 1) | **61.5**<br>61.5 (86, 0), 52.5 (57, 0), 124.3 (111, 3) | **90.7**<br>151.7 (121, 5), 62.9 (105, 1), 90.7 (99, 0) |
| Today: Day sheet scrolling | **19.1**<br>19.1 (58, 0), 38.4 (83, 0), 14.5 (44, 0) | **14.5**<br>25.5 (96, 0), 14.5 (48, 0), 9.8 (36, 0) | **13.0**<br>37.1 (40, 0), 13 (40, 0), 0.1 (18, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | – | **0.6**<br>0.1 (18, 0), 2.5 (45, 0), 0.6 (26, 0) | **0.0**<br>4 (46, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0.3 (21, 0) | **2.3**<br>2.9 (39, 0), 0 (0, 0), 2.3 (34, 0) |

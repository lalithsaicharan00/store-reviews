# claude/exciting-mccarthy-g6vlu5 @ 81541b9 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37774018835 · 2026-10-08 12:46 UTC
Commit: Current Work 49: speed bisect, 4 Oct baseline vs the end of the timer/swipe/limits work vs main [ios-perf-bisect]

Variants: `base=396c40e limits=c9909e6 main=e3afd6c` · scenarios: `scroll-today tap-today new-habit progress` · rounds: 2

- base: 396c40e3 After-log line: one layout instead of ViewThatFits (it measured three layouts each time the line appe
- limits: c9909e63 Today: limits leave the times of day and join quit habits in one "Quit or Cut Down" card; Cut down ha
- main: e3afd6c6 Widgets: a tap changes the whole card at once and the app saves it behind; locked (Current Work 64-66

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | base | limits | main |
|---|---|---|---|
| Today: scrolling | **12.6**<br>20 (128, 1), 5.2 (38, 0) | **27.6**<br>47.4 (640, 1), 7.7 (81, 0) | **11.3**<br>17.7 (135, 2), 4.9 (38, 0) |
| Today: +1 and day ‹ › | **62.3**<br>72.5 (228, 1), 52.1 (85, 0) | **83.7**<br>119 (155, 3), 48.3 (54, 0) | **123.8**<br>89.7 (194, 3), 158 (88, 0) |
| Today: +1 alone | **1.5**<br>2.4 (33, 0), 0.7 (27, 0) | **3.4**<br>5.1 (49, 0), 1.8 (33, 0) | **15.5**<br>5.8 (47, 0), 25.2 (116, 1) |
| Today: day ‹ › alone | **59.8**<br>81.4 (90, 0), 38.1 (66, 0) | **87.8**<br>73 (89, 0), 102.7 (120, 1) | **73.5**<br>67.5 (91, 0), 79.4 (92, 0) |
| Today: Day sheet scrolling | **102.3**<br>149.6 (587, 8), 55 (360, 1) | **20.2**<br>23.1 (55, 0), 17.3 (33, 0) | **0.0**<br>0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | – | **6.0**<br>12 (131, 1), 0 (0, 0) | **1.9**<br>3.6 (46, 0), 0.2 (20, 0) |
| Habit form: typing | **14.2**<br>16.8 (64, 0), 11.6 (67, 0) | **18.8**<br>16 (63, 0), 21.5 (171, 1) | **15.8**<br>23.3 (110, 1), 8.2 (83, 0) |
| Progress: scrolling | **10.9**<br>14.8 (54, 0), 6.9 (51, 0) | **15.0**<br>25.1 (58, 0), 4.9 (34, 0) | **1.4**<br>0 (0, 0), 2.9 (29, 0) |
| Progress: period ‹ › and range | **107.5**<br>108.8 (176, 2), 106.3 (121, 4) | **128.5**<br>133.1 (153, 4), 123.9 (141, 4) | **93.1**<br>85.2 (123, 3), 101 (147, 3) |
| Progress: key fold and open | **12.7**<br>11.9 (48, 0), 13.4 (42, 0) | **17.9**<br>18.5 (64, 0), 17.4 (60, 0) | **0.8**<br>0.5 (24, 0), 1.1 (34, 0) |

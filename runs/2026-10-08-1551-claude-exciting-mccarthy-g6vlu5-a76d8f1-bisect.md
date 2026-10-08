# claude/exciting-mccarthy-g6vlu5 @ a76d8f1 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37797217908 · 2026-10-08 15:51 UTC
Commit: Current Work 49: a speed-run switch that leaves out the widgets' publication; measured beside main [ios-perf-bisect]

Variants: `redesign=84d42ef main=HEAD nopub=HEAD+-perf-no-widget-publish` · scenarios: `tap-today scroll-today new-habit progress` · rounds: 2

- redesign: 84d42ef6 Current Work 59–63: the last rerun passed (37639195688); merged into main
- main: a76d8f15 Current Work 49: a speed-run switch that leaves out the widgets' publication; measured beside main [i
- nopub: a76d8f15 Current Work 49: a speed-run switch that leaves out the widgets' publication; measured beside main [i

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | redesign | main | nopub |
|---|---|---|---|
| Today: +1 and day ‹ › | **52.0**<br>2.4 (82, 0), 101.6 (164, 3) | **95.2**<br>126.4 (158, 3), 64 (111, 1) | **103.8**<br>125.2 (145, 3), 82.4 (161, 2) |
| Today: +1 alone | **4.6**<br>5.9 (52, 0), 3.3 (42, 0) | **4.5**<br>7.2 (89, 0), 1.7 (40, 0) | **4.0**<br>3.9 (34, 0), 4 (47, 0) |
| Today: day ‹ › alone | **106.0**<br>113.1 (132, 1), 98.9 (91, 0) | **83.5**<br>108.8 (99, 0), 58.3 (78, 0) | **99.5**<br>98 (86, 0), 101.1 (91, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **4.2**<br>7.1 (40, 0), 1.4 (37, 0) | **3.6**<br>7.2 (125, 1), 0 (0, 0) | **1.6**<br>0 (0, 0), 3.1 (64, 0) |
| Today: scrolling | **38.4**<br>47.6 (439, 2), 29.2 (196, 2) | **21.0**<br>12.4 (117, 1), 29.6 (356, 1) | **29.1**<br>29.3 (380, 1), 28.9 (214, 2) |
| Habit form: typing | **20.6**<br>22.3 (49, 0), 19 (93, 0) | **57.5**<br>55.4 (178, 3), 59.7 (338, 2) | **22.6**<br>21.3 (128, 1), 24 (92, 0) |
| Progress: scrolling | **6.8**<br>6.4 (32, 0), 7.3 (36, 0) | **18.9**<br>16.2 (56, 0), 21.5 (60, 0) | **3.0**<br>1 (23, 0), 5.1 (42, 0) |
| Progress: period ‹ › and range | **105.9**<br>110.6 (181, 4), 101.2 (156, 2) | **148.0**<br>129.6 (160, 5), 166.4 (276, 8) | **110.9**<br>107.1 (138, 1), 114.8 (219, 3) |
| Progress: key fold and open | **0.4**<br>0.4 (23, 0), 0.4 (22, 0) | **1.1**<br>1.3 (37, 0), 1 (33, 0) | **1.1**<br>1.9 (46, 0), 0.3 (21, 0) |

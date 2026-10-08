# claude/exciting-mccarthy-g6vlu5 @ 86c5c26 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37804587883 · 2026-10-08 16:45 UTC
Commit: Current Work 49: what the second and third bisects found; confirm the +1 and day ‹ › difference with four rounds [ios-perf-bisect]

Variants: `base=396c40e redesign=84d42ef main=HEAD` · scenarios: `tap-today` · rounds: 4

- base: 396c40e3 After-log line: one layout instead of ViewThatFits (it measured three layouts each time the line appe
- redesign: 84d42ef6 Current Work 59–63: the last rerun passed (37639195688); merged into main
- main: 86c5c26e Current Work 49: what the second and third bisects found; confirm the +1 and day ‹ › difference with 

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | base | redesign | main |
|---|---|---|---|
| Today: +1 and day ‹ › | **159.1**<br>172.2 (350, 4), 146.1 (105, 1), 139.4 (232, 1), 173.9 (185, 2) | **159.2**<br>220.5 (164, 5), 155 (140, 1), 163.4 (109, 1), 144.3 (99, 0) | **181.6**<br>181.8 (426, 6), 137.6 (197, 3), 190.8 (146, 4), 181.4 (106, 2) |
| Today: +1 alone | **6.8**<br>16.7 (48, 0), 8.4 (56, 0), 5.1 (68, 0), 2.7 (57, 0) | **11.3**<br>17.9 (56, 0), 5.5 (62, 0), 12 (62, 0), 10.6 (70, 0) | **8.7**<br>8.8 (57, 0), 8.6 (54, 0), 25.1 (116, 1), 2.6 (36, 0) |
| Today: day ‹ › alone | **141.0**<br>209.7 (268, 11), 141.6 (107, 2), 140.4 (130, 2), 78.9 (115, 1) | **145.8**<br>145.7 (174, 2), 114.1 (93, 0), 145.8 (146, 4), 155.3 (139, 4) | **128.8**<br>129.5 (98, 0), 138.7 (148, 3), 128 (147, 2), 114.3 (99, 0) |
| Today: Day sheet scrolling | **54.4**<br>115.7 (162, 5), 29.9 (62, 0), 43.6 (57, 0), 65.2 (67, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | – | **3.7**<br>25.5 (194, 1), 7.2 (99, 0), 0 (0, 0), 0.2 (19, 0) | **1.9**<br>4.3 (55, 0), 1.5 (28, 0), 1.2 (28, 0), 2.3 (42, 0) |

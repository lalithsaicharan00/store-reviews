# claude/shared-habit-rules-perf @ 52b2383 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38229387771 · 2026-10-12 13:04 UTC
Commit: Current Work 92: speed side by side with main, part 1 (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `scroll-today tap-today` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: 52b23839 Current Work 92: speed side by side with main, part 1 (scratch, safe to delete) [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Today: scrolling | **19.1**<br>22.8 (291, 1), 19.6 (251, 1), 18.5 (246, 1), 15.7 (141, 2) | **21.8**<br>16.6 (125, 2), 24.6 (343, 1), 18.9 (169, 2), 25.7 (207, 1) |
| Today: +1 and day ‹ › | **122.9**<br>83.3 (114, 1), 139.9 (177, 4), 147.2 (144, 3), 105.9 (140, 3) | **130.2**<br>180 (121, 7), 162.7 (127, 4), 97.7 (138, 2), 96.3 (158, 1) |
| Today: +1 alone | **8.5**<br>11.8 (101, 1), 5.2 (69, 0), 3.5 (52, 0), 12 (50, 0) | **33.4**<br>58.6 (91, 0), 44.8 (65, 0), 8.6 (40, 0), 22 (61, 0) |
| Today: day ‹ › alone | **110.4**<br>140.9 (145, 3), 105.3 (89, 0), 115.6 (127, 2), 87.5 (80, 0) | **86.9**<br>91.6 (94, 0), 130.8 (108, 2), 55.3 (62, 0), 82.2 (97, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **4.1**<br>40.2 (486, 1), 0.8 (28, 0), 7.2 (75, 0), 1 (27, 0) | **0.6**<br>0.3 (20, 0), 0.5 (20, 0), 6.5 (98, 0), 0.6 (24, 0) |

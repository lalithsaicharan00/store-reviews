# claude/shared-habit-rules-perf2 @ 6b36c6f (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38229391744 · 2026-10-12 12:31 UTC
Commit: Current Work 92: speed side by side with main, part 2 (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `habit-page progress` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: 6b36c6fc Current Work 92: speed side by side with main, part 2 (scratch, safe to delete) [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Habit page: History scrolling | **9.0**<br>13 (80, 0), 13.6 (122, 1), 5 (84, 0), 4.8 (70, 0) | **6.5**<br>10.3 (75, 0), 3.8 (56, 0), 8.7 (132, 1), 4.3 (58, 0) |
| Habit page: Progress scrolling | **12.1**<br>12.7 (114, 1), 15.5 (93, 0), 9 (52, 0), 11.5 (61, 0) | **8.6**<br>11.7 (60, 0), 12.2 (66, 0), 5.3 (32, 0), 5.6 (55, 0) |
| Habit page: switching tabs | **7.7**<br>1.3 (31, 0), 10.6 (57, 0), 4.8 (65, 0), 14.6 (65, 0) | **4.7**<br>7.2 (57, 0), 5 (58, 0), 2.2 (29, 0), 4.4 (41, 0) |
| Progress: scrolling | **11.1**<br>15.2 (54, 0), 11.2 (49, 0), 11 (47, 0), 10.9 (46, 0) | **7.7**<br>6 (35, 0), 10.7 (37, 0), 6.9 (36, 0), 8.5 (36, 0) |
| Progress: period ‹ › and range | **131.8**<br>151.8 (171, 10), 132.1 (187, 6), 103.4 (132, 4), 131.6 (182, 5) | **133.4**<br>108.7 (176, 1), 168.1 (253, 8), 106.5 (141, 5), 158.2 (184, 11) |
| Progress: key fold and open | **2.0**<br>2.8 (60, 0), 0.6 (26, 0), 1.5 (40, 0), 2.6 (58, 0) | **2.2**<br>0.2 (19, 0), 2.2 (51, 0), 2.3 (52, 0), 2.3 (52, 0) |

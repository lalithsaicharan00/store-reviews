# claude/shared-habit-rules-perf3 @ ce6edf2 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38229393346 · 2026-10-12 11:42 UTC
Commit: Current Work 92: speed side by side with main, part 3 (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `progress-year calendar` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: ce6edf29 Current Work 92: speed side by side with main, part 3 (scratch, safe to delete) [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Progress Year: sideways | **0.0**<br>0 (0, 0), 0.3 (21, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 4.6 (86, 0), 0 (0, 0), 0 (0, 0) |
| Progress Year: scrolling | **11.1**<br>27.2 (72, 0), 9.5 (43, 0), 2.8 (28, 0), 12.7 (72, 0) | **11.4**<br>0 (0, 0), 27.8 (162, 1), 3.1 (32, 0), 19.7 (112, 1) |
| Calendar: month ‹ › | **9.7**<br>22 (84, 0), 12.9 (56, 0), 6.5 (31, 0), 3.4 (29, 0) | **3.3**<br>32.7 (130, 1), 4.1 (27, 0), 0.6 (23, 0), 2.5 (31, 0) |

# habit-progress-milestones-bisect @ b37aca4 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38048447170 · 2026-10-10 11:50 UTC
Commit: Speed bisect: the habit page with the Progress redesign against main before it, four rounds [ios-perf-bisect]

Variants: `before=bcab5377 branch=32dcca91` · scenarios: `habit-page` · rounds: 4

- before: bcab5377 Merging the Branches: sync-reliability-cloud fully in main (10 Oct), safe to delete
- branch: 32dcca91 Habit Progress: a best run's and best week's dates in the phone's own order, as every other date on t

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | before | branch |
|---|---|---|
| Habit page: History scrolling | **2.9**<br>3 (32, 0), 2.8 (50, 0), 0.6 (26, 0), 7.1 (89, 0) | **7.7**<br>13.7 (114, 1), 11.2 (103, 1), 4.2 (80, 0), 3 (61, 0) |
| Habit page: Progress scrolling | **9.9**<br>31.6 (160, 1), 11.7 (46, 0), 1 (27, 0), 8.1 (51, 0) | **8.3**<br>9.7 (63, 0), 22.4 (142, 2), 7 (55, 0), 1.2 (24, 0) |
| Habit page: switching tabs | **41.6**<br>253.7 (746, 9), 14.5 (46, 0), 34.6 (62, 0), 48.6 (61, 0) | **37.7**<br>43.7 (87, 0), 8.8 (94, 0), 51.4 (72, 0), 31.7 (58, 0) |

# apple-watch-ci5 @ e281058 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38132967688 · 2026-10-11 12:15 UTC
Commit: Apple Watch: iPhone speed, main and this branch side by side (scratch branch run)

Variants: `main=bac8a1b5 watch=HEAD` · scenarios: `habit-page progress` · rounds: 4

- main: bac8a1b5 Current Work 88: coming back to the iPhone after using the iPad, "Use your habits on this iPhone?" (t
- watch: e2810585 Apple Watch: iPhone speed, main and this branch side by side (scratch branch run)

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | watch |
|---|---|---|
| Habit page: History scrolling | **2.6**<br>1.6 (40, 0), 5 (91, 0), 3.6 (70, 0), 1.5 (35, 0) | **1.8**<br>1.9 (36, 0), 0.9 (31, 0), 1.6 (41, 0), 3.3 (66, 0) |
| Habit page: Progress scrolling | **4.9**<br>57 (492, 2), 5.3 (65, 0), 3.4 (56, 0), 4.6 (37, 0) | **2.4**<br>2.2 (32, 0), 1.5 (33, 0), 2.5 (43, 0), 3.7 (58, 0) |
| Habit page: switching tabs | **13.7**<br>6.9 (67, 0), 29 (218, 1), 10.8 (36, 0), 16.6 (70, 0) | **9.6**<br>11.7 (66, 0), 24.1 (50, 0), 7.6 (29, 0), 7.2 (31, 0) |
| Progress: scrolling | **1.4**<br>0 (0, 0), 2.2 (28, 0), 3.9 (32, 0), 0.5 (23, 0) | **0.6**<br>0 (0, 0), 22.9 (80, 0), 0.6 (25, 0), 0.5 (24, 0) |
| Progress: period ‹ › and range | **86.9**<br>56.3 (84, 0), 106.7 (111, 1), 91.6 (103, 1), 82.3 (138, 1) | **109.5**<br>61.8 (88, 0), 162 (215, 9), 78.5 (110, 1), 140.5 (158, 6) |
| Progress: key fold and open | **0.4**<br>0.3 (22, 0), 0.6 (25, 0), 0 (0, 0), 0.9 (30, 0) | **0.1**<br>0 (0, 0), 0 (0, 0), 0.1 (19, 0), 2.4 (49, 0) |

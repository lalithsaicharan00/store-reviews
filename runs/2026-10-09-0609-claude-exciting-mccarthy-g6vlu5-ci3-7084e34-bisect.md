# claude/exciting-mccarthy-g6vlu5-ci3 @ 7084e34 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/37889969212 · 2026-10-09 06:09 UTC
Commit: Habit page speed: main against this branch, side by side, four rounds [ios-perf-bisect]

Variants: `main=4543c68a branch=b841fd4b` · scenarios: `habit-page` · rounds: 4

- main: 4543c68a Current Work 58: App Lock and widget privacy research, decisions 1-4 and the Privacy & Security spec
- branch: b841fd4b Rulebook T10 and CLAUDE.md: never wait for another agent's runs; temporary branches of your own for p

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Habit page: History scrolling | **8.4**<br>11.3 (85, 0), 2.4 (52, 0), 7.8 (101, 1), 9.1 (146, 1) | **4.6**<br>13.7 (149, 1), 2 (47, 0), 5.4 (86, 0), 3.7 (52, 0) |
| Habit page: Progress scrolling | **9.1**<br>28.3 (191, 2), 3.5 (30, 0), 10.6 (53, 0), 7.5 (43, 0) | **5.9**<br>130.4 (562, 5), 0.3 (20, 0), 2.9 (36, 0), 8.8 (64, 0) |
| Habit page: switching tabs | **25.0**<br>64.3 (112, 1), 10 (69, 0), 27.5 (53, 0), 22.5 (54, 0) | **41.5**<br>110.9 (695, 3), 5.8 (31, 0), 52.1 (64, 0), 31 (66, 0) |

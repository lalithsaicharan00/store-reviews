# claude/pensive-gates-3n4ie8-perf5 @ 57a35eb (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38172254885 · 2026-10-11 21:26 UTC
Commit: Speed bisect: the merged iPad build against the new main on the iPhone, six rounds [ios-perf-bisect] perf-variants: main=161c1779 branch=HEAD~1 perf-scenarios: tap-today habit-page perf-rounds: 6

Variants: `main=161c1779 branch=HEAD~1` · scenarios: `tap-today habit-page` · rounds: 6

- main: 161c1779 Merging the Branches: claude/drive-sync merged; its test copies safe to delete
- branch: e67883a6 Merge main (the Apple Watch app, Google Drive sync in the core, docs) into the iPad build

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Today: +1 and day ‹ › | **33.5**<br>92 (140, 1), 65.6 (54, 0), 16.1 (45, 0), 50.8 (64, 0), 13.1 (38, 0), 14.7 (49, 0) | **30.8**<br>98.1 (146, 2), 68.1 (110, 1), 13.6 (48, 0), 48 (49, 0), 12.7 (45, 0), 11.9 (44, 0) |
| Today: +1 alone | **0.3**<br>4.4 (55, 0), 6.5 (46, 0), 0 (0, 0), 0 (0, 0), 0.1 (18, 0), 0.5 (24, 0) | **0.6**<br>0.3 (19, 0), 1 (28, 0), 0.1 (18, 0), 1.8 (35, 0), 0.9 (24, 0), 0.1 (18, 0) |
| Today: day ‹ › alone | **30.3**<br>114.7 (173, 2), 118.3 (104, 1), 12.8 (52, 0), 44.9 (58, 0), 15.7 (64, 0), 15 (41, 0) | **59.6**<br>88.7 (91, 0), 58.5 (62, 0), 60.8 (141, 1), 110.1 (99, 0), 9.9 (34, 0), 20.4 (44, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **0.6**<br>11.6 (62, 0), 0 (0, 0), 0.6 (24, 0), 3.4 (69, 0), 0.6 (26, 0), 0 (0, 0) | **0.6**<br>2.1 (36, 0), 3.3 (67, 0), 0 (0, 0), 1.2 (31, 0), 0 (0, 0), 0 (0, 0) |
| Habit page: History scrolling | **5.7**<br>13.6 (128, 1), 6.5 (100, 0), 8.4 (108, 1), 1.7 (42, 0), 4.8 (58, 0), 1 (32, 0) | **3.9**<br>6.6 (89, 0), 4 (65, 0), 4.2 (80, 0), 3.7 (60, 0), 1.5 (39, 0), 2.4 (52, 0) |
| Habit page: Progress scrolling | **5.8**<br>31 (202, 2), 3.5 (62, 0), 9.9 (105, 1), 4.5 (84, 0), 5.9 (68, 0), 5.8 (48, 0) | **9.2**<br>17.2 (202, 1), 12.8 (133, 1), 13.5 (148, 1), 5.5 (65, 0), 2.2 (48, 0), 2.3 (35, 0) |
| Habit page: switching tabs | **14.7**<br>6.9 (61, 0), 19.6 (53, 0), 22.5 (43, 0), 3.2 (29, 0), 9.7 (64, 0), 20.4 (60, 0) | **7.8**<br>21 (61, 0), 0.4 (18, 0), 12.4 (32, 0), 11.4 (39, 0), 2.3 (25, 0), 4.1 (36, 0) |

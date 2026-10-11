# claude/pensive-gates-3n4ie8-perf5 @ fc86a77 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38154788830 · 2026-10-11 17:14 UTC
Commit: Speed bisect: Today's taps, the iPad build's newest commit against main on the iPhone, six rounds [ios-perf-bisect] perf-variants: main=bac8a1b5 branch=HEAD~1 perf-scenarios: tap-today perf-rounds: 6

Variants: `main=bac8a1b5 branch=HEAD~1` · scenarios: `tap-today` · rounds: 6

- main: bac8a1b5 Current Work 88: coming back to the iPhone after using the iPad, "Use your habits on this iPhone?" (t
- branch: 555410fb Current Work 86: Day details takes the iPad's options from the iPad's own code; the iPhone's reads no

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Today: +1 and day ‹ › | **56.5**<br>37.3 (90, 0), 80.3 (115, 2), 70.2 (94, 0), 94.3 (176, 3), 34.5 (62, 0), 42.7 (65, 0) | **52.7**<br>68.2 (120, 1), 184.9 (159, 4), 38.1 (79, 0), 14.2 (38, 0), 57.8 (82, 0), 47.6 (93, 0) |
| Today: +1 alone | **1.8**<br>1.8 (41, 0), 3.2 (47, 0), 1.8 (30, 0), 1.9 (45, 0), 1.7 (29, 0), 0.2 (20, 0) | **1.4**<br>2.9 (39, 0), 5.2 (38, 0), 2.2 (36, 0), 0.6 (22, 0), 0.2 (20, 0), 0.5 (24, 0) |
| Today: day ‹ › alone | **39.7**<br>125 (107, 1), 67.3 (118, 1), 36.5 (59, 0), 40.3 (53, 0), 39.1 (56, 0), 19.5 (44, 0) | **64.8**<br>91.5 (108, 1), 78.9 (78, 0), 22.9 (50, 0), 12.3 (37, 0), 117.4 (127, 2), 50.6 (79, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **0.0**<br>28.7 (114, 1), 0.2 (20, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 19 (101, 1), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |

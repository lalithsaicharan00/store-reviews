# claude/pensive-gates-3n4ie8-perf7 @ 5285d11 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38143097108 · 2026-10-11 14:16 UTC
Commit: Speed bisect: the iPad's Columns with each list holding its own height, against the commit before [ios-perf-bisect] perf-variants: before=a1eed4b5 after=HEAD~1 perf-scenarios: pad-columns pad-today perf-rounds: 4 perf-device: iPad Air 11-inch

Variants: `before=a1eed4b5 after=HEAD~1` · scenarios: `pad-columns pad-today` · rounds: 4

- before: a1eed4b5 Current Work 86: Day details keeps Add log and its typed amount as the window narrows; Plus's Buy kee
- after: 5d1ca265 Current Work 86: each Columns list holds its own height, so a column that changes redraws only itself

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | before | after |
|---|---|---|
| iPad Columns: scrolling sideways | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.1**<br>0 (0, 0), 0.2 (20, 0), 0 (0, 0), 2.2 (50, 0) |
| iPad Columns: scrolling down | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| iPad Columns: +1 and day ‹ › | **738.4**<br>742.6 (1390, 39), 745.3 (726, 40), 734.2 (580, 38), 696.3 (582, 39) | **647.5**<br>716.2 (640, 45), 665.4 (1077, 39), 575 (432, 36), 629.6 (426, 36) |
| iPad Today: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| iPad Today: +1 and day ‹ › | **145.2**<br>160.1 (163, 6), 142.4 (176, 3), 147.9 (188, 5), 137.8 (196, 3) | **175.6**<br>245.3 (213, 18), 148.2 (198, 5), 203.1 (267, 9), 131.1 (176, 4) |
| iPad: typing in Add log inside the popover | **25.7**<br>32.8 (459, 1), 13.1 (212, 1), 18.6 (200, 2), 211.5 (2020, 4) | **239.9**<br>229.3 (2408, 2), 253.6 (1899, 3), 44.5 (347, 2), 250.5 (2660, 5) |

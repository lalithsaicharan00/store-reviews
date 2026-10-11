# claude/pensive-gates-3n4ie8-perf6 @ e291047 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38154786500 · 2026-10-11 17:12 UTC
Commit: Speed bisect: Day details and Today's scrolling, the iPad build's newest commit against main on the iPhone, six rounds [ios-perf-bisect] perf-variants: main=bac8a1b5 branch=HEAD~1 perf-scenarios: day-sheet scroll-today perf-rounds: 6

Variants: `main=bac8a1b5 branch=HEAD~1` · scenarios: `day-sheet scroll-today` · rounds: 6

- main: bac8a1b5 Current Work 88: coming back to the iPhone after using the iPad, "Use your habits on this iPhone?" (t
- branch: 555410fb Current Work 86: Day details takes the iPad's options from the iPad's own code; the iPhone's reads no

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **0.6**<br>1.1 (30, 0), 0 (0, 0), 0.7 (23, 0), 2.7 (25, 0), 0.4 (22, 0), 0.2 (19, 0) | **0.4**<br>0 (0, 0), 0 (0, 0), 0.1 (18, 0), 1.7 (29, 0), 0.7 (22, 0), 0.9 (28, 0) |
| Day sheet: add, edit and exact undo | **101.8**<br>76.6 (79, 0), 56.3 (58, 0), 164.5 (114, 2), 253.5 (124, 3), 126.9 (88, 0), 69.2 (66, 0) | **135.4**<br>65.6 (56, 0), 67.6 (54, 0), 365.1 (158, 11), 180.4 (123, 1), 156.3 (130, 2), 114.5 (81, 0) |
| Today: scrolling | **17.8**<br>23.4 (245, 1), 7.4 (64, 0), 22.3 (196, 2), 19.6 (108, 2), 16 (100, 1), 2.9 (31, 0) | **8.2**<br>5.5 (45, 0), 7 (115, 1), 14.6 (190, 1), 29.3 (170, 3), 7.1 (52, 0), 9.4 (122, 1) |

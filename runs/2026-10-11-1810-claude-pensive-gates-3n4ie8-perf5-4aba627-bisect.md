# claude/pensive-gates-3n4ie8-perf5 @ 4aba627 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38159808960 · 2026-10-11 18:10 UTC
Commit: Speed bisect: Today's taps and scrolling, the final iPad build against main on the iPhone, six rounds [ios-perf-bisect] perf-variants: main=bac8a1b5 branch=HEAD~1 perf-scenarios: tap-today scroll-today perf-rounds: 6

Variants: `main=bac8a1b5 branch=HEAD~1` · scenarios: `tap-today scroll-today` · rounds: 6

- main: bac8a1b5 Current Work 88: coming back to the iPhone after using the iPad, "Use your habits on this iPhone?" (t
- branch: 0fcfa8fb Current Work 86: Today's rows and headers hide themselves from VoiceOver while a page covers Today; t

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Today: +1 and day ‹ › | **37.5**<br>266.5 (261, 16), 152.3 (104, 1), 46 (71, 0), 22.1 (82, 0), 20 (59, 0), 29.1 (57, 0) | **65.3**<br>165.9 (166, 7), 83.9 (95, 0), 80.9 (100, 1), 49.8 (76, 0), 17.2 (66, 0), 34.8 (57, 0) |
| Today: +1 alone | **0.9**<br>19.2 (48, 0), 4.8 (46, 0), 1.3 (30, 0), 0 (0, 0), 0.3 (21, 0), 0.6 (25, 0) | **1.4**<br>8.2 (66, 0), 2.3 (39, 0), 6.5 (80, 0), 0.2 (19, 0), 0.1 (18, 0), 0.5 (24, 0) |
| Today: day ‹ › alone | **67.8**<br>135 (125, 2), 100.4 (100, 1), 80.4 (95, 0), 30.3 (62, 0), 19.8 (41, 0), 55.3 (77, 0) | **39.7**<br>100.9 (97, 0), 96.6 (77, 0), 37.5 (56, 0), 19.7 (47, 0), 12.2 (37, 0), 41.9 (63, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **0.1**<br>1.3 (22, 0), 0.2 (19, 0), 0.5 (24, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0.2 (20, 0), 0 (0, 0) |
| Today: scrolling | **13.1**<br>25.4 (180, 2), 14 (95, 0), 12.1 (97, 0), 5.2 (30, 0), 4.4 (30, 0), 18.3 (126, 1) | **11.5**<br>19.8 (154, 2), 13.8 (112, 1), 13 (114, 1), 10 (51, 0), 7.3 (39, 0), 7 (37, 0) |

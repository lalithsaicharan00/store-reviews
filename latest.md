# claude/pensive-gates-3n4ie8-perf7 @ 3ae1d9a (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38165599443 · 2026-10-11 19:29 UTC
Commit: Speed bisect: the iPad's places with Today drawing nothing under a page, against Today kept drawn [ios-perf-bisect] perf-variants: before=b0991b2a after=HEAD~1 perf-scenarios: pad-places pad-today perf-rounds: 4 perf-device: iPad Air 11-inch

Variants: `before=b0991b2a after=HEAD~1` · scenarios: `pad-places pad-today` · rounds: 4

- before: b0991b2a Current Work 86: Today is hidden from VoiceOver under a page through UIKit's own flag on its navigati
- after: 548aa01d Current Work 86: a page beside the sidebar covers Today as the routine player does: Today stays alive

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | before | after |
|---|---|---|
| iPad Habits: moving between habits | **223.1**<br>259.5 (249, 24), 172.9 (141, 14), 241.8 (255, 22), 204.3 (197, 16) | **216.9**<br>220.5 (176, 20), 153.1 (117, 7), 318 (243, 32), 213.3 (222, 18) |
| iPad Progress: scrolling | **11.2**<br>40.1 (354, 1), 0.8 (28, 0), 11 (128, 1), 11.5 (50, 0) | **20.1**<br>14.1 (64, 0), 8.2 (50, 0), 46.8 (126, 1), 26 (71, 0) |
| iPad Today: scrolling | **103.1**<br>69.2 (138, 1), 118.6 (212, 12), 100 (177, 6), 106.2 (168, 5) | **71.9**<br>64.5 (169, 1), 42 (81, 0), 79.3 (133, 3), 115.1 (293, 8) |
| iPad Today: +1 and day ‹ › | **137.2**<br>84.3 (97, 0), 153.9 (181, 5), 157 (157, 11), 120.5 (138, 2) | **115.1**<br>85.8 (87, 0), 58.4 (67, 0), 144.3 (190, 3), 202.4 (143, 7) |
| iPad: typing in Add log inside the popover | **132.1**<br>85.9 (540, 4), 12.1 (160, 1), 192 (1393, 4), 178.3 (2005, 4) | **152.3**<br>142.7 (1453, 4), 161.9 (1282, 7), 193.2 (1081, 5), 4.8 (60, 0) |

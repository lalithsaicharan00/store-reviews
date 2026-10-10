# app-lock-privacy-security-perf @ ec8ae42 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38020884534 · 2026-10-10 04:14 UTC
Commit: Speed bisect: the menu and Today's day switch, this branch against main, six rounds [ios-perf-bisect]

Variants: `main=d39664f branch=0fd42f0` · scenarios: `menu tap-today` · rounds: 6

- main: d39664f8 Cloud session's list: final runs passed on the merged code; merged into main; iPhone checks listed; s
- branch: 0fd42f04 Current Work 73.1: an idea's form leaves by Back without "Discard Changes?" until something is typed 

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Menu: open and close | **35.3**<br>77.8 (139, 9), 42.9 (186, 1), 46.6 (97, 0), 27.7 (61, 0), 27.4 (146, 1), 23.9 (98, 0) | **36.5**<br>75.4 (145, 8), 63.1 (162, 3), 45.3 (220, 2), 27.6 (98, 0), 15.8 (63, 0), 23.1 (155, 1) |
| Today: +1 and day ‹ › | **17.8**<br>79.2 (81, 0), 38 (100, 1), 10.7 (74, 0), 17.2 (67, 0), 18.4 (46, 0), 8.6 (51, 0) | **12.8**<br>100.3 (224, 4), 60 (148, 1), 9.5 (42, 0), 13.4 (60, 0), 8.6 (48, 0), 12.2 (50, 0) |
| Today: +1 alone | **0.2**<br>8.7 (39, 0), 0.8 (28, 0), 0 (0, 0), 0.4 (22, 0), 0 (0, 0), 0 (0, 0) | **0.3**<br>21.7 (122, 1), 0.5 (23, 0), 0.4 (22, 0), 0.3 (21, 0), 0.1 (18, 0), 0.1 (18, 0) |
| Today: day ‹ › alone | **12.5**<br>100 (101, 1), 51.1 (60, 0), 13.7 (34, 0), 8 (42, 0), 11.2 (34, 0), 11.3 (40, 0) | **12.6**<br>70.9 (82, 0), 23.7 (90, 0), 13.2 (41, 0), 12.1 (32, 0), 7.3 (33, 0), 9.9 (39, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **0.0**<br>12.3 (89, 0), 0 (0, 0), 0.1 (19, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>4.6 (73, 0), 1.1 (28, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |

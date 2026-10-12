# claude/shared-habit-rules-perf20 @ cec56c7 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38292286414 · 2026-10-12 20:07 UTC
Commit: Current Work 92: speed side by side with main, every strip in one call (scratch, safe to delete) [ios-perf-bisect]

Variants: `main=ad7a898f shared=HEAD` · scenarios: `scroll-today tap-today` · rounds: 4

- main: ad7a898f Current Work 92: checkpoint 1 ticked (runs 38213677372, 38213679929, 38224578250, 38216734746)
- shared: cec56c7d Current Work 92: speed side by side with main, every strip in one call (scratch, safe to delete) [ios

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | shared |
|---|---|---|
| Today: scrolling | **20.9**<br>17.5 (119, 1), 24.8 (354, 1), 8.3 (46, 0), 24.3 (285, 1) | **14.4**<br>8.4 (80, 0), 552.3 (8304, 1), 16.2 (96, 0), 12.7 (98, 0) |
| Today: +1 and day ‹ › | **20.9**<br>25.8 (76, 0), 23.5 (98, 0), 18.3 (83, 0), 15.9 (55, 0) | **25.2**<br>15.5 (76, 0), 132.9 (1698, 2), 31.3 (76, 0), 19.1 (72, 0) |
| Today: +1 alone | **0.1**<br>0.5 (25, 0), 0.1 (18, 0), 0 (0, 0), 0 (0, 0) | **0.1**<br>0.2 (19, 0), 0 (0, 0), 5.1 (65, 0), 0 (17, 0) |
| Today: day ‹ › alone | **16.9**<br>18.4 (66, 0), 15.4 (43, 0), 19.4 (48, 0), 10 (36, 0) | **15.0**<br>20.3 (70, 0), 12.7 (40, 0), 16.9 (45, 0), 13.2 (38, 0) |
| Today: Day sheet scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Timer screen: a running clock | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **1.3**<br>2.6 (56, 0), 2.8 (36, 0), 0 (0, 0), 0 (0, 0) |

Timed work, all rounds (count · total ms · longest ms):

| What | main | shared |
|---|---|---|
| Store load: read the database | 16 · 3835 · 964.4 | 16 · 3593 · 592.4 |
| Widgets: one habit's week | 201 · 1569 · 858.4 | 201 · 1119 · 250.1 |
| Store load: into the app (5593 logs) | 8 · 385 · 58.7 | 8 · 361 · 51.7 |
| Store load: into the app (0 logs) | 8 · 12 · 2.2 | 8 · 13 · 2.8 |
| Widgets: the snapshot | 73 · 61 · 2.5 | 73 · 105 · 9.0 |
| Count: Today's list drawn | 403 · 3 · 2.3 | 413 · 1 · 0.5 |
| Reminders: plan every alert | 238 · 12 · 0.5 | 237 · 16 · 1.1 |
| Count: a Today row drawn | 3122 · 0 · 0.0 | 3194 · 0 · 0.0 |
| Shared rules: built from every log | – | 32 · 156 · 22.0 |
| Shared rules: habits and settings again | – | 48 · 32 · 3.2 |
| Change: Siri's habit names | 231 · 12 · 0.2 | 230 · 12 · 0.3 |
| Count: the Day sheet drawn | 57 · 0 · 0.0 | 60 · 0 · 0.0 |
| Count: the Day sheet's activity drawn | 57 · 0 · 0.0 | 60 · 0 · 0.0 |
| Shared rules: a log added | – | 226 · 12 · 0.2 |

# claude/pensive-gates-3n4ie8-perf6 @ bef8889 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38172256877 · 2026-10-11 21:02 UTC
Commit: Speed bisect: the merged iPad build against the new main on the iPhone, six rounds [ios-perf-bisect] perf-variants: main=161c1779 branch=HEAD~1 perf-scenarios: day-sheet scroll-today perf-rounds: 6

Variants: `main=161c1779 branch=HEAD~1` · scenarios: `day-sheet scroll-today` · rounds: 6

- main: 161c1779 Merging the Branches: claude/drive-sync merged; its test copies safe to delete
- branch: e67883a6 Merge main (the Apple Watch app, Google Drive sync in the core, docs) into the iPad build

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | main | branch |
|---|---|---|
| Day sheet: entry list scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| All logs: scrolling | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) | **0.0**<br>0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0) |
| Entry editor: typing | **0.1**<br>0.3 (21, 0), 0 (0, 0), 0.3 (20, 0), 0.1 (18, 0), 0 (0, 0), 0.1 (18, 0) | **0.0**<br>0.3 (21, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0 (0, 0), 0.7 (23, 0) |
| Day sheet: add, edit and exact undo | **53.1**<br>51 (55, 0), 52.5 (48, 0), 67.1 (59, 0), 53.8 (46, 0), 38.9 (48, 0), 66.1 (53, 0) | **60.6**<br>54.7 (70, 0), 62.1 (49, 0), 68.9 (50, 0), 62.9 (63, 0), 59.1 (52, 0), 58.8 (59, 0) |
| Today: scrolling | **2.9**<br>4.4 (39, 0), 2.2 (26, 0), 3.3 (40, 0), 2.5 (25, 0), 5.3 (38, 0), 0.6 (23, 0) | **5.3**<br>7.8 (67, 0), 5.3 (44, 0), 2 (39, 0), 4.1 (32, 0), 5.4 (60, 0), 5.4 (38, 0) |

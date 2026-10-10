# claude/awesome-newton-pmu4y7-ci3 @ 0780cee (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38066123267 · 2026-10-10 16:28 UTC
Commit: Plus screens: does the habit form type slower? Side by side with main [ios-perf-bisect]

Variants: `base=f604973 head=HEAD` · scenarios: `new-habit` · rounds: 4

- base: f6049733 Plus screens: the build prompt and its 26 mockup images for a cloud session (delete the folder when d
- head: 0780ceec Plus screens: does the habit form type slower? Side by side with main [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | base | head |
|---|---|---|
| Habit form: typing | **12.2**<br>19.4 (86, 0), 36.4 (258, 2), 3.2 (34, 0), 5.1 (65, 0) | **20.1**<br>30.1 (130, 1), 34.1 (91, 0), 4.9 (35, 0), 10 (46, 0) |

# claude/awesome-newton-pmu4y7-ci3 @ e3978a3 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38067941263 · 2026-10-10 16:59 UTC
Commit: Plus screens: habit form typing side by side with main, again [ios-perf-bisect]

Variants: `base=f604973 head=HEAD` · scenarios: `new-habit` · rounds: 6

- base: f6049733 Plus screens: the build prompt and its 26 mockup images for a cloud session (delete the folder when d
- head: e3978a35 Plus screens: habit form typing side by side with main, again [ios-perf-bisect]

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | base | head |
|---|---|---|
| Habit form: typing | **21.9**<br>61.5 (605, 2), 25.9 (85, 0), 38.9 (193, 2), 17.9 (71, 0), 12 (61, 0), 16.9 (92, 0) | **21.2**<br>29.5 (102, 1), 17.1 (66, 0), 21 (102, 1), 21.5 (160, 1), 8.7 (75, 0), 22.6 (63, 0) |

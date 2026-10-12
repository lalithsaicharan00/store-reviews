# claude/shared-habit-rules-bench @ 5659e85 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38289401969 · 2026-10-12 18:32 UTC
Commit: Current Work 92: where a rule's time goes, Swift rules against shared rules (scratch, safe to delete) [ios-perf-bisect]

Variants: `swift=HEAD+-swift-rules shared=HEAD` · scenarios: `rules-calls` · rounds: 2

- swift: 5659e850 Current Work 92: where a rule's time goes, Swift rules against shared rules (scratch, safe to delete)
- shared: 5659e850 Current Work 92: where a rule's time goes, Swift rules against shared rules (scratch, safe to delete)

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | swift | shared |
|---|---|---|

Timed work, all rounds (count · total ms · longest ms):

| What | swift | shared |
|---|---|---|
| Store load: read the database | 4 · 2591 · 1774.9 | 4 · 2433 · 1497.1 |
| Widgets: one habit's week | 34 · 186 · 56.2 | 34 · 384 · 173.0 |
| Rules (in a view): dayMark | 6 · 167 · 32.7 | 6 · 215 · 43.8 |
| Rules (in a view): isDone | 6 · 137 · 33.2 | 6 · 188 · 38.5 |
| Store load: into the app (5593 logs) | 2 · 112 · 56.8 | 2 · 142 · 85.7 |
| Rules (outside a view): isDone | 6 · 100 · 27.7 | 6 · 191 · 46.3 |
| Rules (in a view): dayProgress | 6 · 79 · 17.9 | 6 · 155 · 37.7 |
| Rules (outside a view): dayMark | 6 · 76 · 16.2 | 6 · 238 · 48.6 |
| Rules (in a view): isDue | 6 · 49 · 13.9 | 6 · 125 · 28.0 |
| Rules (outside a view): dayProgress | 6 · 39 · 8.3 | 6 · 159 · 32.4 |
| Rules (outside a view): isDue | 6 · 19 · 5.0 | 6 · 94 · 18.6 |
| Store load: into the app (0 logs) | 2 · 6 · 5.2 | 2 · 3 · 1.6 |
| Widgets: the snapshot | 2 · 5 · 3.2 | 2 · 6 · 2.5 |
| Reminders: plan every alert | 2 · 2 · 1.8 | 2 · 0 · 0.2 |
| Count: Today's list drawn | 14 · 0 · 0.1 | 17 · 0 · 0.1 |
| Count: a Today row drawn | 32 · 0 · 0.0 | 40 · 0 · 0.0 |
| Rules (outside a view): Swift reads a year's numbers back | – | 6 · 319 · 67.7 |
| Rules (outside a view): Kotlin days, a year in one call | – | 6 · 272 · 68.8 |
| Rules (in a view): Kotlin days, a year in one call | – | 6 · 268 · 77.1 |
| Rules (in a view): Swift reads a year's numbers back | – | 6 · 261 · 69.1 |
| Rules (outside a view): Kotlin isDone, habit in hand | – | 6 · 80 · 24.9 |
| Rules (in a view): the Swift side only (shared) | – | 6 · 87 · 16.1 |
| Rules (in a view): Kotlin isDone, habit in hand | – | 6 · 65 · 13.8 |
| Rules (outside a view): the Swift side only (shared) | – | 6 · 57 · 12.5 |
| Shared rules: built from every log | – | 8 · 45 · 21.6 |
| Shared rules: habits and settings again | – | 10 · 6 · 1.9 |
| Rules (outside a view): Kotlin dayGoal, habit in hand (the crossing) | – | 6 · 6 · 2.1 |
| Rules (in a view): Kotlin dayGoal, habit in hand (the crossing) | – | 6 · 4 · 0.6 |

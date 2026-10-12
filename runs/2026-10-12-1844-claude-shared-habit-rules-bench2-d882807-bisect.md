# claude/shared-habit-rules-bench2 @ d882807 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38290557325 · 2026-10-12 18:44 UTC
Commit: Current Work 92: where a rule's time goes, after the optimisations (scratch, safe to delete) [ios-perf-bisect]

Variants: `swift=HEAD+-swift-rules shared=HEAD` · scenarios: `rules-calls` · rounds: 2

- swift: d882807a Current Work 92: where a rule's time goes, after the optimisations (scratch, safe to delete) [ios-per
- shared: d882807a Current Work 92: where a rule's time goes, after the optimisations (scratch, safe to delete) [ios-per

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | swift | shared |
|---|---|---|

Timed work, all rounds (count · total ms · longest ms):

| What | swift | shared |
|---|---|---|
| Store load: read the database | 4 · 4187 · 2591.5 | 4 · 3754 · 1894.9 |
| Widgets: one habit's week | 34 · 243 · 111.2 | 34 · 329 · 116.0 |
| Store load: into the app (5593 logs) | 2 · 192 · 100.9 | 2 · 138 · 84.8 |
| Rules (in a view): isDone | 6 · 146 · 30.1 | 6 · 108 · 28.7 |
| Rules (in a view): dayMark | 6 · 142 · 29.1 | 6 · 121 · 22.4 |
| Rules (outside a view): isDone | 6 · 103 · 22.8 | 6 · 73 · 17.6 |
| Rules (outside a view): dayMark | 6 · 94 · 19.5 | 6 · 101 · 19.1 |
| Rules (in a view): dayProgress | 6 · 82 · 21.5 | 6 · 107 · 28.4 |
| Rules (outside a view): dayProgress | 6 · 47 · 11.8 | 6 · 66 · 17.9 |
| Rules (in a view): isDue | 6 · 38 · 9.1 | 6 · 88 · 22.6 |
| Rules (outside a view): isDue | 6 · 21 · 4.4 | 6 · 43 · 9.9 |
| Store load: into the app (0 logs) | 2 · 11 · 5.7 | 2 · 2 · 0.7 |
| Widgets: the snapshot | 2 · 6 · 4.6 | 2 · 4 · 2.3 |
| Count: Today's list drawn | 14 · 0 · 0.4 | 18 · 0 · 0.0 |
| Reminders: plan every alert | 2 · 0 · 0.2 | 2 · 0 · 0.3 |
| Count: a Today row drawn | 32 · 0 · 0.0 | 32 · 0 · 0.0 |
| Rules (outside a view): Swift reads a year's numbers back | – | 6 · 289 · 93.7 |
| Rules (in a view): Swift reads a year's numbers back | – | 6 · 224 · 57.2 |
| Rules (in a view): Kotlin days, a year in one call | – | 6 · 179 · 52.5 |
| Rules (outside a view): Kotlin days, a year in one call | – | 6 · 180 · 45.8 |
| Rules (in a view): the Swift side only (shared) | – | 6 · 63 · 18.1 |
| Rules (outside a view): Kotlin isDone, habit in hand | – | 6 · 59 · 16.4 |
| Shared rules: built from every log | – | 8 · 52 · 26.1 |
| Rules (in a view): Kotlin isDone, habit in hand | – | 6 · 38 · 7.6 |
| Rules (outside a view): the Swift side only (shared) | – | 6 · 31 · 9.8 |
| Shared rules: habits and settings again | – | 10 · 7 · 2.8 |
| Rules (outside a view): Kotlin dayGoal, habit in hand (the crossing) | – | 6 · 6 · 2.0 |
| Rules (in a view): Kotlin dayGoal, habit in hand (the crossing) | – | 6 · 4 · 0.7 |

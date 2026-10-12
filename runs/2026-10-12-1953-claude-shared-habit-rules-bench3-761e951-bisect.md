# claude/shared-habit-rules-bench3 @ 761e951 (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38292303908 · 2026-10-12 19:53 UTC
Commit: Current Work 92: where a rule's time goes, every strip in one call (scratch, safe to delete) [ios-perf-bisect]

Variants: `swift=HEAD+-swift-rules shared=HEAD` · scenarios: `rules-calls` · rounds: 2

- swift: 761e951d Current Work 92: where a rule's time goes, every strip in one call (scratch, safe to delete) [ios-per
- shared: 761e951d Current Work 92: where a rule's time goes, every strip in one call (scratch, safe to delete) [ios-per

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | swift | shared |
|---|---|---|

Timed work, all rounds (count · total ms · longest ms):

| What | swift | shared |
|---|---|---|
| Store load: read the database | 4 · 1936 · 941.6 | 4 · 2127 · 958.1 |
| Widgets: one habit's week | 34 · 173 · 57.2 | 34 · 153 · 45.3 |
| Rules (in a view): dayMark | 6 · 134 · 23.1 | 6 · 90 · 16.0 |
| Rules (in a view): isDone | 6 · 113 · 20.9 | 6 · 72 · 13.2 |
| Store load: into the app (5593 logs) | 2 · 120 · 73.1 | 2 · 96 · 48.8 |
| Rules (outside a view): isDone | 6 · 66 · 12.4 | 6 · 58 · 11.8 |
| Rules (outside a view): dayMark | 6 · 65 · 12.6 | 6 · 75 · 14.4 |
| Rules (in a view): dayProgress | 6 · 57 · 9.8 | 6 · 60 · 11.1 |
| Rules (in a view): isDue | 6 · 36 · 6.6 | 6 · 47 · 8.1 |
| Rules (outside a view): dayProgress | 6 · 31 · 5.8 | 6 · 46 · 8.6 |
| Rules (outside a view): isDue | 6 · 13 · 2.3 | 6 · 50 · 22.3 |
| Store load: into the app (0 logs) | 2 · 4 · 3.7 | 2 · 0 · 0.3 |
| Widgets: the snapshot | 2 · 2 · 1.3 | 2 · 4 · 3.1 |
| Reminders: plan every alert | 2 · 1 · 0.7 | 2 · 1 · 0.9 |
| Count: Today's list drawn | 15 · 0 · 0.0 | 17 · 0 · 0.0 |
| Count: a Today row drawn | 40 · 0 · 0.0 | 40 · 0 · 0.0 |
| Rules (outside a view): Swift reads a year's numbers back | – | 6 · 153 · 49.0 |
| Rules (in a view): Swift reads a year's numbers back | – | 6 · 141 · 40.6 |
| Rules (in a view): Kotlin days, a year in one call | – | 6 · 146 · 37.9 |
| Rules (outside a view): Kotlin days, a year in one call | – | 6 · 153 · 38.0 |
| Rules (in a view): Kotlin isDone, habit in hand | – | 6 · 52 · 20.6 |
| Rules (outside a view): Kotlin isDone, habit in hand | – | 6 · 40 · 8.0 |
| Rules (in a view): the Swift side only (shared) | – | 6 · 31 · 5.7 |
| Shared rules: built from every log | – | 8 · 28 · 9.1 |
| Rules (outside a view): the Swift side only (shared) | – | 6 · 16 · 2.9 |
| Shared rules: habits and settings again | – | 10 · 3 · 1.0 |
| Rules (outside a view): Kotlin dayGoal, habit in hand (the crossing) | – | 6 · 4 · 0.6 |
| Rules (in a view): Kotlin dayGoal, habit in hand (the crossing) | – | 6 · 6 · 2.8 |

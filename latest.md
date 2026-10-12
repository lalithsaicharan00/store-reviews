# claude/shared-habit-rules-bench4 @ 523f72e (speed bisect)

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38307061584 · 2026-10-12 21:59 UTC
Commit: Current Work 92: where a rule's time goes, all optimisations (scratch, safe to delete) [ios-perf-bisect]

Variants: `swift=HEAD+-swift-rules shared=HEAD` · scenarios: `rules-calls` · rounds: 2

- swift: 523f72ee Current Work 92: where a rule's time goes, all optimisations (scratch, safe to delete) [ios-perf-bise
- shared: 523f72ee Current Work 92: where a rule's time goes, all optimisations (scratch, safe to delete) [ios-perf-bise

Hitch ms/s per round (longest stall ms, freezes ≥100 ms), then the median hitch. Same machine, same job.

| Window | swift | shared |
|---|---|---|

Timed work, all rounds (count · total ms · longest ms):

| What | swift | shared |
|---|---|---|
| Store load: read the database | 4 · 3996 · 2637.4 | 4 · 2476 · 1228.3 |
| Widgets: one habit's week | 34 · 259 · 79.8 | 34 · 240 · 90.7 |
| Rules (in a view): dayMark | 6 · 199 · 37.1 | 6 · 118 · 27.1 |
| Store load: into the app (5593 logs) | 2 · 154 · 82.6 | 2 · 133 · 71.0 |
| Rules (in a view): isDone | 6 · 149 · 29.0 | 6 · 117 · 33.4 |
| Rules (outside a view): isDone | 6 · 107 · 27.6 | 6 · 98 · 19.5 |
| Rules (outside a view): dayMark | 6 · 86 · 19.4 | 6 · 115 · 29.8 |
| Rules (in a view): dayProgress | 6 · 76 · 17.4 | 6 · 72 · 16.0 |
| Rules (in a view): isDue | 6 · 50 · 11.4 | 6 · 63 · 14.4 |
| Rules (outside a view): dayProgress | 6 · 45 · 10.2 | 6 · 76 · 16.0 |
| Rules (outside a view): isDue | 6 · 18 · 4.1 | 6 · 54 · 13.8 |
| Store load: into the app (0 logs) | 2 · 7 · 6.0 | 2 · 0 · 0.5 |
| Widgets: the snapshot | 2 · 8 · 4.9 | 2 · 7 · 6.0 |
| Reminders: plan every alert | 2 · 2 · 0.8 | 2 · 0 · 0.3 |
| Count: Today's list drawn | 14 · 1 · 0.6 | 17 · 0 · 0.0 |
| Count: a Today row drawn | 32 · 0 · 0.0 | 40 · 0 · 0.0 |
| Rules (outside a view): Swift reads a year's numbers back | – | 6 · 81 · 20.9 |
| Rules (in a view): Swift reads a year's numbers back | – | 6 · 80 · 20.2 |
| Rules (in a view): Kotlin days, a year in one call | – | 6 · 65 · 15.1 |
| Rules (outside a view): Kotlin days, a year in one call | – | 6 · 65 · 22.2 |
| Rules (outside a view): Kotlin isDone, habit in hand | – | 6 · 50 · 13.6 |
| Shared rules: built from every log, off the main thread | – | 4 · 60 · 36.3 |
| Rules (in a view): the Swift side only (shared) | – | 6 · 41 · 10.2 |
| Rules (in a view): Kotlin isDone, habit in hand | – | 6 · 48 · 14.7 |
| Rules (outside a view): the Swift side only (shared) | – | 6 · 27 · 7.7 |
| Shared rules: built from every log | – | 4 · 11 · 5.3 |
| Shared rules: habits and settings again | – | 10 · 5 · 1.2 |
| Rules (outside a view): Kotlin dayGoal, habit in hand (the crossing) | – | 6 · 4 · 1.1 |
| Rules (in a view): Kotlin dayGoal, habit in hand (the crossing) | – | 6 · 4 · 1.3 |

Long stalls (250 ms or more), with what the Kotlin collector last did:

- swift, rules-calls round 1: long stall 263 ms at 1791842251.150; kotlin no collection yet
- swift, rules-calls round 1: long stall 1107 ms at 1791842264.084; kotlin collection 237: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 7.6 ms
- swift, rules-calls round 1: long stall 359 ms at 1791842274.321; kotlin collection 238: stopped 0.4 ms (after waiting 0.0 ms), then 0.4 ms, took 23.1 ms
- shared, rules-calls round 1: long stall 666 ms at 1791842306.134; kotlin collection 236: stopped 0.0 ms (after waiting 0.0 ms), then 0.0 ms, took 32.8 ms
- shared, rules-calls round 1: long stall 542 ms at 1791842315.452; kotlin collection 238: stopped 0.0 ms (after waiting 0.0 ms), then 0.3 ms, took 24.1 ms
- shared, rules-calls round 2: long stall 875 ms at 1791842335.796; kotlin collection 233: stopped 0.1 ms (after waiting 0.0 ms), then 0.0 ms, took 14.3 ms
- shared, rules-calls round 2: long stall 656 ms at 1791842345.327; kotlin collection 235: stopped 0.0 ms (after waiting 0.0 ms), then 0.2 ms, took 36.9 ms
- swift, rules-calls round 2: long stall 838 ms at 1791842375.607; kotlin collection 250: stopped 0.4 ms (after waiting 10.0 ms), then 0.0 ms, took 64.0 ms
- swift, rules-calls round 2: long stall 391 ms at 1791842385.410; kotlin collection 251: stopped 0.0 ms (after waiting 0.0 ms), then 0.7 ms, took 19.0 ms

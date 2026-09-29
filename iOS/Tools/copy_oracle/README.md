# Copy oracle

Written by Claude (Claude Code), 29 September 2026.

The habit copy ("Gym every Monday and Wednesday", "Run every Sunday to Thursday", "Read 2 chapters a week") has one
home in the app, `Habits/Model/HabitCopy.swift`. This folder is its reference, written in Python so every case
can be printed and read before it ships:

| File | What it is |
|---|---|
| `copy_oracle.py` | The rules, mirroring `HabitCopy.swift`. `python3 copy_oracle.py` prints all 127 weekday sets for both week starts |
| `habits_cases.py` | 70 habit shapes and edge cases (every How often choice, amounts, units, limits, the longest texts) |
| `print_cases.py` | Dates of the month, monthly weekdays, yearly dates, every N days or weeks |
| `make_golden.py` | Writes `Habits/Model/CopyCheckCases.swift` from the oracle, for `CopyCheck` to compare on the phone |
| `weekdays_all.txt`, `habits_all.txt`, `dates_and_rules.txt` | The print-outs, as reviewed |

To change the copy: change `copy_oracle.py` and `HabitCopy.swift` the same way, read the print-outs, run
`python3 make_golden.py`, then run `NewHabitUITests/testCopyChecks` on the phone (it launches the app with
`-copycheck`, which runs `CopyCheck` and shows "Copy: all checks passed" or the phrases that differ).

# Who Pays for Habit Apps — Evidence

Written by Claude (Claude Code), 7 November 2026. The working files behind [the report](<../Who Pays for Habit Apps and Why — Audience Groups — 7 November 2026.md>).

| File | What it is |
|---|---|
| `hand_codes.json` | Every one of the 1,298 hand-read payer reviews: review key (`store\|app number\|review id`), P chose, S surprise charge, N not a payer, its true groups and reasons |
| `codes/a0–a6.py` | The same hand codes as written while reading, by batch |
| `codes/samples.py` | Hand codes for the 120 interest-only and 240 no-group samples |
| `codes/precision.py` | How many of 24 word matches were true, for each of 17 groups |
| `quotes_used.json` | Every quote in the report with its app, store and review ID, checked word for word against the source reviews |
| `tally_results.txt`, `extras_results.txt` | The printed tables. The money view in `extras_results.txt` skipped Finch by a bug; `scripts/money.py` is the corrected one the report uses |
| `scripts/` | The pipeline in order: `build_corpus`, `scope`, `pay_gate`, `paid`, `seg`, `flags`, `afford`, `lift_core`, `make_read`, `make_read2`, `make_prec`, `tally`, `tally2`, `extras`, `money`, `quotes`. They ran in `Research/Temp/audience/`, which isn't in git |

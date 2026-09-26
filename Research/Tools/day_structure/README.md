# Day-structure corpus scan

These scripts back `Research Reports/Day Structure and Organization/Habit Tracker — Day Structure Whole-Corpus Verification.md`.
They read every `reviews.jsonl` in `App Store Reviews/`, `Play Store Reviews/` and `Native Store Reviews/`, and write their working files to `Temp/daystructure/`. Run them from that folder: `cd Temp/daystructure`, then `python3 ../../Tools/day_structure/<script>.py`, or copy them there.

| Step | Script | Output |
|---|---|---|
| 1 | `screen.py` | `candidates.jsonl`: multilingual regex hits for time of day, groups, routines, sub-habits and group stats |
| 2 | `refine.py` | `candidates2.json`: splits habit-app hits from adjacent apps (to-do, notes, calendar, gym, native) and drops generic matches |
| 3 | `make_index.py` | `index.jsonl`: stable index of the 8,439 habit-tier hits, which is what the hand-coding refers to |
| 4 | `show.py START END` | readable batches for hand-coding into `cls/<start>-<end>.txt` |
| 5 | `aggregate.py` | validates the map (coverage, duplicates, unknown codes, remap), then writes `coded.jsonl` and `summary.json` |
| 6 | `analyze.py`, `showcode.py`, `pick.py` | secondary breakdowns, the friction sub-typing views and candidate citations |
| 7 | `resolve_cites.py`, `build_appendix.py` (+ `gists.py`) | resolve cited indices to review IDs and build the appendix table |

The hand-coded map and its outputs are saved in `Research Reports/Day Structure and Organization/Day Structure Evidence/Whole-Corpus Coding/`, because `Temp/` is gitignored.

# Today Screen Evidence

Supporting files for the nine Today Screen Top Area reports (24 September 2026, Claude Code).

| File | What it is |
|---|---|
| `QUESTIONS.md` | The nine questions as asked, with the screen being studied (Figma board 18:4) |
| `screen.py`, `screen2.py`, `screen3.py`, `screen4.py` | Keyword screens over all 1,487,223 reviews (run from `Temp/today-top/`, output `cand/<family>.jsonl`) |
| `common.py`, `wc.py`, `aggregate.py` | Batch writing, hand-code entry (every batch row coded, default X), union by citation id and counts |
| `codebook.md` | Every code used, per question |
| `review-classification-map.txt` | Every relevant hand-coded review: citation, codes, rating, app, note |
| `q9_tier.json` | Which reading tier (full read or random sample, seed 20260924) each Q9 row came from |
| `census-top.md`, `census-top.csv` | 49-app competitor census of the top of Home |
| `external-notes.md`, `hig/` | Apple HIG and NN/g passages quoted in the reports |
| `verify_report.py` | Checks that every cited review id exists and every quote matches the review text |

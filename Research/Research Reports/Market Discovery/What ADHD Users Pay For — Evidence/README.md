# What ADHD Users Pay For — Evidence

Written by Claude (Claude Code), 7 November 2026. Backs [the report](<../What ADHD Users Pay For — Features and Reasons — 7 November 2026.md>).

| File | What it holds |
|---|---|
| `Payers.csv` | All 1,339 coded payers: number, store, app, stars, date, review ID, status (P said paid, W implied, C paid then quit), read depth, group (main, child, suspected), feature codes, quit reasons and text |
| `Surprise Charges.csv` | The 285 hand-read surprise-charge and cancelling complaints, kept out of the payers |
| `Cited Non-Payers.csv` | The 6 reviews the report quotes from people who hadn't paid, marked as such there |
| `Codes/` | The hand codes, batch by batch; `quit_w.py` holds why each payer quit, with its key at the top |
| `Scripts/` | How the pool, filters, tallies and checks were built. `tally.py` groups apps; `final.py` makes every table; `mx.py` is the word-search check; `quotes.py` lists quotes checked word for word |

Source reviews are in `Research/ADHD App Reviews/`, `Research/App Store Reviews/` and `Research/Play Store Reviews/`.

Numbers 1 to 1816 were read in full; 5000 and above were read around their money sentence.

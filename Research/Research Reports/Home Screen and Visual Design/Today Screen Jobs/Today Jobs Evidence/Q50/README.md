# Question 50 evidence — the progress fill

- `scan.py` loads every App Store and Play Store review (205 apps, 1,238,784 reviews).
- `pass2.py` finds candidates (fill / progress bar / ring / "turns green" / tint words, plus a habit-or-list context word) and writes `pass2.json`.
- `pass3.py` adds the bar, swipe and slide reviews of the two apps whose rows fill (App Store 1 and 31), writes `pool.json` (1,427 reviews) and the reading chunks `read_NN.txt`.
- Every review in the pool was read individually. `progress_fill_classification.py` is the hand-curated code map (610 coded); `uncoded-ids.txt` lists the 817 read and judged off-topic.
- `validate.py` checks the map (zero unknown IDs) and prints the counts used in the report.
- `coded-reviews.tsv` holds the text of every coded review; `review-index.md` lists every ID by code.

Run in order from this folder: `python3 pass2.py && python3 pass3.py && python3 validate.py`.

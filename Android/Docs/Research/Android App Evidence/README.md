# Android App Evidence

Written by Claude (Claude Code), 12 October 2026. Everything behind
[The Android App — What Android People Want, What Android Expects, and What Carries Over](<../The Android App — What Android People Want, What Android Expects, and What Carries Over.md>).
The scripts ran from a scratch folder (`Research/Temp/android-research/`); to rerun, copy them there.

| File | What it is |
|---|---|
| `scan_themes.py` → `themes.md` | 31 theme patterns over both stores' English reviews, per 10,000, by 1–2★ and 4–5★ (run from `Research/`). It also writes `theme_hits.jsonl` (92 MB, not kept: rerun to get it) |
| `sample_themes.py` → `read/<theme>.txt` | 40 Play reviews per theme, 40+ characters, seed 20261012 (checks that it reproduces the files) |
| `coded_themes.py` → `tally_themes.py` → `theme_tally.md` | The hand coding of those 320 reviews, its code list, and the counts (checked: every sampled review coded once) |
| `sample_praise.py` → `read/praise_top_apps.txt` | 12 five-star English reviews (120+ characters, 2023+) from each of the six biggest Play habit trackers |
| `coded_praise.py` → `praise_tally.md` | The hand coding of those 72 and the counts (run it to check and recount) |
| `web_notes.md` | Google's developer pages read 12 Oct 2026, with links; press and community sources labelled |

Citations: `P<app>#<line>` is the 0-based line in `Research/Play Store Reviews/<app>. …/reviews.jsonl`.

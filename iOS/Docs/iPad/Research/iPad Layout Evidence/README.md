# iPad Layout Evidence

Written by Claude (Claude Code), 11 October 2026. The working files behind
[The iPad Layout](<../The iPad Layout — Familiar Like the iPhone, Native to the iPad.md>). Run every script with `python -I` from this folder.

| File | What it is |
|---|---|
| `scan.py` | Screens every review in `App Store Reviews/`, `Play Store Reviews/` and `Native Store Reviews/` for the iPad, a tablet, or a big-screen word (landscape, Split View, Slide Over, Stage Manager, multitasking, keyboard shortcuts, Pencil, horizontal mode in several languages). Writes `candidates.jsonl` (13,391 rows; not committed: it copies review text) and `stats.txt`. The reading batches were cut from it: every App Store candidate (2,071), the platform apps' iPad/tablet candidates that also use a layout word (455, Google Sheets left out), and the Play Store candidates with a layout word (209). |
| `coded.py` | Hand coding of the 2,071 App Store habit-app candidates: the 996 about the iPad's layout or use, by code (the codes are defined at the top); `TODAY_EVIDENCE` (phone-side reviews about scanning Today, not about the iPad); `ROLE_THEMES` and `MORE_THEMES` (sub-themes sorted by hand). |
| `coded_native.py` | Hand coding of the 455 platform-app candidates (337 coded). |
| `coded_play.py` | Hand coding of the 209 Play Store tablet candidates (129 coded). |
| `add_codes.py` | The helper used to append each batch's codes to `coded.py` while reading. |
| `check.py` | Checks `coded.py` against `candidates.jsonl` (every key exists, no code twice in a review, no key repeated in the file, every Today key exists) and writes `tally.txt`. |
| `tally.txt` | The counts quoted in the report's §3. |

Every review was read in full in its original language. A review is coded only for what it says about the iPad; the
1,075 App Store candidates left uncoded are about sync, buying a second time, or name the iPad in passing. Quotes in the
report were checked by script against the review text (translated ones are marked as such and not quoted).

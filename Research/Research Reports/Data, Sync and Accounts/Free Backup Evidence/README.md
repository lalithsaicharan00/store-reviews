# Free Backup Evidence

Evidence for [Free Plan Data Protection — Backup Without Giving Away Plus](<../Free Plan Data Protection — Backup Without Giving Away Plus.md>) (1 Oct 2026).

| File | What it is |
|---|---|
| `scan.py` | Full-corpus screen (1,238,784 App Store + Play reviews, 5 patterns). Writes `candidates.jsonl` and `mode-stats.txt` next to itself; `candidates.jsonl` is not kept here (regenerate it, about 3.5 min) |
| `mode-stats.txt` | Match counts per pattern |
| `codes.py` | Hand codes for all 710 paywall / hostage / paid-for / free-praise matches, keyed by review ref |
| `loss_codes.py` | Hand codes for all 643 data-loss stories, keyed by index in the sorted loss list (`tally.py` maps them to refs) |
| `tally.py`, `tally.txt` | Validation (every match coded once, no unknown refs, no duplicate codes) and all counts used in the report |
| `coded.json` | Every coded review: ref → codes (the full per-review index) |
| `quotes.py`, `quotes.json` | The 50 quotes in the report, each checked word for word against `reviews.jsonl` |

Ref = store letter (A App Store, P Play) + app folder number + line index in that app's `reviews.jsonl`.

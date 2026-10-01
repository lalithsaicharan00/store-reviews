# Backup Experience Evidence

Evidence for [Backup, Sync and Accounts — One Seamless Experience](<../Backup, Sync and Accounts — One Seamless Experience.md>) (1 Oct 2026).

| File | What it is |
|---|---|
| `scan.py` | Screen of 897,899 habit-app reviews (App Store + Play; to-do, gym, planner and native apps left out), 5 patterns. Writes `candidates.json` next to itself (not kept; regenerate) |
| `codes.py` | Hand codes for all 264 matches, by index in the sorted reading list (`scan.py` order, sorted by first pattern then ref) |
| `coded.json` | Every coded review: ref → codes |
| `tally.txt` | Counts per code, with apps, mean stars and the biggest app |
| `quotes.py`, `quotes.json` | The 21 quotes in the report, each checked word for word against `reviews.jsonl` |

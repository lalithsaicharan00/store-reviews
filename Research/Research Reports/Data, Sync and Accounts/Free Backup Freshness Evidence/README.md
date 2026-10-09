# Free Backup Freshness Evidence

Written by Claude (Claude Code), 9 Oct 2026, for
[Free Plan Backups — iPhone and iPad, and a Backup That's Never a Day Behind](<../Free Plan Backups — iPhone and iPad, and a Backup That's Never a Day Behind.md>)
(Current Work 75).

| File | What it is |
|---|---|
| `scan.py` | The full-corpus screen (1,238,784 App Store and Play reviews), three patterns. Rebuilds `candidates.jsonl` here (not kept in git: it's rebuilt in a minute) |
| `stats.txt` | What the screen found: 103 candidates |
| `classification.py` | The hand-coded map: every one of the 103 was read; the reviews on topic, by code |
| `verify.py` | Checks every quote in the report word for word against the candidates, and the counts, apps and ratings |
| `cost_model.py`, `cost.txt` | What each way of backing up a free account costs on Cloudflare, from sizes measured in the dev bucket on 9 Oct 2026 |

Run from this folder: `python3 -I scan.py`, then `python3 -I verify.py` and `python3 -I cost_model.py`.

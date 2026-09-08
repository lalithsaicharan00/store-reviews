# Google Play review extractor

Pulls every written review for an app, across all languages, as JSONL.
No API key, no account, no dependencies. Python 3.9+.

---

## Run everything

```bash
cd "/Users/lalith/Desktop/App store reviews"
python3 play_run_all.py
```

Walks all 146 apps in `play-habit-apps-ranked.json`, **one at a time**, in rank order.

Faster option — the 20 highest-volume languages instead of all 76 (typically 90%+
of reviews for a fraction of the time):

```bash
python3 play_run_all.py --priority
```

Specific ranks only:

```bash
python3 play_run_all.py 1 2 3
```

## One app at a time

```bash
python3 play_extract.py org.isoron.uhabits
python3 play_extract.py com.habitnow --languages priority --number 2
```

The **package id** is the first argument — the `id=` value in a Play URL:

```
https://play.google.com/store/apps/details?id=org.isoron.uhabits
                                              ^^^^^^^^^^^^^^^^^^
```

## Output

```
play_out/
  1. Habit Builder/
       reviews.jsonl        every review, one JSON object per line
       by_language/en.jsonl  split per language
       manifest.json        totals, rating split, per-language counts
       _state.json          resume cursor
```

Folder number = the app's rank in `play-habit-apps-ranked.md`.

```json
{"review_id":"f123fe51-...","package":"org.isoron.uhabits","app_name":"Loop Habit Tracker",
 "language":"ar","language_name":"Arabic","rating":5,"text":"...","author":"...",
 "date":"2026-09-01T10:22:03Z","thumbs_up":0,"app_version":"2.3.1","developer_reply":null}
```

---

## Languages, not countries

This is the big difference from the App Store version. **Play partitions reviews by
language, not country.** Verified: holding `hl=en` while varying country across US,
India, Japan, Germany, Brazil and Nigeria returned *identical* reviews; varying the
language returned *zero* overlap.

So `--languages` sweeps ~76 locales rather than storefronts, and there is **no
per-country breakdown available at all** — Play does not expose one. The
"12K ratings in India" style analysis has no Play equivalent.

| `--languages` | What it does |
|---|---|
| `all` (default) | All 76 locales |
| `priority` | The 20 highest-volume ones |
| `en,es,ja` | Just those |

---

## Not getting blocked

Measured against the live endpoint: **no throttling at 27 requests/second.** The
default is **4 workers**, far below that, because the risk is not a 429 — it is an
IP block from sustained load, which is what happened during the iOS run.

Built-in protection:

- 429/503/403 → global backoff, doubling to 30s, shared across threads, easing
  back as requests succeed.
- **Checkpointed after every page**, continuation token included, so an interrupt
  costs at most one page and resumes *mid-language*.
- One app at a time in `play_run_all.py`, plus a 3s gap between apps.
- A folder lock stops two extractors touching the same app; a lock left by a
  killed process clears itself.

`Ctrl-C` once finishes current pages and exits cleanly. Twice forces a stop.
**If anything stops, just rerun the same command** — finished work is skipped.

To go gentler: `--workers 2 --delay 0.5`

---

## Getting everything

Each language is paginated until Play stops returning a continuation token, which
is the natural end of that language's reviews.

**One honest limitation.** Play publishes no total written-review count, so unlike
the App Store — where I could confirm 391,203 of 391,203 — completeness here cannot
be *proven*, only inferred from the token running out. `_state.json` records
`complete: true` per language so you can see which ones genuinely exhausted.

Verified on real apps:

| App | Reviews | Duplicates | Languages exhausted | Date range |
|---|---|---|---|---|
| Loop Habit Tracker | 26,566 | 0 | 20/20 | 2016-02 → 2026-09 |
| HabitNow | 28,450 | 0 | 20/20 | 2019-05 → 2026-09 |
| Habit Builder | 246 | 0 | 20/20 | 2023-01 → 2026-07 |

Roughly 30k reviews per minute per app.

---

## Analysis

```bash
cd "play_out/3. Loop Habit Tracker"
cat manifest.json
wc -l by_language/en.jsonl
jq -r 'select(.rating==1) | .text' reviews.jsonl | head -20
```

```python
import pandas as pd
df = pd.read_json("reviews.jsonl", lines=True)
print(df.groupby("language")["rating"].agg(["count","mean"]).sort_values("count", ascending=False))
```

---

## A caveat about this endpoint

Play has **no public reviews API**. The official `androidpublisher` API returns 401
without OAuth, works only for apps you own, and only covers the last ~7 days.

This tool uses the internal RPC the Play web UI itself calls
(`batchexecute`/`UsvDTd`). It works well today, but it is undocumented, relies on
positional array indices, and carries no stability guarantee — unlike the iTunes
endpoint, which has been stable for over a decade. Expect it to break eventually.
If it does, the field positions in `normalise()` are the first place to look.

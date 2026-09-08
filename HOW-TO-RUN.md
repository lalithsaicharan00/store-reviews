# How to run the App Store review extractor

Pulls the **complete written-review history** for an iOS app from **all ~176 App Store
storefronts** and saves it as JSON.

No install, no API key, no Apple account. Python 3.9+ (macOS already has it).

---

## The short version

Open Terminal and run these two lines:

```bash
cd "/Users/lalith/Desktop/App store reviews"
python3 extract_reviews.py 570060128 --markets all
```

Replace `570060128` with your app. **That number is the only thing you change.**

---

## Where you enter the app

The app goes **directly after `extract_reviews.py`**, as the first argument. There is no
config file to edit. Three forms all work:

```bash
# 1. Numeric App Store ID  (most reliable)
python3 extract_reviews.py 570060128 --markets all

# 2. Full App Store URL  (paste straight from the browser -- keep the quotes)
python3 extract_reviews.py "https://apps.apple.com/us/app/id284882215" --markets all

# 3. App name  (convenient, but confirm it picked the right app)
python3 extract_reviews.py "Duolingo" --markets all
```

### Finding the App ID

Open the app on the App Store website. The URL ends in `id` + digits:

```
https://apps.apple.com/us/app/duolingo-language-lessons/id570060128
                                                          ^^^^^^^^^  <- this
```

### A note on searching by name

Names are ambiguous. The tool takes the **first** match and prints the others it saw:

```
Matched 5 apps for 'duolingo'; using the first:
   570060128  Duolingo: Language Lessons -- Duolingo, Inc (5,430,500 ratings)
   1440502568 Learn to Read - Duolingo ABC -- Duolingo, Inc (61,984 ratings)
```

If the first line isn't the app you meant, rerun with the numeric ID.

---

## What it creates

Each app gets its **own numbered folder**, named exactly as the App Store displays it —
the app title, then its subtitle:

```
out/
  1. Duolingo: Language Lessons - Languages, Math, Music & Chess/
       reviews.jsonl          <- every review, all countries, one file
       by_country/
         us.jsonl             <- same reviews, split per storefront
         jp.jsonl
         ... one per storefront
       manifest.json          <- totals, rating breakdown, per-country counts
       _state.json            <- resume cursor (internal)
  2. Instagram - Videos, creators & friends/
       ...
```

Numbering is automatic. **Re-running an app you've already pulled reuses its existing
folder** and adds only new reviews — it will not create a duplicate `3.` folder.

One review record:

```json
{"review_id":"14520162307","app_id":"570060128","app_name":"Duolingo: Language Lessons",
 "country":"jp","country_name":"Japan","rating":5,"title":"最高","body":"毎日続けられる…",
 "author":"...","date":"2026-09-07T04:56:55Z","vote_count":0,"vote_sum":0,"is_edited":false}
```

### Why `.jsonl` and not `.json`

It **is** JSON — one object per line (JSONL), rather than one giant array. For this size
that's strictly better: a 400 MB array has to be parsed whole before you can read record
one, while JSONL streams line by line, appends safely (which is what makes resume work),
and is read natively by `pandas.read_json(lines=True)`, DuckDB, `jq`, and every LLM
pipeline.

`manifest.json` is ordinary JSON, since it's small and you read it whole.

Need a single array? `jq -s '.' reviews.jsonl > reviews.json`

---

## Progress in the terminal

Yes — it prints as it goes. One line per storefront as each finishes, with a running
total, throughput, and ETA:

```
Duolingo: Language Lessons -- Languages, Math, Music & Chess
id 570060128  by Duolingo, Inc
Probing 176 storefronts for review counts...
  probed 176/176

1,240,318 reviews across 171 storefronts
   store                 reviews   share
   United States         391,203    31.5%
   United Kingdom         75,128     6.1%
   Brazil                 56,079     4.5%
   ...and 151 more storefronts (207,458 reviews)

Estimated requests: ~2,616

Writing to  out/1. Duolingo: Language Lessons - Languages, Math, Music & Chess/
  [  1/171] mv Maldives            14 reviews   total        14/1,240,318 ( 0.0%)  120/s  eta  9.2m
  [  2/171] is Iceland            208 reviews   total       222/1,240,318 ( 0.0%)  340/s  eta  8.8m
  [ 45/171] vn Vietnam         36,563 reviews   total   612,340/1,240,318 (49.4%)  8,204/s  eta  1.3m
  ...
Done in 14.2 min -- 1,240,318 new reviews this run
```

Roughly 171 lines over a full run — enough to see it's alive, not a wall of text.

It runs **unattended**. Start it and walk away.

---

## Options

| Flag | Default | What it does |
|---|---|---|
| `--markets` | `t1+t2` | `all` = every storefront. Or `t1`, `t2`, or a list like `us,gb,jp` |
| `--workers` | `6` | Storefronts fetched in parallel. Lower = gentler on your connection |
| `--probe-only` | off | Just count reviews per storefront; download nothing |
| `--out` | `out` | Output directory |
| `--page-size` | `500` | Reviews per request |
| `--min-reviews` | `1` | Skip storefronts with fewer than N reviews |
| `--delay` | `0` | Extra seconds between requests |

### Check the size before a big run

Takes ~30 seconds and downloads no reviews:

```bash
python3 extract_reviews.py 570060128 --markets all --probe-only
```

Prints per-storefront review counts and an estimated request count.

### Sharing your connection with something else

Lower the worker count so the two jobs don't fight:

```bash
python3 extract_reviews.py 570060128 --markets all --workers 3
```

`--workers 3` roughly halves the bandwidth. Add `--delay 0.5` to go gentler still.

### Skip the long tail

Many of the 176 storefronts have only a handful of reviews. To skip them:

```bash
python3 extract_reviews.py 570060128 --markets all --min-reviews 100
```

---

## Market presets

`--markets all` is what you want for full coverage. The presets are shortcuts:

- **`t1`** — highest iOS consumer spend (27): `us jp cn gb de fr ca au kr tw hk sg ch nl
  se no dk fi it es at be ie nz ae sa il`
- **`t2`** — high download volume, lower ARPU (26): `in br mx id vn ph th tr ru eg ng pk
  bd za ar co cl pe pl ua my ro cz pt gr hu`
- **`t1+t2`** — both (53, the default)
- **`all`** — everything Apple operates (~176)

Don't trust the tiers blindly — **run `--probe-only` and let the app's real numbers
decide.** For Duolingo, Vietnam (36,563) and Turkey (31,603) both out-review Japan
(28,644), and India (8,985) lands below Sweden.

---

## If it stops

**Rerun the exact same command.** It saves its position after every page, so:

- Completed storefronts are skipped in milliseconds
- A partially-done storefront resumes mid-country
- Nothing is re-downloaded, nothing is duplicated

Safe to interrupt any time. `Ctrl-C` once finishes the current pages and exits cleanly;
twice forces a stop. A crash, a dropped connection, or the laptop sleeping costs you at
most one page.

To force a clean re-pull, delete that app's folder (or just its `_state.json`).

### Only one extractor per app at a time

Each app folder is locked while a run is in progress. Starting a second run on the
*same app* is refused:

```
Another extractor is already working on this app folder (pid=4468).
  Running two at once creates duplicate reviews.
```

Two apps in parallel is fine — different folders, different locks. If a run is killed
hard (power loss, force quit), the lock can be left behind; the message tells you it's
stale and gives you the exact `rm` command.

### Speed

Throughput is roughly 5,000–18,000 reviews/second once running. Duolingo (~1.24M
reviews, one of the largest catalogues on the store) takes about 15 minutes. A typical
app with 50k reviews takes well under a minute.

### If it slows down mid-run

That's the built-in backoff reacting to Apple pushing back, and it's working as
intended:

```
  ! throttled by Apple -- backing off to 2.0s between requests
```

It recovers on its own as requests start succeeding again. Don't kill it.

---

## Good to know

**Ratings are not reviews.** Duolingo has ~21.6M star *ratings* worldwide but ~1.24M
*written* reviews. Ratings with no text can't be retrieved. You get every written one.

**Nothing about the App Store is global.** Every storefront is a separate dataset with
its own reviews, in its own language. The US is ~31% of Duolingo's written reviews; the
number on the US product page tells you nothing about the other 175. "Global" is
something this tool builds by sweeping and merging.

**Reviews come back in the local language** — Japanese from `jp`, Korean from `kr`,
Portuguese from `br`. Translate downstream if you need one language.

---

## Quick analysis

```bash
cd "out/1. Duolingo: Language Lessons - Languages, Math, Music & Chess"

# Totals, rating split, per-country counts
cat manifest.json

# Count reviews
wc -l reviews.jsonl

# 1-star reviews mentioning a keyword
jq -r 'select(.rating==1 and (.body|test("crash";"i"))) | "\(.country) \(.body[0:100])"' reviews.jsonl | head -20

# Just one country
wc -l by_country/jp.jsonl
```

In Python:

```python
import pandas as pd
df = pd.read_json("reviews.jsonl", lines=True)
print(df.groupby("country")["rating"].agg(["count", "mean"]).sort_values("count", ascending=False).head(20))
```

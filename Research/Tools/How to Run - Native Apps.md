# How to run the native-app review extractor

Pulls the **complete written-review history** from **all ~176 App Store storefronts**
for the first-party apps people use as habit-tracking workarounds, into
`Native Store Reviews/` — same file layout as `App Store Reviews/`.

```bash
cd "/Users/lalith/Desktop/store reviews/Research/Tools"
python3 native_fetch_meta.py && python3 native_run_all.py
```

The first command runs once and takes about a minute; the second does the work. It runs
unattended, one app at a time, printing progress as it goes.

### Why two commands — and why the first one matters

`native_fetch_meta.py` writes `native_ratings.json`, a map of which storefronts each app
is actually sold in. That file is what lets the extractor run with `--no-probe`.

Without it, the extractor opens each app with a *probe* phase that counts reviews per
storefront. Two things make that phase hostile:

- it hits `customerReviews`, which Apple rate-limits far more aggressively than the
  endpoint the reviews themselves come from, and
- it ignores your `--workers` setting and runs at `min(16, workers * 3)` — so
  `--workers 4` silently becomes **12 concurrent requests**, with no delay between them
  (`extract_reviews.py:669`).

176 of those per app, across 11 apps, is what produces `! throttled by Apple -- backing
off to 2.0s`. The third-party sweep never hit this because `run_all.py` has always passed
`--no-probe --storefronts-from keyword_scans/_ratings.json` — that cache covers the 89
habit apps only, so the native apps needed their own.

`native_fetch_meta.py` gets the same information from `/lookup` instead: all 11 apps
batched into **one request per storefront**, 6 workers, a real 0.15s gap between
requests. 176 requests total for the whole sweep, and it does not draw a throttle.

---

## What it covers

| # | App | App Store ID |
|---|---|---|
| 1 | Reminders (Apple) | 1108187841 |
| 2 | Calendar (Apple) | 1108185179 |
| 3 | Notes (Apple) | 1110145109 |
| 4 | Apple Health | 1242545199 |
| 5 | Apple Fitness | 1208224953 |
| 6 | Google Tasks: Get Things Done | 1353634006 |
| 7 | Google Keep - Notes and lists | 1029207872 |
| 8 | Google Calendar: Get Organized | 909319292 |
| 9 | Google Sheets | 842849113 |
| 10 | Microsoft To Do | 1212616790 |
| 11 | Samsung Health | 1224541484 |

**Samsung Reminder and Samsung Notes are not on the App Store** — they ship
preinstalled and are distributed through the Galaxy Store, so there is no iOS review
corpus to pull. Samsung Health does have an App Store listing and is included.

The list lives in `native_apps.json`. Add a row there to extend the sweep; the
`position` field is the folder number.

---

## Output

Identical in shape to the third-party corpora:

```
../Native Store Reviews/
  1. Reminders - Don't forget. Use Reminders/
       reviews.jsonl          every review, all countries, one JSON object per line
       by_country/
         us.jsonl             same reviews, split per storefront
         de.jsonl
         ...
       manifest.json          totals, rating breakdown, per-country counts
       _state.json            resume cursor (internal)
  2. Calendar - .../
  ...
```

---

## Options

```bash
python3 native_run_all.py 1                       # just Reminders
python3 native_run_all.py 6 7 8 9                 # just the Google apps
python3 native_run_all.py --workers 2 --delay 0.5 # gentler on a shared connection
```

Positions are the numbers in the table above. Defaults are `--workers 4 --delay 0.2` —
note that the third-party runner used `--delay 0` and relied purely on reactive backoff;
this one keeps a small proactive gap.

If Apple throttles anyway, the message is the built-in backoff doing its job. It eases
off on its own as requests start succeeding. Don't kill the run — but if it persists,
drop to `--workers 2 --delay 1`.

---

## If it stops

**Rerun the exact same command.** Position is saved after every page: completed
storefronts are skipped in milliseconds, a part-done storefront resumes mid-country,
and nothing is re-downloaded or duplicated. `Ctrl-C` once exits cleanly; twice forces
a stop.

To force a clean re-pull of one app, delete its folder (or just its `_state.json`).

---

## Rough size

Measured: **Apple Health — 10,420 reviews across 97 storefronts in 0.6 min**, no
throttling. Reminders probes at ~26,000 written reviews.

Ratings counts per app, from `native_fetch_meta.py` (ratings, not written reviews — the
written share is typically 1–3%):

| # | App | Storefronts | Ratings |
|---|---|---|---|
| 1 | Reminders | 171 | 2,849,749 |
| 2 | Calendar | 167 | 3,576,613 |
| 3 | Notes | 172 | 1,841,170 |
| 4 | Apple Health | 139 | 33,492 |
| 5 | Apple Fitness | 146 | 39,719 |
| 6 | Google Tasks | 159 | 354,763 |
| 7 | Google Keep | 153 | 133,621 |
| 8 | Google Calendar | 166 | 359,581 |
| 9 | Google Sheets | 172 | 7,073,303 |
| 10 | Microsoft To Do | 171 | 1,044,318 |
| 11 | Samsung Health | 168 | 247,476 |

**Google Sheets is the outlier** at 7M ratings — an order of magnitude past anything
else. It is still extracted in full, but it is marked `"defer": true` in
`native_apps.json`, so the runner puts it **last** no matter what and every
habit-relevant app lands first. Its folder is still numbered `9.`.

Run order:

```
 1. Reminders          5. Apple Fitness    9. Microsoft To Do
 2. Calendar           6. Google Tasks    10. Samsung Health
 3. Notes              7. Google Keep     11. Google Sheets  <- deferred
 4. Apple Health       8. Google Calendar
```

**Already complete** (skipped in milliseconds on re-run): `1. Reminders` (25,951
reviews) and `4. Apple Health` (10,420).

See `How to Run - App Store.md` for the underlying extractor's full flag list, the
ratings-vs-reviews distinction, and the per-storefront language caveat.

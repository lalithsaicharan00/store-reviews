# App Store review extractor

Pulls the **complete written-review history** for an iOS app from **every App Store
storefront**, and writes it as JSONL.

```bash
python3 extract_reviews.py 570060128                      # tier1+tier2 markets
python3 extract_reviews.py "Duolingo" --markets all       # every storefront
python3 extract_reviews.py 570060128 --markets t1 --probe-only   # just count first
```

No dependencies, no API key, no account. Python 3.9+.

---

## What you get

```
out/<app_id>/
  reviews.jsonl          all reviews, one JSON object per line
  by_country/us.jsonl    same data split per storefront
  by_country/jp.jsonl
  manifest.json          counts, rating distribution, per-country totals
  _state.json            resume cursor (safe to delete to force a full re-pull)
```

One record:

```json
{"review_id":"14520162307","app_id":"570060128","app_name":"Duolingo: Language Lessons",
 "country":"jp","country_name":"Japan","rating":5,"title":"最高","body":"毎日続けられる…",
 "author":"...","date":"2026-09-07T04:56:55Z","vote_count":0,"vote_sum":0,"is_edited":false}
```

### Why JSONL and not JSON

You asked for JSON, and this *is* JSON — one object per line (JSONL / NDJSON) rather
than one giant array. For this job it is strictly better:

- **Streamable.** 400k reviews is ~400 MB. A single JSON array must be parsed whole
  before you can touch record one; JSONL streams line by line in constant memory.
- **Resumable.** The extractor appends. A single array would have to be rewritten
  after every page.
- **Native everywhere.** `pandas.read_json(lines=True)`, DuckDB `read_json_auto`,
  `jq -c`, and every LLM/embedding pipeline read it directly.

`manifest.json` is a regular JSON object, since it's small and you'll read it whole.

If you specifically need one array: `jq -s '.' reviews.jsonl > reviews.json`.
For analytics at this scale, Parquet is smaller and faster —
`duckdb -c "COPY (SELECT * FROM read_json_auto('reviews.jsonl')) TO 'reviews.parquet'"`.

---

## Markets

`--markets` takes a preset or a comma list (`us,gb,jp`).

**`t1` — highest iOS consumer spend.** Where subscription revenue actually comes from.

> us, jp, cn, gb, de, fr, ca, au, kr, tw, hk, sg, ch, nl, se, no, dk, fi, it, es,
> at, be, ie, nz, ae, sa, il

**`t2` — high download volume, lower ARPU.** Where the user base lives.

> in, br, mx, id, vn, ph, th, tr, ru, eg, ng, pk, bd, za, ar, co, cl, pe, pl, ua,
> my, ro, cz, pt, gr, hu

**`t1+t2`** (default, 53 storefronts) · **`all`** (~176, everything Apple operates).

### What your list was missing

You named US, UK, Japan, South Korea, Canada, Australia, New Zealand, India, Brazil.
The significant gaps:

| Missing | Why it matters |
|---|---|
| **Germany, France** | Top-6 iOS revenue markets globally. Bigger than Canada or Australia. |
| **China mainland** | Among the largest App Store markets by revenue. See caveat below. |
| **Taiwan, Hong Kong, Singapore** | Small populations, ARPU rivalling the US. |
| **Nordics + Switzerland, Netherlands** | Highest per-capita app spend in the world. |
| **Italy, Spain** | Large European markets; usually out-review Australia. |
| **UAE, Saudi Arabia** | Highest ARPU in MENA, growing fast. |
| **Mexico, Indonesia, Vietnam, Philippines, Thailand, Turkey** | The real download-volume tier alongside India and Brazil. |
| **Egypt, Nigeria, Pakistan, Bangladesh** | Very high volume, very low ARPU. |

Caveats worth knowing:

- **Russia** is high-volume but App Store payments have been restricted since 2022,
  so reviews keep coming while revenue does not.
- **China mainland** returns review data through this endpoint, but the storefront is
  operated differently and review volume there is not comparable to Western markets.
- **India** has enormous Android volume but a comparatively small iOS base — its
  review count usually lands well below its download reputation.

**The tiers are a starting guess, not the answer.** Which storefronts matter depends
on the app. Run `--probe-only` first: it reports the real per-storefront review counts
in about 30 seconds, and you can pick from actual data rather than assumptions.

---

## Rate limits

Measured against the live endpoint, not guessed:

| Concurrency | Throughput | Result |
|---|---|---|
| 4 workers | 5.6 req/s | all 200 |
| 16 workers | 18.4 req/s | all 200 |
| 40 workers | 36.5 req/s | all 200 |

At 500 reviews per request that is ~18,000 reviews/second, and Apple did not throttle
at any point. **The default is deliberately 6 workers** — roughly 6 req/s, far under
anything that provoked a reaction, because the risk here isn't a 429, it's an IP block
from sustained hammering. Raise `--workers` if you're in a hurry; add `--delay 0.5` to
be gentler.

The client handles pushback on its own:

- 429/403/503 → global backoff, doubling to 30s, shared across all threads, then
  easing back as requests succeed.
- An HTML interstitial instead of JSON is treated as a soft block, same backoff.
- Network errors get 6 tries with exponential backoff.
- Cursor is checkpointed **after every page**, so a crash, a `Ctrl-C`, or a laptop
  sleeping loses at most one page. Rerunning resumes; finished storefronts are skipped
  in milliseconds.

`Ctrl-C` once = finish current pages and exit cleanly. Twice = hard stop.

---

## How it works, and the limits that are real

Apple exposes reviews three ways. Two of them are dead ends:

| Source | Depth | Status |
|---|---|---|
| `apps.apple.com` product page | **10 per storefront** | Works, but capped. No sort or offset param changes it. |
| `itunes.apple.com/rss/customerreviews` | — | **Dead.** Returns an empty feed for every app now. |
| `MZStore.woa/wa/userReviewsRow` | **Everything** | What this tool uses. |
| App Store Connect API | Everything | Official, but only for apps you own. |

`userReviewsRow` is the legacy iTunes desktop client endpoint. It paginates to the end
of an app's history — verified by walking Duolingo's US storefront to index 391,200 and
landing on reviews dated 2012-11-13, its launch day.

Two things about it that cost real debugging time:

1. **`cc` is the storefront control.** Sending an `X-Apple-Store-Front` header
   *overrides* `cc`, so every request silently returns US data. The extractor sends no
   such header.
2. **Ratings ≠ reviews.** Duolingo has ~21.6M *ratings* worldwide but ~870k *written
   reviews*. Star ratings without text are not retrievable here; only written reviews
   are. `manifest.json` counts the reviews actually pulled.

### Nothing here is global

Every storefront is a separate dataset. The US is ~45% of Duolingo's written reviews;
the number on the US product page tells you nothing about the other 175 storefronts.
"Global" is something this tool *constructs* by sweeping and merging.

---

## Flags

| Flag | Default | Purpose |
|---|---|---|
| `--markets` | `t1+t2` | `t1`, `t2`, `t1+t2`, `all`, or `us,gb,jp` |
| `--out` | `out` | Output directory |
| `--workers` | `6` | Storefronts in parallel |
| `--page-size` | `500` | Reviews per request |
| `--min-reviews` | `1` | Skip storefronts thinner than this |
| `--probe-only` | off | Report counts, extract nothing |
| `--delay` | `0` | Extra seconds between requests |

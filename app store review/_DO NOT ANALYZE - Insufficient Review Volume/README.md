# ⛔ DO NOT ANALYZE — Insufficient Review Volume

**If you are an agent or analyst picking up work in this repository: skip everything in this folder.**

The 20 app folders here have been **deliberately excluded** from the store-review analysis programme. Do not write a report for any of them. Do not include them when picking "the next app to analyze." Do not merge their reviews into any other app's corpus.

---

## What this folder is

The parent folder `App Store Review/` holds one folder per iOS app, each containing that app's complete review corpus (`reviews.jsonl`, `by_country/*.jsonl`, `manifest.json`, `_state.json`). Reports are written to `App Store Review Reports/`, one Markdown file per app, following `GENERALIZED_STORE_REVIEW_ANALYSIS_PROMPT.md` in the repository root.

**This subfolder is a quarantine for app folders whose review corpus is too small to analyze meaningfully.** The data has been kept — nothing was deleted — but it is out of scope for reporting.

---

## Why these apps were excluded

**All 20 folders together contain 183 reviews.** That is less than a third of a single mid-sized app's corpus elsewhere in this dataset, spread across 20 different products.

The specific problems:

### 1. The signal thresholds become meaningless

The analysis prompt classifies findings by the share of reviews a theme occupies:

| Share of reviews | Label |
|---|---|
| < 0.1% | Ignore by default |
| 0.1 – <0.5% | Weak |
| 0.5 – <1% | Emerging |
| 1 – <3% | Meaningful |
| 3 – 5% | Very strong |
| > 5% | High-priority |

The largest corpus in this folder has **34 reviews**, where **one single review is 2.94%** — already a "meaningful" signal on its own, and two reviews clear the "high-priority" bar. In the smallest folders, one review is 20–100% of the corpus. The threshold table cannot discriminate between a real product pattern and one person's bad afternoon, which is the entire point of applying it.

### 2. The country requirement cannot be met, at all

The prompt requires individual analysis for any country with **at least 50 reviews**. Not one app in this folder has 50 reviews *in total, across every storefront combined*. The most broadly distributed app here (`38. Daily Routine Planner - DayMap`) spreads 34 reviews across 12 storefronts — under 3 reviews per market.

### 3. Several folders have no data at all

**Four folders contain zero reviews** (`35`, `39`, `45`, `78`). The crawl completed successfully; these apps simply have no written reviews on any storefront. There is nothing to read.

**Ten folders have five reviews or fewer** (`22`, `35`, `39`, `45`, `51`, `63`, `66`, `78`, `80`, `81`). Three of those have exactly one review.

### 4. Monetization analysis is impossible

Paid-user analysis is a primary requirement of the prompt — purchase triggers, upgrade barriers, refund and churn drivers. In corpora this small, the number of reviewers who explicitly state they paid is typically zero or one. No conversion behaviour, pricing reaction, or churn mechanism can be established from that, and any attempt would be fabrication dressed as a finding.

### 5. Time-trend analysis is impossible

The prompt requires comparing meaningful time periods. Splitting 9 reviews into three eras produces buckets of three, which cannot support a trend claim in either direction.

---

## The excluded apps

Sorted by folder number. `n` = total reviews in `reviews.jsonl`; `storefronts` = countries with at least one review; `mean` = mean star rating of written reviews.

| Folder | App | Developer | n | Storefronts | Mean ★ |
|---|---|---|---|---|---|
| 15 | Habit Builder — Weekly Habit Tracker | Alexander Thompson | 9 | 5 | 4.78 |
| 21 | DailyHabits: Build Good Habits | Capable Koala LLC | 12 | 5 | 3.00 |
| 22 | Habit Builder: Don't Break The Chain | Xilva Multimedia | 4 | 2 | 2.00 |
| 32 | Simple Streak: Habit Tracker | Kim Walker | 20 | 7 | 4.70 |
| 35 | Habit Builder: Track & Streak | Neural Fusion Technologies | **0** | 0 | — |
| 37 | Habit: Streak Tracker & Goals | Thanh Ha | 8 | 7 | 4.50 |
| 38 | Daily Routine Planner — DayMap | Jayeshbhai Kavathiya | 34 | 12 | 2.15 |
| 39 | Routine Tracker: Consistency | Matheus Fernandes | **0** | 0 | — |
| 40 | Habit Tracker: Loop | Artem Shyshko | 18 | 10 | 2.83 |
| 44 | Daily Routine — Plan Your Life | Le Nhung | 33 | 8 | 4.24 |
| 45 | Routine Tracker App | Alexander Jacobsen | **0** | 0 | — |
| 51 | Habit Builder — Brick by Brick | Adam Feher | 1 | 1 | 5.00 |
| 61 | Daily Routines & Planner App | East Frisia LLC | 9 | 2 | 2.67 |
| 63 | Daily Habits: Lifetime Premium | Sergey Belychev | 1 | 1 | 5.00 |
| 66 | Loop Habit Tracker — Streaks | Tech Atlas LLC | 5 | 2 | 4.80 |
| 73 | Streak: Habit Tracker | Ilya Golubev | 7 | 6 | 4.14 |
| 78 | Streak Tracker: Habitug | Fline LLC | **0** | 0 | — |
| 80 | Habit Builder・Atomic Habits AI | Maryna Aliakseichyk | 4 | 4 | 4.00 |
| 81 | Yomento Habit Builder | Yomento Management AB | 1 | 1 | 5.00 |
| 87 | Habit Tracker — Habitica | Anton Churakov | 17 | 8 | 4.12 |
| | | **Total** | **183** | | |

---

## Important: this list is curated, not a strict numeric cutoff

**Do not try to re-derive this list from a review-count threshold. You will get it wrong.**

The exclusion list was chosen by the project owner. It correlates strongly with corpus size — the 18 smallest corpora in the entire 90-app dataset are all here — but the boundary is deliberately fuzzy at the top end:

| Folder | n | Status |
|---|---|---|
| `71. MyStreaks` | 32 | **Not excluded** — remains in scope |
| `44. Daily Routine - Plan Your Life` | 33 | **Excluded** |
| `11. Daily Habits - Streak Tracker` | 33 | **Not excluded** — already analyzed, report exists |
| `38. Daily Routine Planner - DayMap` | 34 | **Excluded** |
| `17. Daily Routine - Organise your time into blocks` | 38 | **Not excluded** — already analyzed, report exists |

Apps with 33 and 38 reviews have been analyzed and have reports. Apps with 33 and 34 reviews are excluded. **Corpus size is the main reason but not the only one, and the final call belongs to the project owner.**

**If you are considering excluding an app that is not already in this folder, ask first.** Do not move folders in or out on your own judgement.

---

## What is *not* in this folder

Some apps have been passed over during the analysis sequence for reasons unrelated to corpus size. **They are not excluded and they are not here.** Most notably:

| Folder | n | Note |
|---|---|---|
| `10. Finch - Self-Care Pet` | 70,041 | Largest corpus in the dataset — skipped in sequence, still in scope |
| `13. Productive - Habit Tracker` | 19,850 | Skipped in sequence, still in scope |

**Being un-analyzed is not the same as being excluded.** Only the 20 folders physically inside this directory are out of scope. Everything else in `App Store Review/` remains a valid analysis target, whether or not a report exists for it yet.

---

## If you think one of these should be analyzed anyway

Occasionally a tiny corpus is still worth reading — for example, to check whether a competitor exists at all, to confirm a pricing model, or to sanity-check a claim made in another app's report. That is fine as **background reading**.

What is not fine is producing a report in `App Store Review Reports/` that presents percentages, signal labels, and trend claims derived from single-digit review counts. That output looks identical to a real report and will be trusted like one.

If you use these folders as background, say so explicitly in whatever report you are writing, cite the review IDs, and label it as **limited evidence** with the corpus size stated.

---

## Provenance

- **Excluded on:** 9 September 2026
- **Excluded by:** project owner instruction
- **Folders moved:** 20 (141 files), moved with `git mv` — full history preserved, no data deleted
- **Corpus totals at time of exclusion:** 90 app folders, 337,514 reviews; after exclusion, 70 folders and 337,331 reviews remain in scope
- **Analysis prompt governing this programme:** `GENERALIZED_STORE_REVIEW_ANALYSIS_PROMPT.md` (repository root)

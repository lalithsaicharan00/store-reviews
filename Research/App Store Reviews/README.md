# App Store Review — corpus folders

One folder per iOS app, each holding that app's complete review corpus:

| File | Contents |
|---|---|
| `reviews.jsonl` | The full merged corpus — one JSON object per line. **This is the authoritative record count.** |
| `by_country/<cc>.jsonl` | The same reviews split by storefront. Use for reconciliation, not as a separate source. |
| `manifest.json` | App ID, name, developer, bundle ID, per-country counts, rating distribution, mean rating |
| `_state.json` | Crawl completion state per storefront, including storefronts that returned zero reviews |

Record schema (13 fields, no nulls): `review_id`, `app_id`, `app_name`, `country`, `country_name`, `rating`, `title`, `body`, `author`, `date`, `vote_count`, `vote_sum`, `is_edited`. Text arrives HTML-escaped — unescape before reading.

---

## ⛔ Read this before choosing an app to analyze

### `Do Not Analyze - Insufficient Review Volume/`

**20 app folders in that subfolder are out of scope.** Their corpora are too small to analyze (183 reviews across all 20; four have zero reviews). Never write a report for them, and never count them when picking the next app.

**See [`Do Not Analyze - Insufficient Review Volume/README.md`](Do%20Not%20Analyze%20-%20Insufficient%20Review%20Volume/README.md) for the full list, the reasoning, and the rules for adding to it.** Do not move folders in or out of it on your own judgement — ask the project owner.

### Un-analyzed is not the same as excluded

Some large apps have been passed over in the numbering sequence and **remain fully in scope** — notably `10. Finch - Self-Care Pet` (70,041 reviews) and `13. Productive - Habit Tracker` (19,850 reviews). The absence of a report means the work has not been done yet, not that the app was rejected.

---

## How to run an analysis

Follow [`Store Review Analysis Prompt.md`](../Store Review Analysis Prompt.md) in the repository root. Key expectations established by the existing reports:

- **Read every review**, not a keyword search, a sample, or only the high-rated ones. State the total read and reconcile it against `by_country/*.jsonl`.
- **Every material claim carries review IDs** so any conclusion can be traced back to source. Existing reports include a complete per-review index for small corpora.
- **Quantify with count / percentage / denominator / time window / signal label.** State the denominator every time.
- **Translate non-English reviews** rather than dropping them.
- **Separate paid-user evidence from general feedback**, and never infer a conversion rate from review text.
- **Report ambiguity as ambiguity** — disclose judgement calls, small samples, and selection bias rather than smoothing them over.

Reports are written to `../App Store Reports/`, named `<number>. <folder name> (REPORT).md`.

> **Note on country analysis:** the prompt asks for per-country sections at ≥50 reviews per country. For recent reports the project owner has asked for **global-only** analysis. Confirm which is wanted before starting.

---

## Progress

As of 9 September 2026:

| | Folders | Reviews |
|---|---|---|
| Total collected | 90 | 337,514 |
| **Excluded** (`Do Not Analyze`) | 20 | 183 |
| **In scope** | **70** | **337,331** |
| — reports written | 13 | 95,200 |
| — remaining | **57** | **242,131** |

Reports exist for folders: **1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 14, 17**.

Largest corpora still awaiting analysis: `10` (70,041), `24` (43,469), `52` (20,634), `13` (19,850), `59` (15,176).

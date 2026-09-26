# Temp — working scratch (gitignored except this file)

All intermediate files for the current analysis live here. Never `/tmp`, never the
session scratchpad, never inside `App Store Reviews/` or `Native Store Reviews/`.

## Current status

**Native app 6 — "Google Tasks" — COMPLETE (2026-09-21).**
Report written to `Native Store Reports/6. Google Tasks- Get Things Done - Plan, Organize & Schedule Work (REPORT).md`
(1.16 MB, PART 0–10). All 7,069 reviews read individually and hand-coded; 166 of 170 codes used,
18,423 assignments; 0 validation errors; every cited review ID and every quoted fragment verified
against `reviews.jsonl`. The `n6-*` pipeline mirrors `n1-*` (same file roles, prefix `n6`);
extra outputs: `n6-evidence.txt` (all quote fragments per code, the source of every citation),
`n6-xtabs.txt`, `n6-extra.txt`, `n6-trend.txt`, `n6-painkiller.txt`, `n6-sensitivity.txt`, `n6-absence.txt`.

**Native app 1 — "Reminders" — COMPLETE.** Report in `Native Store Reports/1. …`. The `n1-*` files
are still here (including the hand-coded `n1-cls/`); they were not deleted because that folder is
the expensive artifact. Delete `n1-*` and `n6-*` only when you are sure the reports will not be revised.

## The `n1-*` / `n6-*` pipeline (one prefix per native app)

| File | Role |
|---|---|
| `n1-common.py` | loader (date order, 1-based `idx`), signal bands, paths |
| `n1-dump.py` → `n1-batch/` | 260 batch files of 100 reviews, full text |
| `n1-themes.py` | the 159-code taxonomy + 10 union definitions |
| `n1-cls/*.txt` | **the hand-coded source of truth** — one line per review |
| `n1-fill-ids.py` | replaces the `~` placeholder with the real review_id |
| `n1-check-cls.py` | per-line validator, incl. verbatim-quote check. Run after every batch |
| `n1-build-classification.py` | builds `n1-review-classification.py` (THEMES / UNIONS / PER_REVIEW) |
| `n1-validate.py` | six integrity checks on the built map |
| `n1-stats.py`, `n1-trend.py`, `n1-country.py`, `n1-sensitivity.py` | aggregation |
| `n1-painkiller.py` | leave-intent lift per code |
| `n1-absence.py`, `n1-script.py` | mechanical presence tests, script detection |
| `n1-ev.py CODE [n]` | print evidence rows for a code/union |
| `n1-idx.py IDX...` | **resolve a working index to its real review_id** |
| `n1-verify-ids.py` | verify every ID cited in the report exists and its metadata matches |
| `n1-storefront-table.py`, `n1-build-appendix.py` | generate §6.2, §9.B, §9.J, Part 10 |

## Hard-won lessons

- **Never write a review ID from memory.** Use `n1-idx.py <index>` to resolve it, then
  run `n1-verify-ids.py` on the finished report. The first draft contained 21 fabricated
  IDs; all were caught by the verifier and corrected. This is disclosed in §9.M.
- **Check the corpus for collection artefacts before claiming a trend.** Pre-Sept-2023
  reviews in this corpus are a helpful-vote-ranked survivorship sample (13× the vote
  rate, 2.42★ vs 4.11★ after). Reporting that as "ratings improved" would have been wrong.
- **Compare the corpus mean to public ratings.** Here: 3.94★ vs 4.81★ over 2.85M ratings,
  i.e. text reviewers are a 0.911% self-selected complaint-skewed slice.
- The per-review `lang=` tag in early `n1-cls` batches sometimes captured the storefront
  instead of the language. It is unusable for quantified claims; script is derived
  mechanically instead (`n1-script.py`). Disclosed in §6.8.
- **Check adjacent codes for coder drift before any trend claim.** In n6, `PR_CALVIEW` collapsed
  8.2%→0.6% across 2024 while `PR_GOOGLEINT` rose by the same amount — the union was flat. Run
  per-quarter shares of every pair of adjacent codes and use the union where they trade places.
  Disclosed in the n6 report (warning 5, §1.4, §9.C).
- Copied `n1-*` scripts carry n1 assumptions: app ID in `storefront-table`, iOS-era cut points in
  `trend`/`sensitivity`, n1-only codes in `country`, a hard-coded base rate in `painkiller`, and a
  `U_LEAVE_INTENT` that included `SW_PAPER`. Grep every copied script for code names and constants.

## Naming

`<N>-<purpose>.<ext>` so a file traces back to its app folder — `42-review-classification.py`,
`n1-cls/`, `n1-stats.txt`.

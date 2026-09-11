# Store review analysis — working conventions

## Scratch files: use `temp/`, never `/tmp`

**All intermediate files go in `temp/` in this repo.** Do not use the session
scratchpad under `/private/tmp/claude-*`, and do not write working files into the
data folders under `app store review/`.

Session scratchpads are keyed by session UUID and live under `/private/tmp`, so they
are lost on reboot, on a new session, and on an account switch. `temp/` survives all
three. The expensive artifact in this repo is the hand-curated review classification
behind each report — losing one means re-reading the entire corpus.

`temp/` is gitignored (except its README). Name files so they trace back to their app
folder: `42-review-classification.py`, `43-all-reviews.txt`. See `temp/README.md`.

## Repository layout

| Path | Contents |
|---|---|
| `app store review/<N>. <app name>/` | Source data per app: `reviews.jsonl`, `by_country/*.jsonl`, `manifest.json`, `_state.json`. **Read-only — do not add files here.** |
| `App Store Review Reports/` | Deliverables: `<N>. <app name> (REPORT).md`, one per app |
| `play store reviews/` | Play Store corpora (same shape) |
| `temp/` | Working scratch, gitignored |
| `GENERALIZED_STORE_REVIEW_ANALYSIS_PROMPT.md` | The analysis spec every report must follow |

## Analysis workflow

Apps are analysed one at a time, in folder-number order. Follow
`GENERALIZED_STORE_REVIEW_ANALYSIS_PROMPT.md` exactly, and match the structure of the
most recent report in `App Store Review Reports/` (currently report 42).

Non-negotiables, because they are what makes a report auditable:

- **Read every review individually**, in its original language. No sampling, no
  keyword-only filtering, no stopping at the context limit.
- **Hand-curate the theme → review-ID map.** Save it to `temp/<N>-review-classification.py`.
- **Validate the map programmatically** before writing: zero unknown IDs, zero
  intra-theme duplicates, zero unassigned records.
- **Every quantified claim carries** count, percentage, denominator, scope, period,
  signal label and representative review IDs.
- **Include a complete per-review index** in the appendix so any number resolves back
  to exact reviews, and any review resolves to the findings it supports.
- **Verify before finishing** that every review ID cited in the report exists in
  `reviews.jsonl`.
- Country threshold is **50 reviews** for standalone claims; below that, label
  limited evidence explicitly.
- Disclose review-burst / solicited-review patterns and rating-vs-text contradictions
  rather than silently dropping them.

## Git

Reports are committed one per commit, message form: `report <N> completed`.
Commit only when asked.

# Store review analysis — working conventions

## Repository layout

| Path | Contents |
|---|---|
| `PRD for App Store.md` | What we will build, do, and avoid — distilled from the reports. See its section 0 for writing rules. |
| `Store Review Analysis Prompt.md` | The analysis spec every report must follow |
| `App Store Reviews/<N>. <app name>/` | Source data per app: `reviews.jsonl`, `by_country/*.jsonl`, `manifest.json`, `_state.json`. **Read-only — do not add files here.** |
| `App Store Reports/` | Deliverables: `<N>. <app name> (REPORT).md`, one per app |
| `Play Store Reviews/` | Play Store corpora (same shape) |
| `Research Reports/` | Standalone research and decision documents (not per-app) |
| `Tools/` | Extractors, keyword scanners, ranking scripts, their caches and how-to docs. Run them from inside `Tools/`. |
| `Temp/` | Working scratch, gitignored |

## Naming rules

- **Folders and documents:** Title Case with spaces — `App Store Reports/`, `Research Reports/`, `PRD for App Store.md`.
- **Code and machine-read files (inside `Tools/`):** `snake_case` — `extract_reviews.py`, `habit_apps_ranked.json`, `keyword_scans/`.
- **Per-app folders and reports:** `<N>. <App Store name>` and `<N>. <App Store name> (REPORT).md`. The number is the app's rank and must match between `App Store Reviews/` and `App Store Reports/`.
- **Root folder holds only:** the PRD, the analysis prompt, `README.md`, `CLAUDE.md`, and the folders above. Everything else goes in a folder.

## Scratch files: use `Temp/`, never `/tmp`

**All intermediate files go in `Temp/` in this repo.** Do not use the session
scratchpad under `/private/tmp/claude-*`, and do not write working files into the
data folders under `App Store Reviews/`.

Session scratchpads are keyed by session UUID and live under `/private/tmp`, so they
are lost on reboot, on a new session, and on an account switch. `Temp/` survives all
three. The expensive artifact in this repo is the hand-curated review classification
behind each report — losing one means re-reading the entire corpus.

`Temp/` is gitignored (except its README). Name files so they trace back to their app
folder: `42-review-classification.py`, `43-all-reviews.txt`. See `Temp/README.md`.

## Analysis workflow

Apps are analysed one at a time, in folder-number order. Follow
`Store Review Analysis Prompt.md` exactly, and match the structure of the
most recent report in `App Store Reports/` (currently report 42).

Non-negotiables, because they are what makes a report auditable:

- **Read every review individually**, in its original language. No sampling, no
  keyword-only filtering, no stopping at the context limit.
- **Hand-curate the theme → review-ID map.** Save it to `Temp/<N>-review-classification.py`.
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

## PRD for App Store

`PRD for App Store.md` in the repo root collects what we will build, do, and avoid,
distilled from the reports. **Section 0 of that file holds the writing rules** (plain
English, 2–3 lines per bullet, no statistics, every bullet ends with a "Repeated in:"
list of linked report numbers that only the owner extends). Read section 0 before
adding anything, and use the bullet template there.

## Git

Reports are committed one per commit, message form: `report <N> completed`.
Commit only when asked.

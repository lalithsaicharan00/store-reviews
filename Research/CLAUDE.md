# Store review analysis — working conventions

> This folder is `Research/` inside the monorepo. **All paths below are relative to `Research/`.**

## Repository layout

| Path | Contents |
|---|---|
| `PRD for App Store.md` | **Superseded — ignore.** An aggregation of the whole ledger, not a decision record. Do not cite, build from, or extend it. See "PRD for App Store" below. |
| `Store Review Analysis Prompt.md` | The analysis spec every report must follow |
| `Report Synthesis Prompt.md` | How to combine all reports into one feature ledger (cards → coverage check → merge → confidence → final report) |
| `App Store Reviews/<N>. <app name>/` | Source data per app: `reviews.jsonl`, `by_country/*.jsonl`, `manifest.json`, `_state.json`. **Read-only — do not add files here.** |
| `App Store Reports/` | Deliverables: `<N>. <app name> (REPORT).md`, one per app |
| `Play Store Reviews/` | Play Store corpora (same shape) |
| `Research Reports/` | Standalone research and decision documents (not per-app), grouped into topic folders. `Research Reports/README.md` indexes every report and records its author. A report Claude writes must open with a "Written by Claude (Claude Code), <date>" line and be added to that index. The Feature Ledger, its Card Index, Quit Habit Decision and Feature Gating stay at the top level because `Tools/prd_ledger/` links to those exact paths. |
| `Tools/` | Extractors, keyword scanners, ranking scripts, their caches and how-to docs. Run them from inside `Tools/`. |
| `Temp/` | Working scratch, gitignored |

## Naming rules

- **Folders and documents:** Title Case with spaces — `App Store Reports/`, `Research Reports/`, `PRD for App Store.md`.
- **Code and machine-read files (inside `Tools/`):** `snake_case` — `extract_reviews.py`, `habit_apps_ranked.json`, `keyword_scans/`.
- **Per-app folders and reports:** `<N>. <App Store name>` and `<N>. <App Store name> (REPORT).md`. The number is the app's rank and must match between `App Store Reviews/` and `App Store Reports/`.
- **Root folder holds only:** the PRD, the analysis prompt, the synthesis prompt, `README.md`, `CLAUDE.md`, and the folders above. Everything else goes in a folder.

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

## Design decisions: never copy competitors blindly (applies to every design task)

Competitors are a source to check, not an authority. An app doing something does not make it right;
it may be doing it badly.

1. **Reviews first.** Look for user evidence about the pattern: our corpus, and the competitor's own
   reviews. Adopt a competitor pattern only when reviews show users actually like it or it solves their
   problem.
2. **No reviews? Reason from first principles.** Ask:
   - What is the user trying to do on this screen?
   - What do they see, expect and tap?
   - What could go wrong?

   Then apply sound design principles: clarity, fewest steps for frequent tasks, no hidden state,
   consistency, and recovery from mistakes. Design from that.
3. **In reports, say which it was:** "users show…" (review evidence) or "reasoned from first principles".
   Never "App X does it, so we should".

## PRD for App Store — superseded, ignore it

`PRD for App Store.md` is **not** a decision record and must not be used as one. It was built by
combining every point in the Feature Ledger into one document, so it states positions that were
never actually decided — the decisive "we will / we will not" voice comes from the synthesis
template, not from a choice anyone made.

So, in any future session:

- **Do not** cite it as settled, plan or scope against it, resolve an open question with it, or
  treat its sections as agreed requirements.
- **Do not** add to it or update it. It is frozen for reference and history.
- For evidence, go to `Research Reports/Feature Ledger.md`, which carries the counts, confidence
  and per-report links.
- For actual decisions, go to **Notion** — the decisions document lives there, not in this repo.
  Ask the user for the page if the link isn't to hand. Never substitute this file for it, and
  never write a decisions document into this repository.

The old writing rules for it (Stage 6 of `Report Synthesis Prompt.md`) no longer apply to new work.

## Git

Reports are committed one per commit, message form: `report <N> completed`.
Commit only when asked.

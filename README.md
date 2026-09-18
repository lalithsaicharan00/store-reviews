# Store Reviews

Review research for habit / routine tracker apps, and the product decisions that come out of it.

## Where things are

| Path | What it is |
|---|---|
| `PRD for App Store.md` | **Start here.** What we will build, do, and avoid — every point has a count and a link to the report it came from. |
| `Research Reports/Feature Ledger.md` | **The consolidated evidence.** Every finding from all 70 reports in one file — what wins, what loses, what drives purchases, ranked — with confidence, app counts and links back to each report. |
| `Store Review Analysis Prompt.md` | The spec every per-app report follows. |
| `Report Synthesis Prompt.md` | How the 70 reports were combined into the Feature Ledger (cards → coverage → merge → confidence → report). |
| `App Store Reviews/` | Raw review data, one folder per app: `<N>. <app name>/reviews.jsonl` (+ `by_country/`, `manifest.json`, `_state.json`). Read-only. |
| `App Store Reports/` | One full analysis per app: `<N>. <app name> (REPORT).md`. |
| `Play Store Reviews/` | Raw Play Store review data, same shape as above. |
| `Research Reports/` | The Feature Ledger and its card index, plus standalone research and decision docs (feature gating, quit-habit scope, …). |
| `Tools/` | Scripts that pull reviews, scan keywords and rank apps, plus their caches and how-to guides. |
| `Temp/` | Scratch space for analysis sessions. Gitignored. |

## Naming rules

- Folders and documents: **Title Case with spaces**.
- Code and machine-read files (inside `Tools/`): **snake_case**.
- Per-app folders and reports: `<N>. <App Store name>`; the number is the app's rank and matches between `App Store Reviews/` and `App Store Reports/`.
- Root folder stays minimal: the PRD, the prompt, this README, `CLAUDE.md`, and the folders above.

## Running the tools

```bash
cd Tools
python3 extract_reviews.py <app id> --markets all     # App Store  → ../App Store Reviews/
python3 play_extract.py <package id>                   # Play Store → ../Play Store Reviews/
```

Full instructions: `Tools/How to Run - App Store.md` and `Tools/How to Run - Play Store.md`.

## Rebuilding the Feature Ledger

The ledger is generated from `Tools/prd_ledger/` — `canonical.json` (the merged points) and one
`cards.jsonl` per report. After any change to those, regenerate it:

```bash
python3 Tools/prd_ledger/build_report.py     # → Research Reports/Feature Ledger.md (+ card index)
```

Edit the ledger, never the generated file.

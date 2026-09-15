# `Temp/` — working directory for Claude Code / agent sessions

**If you are a model or agent working in this repository: use THIS folder for all
intermediate files. Do NOT use the session scratchpad under `/tmp` or
`/private/tmp/claude-*`, and do not scatter temp files into the data folders.**

## Why

Session scratchpads are lost in two ways that have nothing to do with git:

1. They live under `/private/tmp/`, which macOS clears on reboot and via periodic cleanup.
2. Their path contains the **session UUID**. A new session — after a restart, a
   re-login, or an account switch — gets a *different* scratchpad path, so prior
   work is no longer reachable even when the bytes still exist on disk.

This folder is inside the project, so it survives all three: reboots, new sessions,
and account switches. That matters because the expensive artifact in this repo is
not the report — it is the **hand-curated classification** behind it. Re-creating one
means re-reading every review in the corpus.

## Rules

- Put intermediate analysis artifacts here: classification maps, extracted corpora,
  generated tables, one-off scripts, working notes.
- **Name files so they are traceable to the app folder they belong to**, e.g.
  `42-review-classification.py`, `43-all-reviews.txt`.
- Everything here is **gitignored** (see `.gitignore`) — except this README. Nothing
  in here enters the repo history, so it is safe to leave working files behind.
- **Finished deliverables do not belong here.** Reports go to
  `App Store Reports/`. Source review data stays in `App Store Reviews/<N>. <app>/`.
- Do not delete another session's files unless they are clearly yours or the user asks.

## What is worth preserving here

Anything whose cost is *reading*, not *computing*. A file that regenerates from
`reviews.jsonl` in one command is cheap — regenerate it. A file that encodes a
judgement made while reading thousands of reviews is expensive — keep it here.

## Current contents

Report 59 is the current work; the report-76 working files were cleared at the start of this
session (report 76 was complete and committed as `report 76 completed`). What follows belongs to
**app 59, `Tappsk: ToDo & Habit Tracker`** (MATVEY KONDAKOV, bundle `com.tappsk.ios`, App Store ID 1385049326),
**15,176 reviews**, 109 storefronts (ru 10667, ua 824, br 583, de 332, us 311, fr 279, kz 247, sa 220),
**2018-10-14 → 2026-09-05**, corpus mean **4.60★**. Eligible countries (≥50): ru, ua, br, de, us, fr, kz, sa,
gb, tr, ca, au, by, ch, se, es, it, mx, in.

| File | What it is |
|---|---|
| `59-cls/*.txt` | **The expensive one.** Hand judgement per review: `idx review_id CODE,CODE  # lang=xx \| "verbatim quote"; "quote"`. One file per batch of 100, named like the batch. |
| `59-themes.py` | Hand-code taxonomy (grown while reading; codes used in 59-cls must all be defined here). |
| `59-fill-ids.py` | Fills `~` placeholders in column 2 of `59-cls/*.txt` with the review_id at that index. |
| `59-check-cls.py` | Run after every batch: review_id at index **and** every quoted fragment occurs in that review. |
| `59-build-classification.py` | Only writer of `59-review-classification.py` (generated). |
| `59-validate.py` | Data checks on the classification. |
| `59-dump.py`, `59-batch/`, `59-all-reviews.txt`, `59-index.tsv` | Cheap regenerable reading material (152 batches of 100; `#idx cc stars date [E=edited]`). |
| `59-reconcile.py` / `-out.txt` | Main vs country files vs manifest vs `_state.json`. |
| `59-itunes-{cc}.json` | Apple Lookup API captures for the 19 eligible storefronts, 2026-09-14. |
| `59-common.py` | Shared loaders (corpus, classification, eras) imported by the scripts below. |
| `59-build-report.py`, `59-verify-report.py`, `59-run-all.sh` | Report builder (asserts every quotation and narrative claim at build time), post-write verification (`59-verify-out.txt`), end-to-end rebuild. |
| `59-analysis-out.txt`, `59-build-meta.json`, `59-verify-out.txt` | Generated: monthly code series, build metadata, final verification output (copied into §9.M). |

Status: **complete.** All 152 batches are hand-coded (`59-check-cls.py`: errors 0, unclassified 0),
`59-validate.py` passes (2854 checks, 0 failures), and the report in `App Store Reports/59. … (REPORT).md`
verifies (`59-verify-report.py`: 62224 checks, 0 failures; 15,176 IDs cited, all exist). Rebuild everything
with `sh Temp/59-run-all.sh`. Committed as `report 59 completed`.

# Bugs and Fixes

**Goal:** every distinct bug users report, from both the App Store and Google Play, with how often it happens,
how bad it is, and how to prevent it in our app.

**Status:** folder set up on 26 Sep 2026. Work starts after the current architecture topic; see
[`Architecture/README.md`](<../../../Architecture/README.md>).

## Plan

| Step | Source | How | Status |
|---|---|---|---|
| 1 | **App Store:** 70 per-app reports in `App Store Reports/` (hand-read, bugs already coded per app) | Pull every bug and defect code from each report into one list, one row per distinct bug | – |
| 2 | **Google Play:** 146 corpora in `Play Store Reviews/` (no per-app reports yet) | Full-corpus screen for bug language, then read samples per bug type (the same method as the Data Safety report) | – |
| 3 | **Native apps:** 11 corpora and 2 reports | Only for bugs that apply to us (sync, widgets, notifications, dates) | – |
| 4 | **Merge** | Merge duplicates across stores into unique bugs; rank by frequency × 1★ share × apps affected | – |
| 5 | **Fixes** | For each unique bug: root cause, prevention rule, and a test that catches it | – |

## Files (as they are made)

- `Bug Catalogue.md`: the merged list of unique bugs with fixes.
- `Bug Evidence/`: scripts, coded samples and validation.

Bugs that are already covered by the data-safety work (data loss, sync, restore, dates) are linked from
[`../Data, Sync and Accounts/`](<../Data, Sync and Accounts/>), not repeated.

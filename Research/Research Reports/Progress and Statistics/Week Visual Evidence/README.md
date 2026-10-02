Written by Claude (Claude Code), 2 October 2026.

# Week Visual Evidence

This is the complete hand-coded appendix for [Progress Week — Visual Options](<../Progress Week — Visual Options.md>). Each retrieved candidate was read individually in its original language. This focused audit is additional to the prior Progress audit; it does not claim to have reread that audit's 14,726 records.

## Population and retrieval

Canonical `reviews.jsonl` only, not duplicated `by_country` exports: App 337,331, Play 901,453, Native 248,439; total 1,487,223. The first visual/week/meaning screen yields 339 individually read candidates. Expanded keyword pairs cover the 72 language codes recorded in the corpora. The expansion yields 1,409 broad matches; a disclosed week/visual proximity rule selects 323 additional individually read candidates. The remaining broad matches were not individually read for this task. The final 662 unique records comprise App 279, Play 176, Native 207; dates 19 January 2013–7 September 2026. See [Scan Summary](<Scan Summary.json>).

Search terms retrieve candidates rather than classify sentiment. Hand codes follow the original full text, not the presence of a keyword or the star rating. Retrieval misses implicit wording and may favour larger corpora or common phrases. Country metadata is not a statement of language. No population prevalence, language-group comparison or usability-comprehension percentage follows from these counts.

## Files and codebook

[Coded Reviews.tsv](<Coded Reviews.tsv>) is the complete per-review index. `source_line` is the physical JSONL record line, counted from one; Unicode line separators inside a review do not create new source records. `app_folder` identifies the canonical source. `retrieval_pass` identifies the initial focused or language-expansion pass. `row` connects to the saved manual [Classification](<Classification.json>). [Theme Counts](<Theme Counts.json>) includes every ID, n, percentage of 662 and store/app-corpus count. All records receive at least one code; themes can overlap.

| Code | Inclusion rule |
|---|---|
| P_WEEK | Explicit weekly/calendar readability, usefulness, visibility or weekly-report praise; calendar mentions are not always an exact seven-day view. |
| P_OVERVIEW | Praise for aggregate/overview visibility or all-habit presentation. |
| P_CLARITY | Broader clean/simple/readable UI/statistics praise; not proof of specific mark comprehension. |
| P_QUIT | Quit duration/counter/history presentation praise. Limited evidence, one corpus. |
| X_MARK | Symbol/state/icon/colour ambiguity, including adjacent selection and priority flows. Not all are weekly strips. |
| X_DENSITY | Visual/readability/navigation friction: too small/large, decoration, long scrolling, unclear or laborious presentation. Do not relabel every instance as clutter. |
| X_SCORE | Score/count meaning, denominator or apparent daily/weekly mismatch. |
| ASK_WEEK | Weekly overview, summary, full-week visibility or related presentation/detail request. |
| N_MARK | Native calendar/Fitness meaning ambiguity; indirect habit-design evidence. |
| N_DENSITY | Native calendar/task readability, spacing, scrolling/navigation friction; indirect evidence. |
| N_PRAISE | Native calendar/task/Fitness readability praise. |
| N_SUMMARY | Native summary/history feedback. |
| SOLICITED | Text explicitly discloses a promotion/reward. One observed disclosure is not a solicitation-rate estimate. |
| NA | Individually read but outside these narrow visual themes. Includes broad praise, data bugs, logging-only workflows and unrelated requests. |

Criticism in four/five-star reviews stays criticism; praise in a mixed review stays praise. For example InnerGrow's five-star request for plainer reports is X_DENSITY; its promotional review receives both P_WEEK and SOLICITED. Red/failure requests remain in evidence but conflict with this app's explicit constraints. Competitor screenshots are marketing references, not controlled tests.

## Verification

`Research/Tools/progress_week_visual/verify.py` resolves all 662 records by physical source line and exact ID across all three stores; verifies unique store/app/ID keys, assigned codes, theme arithmetic and all backtick-formatted review IDs in the report. It passed with zero unknown IDs, duplicates, unassigned records or count mismatches; 42 report review IDs verified.

The inherited `Research/Temp/goals/verify_ids.py` was also run on the full report. It resolves App/Play but does not index Native Store Reviews; its six missing Native IDs are verified by the all-three-store checker above. Its initial artifact-ID false positive was removed by keeping screenshot artifact numbers outside review-ID code formatting. This is a checker coverage limitation, not missing review evidence.

Source screenshots are catalogued by URL in [Source Catalogue](<Source Catalogue.md>) and placed on the user's [Figma Inspiration board](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=238-2). No third-party image is committed here.

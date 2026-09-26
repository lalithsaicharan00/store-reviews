# Blind pass — report 70

The blind list was written by a fresh context that did not see `cards.jsonl`: `Temp/70-blind-list.md` (165 items, kept in Temp as in batch 52–62). It was diffed item by item against the 33 cards written in-section.

## Covered

Items 1–46, 50–146 and 147–165 map to existing cards (header R70-001; method R70-002/003; subtraction and outcomes R70-004/005; voice R70-006/007/032; multi-goal R70-008/031; rules R70-009/010/011; defects R70-012/013; patronage R70-014/015/016/017/018; free and wellbeing R70-019/020; open-the-app churn R70-021; requests R70-023; bands R70-024/025; markets R70-026/027; eras R70-028/029; research R70-030; implications R70-033). Tables are carried verbatim, so per-era, per-band and per-storefront values are on cards.

## Gaps found → cards added

| Blind item | Gap | Card added |
|---|---|---|
| 47 | `MON_MUDA_AWARE` 44 — the add-on is named 「無駄機能」 ("useless feature"); the naming itself had no card | R70-035 (tactic) |
| 48, 49 | Positive counts in the §2.1 capability table (`PR_GRACE` 41, `PR_FAST` 7, `PR_HISTORY` 31, `PR_PRIVACY` 4) sat only inside the verbatim table; friction rows `REQ_CALENDAR` / `REQ_HISTORY` / `REQ_MEMO` had no card of their own | R70-034 (feature) |
| 137, 138 | 2023 as the lowest year since launch (4.56) and its coincidence with the tone backlash was only inside the verbatim yearly table | R70-036 (timeline) |

## Rule added to Report Synthesis Prompt.md

A capability / feature-inventory table whose rows carry *positive and friction counts side by side* (not only a gate or defect state) gets a feature card per row that has its own counts — the Report 20 rule covered gated and defect rows only. Also: a series table's extreme value (lowest / highest year or era) gets a timeline card when the report's narrative does not name it.

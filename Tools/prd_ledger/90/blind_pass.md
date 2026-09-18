# Blind pass — report 90

The blind list was written by a fresh context that did not see `cards.jsonl`: `Temp/90-blind-list.md` (218 items, kept in Temp as in earlier batches). It was diffed item by item against the 46 cards written in-section.

## Covered

Items 1–210 and 214–218 map to existing cards (header R90-001; method R90-002; the public-rating gap and the crash week R90-003; Part 0 findings R90-004 … R90-011; the model and privacy tables R90-012; Part 3 R90-013 … R90-023; Part 4 R90-024/025/026; Part 5 R90-027/028/029; Part 6 R90-030 … R90-034; Part 7 R90-035/036/037; Part 8 R90-038 … R90-045; the absent developer replies R90-046). Every table in Parts 0–8 is carried verbatim, so per-era, per-band, per-language and per-storefront values are on cards.

## Gaps found → cards added

| Blind item | Gap | Card added |
|---|---|---|
| 212 | §9.D sensitivity: the four re-runs (without the crash week 4.650★ and crash 10.6% → 0.2%; without Russia the widget 14.0% → 8.7% and tree growth 4.6% → 0.5%; without short reviews specific praise 46.4% → 53.5%) existed only as a pointer on the method card. Two of the four headline findings turn out to be Russian-storefront artefacts — a ledger-level fact with no card. | R90-047 (data-caveat) |
| 211 | §9.C known residual error risk ("Помогает" alone coded as an outcome; drug mentions that may be jokes or slang; `SEG_TRIED_OTHERS` comparative wording) — the method card carried the check counts but not what the checks cannot catch. | R90-047 (data-caveat) |
| 213 | §9.F absence tests: the pattern-by-pattern result table (Apple Watch 1, iPad 1, passcode 1, AI/chat 1, community 2, competitor named 2, "Краш" as *crush* excluded) sat outside the §0.8 absence card, which carried only the headline absences. | R90-048 (data-caveat) |
| 184 | §7.1 month table: the weakest non-crash months (2025-08 at 3.77★, 2023-07 at 2.00★) and the strongest volume months (2025-11, 2026-02) are only inside the verbatim table; the narrative names neither. This is the report-70 rule ("a series table's extreme value gets a timeline card when the narrative does not name it") recurring at month rather than year granularity. | R90-049 (timeline) |

## Rule added to Report Synthesis Prompt.md

Part 9's own re-runs get their own `data-caveat` cards, separate from the method card: the sensitivity table (§9.D), the absence-test result table (§9.F) and the stated residual error risk (§9.C). The method card records how the corpus was built; these record what the re-runs showed and what the checks cannot catch — including, here, that dropping one storefront removes two of the four headline findings.

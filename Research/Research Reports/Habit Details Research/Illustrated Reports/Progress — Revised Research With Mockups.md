# Habit Progress — Revised Research With Mockups

Written by Codex, 3 October 2026. Illustrated companion; the original research text is preserved separately.

**Mockup status: schematic layout and content study only. Habit names, dates, values and note text are dummy/illustrative data. These are not final visual designs. Final visuals need substantial polish: typography, spacing, hierarchy, colors, chart labels, accessibility, native interaction and all states. No usability test or wired interaction prototype is implied.**

**Version status:** **Current Progress layout direction: the revised visible-content study, board 357:1531. We are going with this version rather than the original second-tab/navigation-row layout.** Exact visuals, interactions and usability are not finalized.

[Unchanged original research report](<../Original Reports/Progress and Statistics/Individual Habit Progress — Visibility, Comparisons and Milestones.md>) · [Full Figma study](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=357-1531).

Keep History / Notes / Progress as the three job tabs. Inside Progress, show Overall record and milestone summary, then open Week, Month and Year sections. Each section has its own explicit scope. Repeating a metric across different periods can answer different questions; identical redundant representations within one scope still cost space. Previous-period comparisons belong inline, with honest dates, coverage and equivalent elapsed cutoffs.

## One scrolling Progress page — open sections

Overall record shows 84 h 45 min since 1 January through 30 September. Milestones expose current/best, next progress and a reached record rather than hide everything. Week shows 45 vs 55 recorded minutes over equivalent Mon–Wed windows. Month shows 565 vs 600 minutes and an actual daily amount chart. Year shows the complete portrait grid and Share year. The year shortcut scrolls to the section; it does not replace it. Only richer reached history, counting help and the legend use disclosure.

![Schematic One scrolling Progress page — open sections](<../Mockups/Progress Revised/Open Progress Sections.png>)

[Editable Figma source](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=359-1538).

## Weekly-total goal — actual quantities and ended goals

Move’s weekly target is 180 minutes. Same-point comparison is 140 vs 120 minutes; previous full week is separately labeled 180 minutes. Recent dated weekly quantities are 160, 220, 180 and 140; the last period is open. 2 of 3 ended goal weeks met target is a different fact from raw amounts. Its milestone unit is completed goal weeks, not calendar days. This panel illustrates a different habit type; it is not a second navigation tab or a full app screen set.

![Schematic Weekly-total goal — actual quantities and ended goals](<../Mockups/Progress Revised/Weekly Total Goal.png>)

[Editable Figma source](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=359-1785).

## Month calendar — exact date context alternative

The September calendar shows the same 565-minute, 22/27 record as the main example. Selected 29 September has 25 minutes against its historical 20-minute goal. This is an alternative to daily amount bars for date-finding/inspection; the recommendation does not automatically put both full charts into every habit’s Month section.

![Schematic Month calendar — exact date context alternative](<../Mockups/Progress Revised/Month Date Context.png>)

[Editable Figma source](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=359-1849).

## Full study board

![Full research board](<../Mockups/Progress Revised/Study Board.png>)

A closed period compares full vs previous full period. An open period compares equivalent completed habit days (or a trustworthy explicit event-time cutoff), never a partial Wednesday against last week’s complete week. No earlier comparable data must not become zero. Goal/unit changes require honest separate rules or segments. Quit/cut-down adapt the factual content and recording coverage, not generic build-habit judgment. Streak comparisons and milestone display remain adjustable where evidence supports differing needs.

Twenty originals were checked for this follow-up (9 re-read + 11 further), including contrary and out-of-scope cases; no preference census was claimed. The fixture is preserved in [Illustrative Progress Fixture](<../Evidence/Illustrative Progress Fixture.json>). All dates/values are illustrative. Milestone thresholds and skip/pause rules are fixture choices, not scientifically validated habit-formation rules. Local historical-period controls, optional display, scroll shortcut and button behavior are specifications rather than wired interactions.

The populated alternatives still need task tests for week totals, cutoff comprehension, cumulative work, reached milestones, exact date access and year sharing. Stacked sections reduce hidden state but increase scrolling. The revised direction does not establish an empirical winner over a fully populated period-selector alternative.

[Package index and current direction](<../README.md>).

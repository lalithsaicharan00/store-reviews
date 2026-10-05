# Widgets — Research and Figma Brief

Written by Codex, 5 October 2026. Research/design deliverable for Current Work Checklist item **9**. App implementation and physical-iPhone acceptance remain separate.

## Full request captured before research (W1)

The user considers widgets an important purchase driver and asks for thorough research, followed by editable designs in the supplied Figma file. Validate assumptions instead of treating them as facts. The current experience offers widget sizes but displays an unwanted default habit and gives the user no discoverable way to choose or change it. Investigate native iPhone addition, configuration, replacement, and interaction. Consider multiple independent habit squares, a larger task list, icon-oriented widgets, square cards, horizontal cards, rows, lists, and progress widgets. Review existing research and all available review evidence, compare competitors, identify what people praise and complain about, and explain both widget families and visual styles. Account for the redesigned Week/Month/Year Progress pages. Determine whether progress motivates, which progress each widget should show, and how it should be represented. Validate the five-habit free allowance and task policy. Propose a limited but useful free catalogue and a compelling paid catalogue: enough additional value to encourage upgrades without making basic widgets frustrating. Do not assume zero complaints or conversion can be guaranteed. Adapt useful competitor ideas to Often Enough's native system rather than copying their visual identity. Create **two new Figma sections**, free widgets and paid widgets, with the proposed widget designs. Before claiming completion, audit every requested point and document evidence and remaining limitations.

## Research and delivery checklist

- [x] Read Rulebook in full, CLAUDE.md, and research conventions before changes.
- [x] Capture the full request and retain existing current-work item 9.
- [x] Audit existing widget code, guide, plan entitlement, tests and documented gaps.
- [x] Validate five active habits versus five habits per week; unlimited-task semantics.
- [x] Retrieve current Apple primary documentation for Home Screen/Lock Screen addition, editing, configuration, families, interactivity, and rendering.
- [x] Explain gallery previews versus configured data; native habit picker, independent instances and later change; empty/unavailable selection states.
- [ ] Recover and independently validate the complete prior whole-corpus classification, or finish a new exhaustive human coding pass. **Outstanding:** the full September map is absent; fresh 20,412-candidate inventory is not hand-coded. The delivered report instead attributes the historical aggregate and individually reads/validates 181 originals with explicit iOS/Android scope.
- [x] Examine preferences for list, single card, icon grid, week/month/year, counters, Lock Screen, density, labels, colors and customization.
- [x] Verify current competitor offerings from primary sources, and match patterns to review evidence.
- [x] Separate motivation evidence from causal claims; specify honest progress by habit/goal type, tasks and quit/limit states.
- [x] Propose free/paid matrix, optional upgrade discovery, entitlement expiry and compatibility; do not withdraw working free capabilities.
- [x] Define native setup, taps, correction/recovery, stale/offline/privacy states, accessibility and light/dark/tinted/clear behavior.
- [x] Inspect the supplied Figma board and accepted design conventions; create two new, separate sections using editable native-style layers.
- [x] Include the widget catalogue, configuration journey and meaningful state/style examples in the free/paid sections.
- [x] Write detailed report, reproducible evidence map, sources, limits and build acceptance criteria; update research index and current checklist.
- [x] Record newly learned reusable guidance in Rulebook the same day (W5); label product choices as proposals awaiting review.
- [x] Audit cited reviews, local links, Figma structure/fonts/bounds and composition screenshots; git whitespace/source rules as appropriate.
- [x] Recheck this checklist against the original request before submitting; report unverified device checks explicitly (U9).

The initial request covered research/design, without app implementation or publication. The user's later instruction below authorizes committing the complete documentation and images to `main`.

## Final request audit — 5 October 2026

At the initial delivery, the detailed report, current-source audit, native Apple guidance, seven competitor checks, style/progress/plan recommendations, two editable Figma sections, 20 reusable components and portable PNGs were delivered as a proposal. The final Figma audit has zero clipped overflows, bitmap fills or foreign fonts. Review verification has 181 exact matches, zero unknown IDs, within-theme duplicates or unassigned records. Markdown/source checks and the speed-rule gate are recorded with the report. At that point no app code, purchase settings, commits, pushes or CI jobs had changed. Current Work item 9 remains open under W1/U9.

The outstanding full-corpus classification is deliberately not marked complete. The earlier counts cannot be advertised as independently rebuilt or as an iOS popularity ranking. Native iPhone picker/interaction/appearance/accessibility/performance and actual StoreKit ownership checks remain implementation acceptance work, not completed research tests.

## Publication follow-up — 5 October 2026 (W1)

The user asks whether the material has been committed and explicitly instructs: commit the widget research into **main**, include the proposed images, document widgets properly in a **separate folder**, and make the package usable by other agents. This extends the initial research request; it does not approve app implementation or close the device/review gaps.

- [x] Retain a dedicated dated widget folder with the report and source evidence.
- [x] Add a Start here guide and implementation handoff with priorities, code entry points, behavior contracts, validation and open decisions.
- [x] Include both annotated boards and all 26 individual widget/style renders (28 PNGs); record Figma IDs, dimensions and SHA-256 values.
- [x] Link the package from the research index, iOS docs and existing Current Work item 9; preserve numbering and proposal status.
- [x] Provide repeatable checks for source IDs/text, local links and every image; recheck the original request and preserve incomplete exhaustive coding/device work.
- [x] Commit the checked documentation and images onto current main, retaining unrelated newer work; keep the publication commit free of CI trigger tags under T10.

Post-integration verification: 181 exact-original matches, zero unknown/duplicate/unassigned evidence records, 54 cited report IDs resolved, 87 local links resolved, all 28 PNG hashes/dimensions/CRCs verified, staged and committed whitespace checks passed, and the speed-rule gate passed on current main. The package was integrated above `fd80f253` without conflicts or application-code changes. The commit and remote main history record publication; no iOS validation was dispatched.

The commit history is the publication record. No app code, purchase settings or iOS test dispatch is part of this follow-up.

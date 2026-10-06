# Large Today list — Start here

Written by Codex, 6 October 2026. Final design selection under Current Work item 9.

Open [the updated Figma section](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=585-4698). The accepted design uses **progress-filled rows only, at most five items per page, 12-point row separation and header pagination above five**. The rejected plain comparisons and six-row draft roots were removed from the active delivery. CTAs are neutral before completion, then use the habit’s main color with white content when done.

![Five-item layout, four-item layout and dark appearance](<Images/Five Item Layout.png>)

Read [Layout and Implementation Handoff](<Layout and Implementation Handoff.md>) before building. [Figma State.json](<Figma State.json>) records the 16 scenario components and 18 review instances. [Figma Audit.json](<Figma Audit.json>) checks capacity, spacing, insets, targets, input glyphs, CTA colors, fonts and paging headers. [Export Manifest.json](<Export Manifest.json>) records **20 PNGs**: 18 individual examples, the focused layout and the annotated board, with actual image dimensions and hashes. [Images](<Images/README.md>) lists every export.

Today remains the default aggregate view; it is not a new saved section. Optional selection of one nonempty section is also shown. Six items use 5 + 1, twelve use 5 + 5 + 2, and sixteen use 5 + 5 + 5 + 1. Final pages retain stable row positions. Quit and limits remain visible without entering the positive completion count or receiving a success fill. [Validation Results](<Validation Results.md>) records the final checks and their native-validation limits.

**Status:** the requested Figma/design revision is delivered. Native implementation, installed WidgetKit sizing/interaction, live clocks, accessibility, configuration isolation and real-iPhone validation remain open (U9). Drawings document paging and logging behavior; they are not a wired Figma prototype or installed widget. This package is uncommitted on the research branch; no CI run, commit or push was started in this phase.

See [the Large request checklist](<../../../../../../../iOS/Docs/Checklists/Large Today Widget — Plain and Filled Rows — 6 October 2026.md>) and [the CTA revision checklist](<../../../../../../../iOS/Docs/Checklists/Widget CTA Colors — Match Today Rows — 6 October 2026.md>). The prior [size/section study](<../Today List Widgets — Size, Sections and Native Behavior.md>) supplies the review and primary-provider evidence; the [single-card CTA revision](<../../Daily Cards/CTA Colors — Match Today Rows — 6 October 2026.md>) records the matching control states.

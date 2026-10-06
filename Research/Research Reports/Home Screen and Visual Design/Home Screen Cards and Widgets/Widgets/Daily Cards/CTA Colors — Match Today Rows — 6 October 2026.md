# CTA colors — Match Today rows

Written by Codex, 6 October 2026. Latest accepted user correction; supersedes the earlier monochrome-primary / outlined CTA styling, while preserving the daily-card layout and action contracts.

The user asked for both [single-habit Today cards](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=537-2981) and the [Large Today list](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=585-4698) to match the app's round controls. `RoundActionButton` (`iOS/Habits/Components/Components.swift:100–149`) uses neutral `Color(.tertiarySystemFill)` with `Color.ink` before completion. On completion it uses the habit's main color and `Color.white` in both appearances. The native source was read; it was not modified.

The shared small-card control and its affected variants/examples now use that model. A checked binary day, an amount above its positive goal, and a completed named checklist receive the habit-colored CTA. Amount labels stay +N after completion; the action still adds one actual amount. Opening a completed checklist remains an exact checklist route, not an instruction to check every step. Running timers stay neutral, following the app's `done && !running` caller. Quit and quantity/time limit controls stay neutral even after a slip or at the maximum. Existing disabled/recovery meanings are retained.

Figma uses an opaque neutral preview (#EFEFF0 light, #3E3E42 dark) with a semantic binding to the native `tertiarySystemFill` contract. These are visual proxies, not asserted UIKit constants. Native code must resolve the dynamic system color and its accessibility contrast. Completed content binds to constant white, so dark mode does not reverse it to black. Habit fills reuse the existing palette. Global day-sheet primary-button tokens remain unchanged. The accepted rule is recorded in Rulebook U2; limit/quit meaning remains U16/U25.

The revision preserves the shared icon/action header, separate name and value lines, 16-point insets, 44-point action targets, one visible CTA, exact increments, timer routes, one-line quit elapsed/best context and period-goal scope. [CTA Audit.json](<CTA Audit.json>) records the final color/state check; all 40 [exports](<Export Manifest.json>) are refreshed from the revised Figma nodes. The Large list has its [own delivery and audit package](<../Today List/Large Designs — 6 October 2026/README.md>).

![Incomplete and completed controls](<Images/Shared Layout.png>)

This is a Figma/design revision, not an app implementation or installed-device result. Current Work item 9 and native acceptance remain open (U9). No commit, push or CI dispatch was started for this correction.

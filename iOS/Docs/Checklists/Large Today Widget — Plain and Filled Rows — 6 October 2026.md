# Large Today Widget — Plain and Filled Rows

Written by Codex, 6 October 2026. Design follow-up under Current Work item 9; app implementation remains separate.

- [x] Inspect yesterday's linked daily-card section and reuse its visual language, fonts, colors, spacing and controls.
- [x] Check existing habit-count/free-limit research; identify what its numbers actually measure instead of assuming a population distribution.
- [x] Keep Today as an aggregate view; consider optional section selection without inventing a Today section or automatically splitting/hiding the day.
- [x] Design a minimal Large Today list with easy, explicit logging and today's progress.
- [x] Test the six-row capacity idea and show readable cases for fewer habits and 12/16-item overflow; preserve app section/order meaning and omit empty sections.
- [x] Produce both requested treatments: plain rows and row progress fills matching the app's intent.
- [x] Include honest quit/cut-down and mixed-input behavior; saved increments add only one contribution, steps never guess, complex input opens its exact existing flow.
- [x] Demonstrate completion feedback without immediate row replacement under a finger.
- [x] Add a new Figma section with editable components/instances; preserve existing small-widget designs.
- [x] Visually inspect renders and audit equal insets, text, meaningful progress, control regions and overflow access.
- [x] Save images and a separate design handoff in the widget research folder; update indexes/current status, verify links and repository checks.

Initial scope: one Large Today-list component family, two row treatments, relevant content/overflow/state examples. The plain treatment and six-row idea were created/evaluated, then superseded by the final user selection below. No weekly widget, unrelated library rebuild, app code, native test dispatch or main-branch publication in this phase. Figma interactions represent proposals; installed WidgetKit and iPhone acceptance remain required (U9).

## Final user selection — 6 October

This feedback supersedes the initial six-row / two-treatment proposal above.

- [x] Retain only the progress-filled design in the active Figma section; remove the rejected plain comparison and six-row layouts.
- [x] Cap every page at five habits/items. Show header pagination whenever the selected view contains more than five.
- [x] Increase separation between action regions and rows; keep the widget minimal, easy to scan, neat and visually balanced.
- [x] Recalculate six-, twelve- and sixteen-item paging: 5+1, 5+5+2 and 5+5+5+1, with stable positions on final pages.
- [x] Retain Today, the optional section view, today’s summary, honest ongoing/goal scope and the accepted CTA colors in both appearances.
- [x] Replace the active component/example inventory and refresh the final exports, audits and handoff; verify the final state before reporting design completion.

# Daily Widget — Layout and Actions

Written by Codex, 5 October 2026. Research/design follow-up for Current Work item **9**, not an app implementation sign-off.

## User request (W1)

Audit the codebase and research a clean single-habit widget showing **only the selected tracking day's progress**. Cover binary and repeated checks, quantity, time/timer, checklist steps (including many steps), quit, cut-down/limits, and daily/weekly/monthly goals. Determine whether one or two actions are needed, exactly what each does, and whether time logging opens a full-screen timer. Keep one shared layout and mental model across every daily habit card; do not force irrelevant duplicate controls. Compare the supplied thin-bar/two-action and prominent-progress/top-action ideas and improve them if appropriate. The prior four-line Water card is rejected as cluttered: eliminate redundant explanation, use equal outer insets and deliberate grouping/gaps. Show minimal necessary identity, actual daily progress and clear action. Finalize the shared layout before creating habit variants. Read review evidence and Apple guidance; add a new section to the existing Figma file with designs and researched CTA behavior. Existing sections are preserved.

## Checklist

- [x] Read Rulebook, repository/research instructions and applicable Figma skills.
- [x] Inspect the supplied images and accepted design rules.
- [x] Audit all habit models, goal clocks, daily values, timer/checklist/quantity/quit/limit flows and existing widget actions/routing.
- [x] Verify Apple's current widget interaction and routing constraints from primary documentation.
- [x] Read complete relevant review originals and distinguish user evidence, platform limits and design reasoning.
- [x] Compare layout/action alternatives; lock one shared daily-card layout before composing variants.
- [x] Specify exact CTA behavior and honest daily values for all habit types and weekly/monthly goals.
- [x] Include completed, running, many-step, limit/quit and unavailable/paused states; document correction and stale-tap recovery.
- [x] Discover/reuse Figma foundations/components; create one new editable section with consistent spacing and habit variants.
- [x] Inspect composition at real widget scale; check fonts, bounds, spacing, sample values and action labels.
- [x] Save the research/action matrix, design links, exports and remaining native acceptance work in the dedicated widget package; update indexes/item 9.
- [x] Recheck every user point, verify source IDs/local assets, record learning under W5 and run appropriate local documentation checks.

No runtime implementation or iPhone pass is implied by the Figma proposal (U9). Current Work item 9 remains open.

## User revision — Quit, Limits and Period Goals (5 October)

### Additional quit-card layout correction

Keep the same layout as every other habit: icon and one action in the header, habit name on its own line, then the full elapsed duration on **one emphasized line**. Do not combine the title with the icon at the top or split days and the smaller clock across separate lines. Research internationally understandable compact day/hour/minute/second notation; preserve all four units and the best-run context without adding clutter.

- [x] Compare compact duration notation with primary international/localization guidance and measure the actual string.
- [x] Restore quit cards to the shared icon/action → name → single emphasized duration → best-run layout.
- [x] Update current, after-slip, paused and dark examples; audit fitting, dependent annotations, exports and handoff documentation.

Quit completely and cut down are separate modes. A fully quit habit has no positive logging action: only Record a slip. Its central information is the live elapsed quit run, including days/hours/minutes/seconds, with the best run (example: 45 days). A saved slip restarts the current run at its recorded time; cancelling does nothing and the best run is preserved. Daily-limit consumption remains neutral, but its label must be more legible and its text must distinguish below, reached and above the limit. Include the existing duration-based cut-down case (social media, maximum 20 minutes). For weekly/monthly total goals, show the configured period goal as the subtitle, using the current app's wording, while avoiding an invented daily target. Check current main, roughly the last 10–15 commits, code and recent research. Revise only the affected cards and their supporting documentation; preserve the accepted shared layout for other cards.

- [x] Refresh and inspect main and its last 15 commits; record the exact audited revision.
- [x] Read quit/cut-down models, elapsed/current/best-run calculation, slip timestamp behavior, amount/time limit states and period-goal subtitles.
- [x] Check recent related research, accepted design rules and native widget timer-text limitations.
- [x] Revise quit cards around current elapsed run and best run; only the slip action remains.
- [x] Make daily-limit captions legible and change their state text at/above the limit; include duration limits below, running, reached and above.
- [x] Replace weekly/monthly contribution-only subtitles with configured goal wording while retaining today's actual contribution.
- [x] Update affected Figma components, instances, annotations, exports, report and item 9; preserve unrelated designs.
- [x] Visually inspect revised cards and verify full values, action targets, local links, manifests and source claims; keep native implementation/device acceptance open.

## Original delivery evidence

Initial delivery: section 537:2981; 29 semantic component variants and three weekly/monthly/duration limit examples. The revised results below supersede the original render counts. Native SF Pro/SF Symbols and shell instances; 16-point equal insets, zero example progress-value overflows, targets at least 44 points. 35 final renders plus structural/asset manifests. 37 complete originals matched to raw sources with zero unknown or unassigned records. The separate report records code gaps and native acceptance. Existing catalogue sections preserved. Final checks passed: daily source/asset validator (35 PNGs, 89 local links), original catalogue validator (28 PNGs, 178 local links), git diff --check and local speed rules. Full results are in [Validation Results](<../../../Research/Research Reports/Home Screen and Visual Design/Home Screen Cards and Widgets/Widgets/Daily Cards/Validation Results.json>). Every user point was rechecked against the report and Figma cases. No runtime implementation or CI/device validation is claimed.

## Revised delivery evidence

Focused review panel [560:4241](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=560-4241): current/after-slip/paused quit, three quantity-limit states, four duration-limit states and configured weekly/monthly goals. Quit uses the shared header and separate title, followed by one 17-point semibold `15d 22:36:35` line and Best 45 days capsule. Fresh main audit `f0e52f46d8ef4641b247aa8b243d1728777b3440`; last 15 commits and relevant source equality/hashes are saved. The latest report records localization, live-text/API constraints, exact slip/history behavior and native acceptance. Final validation is recorded in the package Validation Results; item 9 remains open for implementation.

Final revision checks passed: 37 source originals, 40 daily PNG hashes/dimensions/CRCs, 104 local links, zero value overflow/unequal insets/small targets in the recorded audit; original catalogue 28 PNGs and 193 links; git diff --check and local speed rules. The final one-line quit review panel and exported dark card were inspected. Research/design delivery is verified; live native animation, localized/adaptive rendering and iPhone acceptance are still pending.

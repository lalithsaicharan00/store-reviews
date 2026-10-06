# Widget Figma Delivery

**6 October consolidated status:** Read [Widgets — start here](<README.md>) and the [Accepted Widget Contract](<Accepted Widget Contract.md>) first. Current Small supporting labels are 12 pt Medium; Large is filled-only/max five; Medium is filled/max two. Older layouts and phase-specific uncommitted notes below are historical. No native widget source is changed by this publication; device/build acceptance remains open.

Written by Codex, 5 October 2026.

**Editable research proposal; review and native implementation pending.** Created with the Figma plugin's `figma-use`, `figma-generate-design` and `figma-generate-library` workflows. Existing accepted app screens were inspected and left intact. No app implementation, purchase or device-validation claim follows from these designs (Rulebook U9).

| Section | Link | Natural canvas bounds |
|---|---|---|
| Free widgets · research proposal · 5 October 2026 | [Open Free](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=509-3114) | 1840 × 2093; x43590, y711 |
| Paid widgets · research proposal · 5 October 2026 | [Open Plus](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=509-3116) | 1840 × 2552; x45630, y711 |

Both are on the supplied `inspiration` page (`234:2`). Reusable components are below them in frame `509:2867`. [Figma Audit.json](<Figma Audit.json>) records all 20 component IDs, family sizes, section geometry and the final checks.

## What is editable

- 20 reusable components; 74 instances; 652 text nodes in the two sections plus their component frame.
- SF Pro, SF Symbol characters, vector marks and auto layout; no image fills or foreign font families.
- Existing Day sheet semantic variables for card/text/chrome and light/dark, plus generated HeatPalette variables for the widget marks; a per-hue dark check sign matches the source palette.
- iOS 26 library Home Screen widget shell (`c7b43507a20f36e02f596b76965683a289839e81`) and Caption 1 style (`e1ce3de1d3ec79b0c7973d377e14b9f7fc099acd`). The neutral/soft-filled surfaces are intentional overrides of the native shell.
- Actual optional icon-only example with status retained, along with named default favourites, Small seven-day history, Medium history, Month/Year, native setup/configuration proxies and recovery states.

## Verification and cautions

The final clipped-content check returned **zero overflows**, including negative-position checks; foreign fonts and bitmap fills were both zero. The final two whole-section PNG exports were inspected after layout and sample-data corrections. The September sample has 16 goal-met days including 29/30 September; the seven-day strip agrees with those dates, October has two goal-met days, and Year totals 151. Today's Read cell is partial, matching the 10/20-min list status. Today has a thin outline. Heatmap marks are at least 24 pt, and historical squares are read-only.

The checks are structural/composition checks, not native accessibility, contrast, hit-testing or rendering tests. The 44-pt action/paging targets are design geometry to validate in SwiftUI. In particular:

- iOS gallery/editor/picker and Lock Screen examples are explanatory proxies. WidgetKit owns those system screens/materials.
- Tinted/clear examples are deliberately labelled **illustrations**. Real glass/wallpaper contrast, accented groups, background removal and different device sizes require an installed iPhone.
- Compact action indicators need usable VoiceOver labels and native hit testing. Optional icon-only keeps full accessibility names, which Figma cannot prove.
- Medium two-row list opens Today for the rest; Large supports paging. The native view must adjust rows for larger text and long units.
- The Small wrapped seven-day strip preserves a readable family but its date interpretation needs usability validation.
- No prototype wiring represents durable logs or purchases. No screenshot proves the reported picker problem fixed, the extension fast, or the Plus entitlement/restore correct.

The [full research report](<iPhone Widgets — Types, Native Setup and Free vs Plus.md>) is the behavior/plan proposal and includes the implementation acceptance matrix. Current Work Checklist item 9 remains open.

Research delivery checks: all 54 distinct review references in the report resolve to verified originals; `git diff --check` passes; `iOS/Tools/perf/check_rules.sh` passes using Git Bash's Unix-tool PATH on Windows. No app-runtime tests or CI dispatch were needed for documentation, evidence tooling and Figma edits. The publication follow-up adds a [Start here guide](<README.md>), [implementation handoff](<Implementation Handoff.md>) and [26 individual renders](<Images/README.md>). The repeatable delivery verifier checks every local link in the package and all 28 PNGs. [Export Manifest.json](<Export Manifest.json>) and [Images/Manifest.json](<Images/Manifest.json>) record dimensions, sizes, SHA-256 values and Figma node IDs.

## Portable composition exports

These are renders of our new editable designs, not copied competitor images. They include the board annotations and are suitable for reviewing this proposal; the Figma links remain the editable source.

![Free widget research board](<Free Widgets.png>)

![Plus widget research board](<Paid Widgets.png>)

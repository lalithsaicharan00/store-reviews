# Medium Today — Start here

Written by Codex, 6 October 2026. Design follow-up under Current Work item 9.

Open [the new Figma section](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=622-6436). It contains **Today or a selected section, two separated rows per page, progress fills and header paging above two**. A larger-text example reduces capacity to one. The accepted Large and single-habit sections are preserved.

![Today, Morning and dark appearance](<Images/Medium Today Layout.png>)

Read [Layout and Implementation Handoff](<Layout and Implementation Handoff.md>) before building. [Figma State.json](<Figma State.json>) records 21 scenario components, 24 review instances, reused row/native-shell dependencies, five missing typography styles, scoped geometry variables and three Medium-only progress-state row templates. [Figma Audit.json](<Figma Audit.json>) records actual geometry, target regions, clipping checks, CTA bindings, real symbols/labels and visible progress fractions. [Export Manifest.json](<Export Manifest.json>) and [Images](<Images/README.md>) cover 26 PNGs: 24 examples, the focused layout and the board.

The 338 × 158-point illustration uses equal 12-point visible outer insets, a 22-point visible header, 12-point separation and two 44-point rows. Header touch regions use surrounding padding to reach 44 points without overlapping logging controls. This is a feasibility study, not a universal iPhone size or native hit-test result.

**Status:** Figma/design proposal delivered; [Validation Results](<Validation Results.md>) records the checks. Native implementation, configuration/section routes, paging isolation, actual WidgetKit sizing, accessibility and real-iPhone acceptance remain pending under U9. No runtime code, CI dispatch, commit or push in this phase. [Request checklist](<../../../../../../../iOS/Docs/Checklists/Medium Today Widget — Today and Selected Section — 6 October 2026.md>).

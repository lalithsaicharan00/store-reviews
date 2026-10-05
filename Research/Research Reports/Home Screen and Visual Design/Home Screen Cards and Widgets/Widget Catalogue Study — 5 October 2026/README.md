# iPhone widgets — start here

Written by Codex, 5 October 2026. Dedicated research and design handoff for **Current Work Checklist item 9**.

**Status:** research/design proposal, with source verification and editable Figma designs. Native implementation, the reported installed-phone picker problem, device acceptance and product approval remain open. The missing complete historical review coding is also open. Publishing this package to `main` does not change those statuses (W1, W2, U9).

## Read in this order

1. Read the repository [Rulebook](<../../../../../RULEBOOK.md>) and [CLAUDE.md](<../../../../../CLAUDE.md>) first.
2. Read [Implementation Handoff](<Implementation Handoff.md>) for the code entry points, priorities, behavior contracts and completion evidence.
3. Read the [detailed research report](<iPhone Widgets — Types, Native Setup and Free vs Plus.md>) for native setup, review findings, current competitors, progress, appearance and the proposed free/Plus boundary.
4. Open [Figma Delivery](<Figma Delivery.md>) and the [individual image gallery](<Images/README.md>). Review the proposal before implementing optional layouts.
5. Keep [Current Work item 9](<../../../../../iOS/Docs/Checklists/Current Work Checklist.md>) and the [full request audit](<../../../../../iOS/Docs/Checklists/Widgets — Research and Figma Brief — 5 October 2026.md>) current; do not renumber them.

## Editable design and committed images

| Asset | Location |
|---|---|
| Free widgets section | [Figma — Free](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=509-3114) |
| Paid widgets section | [Figma — Plus](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=509-3116) |
| Complete annotated boards | [Free Widgets.png](<Free Widgets.png>), [Paid Widgets.png](<Paid Widgets.png>) |
| 26 individual renders | [Images/](<Images/README.md>) — 20 base components and six appearance/icon-only examples |
| Board export hashes and dimensions | [Export Manifest.json](<Export Manifest.json>) |
| Individual export hashes, dimensions and Figma IDs | [Images/Manifest.json](<Images/Manifest.json>) |
| Editable component IDs and structural audit | [Figma Audit.json](<Figma Audit.json>) |

There are **28 PNGs** in this package. They are renders of our new Figma proposal, not competitor screenshots. The boards include the native setup journey, Lock Screen family proxies and entitlement/recovery notes. Individual renders make the layouts easy to inspect and reuse as implementation references. Tinted/clear appearances and system setup drawings are conceptual; reproduce them through WidgetKit and validate on a real phone. Figma logical sizes are examples, not a fixed pixel contract for every iPhone.

## Evidence and reproducibility

| File | What it proves |
|---|---|
| [Verified Review Sources.json](<Verified Review Sources.json>) | 181 complete originals with stable IDs, platform/source references and manual theme assignments |
| [Verified Review Index.md](<Verified Review Index.md>) | Full per-review source and theme lookup |
| [Scan and Verification Summary.json](<Scan and Verification Summary.json>) | Fresh lexical inventory, exact-original checks, input hashes and explicit scope limits |
| [Evidence and delivery tools](<../../../../Tools/widget_catalogue/README.md>) | Repeatable inventory/source verification and package/link/image validation |

The fresh inventory covers 1,238,784 eligible records and 20,412 lexical candidates; those candidates are **not** a completed manual preference study. The 181 read originals are a selected audit set (128 iOS, 53 Android), not a population denominator. The earlier September aggregate is attributed to its report; its full coding files were not recovered. Do not announce new popularity percentages or treat Android opinions as iPhone evidence.

Use the report's proposed priorities: first reproduce native selection and preserve reliable free tracking, then refine the basic designs and build the most useful optional Plus layouts. Year summary and extra surfaces need further demand/usability validation. This handoff authorizes documentation publication; it does not silently approve every product proposal.

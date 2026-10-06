# Widget history and current implementation

Written by Codex, 6 October 2026.

## How this work started

The user reported that adding a widget selected a default habit without an obvious way to choose another, and asked for native selection, reliable interactive logging, review-backed sizes/styles, honest progress, a free/Plus boundary and editable designs. They also requested all documentation and images on main so another agent could continue.

| Stage | Work and outcome | Current authority |
|---|---|---|
| September research | Broad mixed-platform widget/preferences and free-cap studies; historical aggregate reused with attribution, missing complete coding disclosed | Evidence only; never a new iOS population survey |
| 1 October implementation | Shared snapshot, stable kinds, intents, agenda/history/icon/accessory surfaces and historical CI; installed-phone and performance gaps recorded | [Historical report](<Historical Research/iPhone Widgets — Research and Implementation.md>) and [integration guide](<Native Integration and Release.md>) |
| 5 October catalogue | Fresh inventory, 181 read originals, Free/Plus sections, native picker journey, 28 images | [Detailed report](<iPhone Widgets — Types, Native Setup and Free vs Plus.md>); optional layouts/gating remain proposals |
| 5 October Small Today | Shared icon/action header, separate name/value and progress capsule; 29 base scenarios and scope/timed-limit examples | [Daily report](<Daily Cards/Daily Progress Widgets — Layout and Actions.md>) |
| Quit/limit/period correction | Fully quit uses live run and Best/Since, only slip logging; name separate, elapsed line emphasized on one line. Timed limits added; week/month goals visible without invented daily target | [Revision](<Daily Cards/Quit, Limits and Period Goals — Revision.md>) |
| 6 October CTA correction | Match Today: neutral system fill/ink before done; positive done uses habit main color and white; quit/limits/running stay neutral | [CTA contract](<Daily Cards/CTA Colors — Match Today Rows — 6 October 2026.md>) |
| 6 October Large | User chose progress-filled rows, rejected plain and squashed six-row designs; cap five, 12 pt spacing, header paging | [Large handoff](<Today List/Large Designs — 6 October 2026/Layout and Implementation Handoff.md>) |
| 6 October Medium | Two roomy rows, Today or real selected section, pagination, one-row larger-text fallback, honest goals/ongoing/recovery | [Medium handoff](<Today List/Medium Designs — 6 October 2026/Layout and Implementation Handoff.md>) |
| 6 October final Small / publication | Supporting labels 12 pt Medium; six explicit recovery states added to the current section; consolidated folder and refreshed exports | [Final Small correction](<Daily Cards/Final Typography and Recovery — 6 October 2026.md>) overrides older supporting typography |

## What is implemented versus designed

The earlier [Widgets — Tick Without Opening the App](<Historical Research/Widgets — Tick Without Opening the App.md>) study is preserved here as historical research. Related home-card and pricing reports retain their broader topic locations; links resolve to them, and they do not override the current family handoffs.

Latest main was inspected at `321562c0` before publication, including its latest 15 commits. Those commits address the routine player, habit-start logical day, tests and documentation; they do not implement the new widget designs. No native source is changed by this package.

| Work | Existing source / evidence | Remaining implementation |
|---|---|---|
| Select one habit | `iOS/Shared/PhoneWidgets.swift` and configuration/entity query already contain a picker and UUID selection | Reproduce the reported installed-phone setup problem; ensure default choice, Edit Widget guidance and unavailable selection states are understandable |
| Today / selected section | Existing agenda configuration has completed/tasks-only options; seven logical-day snapshot frames | Add stable section metadata and entity selection; preserve app order; no invented Today section ID; correct mixed habit/task order and per-view paging isolation |
| Exact quick action | Shared `WidgetIntents.swift`, app-process validated write path and disposable snapshot | Exact-day binary toggle/uncheck, configured increments, running timer/pause, precise manual/checklist/slip routes; stale-day/privacy/duplicate and failed-save guards |
| Small layout | Current one-item widget is functional legacy UI | Implement the accepted shared hierarchy, 12 pt Medium supporting context, quit live current/best anchor, neutral limits and all new recovery states |
| Large / Medium layout | Existing agenda and pagination are functional legacy UI | Implement max five / two capacity, fills, header paging and native text-size fallback; Figma is not WidgetKit hit testing |
| Free / Plus | Current entitlement gates exist; five unarchived free habits and unlimited tasks | Confirm the proposed catalogue boundary before changing it; validate genuine purchase/restore/expired entitlement, preserve basic tracking and data |
| Release acceptance | Historical CI and performance records are in the integration guide | Required new targeted tests and performance runs, then physical iPhone: native setup, actions, rollover, persistence, accessibility, light/dark/tinted/clear and multiple instances |

Use `iOS/Habits/Model/HabitStore+Widgets.swift`, `iOS/Shared/WidgetSnapshot.swift`, `iOS/Shared/WidgetIntents.swift`, `iOS/Shared/PhoneWidgets.swift` and `iOS/Habits/Today/TodayRows.swift` as the entry points. `iOS/Habits/Components/Components.swift` is the existing CTA appearance reference. Locate names with `rg` and verify current main before coding; do not copy a dated implementation claim as proof of today's behavior.

## Next implementation order

1. Reproduce setup and verify stable habit selection on the installed phone; implement precise empty/unavailable/privacy behavior.
2. Update snapshot contracts for logical-day, goals, quit runs and real sections; test backward compatibility and failed writes before changing visuals.
3. Implement Small with exact per-type action routes, then Large five-row and Medium two-row families with independent paging and preserved user order.
4. Run affected native tests/performance once for the completed change, coordinating under T10; record physical-device acceptance separately under U9. Keep Current Work item 9 open until the build/tests criterion is met.
5. Treat weekly/history/compact paid variants as later scope until their demand and product boundary are accepted. This document does not approve them silently.

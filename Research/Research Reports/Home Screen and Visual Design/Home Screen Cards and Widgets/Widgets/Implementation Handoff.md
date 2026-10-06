# iPhone widgets — implementation handoff

**6 October consolidated status:** Read [Widgets — start here](<README.md>) and the [Accepted Widget Contract](<Accepted Widget Contract.md>) first. Current Small supporting labels are 12 pt Medium; Large is filled-only/max five; Medium is filled/max two. Older layouts and phase-specific uncommitted notes below are historical. No native widget source is changed by this publication; device/build acceptance remains open.

Written by Codex, 5 October 2026. Read with the [research report](<iPhone Widgets — Types, Native Setup and Free vs Plus.md>) and [Figma delivery](<Figma Delivery.md>). This is a build proposal and acceptance plan, not an implementation sign-off.

## What to establish first

The user reports that an added widget shows a default habit and offers no discoverable choice. The audited source already has an optional App Entity selector, independent item UUIDs and an unselected “Choose an item” state; the timeline code does not deliberately fall back to the first habit. Establish the installed build, widget kind and saved configuration before changing the code. Native Home Screen addition selects a kind/size; holding the installed widget and choosing **Edit Widget** exposes supported parameters. Do not promise an app-owned habit-picker screen inside Apple's gallery.

Reproduce on a physical iPhone: add Water and Stretch as two Small instances, edit their selections independently, cold-launch/terminate the app, reboot, then change only one. Capture device/iOS/build, steps, expected/actual result and relevant configuration. If the problem is discoverability, improve the in-app guide and honest unselected state; if the selector is missing or broken, fix the specific AppIntent/entity/configuration path. Never silently replace the user's choice.

## Code map and integration boundaries

These paths were audited at research baseline `a6aaa2d9`. Recheck them on current `main` before editing; parallel entitlement, sync and app work may have advanced.

| Entry point | Responsibility |
|---|---|
| [WidgetIntents.swift](<../../../../../iOS/Shared/WidgetIntents.swift>) | WidgetSelection / query, item/agenda/history parameters, logging and paging intents |
| [PhoneWidgets.swift](<../../../../../iOS/Shared/PhoneWidgets.swift>) | Timeline/provider entries, stable widget kind declarations, family/layout views |
| [WidgetSnapshot.swift](<../../../../../iOS/Shared/WidgetSnapshot.swift>) | Shared bounded snapshot and data/state contracts |
| [HabitStore+Widgets.swift](<../../../../../iOS/Habits/Model/HabitStore+Widgets.swift>) | App publication, committed action handling and integration hooks |
| [iPhone Widgets integration guide](<Native Integration and Release.md>) | App Group, durable data, sync/entitlement integration, historical test evidence, physical-device matrix |
| [Design Rules](<../../../../../iOS/Design Rules — Don't Regress.md>) | Accepted Progress, color, interaction and native-app rules |
| [Current Work Checklist](<../../../../../iOS/Docs/Checklists/Current Work Checklist.md>) | Item 9 owns current progress; keep numbering intact |

Locate current guide UI and widget tests with `rg --files iOS` / `rg -n 'WidgetUITests|WidgetSystemUITests|WidgetsGuide|WidgetsView' iOS`. Keep the existing five widget kind identities and saved configurations stable. Reuse the common extension/shared files; this proposal does not require a second extension or database.

## Recommended build sequence

| Priority | Deliverable | Evidence required before closing |
|---|---|---|
| P0 | Native per-instance selection and clearer add/edit instructions | Actual iPhone picker, two independent UUID selections, later change, no accidental default |
| P0 | Reliable cold actions and lifecycle recovery | Exactly one durable entry, correct logical day, visible failure, duplicate/stale protection, privacy/offline checks |
| P1 | Free Small item and Today/Tasks lists | Readable actual units, correct per-type routes, all tasks reachable, larger text/VoiceOver, native screenshots |
| P1 | Plus compact favourites, Week and Month | Named default plus deliberate icon-only option, honest history, valid selection and useful entitlement fallback |
| P2 | Year summary, goal/streak focus, soft surfaces | Demand/usability review and native accessibility/rendering evidence before broad expansion |

The free model allows **five unarchived habits at a time**, including paused unarchived habits, not five new habits each week. Tasks and repeating tasks are unlimited. Do not add a second limit on the number of widget instances. Retain existing free Large/Lock functionality. The full free/Plus matrix is in report §7; the layouts are proposals awaiting review.

## Behavior to preserve

- Configure the selected habit/item by stable UUID; deleting/archiving or making it unavailable gives an honest state and a way to choose again. Preserve configuration across app upgrades and entitlement changes.
- Single checks and positive saved increments add one intended entry. Duration, checklist, manual amount and quit/slip input open the existing detail flow. No destructive reset or hidden whole-goal action.
- Commit data before publishing success. A cold intent, repeated callback, Undo, failed save or yesterday's button must not lose/duplicate logs or write to the wrong logical day.
- Show real units in the goal's own day/week/month period. Do not invent one completion percentage across different goal clocks or tasks. Reach-target fill must not become a goal-chasing bar for a limit.
- Use accepted Progress history semantics. Day squares stay at least 24 pt in this proposal; historical marks open Progress. Month is a real calendar month. Year uses 12 monthly summary bars rather than a squeezed full-year day grid.
- Keep names visible by default in compact favourites. Icon-only is an explicit option with full VoiceOver identity/state/action labels. Actual 44-pt action geometry and readable row counts must be verified natively.
- Light/dark, system tint/clear, privacy, accessibility and reliable updates belong to both plans. Paid surfaces add presentation and glance depth; they do not repair broken free tracking.
- On Plus loss, keep data and selections and show a useful free status/list fallback. Verify real ownership, restore, expiry/refund and offline caching; a debug Plus toggle proves only a view state.
- Use existing semantic tokens, SF fonts/symbols and generated heat colors. Support WidgetKit rendering modes and background removal; do not paste the PNG exports into widgets.
- Keep snapshots bounded, aggregation outside view bodies and publication coordinated with sync/store hooks. Measure speed on the built app and extension; a Figma export is no performance evidence.

## Validation and safe test dispatch

The full acceptance matrix is in report §10 and the integration guide. Record device, OS, build and pass/fail/unrun for: native selection; all supported families; long names and larger text; VoiceOver; paging; each logging type; date/time-zone/DST/custom-day rollover; privacy/App Lock; stale/corrupt/pre-unlock data; Undo/deletion/import/sync; light/dark/tinted/clear; compatibility; actual paid ownership and measured performance. Historical simulator runs are context, not a new device sign-off.

Read **Rulebook T10 before every push or test dispatch**. Ordinary documentation commits have no CI/performance/widget tags and do not need to start tests. For intentional tagged runs, check repository-wide queued/running Actions, wait without cancelling another agent's work, and check again before dispatch. The widget cancellation tag requires explicit user authorization and proof that no other agent's work could be cancelled. Do not copy the older guide's historical trigger tags blindly.

Do not close Current Work item 9 until the requested behavior and required checks actually pass (W1/U9). Add implementation findings to that item's existing note, not a new competing numbered checklist. Report a proposal changed by the user as a dated decision; do not promote review synthesis into approval.

## Open research and product decisions

- The complete September review classification is missing. Recover it or finish fresh candidate-by-candidate coding before publishing prevalence claims. Current 181 originals and historical attributed aggregates remain useful directional evidence.
- Named lists and clear configuration have stronger practical support than a universal icon-only default. Optional icon-only, the wrapped Small week, Year bars and paid soft surfaces need direct usability/value validation.
- The user asked for a basic free catalogue and paid value. The proposed boundary preserves existing free capabilities, but has no measured conversion or guarantee of zero complaints. Purchase experiments need retention/refund/complaint guardrails.
- Apple-owned gallery/editor/Lock Screen material and iOS clear/tint examples are explanatory Figma proxies. Actual rendering, contrast, accessibility, hit testing and phone behavior remain unverified.

For package verification, follow [the tools README](<../../../../Tools/widget_catalogue/README.md>). Source evidence, images and Figma IDs are committed with the report; ignored Temp inventory can be regenerated from the numbered source corpora.

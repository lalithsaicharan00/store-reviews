# Daily Cards — current design handoff

Written by Codex, 6 October 2026.

**Latest correction:** [Final Typography and Recovery](<Final Typography and Recovery — 6 October 2026.md>) applies **12 pt Medium** supporting progress/state labels throughout and adds six setup/recovery scenarios to the current Small list. The [gallery](<Images/README.md>) has **48 final PNGs: 42 cards and six overview/layout/dark images**. Older 13 pt Semibold/11 pt Regular caption instructions below are superseded. Native implementation remains pending.

## Daily Cards — Start Here

Written by Codex, 5 October 2026. Follow-up to the widget catalogue for Current Work item **9**.

**Latest, 6 October:** [CTA colors — Match Today rows](<CTA Colors — Match Today Rows — 6 October 2026.md>) applies the user's correction to the single-habit and Large Today designs: neutral system-fill/ink controls before completion, habit-color/white controls on positive completion. The 40 images and their manifest are refreshed; layouts and logging meanings are preserved.

**Status:** code/review research and editable design proposal complete; app implementation and native validation remain open. This folder is on the research branch until publication is requested. It does not replace the earlier Free/Plus boards.

Open [the new Figma section](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=537-2981). The shared layout has one visible top-right action, a Day-details body tap, equal 16-point study insets and three groups. Checklist selection and custom input open the app; direct actions log precise values. Ordinary progress is today’s contribution; period-goal subtitles show the configured target. Fully quit shows the live current run and best-run context.

Read [Quit, Limits and Period Goals — Revision](<Quit, Limits and Period Goals — Revision.md>) for the latest user feedback, then [Daily Progress Widgets — Layout and Actions](<Daily Progress Widgets — Layout and Actions.md>) before building. It contains the option comparison, all habit/action contracts, weekly/monthly target rules, timer behavior, code entry points, states and native acceptance requirements. Then use [Scenarios.json](<Scenarios.json>), [Figma Audit.json](<Figma Audit.json>) and [Review Audit](<Review Audit.md>). The 37 complete verified originals are in [Verified Review Sources.json](<Verified Review Sources.json>); this is a targeted qualitative audit, not a popularity ranking.

There are **29 base variants, three scope examples, a four-state timed-limit family and a paused quit component**. Exported here: **48 PNGs**—the annotated board, shared layout, dark samples, focused revision panel and 42 individual cards. All are our new Figma renders; the user's reference images and competitor images are not copied into the repository (D11). [Export Manifest](<Export Manifest.json>) records dimensions, stable Figma IDs, byte sizes and SHA-256 values.

![Latest quit, limit and period-goal revision](<Images/Quit Limits and Period Goals.png>)

[Open the focused Figma review panel](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=560-4241).

## Delivery files

| File | Purpose |
|---|---|
| [Annotated overview](<Images/Daily Cards Overview.png>) | All cases, shared layout and CTA specification |
| [Dark examples](<Images/Dark Appearance.png>) | Timer, checklist, limit, quit and monthly-limit appearances |
| [Editable component set](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=540-3003) | Scenario variants; nested reusable content and native shell instances |
| [Current request checklist](<../../../../../../iOS/Docs/Checklists/Daily Widget — Layout and Actions — 5 October 2026.md>) | Full user scope and audit status |
| [Current Work checklist](<../../../../../../iOS/Docs/Checklists/Current Work Checklist.md>) | Item 9 remains open for implementation |
| [Verification tools](<../../../../../Tools/widget_catalogue/README.md>) | Read-only source, asset and local-link checks |
| [Original catalogue package](<../README.md>) | Earlier Free/Plus research and handoff |

Verification passed: 37 original records, 48 PNGs, all local links, saved Figma geometry, the original catalogue checks, whitespace and local speed rules. See [Validation Results](<Validation Results.json>) for the recorded results and publication status. Native validation remains pending.

## Individual cards

| Scenario | Image | Editable Figma node |
|---|---|---|
| Single check | [PNG](<Images/01 Single check.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3403) |
| Single checked | [PNG](<Images/02 Single checked.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3422) |
| Repeated check | [PNG](<Images/03 Repeated check.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3442) |
| Named check slots | [PNG](<Images/04 Named check slots.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3463) |
| Saved quantity | [PNG](<Images/05 Saved quantity.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3483) |
| Above quantity goal | [PNG](<Images/06 Above quantity goal.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3503) |
| Custom quantity | [PNG](<Images/07 Custom quantity.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3524) |
| Walking steps manual | [PNG](<Images/08 Walking steps manual.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3544) |
| Walking steps saved | [PNG](<Images/09 Walking steps saved.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3564) |
| Timer ready | [PNG](<Images/10 Timer ready.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3585) |
| Timer running | [PNG](<Images/11 Timer running.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3605) |
| Timer paused | [PNG](<Images/12 Timer paused.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3625) |
| Checklist | [PNG](<Images/13 Checklist.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3645) |
| Many checklist steps | [PNG](<Images/14 Many checklist steps.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3665) |
| Checklist complete | [PNG](<Images/15 Checklist complete.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3685) |
| Quit no slips | [PNG](<Images/16 Quit no slips.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3705) |
| Quit slip recorded | [PNG](<Images/17 Quit slip recorded.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3725) |
| Daily limit below | [PNG](<Images/18 Daily limit below.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3745) |
| Daily limit reached | [PNG](<Images/19 Daily limit reached.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3767) |
| Daily limit exceeded | [PNG](<Images/20 Daily limit exceeded.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3789) |
| Weekly total goal | [PNG](<Images/21 Weekly total goal.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3811) |
| Monthly total goal | [PNG](<Images/22 Monthly total goal.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3831) |
| Flexible daily target | [PNG](<Images/23 Flexible daily target.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3852) |
| Skipped day | [PNG](<Images/24 Skipped day.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3872) |
| Paused habit | [PNG](<Images/25 Paused habit.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3892) |
| Private or locked | [PNG](<Images/26 Private or locked.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3912) |
| Not planned today | [PNG](<Images/27 Not planned today.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3932) |
| Removed or stale | [PNG](<Images/28 Removed or stale.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3952) |
| Long habit name | [PNG](<Images/29 Long habit name.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=545-3972) |
| Weekly total limit | [PNG](<Images/30 Weekly total limit.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=549-4061) |
| Monthly total limit | [PNG](<Images/31 Monthly total limit.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=549-4084) |
| Duration daily limit | [PNG](<Images/32 Duration daily limit.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=553-4097) |

| Time limit running | [PNG](<Images/33 Timed limit running.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=560-4389) |
| Time limit reached | [PNG](<Images/34 Timed limit reached.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=560-4413) |
| Time limit exceeded | [PNG](<Images/35 Timed limit exceeded.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=560-4437) |
| Quit paused | [PNG](<Images/36 Quit paused.png>) | [Card](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=560-4508) |

## Implementation acceptance

The report specifies new daily snapshots, desired-state check intents, exact increments, session-aware timer intents and input routes. Current code does not yet implement this complete contract. Figma read-back verifies the sample geometry, not WidgetKit routing, Dynamic Type or persistence. Run the native acceptance cases in the report, coordinate CI under T10 and record iPhone results under U9 before closing item 9.

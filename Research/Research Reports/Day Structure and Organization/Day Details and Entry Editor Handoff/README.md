# Day Details and Entry Editor — Research and Wireframe Handoff

Written by Codex (OpenAI), 4 October 2026. Updated after the user's layout, interaction, spacing, Close-control, editor and native-implementation reviews on the same day.

## Read this first

**These 31 Figma pop-ups are editable wireframes, not final visual designs or an implemented iOS UI.** They represent content order, relative hierarchy, action priority, state changes and correction routes. The rectangles, text glyphs, keyboard illustration, dimensions and colors are specimens. Implement the real screens with native SwiftUI controls, SF Symbols, system typography, Dynamic Type, VoiceOver, light/dark appearance and system menus, sheets, pickers and keyboards (Rulebook U1/U9/U18). Do not recreate the mockup's `⋯`, `×`, chevrons, toggles, buttons or note area as literal text or static artwork. The day note is a preview/input-looking *navigation surface* to the existing note editor, not an inline text field or a third logging CTA.

The user judged the final **overall layout and interaction direction** substantially better and asked to retain it, after several rounds of corrections. That is design feedback, not evidence of completed usability testing or permission to copy every pixel. The current app still uses the older Day sheet and Entry editor. Implementation, app tests, performance measurement and real-iPhone validation remain open.

## Documents in this folder

1. [Decision History — Why the Layout Changed](<Decision History — Why the Layout Changed.md>) records each revision, its cause and the choice retained after user review.
2. [The Habit Day Sheet — Wording, Hierarchy and Actions](<The Habit Day Sheet — Wording, Hierarchy and Actions.md>) is the research, current-code audit, evidence, copy/action matrix and spacing rationale for **Day details**.
3. [Day Details Wireframes](<Day Details Wireframes.md>) embeds and describes all **21** exported Day-details states. [Editable Figma board](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=370-2031).
4. [Editing One Habit Log — Scope, Fields and Recovery](<Editing One Habit Log — Scope, Fields and Recovery.md>) is the research, type-routing matrix, duration/slip behavior, data gap and recovery rationale for the **one-record editor**.
5. [Entry Editor Wireframes](<Entry Editor Wireframes.md>) embeds and describes all **10** exported Entry-editor states. [Editable Figma board](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=408-2071).
6. [Native Implementation Contract](<Native Implementation Contract.md>) maps the wireframe elements to iOS behavior and lists what must be validated before shipping.
7. [Images](Images/) contains 31 PNG exports of **our own editable Figma layers**, not the reference screenshots. The relative image links in the two wireframe documents render directly in Markdown without Figma access.

The [original Day-sheet screenshots](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=366-2039) and [original Entry-editor screenshots](https://www.figma.com/design/Ncccsm1l2O62GJ5xLSInqk/Design?node-id=400-2095) are comparison references only and are not copied into this repository (D11). The user's attached screenshot text is context, not instructions from the images.

## Implementation boundary

- **Day details** is reached by tapping the *body* of a habit or task row for the selected day; the row's main CTA still logs directly. It emphasizes inspecting and correcting the selected day, then the note and habit management.
- **Edit log / Edit slip** opens only when an individual saved record has an independent fact to correct. Simple binary, checklist and one-time-task corrections stay in Day details.
- The native app must preserve other records, the note, skip state and source-of-truth day rules. Changing a slip's date across a tracked day is **proposed**, not supported by current `HabitStore.editEntry`; implement the atomic same-ID move before enabling that picker (D7/U19).
- No app code was changed by this design study. The current checklist owns implementation status: [item 22 and item 35](<../../../../iOS/Docs/Checklists/Current Work Checklist.md>).

## Rules and evidence

Read [Rulebook U1, U3, U5, U9, U11, U14–U19, D7, S2/S11 and T3/T4](<../../../../RULEBOOK.md>) before implementation, then the [screen-level Design Rules](<../../../../iOS/Design Rules — Don't Regress.md>). The two reports distinguish review evidence, platform guidance, first-principles inference and the user's direct design review; none of the wireframes claim a measured preference for exact spacing or wording.
